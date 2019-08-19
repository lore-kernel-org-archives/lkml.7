Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5B0C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3444F204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NdMgf9Mv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfHSOFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:05:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39966 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfHSOFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:05:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id w16so1232868pfn.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 07:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T3UxKUOZ72VWnnQkB3XywWd1zjsE0svXI0cagmUyoZs=;
        b=NdMgf9Mvh/iqzzLFR9x9Aa7SMVofRb6bFd1a7mU0I+5Bl878oLfmmuWz7zgmMymQNH
         HE/V62KfSHt3cADSjza/dXKtyTsdQxsi6srm1SR2FzQSZoYkC6ZN53f1M56K+kwHqjK/
         nUtCHhui1nDMmHS3a3EzZmX7bm4JrpGwgIqsEcpc72o2sCuTgWgbqXvdOovloYYnQs6W
         yugyH0T81fx5aBwnJlHeJU81YjjhdnWMjuW/vSEoyuoU6gTHGLjs7Z+F8LU/annLcJxw
         Pr2ktzgLX9TGWDFEzOd1iVKz33xu+TF+JT74tnb2H24/SySDOdXcTbeNNBqJsTl15iq4
         UzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T3UxKUOZ72VWnnQkB3XywWd1zjsE0svXI0cagmUyoZs=;
        b=RKscTNI9p37i6E6CtvhuF/uHRAVYPXp2rox5ZKLFztz/Y/W/JpUzKdjFspMThuJ7nc
         un+9h+Lvaioga5uXSDDArLRtCcC7R++80E3U+OYXCeGTUY4R8Gajf8j/q71mInXt/yli
         yGObeuTHKnNZ9pPgy6O3mStuPaBvjwePPofgGvDK3GJcKzotjXNh3w4YUJQtHaOV12OG
         m6lYrPp0dQ6aLWhgP0o2/FRMDKwFqByZCIv825Tnioe4Je1OQw6ln8eDxP15wUhEOgsW
         2uxFB0PJMxZcK8vIvX+pzMmInaNmZHzVZMjfsWEJAzVh8hBmbhUXAtP+Kry8ceh7tUbp
         L+Nw==
X-Gm-Message-State: APjAAAUTKWQporKIC9JN+3wjlOc6wSOMk3fqIbjxSxgZitu8dd8P/6M9
        sJfCMEcNFJF4sb8fkXI0kwlhS+lN0rLTB7+28UrmQA==
X-Google-Smtp-Source: APXvYqx4pbIsB+cFpu0G/IqI4DkfdfDjGIBK/bhaAJTV+87+s3gR5xLbvUgBQ8wEn3A9ZynN/j2XHk6NucfBsWzekek=
X-Received: by 2002:a17:90a:c20f:: with SMTP id e15mr20524366pjt.123.1566223533317;
 Mon, 19 Aug 2019 07:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190819114420.2535-1-walter-zh.wu@mediatek.com>
 <20190819125625.bu3nbrldg7te5kwc@willie-the-truck> <20190819132347.GB9927@lakrids.cambridge.arm.com>
 <20190819133441.ejomv6cprdcz7hh6@willie-the-truck>
In-Reply-To: <20190819133441.ejomv6cprdcz7hh6@willie-the-truck>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 19 Aug 2019 16:05:22 +0200
Message-ID: <CAAeHK+w7cTGN8SgWQs0bPjPOrizqfUoMnJWTvUkCqv17Qt=3oQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: kasan: fix phys_to_virt() false positive on
 tag-based kasan
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        wsd_upstream@mediatek.com, LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-mediatek@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 3:34 PM Will Deacon <will@kernel.org> wrote:
>
> On Mon, Aug 19, 2019 at 02:23:48PM +0100, Mark Rutland wrote:
> > On Mon, Aug 19, 2019 at 01:56:26PM +0100, Will Deacon wrote:
> > > On Mon, Aug 19, 2019 at 07:44:20PM +0800, Walter Wu wrote:
> > > > __arm_v7s_unmap() call iopte_deref() to translate pyh_to_virt address,
> > > > but it will modify pointer tag into 0xff, so there is a false positive.
> > > >
> > > > When enable tag-based kasan, phys_to_virt() function need to rewrite
> > > > its original pointer tag in order to avoid kasan report an incorrect
> > > > memory corruption.
> > >
> > > Hmm. Which tree did you see this on? We've recently queued a load of fixes
> > > in this area, but I /thought/ they were only needed after the support for
> > > 52-bit virtual addressing in the kernel.
> >
> > I'm seeing similar issues in the virtio blk code (splat below), atop of
> > the arm64 for-next/core branch. I think this is a latent issue, and
> > people are only just starting to test with KASAN_SW_TAGS.
> >
> > It looks like the virtio blk code will round-trip a SLUB-allocated pointer from
> > virt->page->virt, losing the per-object tag in the process.
> >
> > Our page_to_virt() seems to get a per-page tag, but this only makes
> > sense if you're dealing with the page allocator, rather than something
> > like SLUB which carves a page into smaller objects giving each object a
> > distinct tag.
> >
> > Any round-trip of a pointer from SLUB is going to lose the per-object
> > tag.
>
> Urgh, I wonder how this is supposed to work?
>
> If we end up having to check the KASAN shadow for *_to_virt(), then why
> do we need to store anything in the page flags at all? Andrey?

As per 2813b9c0 ("kasan, mm, arm64: tag non slab memory allocated via
pagealloc") we should only save a non-0xff tag in page flags for non
slab pages.

Could you share your .config so I can reproduce this?
