Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D09C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 19:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADAE0208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 19:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HYsW2QiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfHFTJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 15:09:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47132 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfHFTJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 15:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RaeoCUSmhxSCGOxwB43DaNZ/5YjX3sQn/mta3yU5yC4=; b=HYsW2QiOT4sji3EIN4Q0wKhkO
        8usk4G3VXuLKfPFt93yayYnL11+Wg7CD6fo5kXE0hCCJsU9hPCfQz0e8rb+Cj/PRiYXJqhgwWmGPZ
        F8nDYUjkOC3GE94SGbYaBkWqx/G9v7lBO1ePtBuaCUt+kGyE5vM2VgrlPTY6FmO8VQ8Gy+lQmUfzi
        lxOePzlgNMzkgaDgPtOdsG+LAhyELSbgT9YNqFNxQ5C/Rdia7AkWDcuYmqvmp0BklX9DjFbIrJZXD
        VvZqWIteZ7nvupkqGl8SD0m+FH3vaDhoP4qemEWgLPkSTRlvRi3LRgWr6rbkK6Z1XOSj9D1wvKK/z
        Ys7utKYGQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hv4q2-00022c-3C; Tue, 06 Aug 2019 19:09:38 +0000
Date:   Tue, 6 Aug 2019 12:09:38 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
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
Message-ID: <20190806190937.GD30179@bombadil.infradead.org>
References: <CAPM=9tzJQ+26n_Df1eBPG1A=tXf4xNuVEjbG3aZj-aqYQ9nnAg@mail.gmail.com>
 <CAPM=9twvwhm318btWy_WkQxOcpRCzjpok52R8zPQxQrnQ8QzwQ@mail.gmail.com>
 <CAHk-=wjC3VX5hSeGRA1SCLjT+hewPbbG4vSJPFK7iy26z4QAyw@mail.gmail.com>
 <CAHk-=wiD6a189CXj-ugRzCxA9r1+siSCA0eP_eoZ_bk_bLTRMw@mail.gmail.com>
 <48890b55-afc5-ced8-5913-5a755ce6c1ab@shipmail.org>
 <CAHk-=whwcMLwcQZTmWgCnSn=LHpQG+EBbWevJEj5YTKMiE_-oQ@mail.gmail.com>
 <CAHk-=wghASUU7QmoibQK7XS09na7rDRrjSrWPwkGz=qLnGp_Xw@mail.gmail.com>
 <20190806073831.GA26668@infradead.org>
 <CAHk-=wi7L0MDG7DY39Hx6v8jUMSq3ZCE3QTnKKirba_8KAFNyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi7L0MDG7DY39Hx6v8jUMSq3ZCE3QTnKKirba_8KAFNyw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 11:50:42AM -0700, Linus Torvalds wrote:
> In fact, I do note that a lot of the users don't actually use the
> "void *private" argument at all - they just want the walker - and just
> pass in a NULL private pointer. So we have things like this:
> 
> > +       if (walk_page_range(&init_mm, va, va + size, &set_nocache_walk_ops,
> > +                       NULL)) {
> 
> and in a perfect world we'd have arguments with default values so that
> we could skip those entirely for when people just don't need it.
> 
> I'm not a huge fan of C++ because of a lot of the complexity (and some
> really bad decisions), but many of the _syntactic_ things in C++ would
> be nice to use. This one doesn't seem to be one that the gcc people
> have picked up as an extension ;(
> 
> Yes, yes, we could do it with a macro, I guess.
> 
>    #define walk_page_range(mm, start,end, ops, ...) \
>        __walk_page_range(mm, start, end, (NULL , ## __VA_ARGS__))
> 
> but I'm not sure it's worthwhile.

Has anyone looked at turning the interface inside-out?  ie something like:

	struct mm_walk_state state = { .mm = mm, .start = start, .end = end, };

	for_each_page_range(&state, page) {
		... do something with page ...
	}

with appropriate macrology along the lines of:

#define for_each_page_range(state, page)				\
	while ((page = page_range_walk_next(state)))

Then you don't need to package anything up into structs that are shared
between the caller and the iterated function.
