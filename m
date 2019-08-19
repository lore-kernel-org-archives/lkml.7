Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBE4C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9142070D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfHSOoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:44:00 -0400
Received: from foss.arm.com ([217.140.110.172]:55742 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfHSOoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:44:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BF7928;
        Mon, 19 Aug 2019 07:43:59 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 293DC3F718;
        Mon, 19 Aug 2019 07:43:57 -0700 (PDT)
Date:   Mon, 19 Aug 2019 15:43:55 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        wsd_upstream@mediatek.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-mediatek@lists.infradead.org,
        Alexander Potapenko <glider@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] arm64: kasan: fix phys_to_virt() false positive on
 tag-based kasan
Message-ID: <20190819144355.GD14981@fuggles.cambridge.arm.com>
References: <20190819114420.2535-1-walter-zh.wu@mediatek.com>
 <20190819125625.bu3nbrldg7te5kwc@willie-the-truck>
 <20190819132347.GB9927@lakrids.cambridge.arm.com>
 <20190819133441.ejomv6cprdcz7hh6@willie-the-truck>
 <CAAeHK+w7cTGN8SgWQs0bPjPOrizqfUoMnJWTvUkCqv17Qt=3oQ@mail.gmail.com>
 <20190819142238.2jobs6vabkp2isg2@willie-the-truck>
 <1ac7eb3e-156f-218c-8c5a-39a05dd46d55@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ac7eb3e-156f-218c-8c5a-39a05dd46d55@arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 03:35:16PM +0100, Robin Murphy wrote:
> On 19/08/2019 15:22, Will Deacon wrote:
> > On Mon, Aug 19, 2019 at 04:05:22PM +0200, Andrey Konovalov wrote:
> > > On Mon, Aug 19, 2019 at 3:34 PM Will Deacon <will@kernel.org> wrote:
> > > > 
> > > > On Mon, Aug 19, 2019 at 02:23:48PM +0100, Mark Rutland wrote:
> > > > > On Mon, Aug 19, 2019 at 01:56:26PM +0100, Will Deacon wrote:
> > > > > > On Mon, Aug 19, 2019 at 07:44:20PM +0800, Walter Wu wrote:
> > > > > > > __arm_v7s_unmap() call iopte_deref() to translate pyh_to_virt address,
> > > > > > > but it will modify pointer tag into 0xff, so there is a false positive.
> > > > > > > 
> > > > > > > When enable tag-based kasan, phys_to_virt() function need to rewrite
> > > > > > > its original pointer tag in order to avoid kasan report an incorrect
> > > > > > > memory corruption.
> > > > > > 
> > > > > > Hmm. Which tree did you see this on? We've recently queued a load of fixes
> > > > > > in this area, but I /thought/ they were only needed after the support for
> > > > > > 52-bit virtual addressing in the kernel.
> > > > > 
> > > > > I'm seeing similar issues in the virtio blk code (splat below), atop of
> > > > > the arm64 for-next/core branch. I think this is a latent issue, and
> > > > > people are only just starting to test with KASAN_SW_TAGS.
> > > > > 
> > > > > It looks like the virtio blk code will round-trip a SLUB-allocated pointer from
> > > > > virt->page->virt, losing the per-object tag in the process.
> > > > > 
> > > > > Our page_to_virt() seems to get a per-page tag, but this only makes
> > > > > sense if you're dealing with the page allocator, rather than something
> > > > > like SLUB which carves a page into smaller objects giving each object a
> > > > > distinct tag.
> > > > > 
> > > > > Any round-trip of a pointer from SLUB is going to lose the per-object
> > > > > tag.
> > > > 
> > > > Urgh, I wonder how this is supposed to work?
> > > > 
> > > > If we end up having to check the KASAN shadow for *_to_virt(), then why
> > > > do we need to store anything in the page flags at all? Andrey?
> > > 
> > > As per 2813b9c0 ("kasan, mm, arm64: tag non slab memory allocated via
> > > pagealloc") we should only save a non-0xff tag in page flags for non
> > > slab pages.
> > 
> > Thanks, that makes sense. Hopefully the patch from Andrey R will solve
> > both of the reported splats, since I'd not realised they were both on the
> > kfree() path.
> > 
> > > Could you share your .config so I can reproduce this?
> > 
> > This is in the iopgtable code, so it's probably pretty tricky to trigger
> > at runtime unless you have the write IOMMU hardware, unfortunately.
> 
> If simply freeing any entry from the l2_tables cache is sufficient, then the
> short-descriptor selftest should do the job, and that ought to run on
> anything (modulo insane RAM layouts).

Ok, so that would be defconfig + CONFIG_IOMMU_IO_PGTABLE_ARMV7S +
CONFIG_IOMMU_IO_PGTABLE_ARMV7S_SELFTEST + KASAN...

Will
