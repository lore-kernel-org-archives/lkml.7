Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887F3C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 22:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E2020880
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 22:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K+IKYnZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfK1WjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 17:39:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48116 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfK1WjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 17:39:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pZCnrPr2b9gLMJqHgJo0gt01BaizFyA66hYSt9kdrmM=; b=K+IKYnZ/GsB+ZkQTbcKnhP/Pc
        c6AKsa1pl3X/SWUAPvotc5kwRzdAocWRZcKuyIdCRNz2v3hWSfKpbjXcqKwKeFCsvKuiiRQruAJX4
        rAybf2ktb0++MuvMBIyMcfEWakbScUlRpQD27Qib2+jeuGlVY8mTyLJDunoTWF6VdfJ99LKe4jvBD
        NHIqDfxvOISGNpPt+cSNGVfXDAwJsH/TLz94fb/9EzXZErZCUIDLH2ypPdg9NSU7xq2OBZgTMLKZn
        l/zH5R3FZnikl4Czt+RVpQLs1qiTVcUdBrTRq+bjjvD4I32SmtnJInWTvP1ET4xEY6dVFm0UBy4S0
        +VU/OID+Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iaSRE-0007TB-JM; Thu, 28 Nov 2019 22:39:04 +0000
Date:   Thu, 28 Nov 2019 14:39:04 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/page_vma_mapped: page table boundary is already
 guaranteed
Message-ID: <20191128223904.GG20752@bombadil.infradead.org>
References: <20191128010321.21730-1-richardw.yang@linux.intel.com>
 <20191128010321.21730-2-richardw.yang@linux.intel.com>
 <20191128083143.kwih655snxqa2qnm@box.shutemov.name>
 <20191128210945.6gtt7wlygsvxip4n@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128210945.6gtt7wlygsvxip4n@master>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 09:09:45PM +0000, Wei Yang wrote:
> On Thu, Nov 28, 2019 at 11:31:43AM +0300, Kirill A. Shutemov wrote:
> >On Thu, Nov 28, 2019 at 09:03:21AM +0800, Wei Yang wrote:
> >> The check here is to guarantee pvmw->address iteration is limited in one
> >> page table boundary. To be specific, here the address range should be in
> >> one PMD_SIZE.
> >> 
> >> If my understanding is correct, this check is already done in the above
> >> check:
> >> 
> >>     address >= __vma_address(page, vma) + PMD_SIZE
> >> 
> >> The boundary check here seems not necessary.
> >> 
> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >
> >NAK.
> >
> >THP can be mapped with PTE not aligned to PMD_SIZE. Consider mremap().
> >
> 
> Hi, Kirill
> 
> Thanks for your comment during Thanks Giving Day. Happy holiday:-)
> 
> I didn't think about this case before, thanks for reminding. Then I tried to
> understand your concern.
> 
> mremap() would expand/shrink a memory mapping. In this case, probably shrink
> is in concern. Since pvmw->page and pvmw->vma are not changed in the loop, the
> case you mentioned maybe pvmw->page is the head of a THP but part of it is
> unmapped.

mremap() can also move a mapping, see MREMAP_FIXED.

> This means the following condition stands:
> 
>     vma->vm_start <= vma_address(page) 
>     vma->vm_end <=   vma_address(page) + page_size(page)
> 
> Since we have checked address with vm_end, do you think this case is also
> guarded?
> 
> Not sure my understanding is correct, look forward your comments.
> 
> >> Test:
> >>    more than 48 hours kernel build test shows this code is not touched.
> >
> >Not an argument. I doubt mremap(2) is ever called in kernel build
> >workload.
> >
> >-- 
> > Kirill A. Shutemov
> 
> -- 
> Wei Yang
> Help you, Help me
> 
