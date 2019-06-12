Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3A1C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9AC20665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393197AbfFMRBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:01:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:15714 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729744AbfFLXtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 19:49:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 16:49:11 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga002.jf.intel.com with ESMTP; 12 Jun 2019 16:49:11 -0700
Date:   Wed, 12 Jun 2019 16:50:31 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3 1/2] mm/gup: fix omission of check on FOLL_LONGTERM in
 get_user_pages_fast()
Message-ID: <20190612235031.GF14336@iweiny-DESK2.sc.intel.com>
References: <1559725820-26138-1-git-send-email-kernelfans@gmail.com>
 <87tvcwhzdo.fsf@linux.ibm.com>
 <2807E5FD2F6FDA4886F6618EAC48510E79D8D79B@CRSMSX101.amr.corp.intel.com>
 <20190612135458.GA19916@dhcp-128-55.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612135458.GA19916@dhcp-128-55.nay.redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 09:54:58PM +0800, Pingfan Liu wrote:
> On Tue, Jun 11, 2019 at 04:29:11PM +0000, Weiny, Ira wrote:
> > > Pingfan Liu <kernelfans@gmail.com> writes:
> > > 
> > > > As for FOLL_LONGTERM, it is checked in the slow path
> > > > __gup_longterm_unlocked(). But it is not checked in the fast path,
> > > > which means a possible leak of CMA page to longterm pinned requirement
> > > > through this crack.
> > > 
> > > Shouldn't we disallow FOLL_LONGTERM with get_user_pages fastpath? W.r.t
> > > dax check we need vma to ensure whether a long term pin is allowed or not.
> > > If FOLL_LONGTERM is specified we should fallback to slow path.
> > 
> > Yes, the fastpath bails to the slowpath if FOLL_LONGTERM _and_ DAX.  But it does this while walking the page tables.  I missed the CMA case and Pingfan's patch fixes this.  We could check for CMA pages while walking the page tables but most agreed that it was not worth it.  For DAX we already had checks for *_devmap() so it was easier to put the FOLL_LONGTERM checks there.
> > 
> Then for CMA pages, are you suggesting something like:

I'm not suggesting this.

Sorry I wrote this prior to seeing the numbers in your other email.  Given
the numbers it looks like performing the check whilst walking the tables is
worth the extra complexity.  I was just trying to summarize the thread.  I
don't think we should disallow FOLL_LONGTERM because it only affects CMA and
DAX.  Other pages will be fine with FOLL_LONGTERM.  Why penalize every call if
we don't have to.  Also in the case of DAX the use of vma will be going
away...[1]  Eventually...  ;-)

Ira

[1] https://lkml.org/lkml/2019/6/5/1049

> diff --git a/mm/gup.c b/mm/gup.c
> index 42a47c0..8bf3cc3 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2251,6 +2251,8 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
>         if (unlikely(!access_ok((void __user *)start, len)))
>                 return -EFAULT;
> 
> +       if (unlikely(gup_flags & FOLL_LONGTERM))
> +               goto slow;
>         if (gup_fast_permitted(start, nr_pages)) {
>                 local_irq_disable();
>                 gup_pgd_range(addr, end, gup_flags, pages, &nr);
> @@ -2258,6 +2260,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
>                 ret = nr;
>         }
> 
> +slow:
>         if (nr < nr_pages) {
>                 /* Try to get the remaining pages with get_user_pages */
>                 start += nr << PAGE_SHIFT;
> 
> Thanks,
>   Pingfan
