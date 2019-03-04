Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0B7C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 04:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBCB20675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 04:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfCEEPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 23:15:20 -0500
Received: from mga05.intel.com ([192.55.52.43]:33416 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbfCEEPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 23:15:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 20:15:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,442,1544515200"; 
   d="scan'208";a="131290433"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga003.jf.intel.com with ESMTP; 04 Mar 2019 20:15:18 -0800
Date:   Mon, 4 Mar 2019 12:13:39 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Artemy Kovalyov <artemyko@mellanox.com>,
        "john.hubbard@gmail.com" <john.hubbard@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2] RDMA/umem: minor bug fix and cleanup in error
 handling paths
Message-ID: <20190304201338.GA28731@iweiny-DESK2.sc.intel.com>
References: <20190302032726.11769-2-jhubbard@nvidia.com>
 <20190302202435.31889-1-jhubbard@nvidia.com>
 <20190302194402.GA24732@iweiny-DESK2.sc.intel.com>
 <2404c962-8f6d-1f6d-0055-eb82864ca7fc@mellanox.com>
 <20190303165550.GB27123@iweiny-DESK2.sc.intel.com>
 <bef8680b-acc5-9f13-f49e-8f36f1939387@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bef8680b-acc5-9f13-f49e-8f36f1939387@nvidia.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 03:11:05PM -0800, John Hubbard wrote:
> On 3/3/19 8:55 AM, Ira Weiny wrote:
> > On Sun, Mar 03, 2019 at 11:52:41AM +0200, Artemy Kovalyov wrote:
> >>
> >>
> >> On 02/03/2019 21:44, Ira Weiny wrote:
> >>>
> >>> On Sat, Mar 02, 2019 at 12:24:35PM -0800, john.hubbard@gmail.com wrote:
> >>>> From: John Hubbard <jhubbard@nvidia.com>
> >>>>
> >>>> ...
> >>>> 3. Dead code removal: the check for (user_virt & ~page_mask)
> >>>> is checking for a condition that can never happen,
> >>>> because earlier:
> >>>>
> >>>>      user_virt = user_virt & page_mask;
> >>>>
> >>>> ...so, remove that entire phrase.
> >>>>
> >>>>   		bcnt -= min_t(size_t, npages << PAGE_SHIFT, bcnt);
> >>>>   		mutex_lock(&umem_odp->umem_mutex);
> >>>>   		for (j = 0; j < npages; j++, user_virt += PAGE_SIZE) {
> >>>> -			if (user_virt & ~page_mask) {
> >>>> -				p += PAGE_SIZE;
> >>>> -				if (page_to_phys(local_page_list[j]) != p) {
> >>>> -					ret = -EFAULT;
> >>>> -					break;
> >>>> -				}
> >>>> -				put_page(local_page_list[j]);
> >>>> -				continue;
> >>>> -			}
> >>>> -
> >>>
> >>> I think this is trying to account for compound pages. (ie page_mask could
> >>> represent more than PAGE_SIZE which is what user_virt is being incrimented by.)
> >>> But putting the page in that case seems to be the wrong thing to do?
> >>>
> >>> Yes this was added by Artemy[1] now cc'ed.
> >>
> >> Right, this is for huge pages, please keep it.
> >> put_page() needed to decrement refcount of the head page.
> > 
> > You mean decrement the refcount of the _non_-head pages?
> > 
> > Ira
> > 
> 
> Actually, I'm sure Artemy means head page, because put_page() always
> operates on the head page. 
> 
> And this reminds me that I have a problem to solve nearby: get_user_pages
> on huge pages increments the page->_refcount *for each tail page* as well.
> That's a minor problem for my put_user_page() 
> patchset, because my approach so far assumed that I could just change us
> over to:
> 
> get_user_page(): increments page->_refcount by a large amount (1024)
> 
> put_user_page(): decrements page->_refcount by a large amount (1024)
> 
> ...and just stop doing the odd (to me) technique of incrementing once for
> each tail page. I cannot see any reason why that's actually required, as
> opposed to just "raise the page->_refcount enough to avoid losing the head
> page too soon".

What about splitting a huge page?

From Documention/vm/transhuge.rst

<quoute>
split_huge_page internally has to distribute the refcounts in the head
page to the tail pages before clearing all PG_head/tail bits from the page
structures. It can be done easily for refcounts taken by page table
entries. But we don't have enough information on how to distribute any
additional pins (i.e. from get_user_pages). split_huge_page() fails any
requests to split pinned huge page: it expects page count to be equal to
sum of mapcount of all sub-pages plus one (split_huge_page caller must
have reference for head page).
</quote>

FWIW, I'm not sure why it needs to "store" the reference in the head page for
this.  I don't see any check to make sure the ref has been "stored" but I'm not
really familiar with the compound page code yet.

Ira

> 
> However, it may be tricky to do this in one pass. Probably at first, I'll have
> to do this horrible thing approach:
> 
> get_user_page(): increments page->_refcount by a large amount (1024)
> 
> put_user_page(): decrements page->_refcount by a large amount (1024) MULTIPLIED
>                  by the number of tail pages. argghhh that's ugly.
> 
> thanks,
> -- 
> John Hubbard
> NVIDIA
> 
