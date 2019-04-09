Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E792C10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E81213F2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IQx6HQ79"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfDICti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 22:49:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38944 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfDICth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 22:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+sTnbP4kwIRGvZ3/0p8aO28bolyQS4PZg/H+Zbxqxf0=; b=IQx6HQ79QqGX7eO8jyasd4v0j
        m0c3D2/Hhq55NUArw4A9igZl44KnhAW/Sv4D9pcn9ybJiD1U9U71AOe4AmNjs6nHdT0V54uLfvQK9
        ZECByfGXchDZxYKEHi1vGG2paLGfUqgreqgIBGpnn5ucQnO01Ft48qBLY1uEMm0VrT3HM/MXxl/Xq
        jwluodV18EV3WZ/b9691OyDEwNOaRBAhZtPtRtEU8kTf0w+Mh/cZmGMTMeSu63RA5m6r6MCKwwv4M
        apckaLCSx3COmCMyv98QI5NS1daHb5QAPSE2I5Bho5fP3vvWu3gX+CrXYF3BcK1Cp7lAr5fNtfs+8
        i11Fn3SWg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDgpG-0001c2-5h; Tue, 09 Apr 2019 02:49:30 +0000
Date:   Mon, 8 Apr 2019 19:49:29 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Huang Shijie <sjhuang@iluvatar.ai>
Cc:     akpm@linux-foundation.org, william.kucharski@oracle.com,
        ira.weiny@intel.com, palmer@sifive.com, axboe@kernel.dk,
        keescook@chromium.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/gup.c: fix the wrong comments
Message-ID: <20190409024929.GW22763@bombadil.infradead.org>
References: <20190408023746.16916-1-sjhuang@iluvatar.ai>
 <20190408141313.GU22763@bombadil.infradead.org>
 <20190409010832.GA28081@hsj-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409010832.GA28081@hsj-Precision-5520>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 09:08:33AM +0800, Huang Shijie wrote:
> On Mon, Apr 08, 2019 at 07:13:13AM -0700, Matthew Wilcox wrote:
> > On Mon, Apr 08, 2019 at 10:37:45AM +0800, Huang Shijie wrote:
> > > The root cause is that sg_alloc_table_from_pages() requires the
> > > page order to keep the same as it used in the user space, but
> > > get_user_pages_fast() will mess it up.
> > 
> > I don't understand how get_user_pages_fast() can return the pages in a
> > different order in the array from the order they appear in userspace.
> > Can you explain?
> Please see the code in gup.c:
> 
> 	int get_user_pages_fast(unsigned long start, int nr_pages,
> 				unsigned int gup_flags, struct page **pages)
> 	{
> 		.......
> 		if (gup_fast_permitted(start, nr_pages)) {
> 			local_irq_disable();
> 			gup_pgd_range(addr, end, gup_flags, pages, &nr);               // The @pages array maybe filled at the first time.

Right ... but if it's not filled entirely, it will be filled part-way,
and then we stop.

> 			local_irq_enable();
> 			ret = nr;
> 		}
> 		.......
> 		if (nr < nr_pages) {
> 			/* Try to get the remaining pages with get_user_pages */
> 			start += nr << PAGE_SHIFT;
> 			pages += nr;                                                  // The @pages is moved forward.

Yes, to the point where gup_pgd_range() stopped.

> 			if (gup_flags & FOLL_LONGTERM) {
> 				down_read(&current->mm->mmap_sem);
> 				ret = __gup_longterm_locked(current, current->mm,      // The @pages maybe filled at the second time

Right.

> 				/*
> 				 * retain FAULT_FOLL_ALLOW_RETRY optimization if
> 				 * possible
> 				 */
> 				ret = get_user_pages_unlocked(start, nr_pages - nr,    // The @pages maybe filled at the second time.
> 							      pages, gup_flags);

Yes.  But they'll be in the same order.

> BTW, I do not know why we mess up the page order. It maybe used in some special case.

I'm not discounting the possibility that you've found a bug.
But documenting that a bug exists is not the solution; the solution is
fixing the bug.
