Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC1CC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 08:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17F320833
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 08:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfLBIyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 03:54:36 -0500
Received: from mga18.intel.com ([134.134.136.126]:29850 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfLBIyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 03:54:36 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 00:54:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,268,1571727600"; 
   d="scan'208";a="262153126"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Dec 2019 00:54:33 -0800
Date:   Mon, 2 Dec 2019 16:54:27 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/page_vma_mapped: use PMD_SIZE instead of
 calculating it
Message-ID: <20191202085427.GA6656@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20191128010321.21730-1-richardw.yang@linux.intel.com>
 <20191128083255.ab5rwj7gvktwunik@box.shutemov.name>
 <20191128212226.sfrhfs5m3q7m6tly@master>
 <20191202080315.oqtm3q7cyfkl5rma@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202080315.oqtm3q7cyfkl5rma@box.shutemov.name>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 11:03:15AM +0300, Kirill A. Shutemov wrote:
>On Thu, Nov 28, 2019 at 09:22:26PM +0000, Wei Yang wrote:
>> On Thu, Nov 28, 2019 at 11:32:55AM +0300, Kirill A. Shutemov wrote:
>> >On Thu, Nov 28, 2019 at 09:03:20AM +0800, Wei Yang wrote:
>> >> At this point, we are sure page is PageTransHuge, which means
>> >> hpage_nr_pages is HPAGE_PMD_NR.
>> >> 
>> >> This is safe to use PMD_SIZE instead of calculating it.
>> >> 
>> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> >> ---
>> >>  mm/page_vma_mapped.c | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >> 
>> >> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>> >> index eff4b4520c8d..76e03650a3ab 100644
>> >> --- a/mm/page_vma_mapped.c
>> >> +++ b/mm/page_vma_mapped.c
>> >> @@ -223,7 +223,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>> >>  			if (pvmw->address >= pvmw->vma->vm_end ||
>> >>  			    pvmw->address >=
>> >>  					__vma_address(pvmw->page, pvmw->vma) +
>> >> -					hpage_nr_pages(pvmw->page) * PAGE_SIZE)
>> >> +					PMD_SIZE)
>> >>  				return not_found(pvmw);
>> >>  			/* Did we cross page table boundary? */
>> >>  			if (pvmw->address % PMD_SIZE == 0) {
>> >
>> >It is dubious cleanup. Maybe page_size(pvmw->page) instead? It will not
>> >break if we ever get PUD THP pages.
>> >
>> 
>> Thanks for your comment.
>> 
>> I took a look into the code again and found I may miss something.
>> 
>> I found we support PUD THP pages, whilc hpage_nr_pages() just return
>> HPAGE_PMD_NR on PageTransHuge. Why this is not possible to return PUD number?
>
>We only support PUD THP for DAX. Means, we don't have struct page for it.
>

Ok, many background story behind it.

Thanks :-)

>-- 
> Kirill A. Shutemov

-- 
Wei Yang
Help you, Help me
