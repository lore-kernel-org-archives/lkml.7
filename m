Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD13C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 06:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6AA214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 06:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dLjgyEgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfHGGkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 02:40:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38656 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbfHGGkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 02:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7uoByRa+Al/xx5bip7rUm8otbKddClrdMOGAdUETRbE=; b=dLjgyEgYjD1Os5q21xXo4cPVG
        9DH2AgUTdtbRF+g2nPIvPt5xl1Kb4pJ9PgP55ZxyrfEJopI8Y6zDiY54klLdOvkh50jjPzNLjN2g3
        YJMwWzn4POHUA71za7cjK1UnTdmYk1umo1Q09nkIrCUrPUZmCC7kliZRklsJpjnPvb1jHKRK8B0LY
        3exvnq5asy/EFK1Fz/4Pa7KlySZu1MpQqfwFN3NHTROnZmA5wy3d66hMcRR0PhsSe730aQcDCEiNP
        Dz+EPfLNHWPuIyFAKQ++QPOeCkLMVt2t+i+At2EeInDwGgyJYOL+Ta8BJGxsLgFDTCd5axhBG1yp8
        ZV8RsxtYw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hvFc8-0007MG-7S; Wed, 07 Aug 2019 06:40:00 +0000
Date:   Tue, 6 Aug 2019 23:40:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas@shipmail.org>, Dave Airlie <airlied@gmail.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: drm pull for v5.3-rc1
Message-ID: <20190807064000.GC6002@infradead.org>
References: <CAPM=9tzJQ+26n_Df1eBPG1A=tXf4xNuVEjbG3aZj-aqYQ9nnAg@mail.gmail.com>
 <CAPM=9twvwhm318btWy_WkQxOcpRCzjpok52R8zPQxQrnQ8QzwQ@mail.gmail.com>
 <CAHk-=wjC3VX5hSeGRA1SCLjT+hewPbbG4vSJPFK7iy26z4QAyw@mail.gmail.com>
 <CAHk-=wiD6a189CXj-ugRzCxA9r1+siSCA0eP_eoZ_bk_bLTRMw@mail.gmail.com>
 <48890b55-afc5-ced8-5913-5a755ce6c1ab@shipmail.org>
 <CAHk-=whwcMLwcQZTmWgCnSn=LHpQG+EBbWevJEj5YTKMiE_-oQ@mail.gmail.com>
 <CAHk-=wghASUU7QmoibQK7XS09na7rDRrjSrWPwkGz=qLnGp_Xw@mail.gmail.com>
 <20190806073831.GA26668@infradead.org>
 <CAHk-=wi7L0MDG7DY39Hx6v8jUMSq3ZCE3QTnKKirba_8KAFNyw@mail.gmail.com>
 <20190806190937.GD30179@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806190937.GD30179@bombadil.infradead.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 12:09:38PM -0700, Matthew Wilcox wrote:
> Has anyone looked at turning the interface inside-out?  ie something like:
> 
> 	struct mm_walk_state state = { .mm = mm, .start = start, .end = end, };
> 
> 	for_each_page_range(&state, page) {
> 		... do something with page ...
> 	}
> 
> with appropriate macrology along the lines of:
> 
> #define for_each_page_range(state, page)				\
> 	while ((page = page_range_walk_next(state)))
> 
> Then you don't need to package anything up into structs that are shared
> between the caller and the iterated function.

I'm not an all that huge fan of super magic macro loops.  But in this
case I don't see how it could even work, as we get special callbacks
for huge pages and holes, and people are trying to add a few more ops
as well.
