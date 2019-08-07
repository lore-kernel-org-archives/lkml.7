Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D54BC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FCD821E6C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AC2sFIrC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbfHGO4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 10:56:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59070 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729550AbfHGO4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 10:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WHDkGIkGDhi7s/aX5RIG2h076WJQgiwTmFKZsiix88I=; b=AC2sFIrClzvrAuopVrXvwugiY
        8pjCjcoNMRxBAbOu1e+IYWnWwBn23rrvVb3+zo9jSy/rEqV0jtM6OKmuaKJgIPCd+ZEJGVHI1xCUM
        V33yiZR1LBHycuELJYuk3ChIMHbwC3+U3UkD+itrcmrRrXwcGTUiy4Emh3dDvFH8iJCGHKTIyZkSS
        JkM7h5vZfpkNwqmfAGioAVQ7oEBCMiwDFERlYOCfEHok0Ct0gRQBQZhg0acgBiGO6N99OC8PyFqGX
        RBH5duCu835KJqDGvsVYJ2T0t8xRO3dI5YDATQhUwKO6u2/VVkIlC73MRjL16m50yadyh4WpPfYWx
        CslHyrvIQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hvNM9-00082M-J1; Wed, 07 Aug 2019 14:56:01 +0000
Date:   Wed, 7 Aug 2019 07:56:01 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Steven Price <steven.price@arm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas@shipmail.org>, Dave Airlie <airlied@gmail.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: drm pull for v5.3-rc1
Message-ID: <20190807145601.GB5482@bombadil.infradead.org>
References: <CAHk-=wiD6a189CXj-ugRzCxA9r1+siSCA0eP_eoZ_bk_bLTRMw@mail.gmail.com>
 <48890b55-afc5-ced8-5913-5a755ce6c1ab@shipmail.org>
 <CAHk-=whwcMLwcQZTmWgCnSn=LHpQG+EBbWevJEj5YTKMiE_-oQ@mail.gmail.com>
 <CAHk-=wghASUU7QmoibQK7XS09na7rDRrjSrWPwkGz=qLnGp_Xw@mail.gmail.com>
 <20190806073831.GA26668@infradead.org>
 <CAHk-=wi7L0MDG7DY39Hx6v8jUMSq3ZCE3QTnKKirba_8KAFNyw@mail.gmail.com>
 <20190806190937.GD30179@bombadil.infradead.org>
 <20190807064000.GC6002@infradead.org>
 <20190807141517.GA5482@bombadil.infradead.org>
 <62cbe523-e8a4-cdfd-90c2-80260cefa5de@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62cbe523-e8a4-cdfd-90c2-80260cefa5de@arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 03:30:38PM +0100, Steven Price wrote:
> On 07/08/2019 15:15, Matthew Wilcox wrote:
> > On Tue, Aug 06, 2019 at 11:40:00PM -0700, Christoph Hellwig wrote:
> >> On Tue, Aug 06, 2019 at 12:09:38PM -0700, Matthew Wilcox wrote:
> >>> Has anyone looked at turning the interface inside-out?  ie something like:
> >>>
> >>> 	struct mm_walk_state state = { .mm = mm, .start = start, .end = end, };
> >>>
> >>> 	for_each_page_range(&state, page) {
> >>> 		... do something with page ...
> >>> 	}
> >>>
> >>> with appropriate macrology along the lines of:
> >>>
> >>> #define for_each_page_range(state, page)				\
> >>> 	while ((page = page_range_walk_next(state)))
> >>>
> >>> Then you don't need to package anything up into structs that are shared
> >>> between the caller and the iterated function.
> >>
> >> I'm not an all that huge fan of super magic macro loops.  But in this
> >> case I don't see how it could even work, as we get special callbacks
> >> for huge pages and holes, and people are trying to add a few more ops
> >> as well.
> > 
> > We could have bits in the mm_walk_state which indicate what things to return
> > and what things to skip.  We could (and probably should) also use different
> > iterator names if people actually want to iterate different things.  eg
> > for_each_pte_range(&state, pte) as well as for_each_page_range().
> > 
> 
> The iterator approach could be awkward for the likes of my generic
> ptdump implementation[1]. It would require an iterator which returns all
> levels and allows skipping levels when required (to prevent KASAN
> slowing things down too much). So something like:
> 
> start_walk_range(&state);
> for_each_page_range(&state, page) {
> 	switch(page->level) {
> 	case PTE:
> 		...
> 	case PMD:
> 		if (...)
> 			skip_pmd(&state);
> 		...
> 	case HOLE:
> 		....
> 	...
> 	}
> }
> end_walk_range(&state);
> 
> It seems a little fragile - e.g. we wouldn't (easily) get type checking
> that you are actually treating a PTE as a pte_t. The state mutators like
> skip_pmd() also seem a bit clumsy.

Once you're on-board with using a state structure, you can use it in all
kinds of fun ways.  For example:

struct mm_walk_state {
	struct mm_struct *mm;
	unsigned long start;
	unsigned long end;
	unsigned long curr;
	p4d_t p4d;
	pud_t pud;
	pmd_t pmd;
	pte_t pte;
	enum page_entry_size size;
	int flags;
};

For this user, I'd expect something like ...

	DECLARE_MM_WALK_FLAGS(state, mm, start, end,
				MM_WALK_HOLES | MM_WALK_ALL_SIZES);

	walk_each_pte(state) {
		switch (state->size) {
		case PE_SIZE_PTE:
			... 
		case PE_SIZE_PMD:
			if (...(state->pmd))
				continue;
		...
		}
	}

There's no need to have start / end walk function calls.
