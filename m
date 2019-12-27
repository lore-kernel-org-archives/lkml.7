Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8936EC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 15:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5252020882
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 15:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M7IFwi3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfL0PNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 10:13:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50096 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfL0PNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 10:13:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mKWmeMq/jXDP6HCH4qqFt/k91vrrbD+r5MY8+5wBr/M=; b=M7IFwi3Jg5BjsBnyGD+4xon2G
        KIOWGardiBBm18dCoil3NMB6Ob5gQGRG/RwNNx7SAykIKQoaaG8OJvA/YB1x4e8tMgOe4VC5Osjp5
        FImLXcx4mNey05Wjk20orKXk2m6Z3SiXJFfTee1gdKPbH93TW/SBNPz0yy+LAu4czyGtgnCVw3vKf
        TG0xBbIqoHl/R7QftEIuH/U6pnpRlrJTT1YejtHxr5Yco3zTrOSUpQULlDB0O4ioXSuKKEtGThxB3
        IPMHGtXrinZ8ff5eXDLf+xMjC2wKBw89XX/6p/5p5CXNmeF3mykXWpQXhI1oY1yosXiWBiHuLZ+kc
        yW+S5smIw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ikrJC-0007nM-S5; Fri, 27 Dec 2019 15:13:46 +0000
Date:   Fri, 27 Dec 2019 07:13:46 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com
Subject: Re: [Patch v2] mm/rmap.c: split huge pmd when it really is
Message-ID: <20191227151346.GA10799@bombadil.infradead.org>
References: <20191223222856.7189-1-richardw.yang@linux.intel.com>
 <20191223231120.GA31820@bombadil.infradead.org>
 <20191224015602.GB7739@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224015602.GB7739@richard>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2019 at 09:56:02AM +0800, Wei Yang wrote:
> On Mon, Dec 23, 2019 at 03:11:20PM -0800, Matthew Wilcox wrote:
> >On Tue, Dec 24, 2019 at 06:28:56AM +0800, Wei Yang wrote:
> >> When page is not NULL, function is called by try_to_unmap_one() with
> >> TTU_SPLIT_HUGE_PMD set. There are two cases to call try_to_unmap_one()
> >> with TTU_SPLIT_HUGE_PMD set:
> >> 
> >>   * unmap_page()
> >>   * shrink_page_list()
> >> 
> >> In both case, the page passed to try_to_unmap_one() is PageHead() of the
> >> THP. If this page's mapping address in process is not HPAGE_PMD_SIZE
> >> aligned, this means the THP is not mapped as PMD THP in this process.
> >> This could happen when we do mremap() a PMD size range to an un-aligned
> >> address.
> >> 
> >> Currently, this case is handled by following check in __split_huge_pmd()
> >> luckily.
> >> 
> >>   page != pmd_page(*pmd)
> >> 
> >> This patch checks the address to skip some work.
> >
> >The description here is confusing to me.
> >
> 
> Sorry for the confusion.
> 
> Below is my understanding, if not correct or proper, just let me know :-)
> 
> According to current comment in __split_huge_pmd(), we check pmd_page with
> page for migration case. While actually, this check also helps in the
> following two cases when page already split-ed:
> 
>    * page just split-ed in place
>    * page split-ed and moved to non-PMD aligned address
> 
> In both cases, pmd_page() is pointing to the PTE level page table. That's why
> we don't split one already split-ed THP page.
> 
> If current code really intend to cover these two cases, sorry for my poor
> understanding.
> 
> >> +	/*
> >> +	 * When page is not NULL, function is called by try_to_unmap_one()
> >> +	 * with TTU_SPLIT_HUGE_PMD set. There are two places set
> >> +	 * TTU_SPLIT_HUGE_PMD
> >> +	 *
> >> +	 *     unmap_page()
> >> +	 *     shrink_page_list()
> >> +	 *
> >> +	 * In both cases, the "page" here is the PageHead() of a THP.
> >> +	 *
> >> +	 * If the page is not a PMD mapped huge page, e.g. after mremap(), it
> >> +	 * is not necessary to split it.
> >> +	 */
> >> +	if (page && !IS_ALIGNED(address, HPAGE_PMD_SIZE))
> >> +		return;
> >
> >Repeating 75% of it as comments doesn't make it any less confusing.  And
> >it feels like we're digging a pothole for someone to fall into later.
> >Why not make it make sense ...
> >
> >	if (page && !IS_ALIGNED(address, page_size(page))
> >		return;
> 
> Hmm... Use HPAGE_PMD_SIZE here wants to emphasize we want the address to be
> PMD aligned. If just use page_size() here, may confuse the audience?

I'm OK with using HPAGE_PMD_SIZE here.  I was trying to future-proof
this function for supporting 64kB pages with a 4kB page size on ARM,
but this function will need changes for that anyway, so I'm OK with
your suggestion.
