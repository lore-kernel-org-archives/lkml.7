Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD9AC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DB022CE2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 15:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BASVfhGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfHSPht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 11:37:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39308 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfHSPhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:37:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so1431670pgi.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 08:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1doVjKq3mcViKTNmljRst42DcW8+lOf7Fak48gVUGb8=;
        b=BASVfhGkzN100FGLXKPxZyTuDTg4gC8vCGHFSJ2QDaCfNCZtKHEAq04TsQ0+463trf
         GBdXivq4N3R9ss4Wm4N5jznlSGLRH33IOUeJzCal1xKetx3QR1PcyWN4v4HJit8hFI/8
         nFMbIWH8qEcI5nPXLhTj52avIgg1R3Gok/PSKm7gPAK+HoOIGzYMJzu7ujn2Hi6mmfm5
         ZdcOg3osALz6v+VLP2frAn/78eygWYbd/46p8fNNwduO+dKL7T+cPOqiJG9kwZLD8nXp
         KggzvDFhQpdUhZ1ruczIO6AktSO4hs53d65me4r+223aInxmAKZaQ7biNvTl/OnTKsZF
         /sZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1doVjKq3mcViKTNmljRst42DcW8+lOf7Fak48gVUGb8=;
        b=mpR1YXD0KF+KIYTJPQpTIJxV5fX+yBB1aWg2khVjTBRd2Dtq3GsfV131LtD1uPNn5R
         LhAKZopGvlTNVxLk4HMw4Dd2waDUU0E94o3ZjA5kfmzJW1633RkiFoIpTwaj4u95+nnx
         YrkbbvQBSUur3K+O3fMJ0fZaIIwDA9pQEoVyWfaabF+kwBLQBhReP8ZMNNXT01Md3qQe
         9dyTG7zcyDgJ9LEFjBz17C6T26/blArDaH3lj7NpR7WdIrryLfZIrBVBJMh75Z7cOVGO
         s0AyVJeQcQ/ZKiQeUpVPI0yYhZTi+Gpl7hO2Yn5i9oGcsEFfdN55l34TpQNnDqjJfc1N
         +JAw==
X-Gm-Message-State: APjAAAUZxQHtmWEEhG4xZTOGveZf67AjzsXMJzArvae+P+fgRpGM0x8n
        ndqmZX2mvZ6No1B2rXkRxbWMyNET/6q24SIvhorgrw==
X-Google-Smtp-Source: APXvYqw6B56e2SpZwAoVQuNMbYHFVLD01QKRph/mh7Hz0wR6sgA4mf5sfjZn+obkXz1yiarMDGGjXriS/Cn3mnt/vVo=
X-Received: by 2002:aa7:9e0a:: with SMTP id y10mr24422794pfq.93.1566229067338;
 Mon, 19 Aug 2019 08:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190819114420.2535-1-walter-zh.wu@mediatek.com>
 <20190819125625.bu3nbrldg7te5kwc@willie-the-truck> <20190819132347.GB9927@lakrids.cambridge.arm.com>
 <20190819133441.ejomv6cprdcz7hh6@willie-the-truck> <CAAeHK+w7cTGN8SgWQs0bPjPOrizqfUoMnJWTvUkCqv17Qt=3oQ@mail.gmail.com>
 <20190819150341.GC9927@lakrids.cambridge.arm.com>
In-Reply-To: <20190819150341.GC9927@lakrids.cambridge.arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 19 Aug 2019 17:37:36 +0200
Message-ID: <CAAeHK+wBNnnKY4wg=34aD8Of6Vea4nzWF-FEnnSpHN0pFyTR3Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: kasan: fix phys_to_virt() false positive on
 tag-based kasan
To:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
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

On Mon, Aug 19, 2019 at 5:03 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Mon, Aug 19, 2019 at 04:05:22PM +0200, Andrey Konovalov wrote:
> > On Mon, Aug 19, 2019 at 3:34 PM Will Deacon <will@kernel.org> wrote:
> > >
> > > On Mon, Aug 19, 2019 at 02:23:48PM +0100, Mark Rutland wrote:
> > > > On Mon, Aug 19, 2019 at 01:56:26PM +0100, Will Deacon wrote:
> > > > > On Mon, Aug 19, 2019 at 07:44:20PM +0800, Walter Wu wrote:
> > > > > > __arm_v7s_unmap() call iopte_deref() to translate pyh_to_virt address,
> > > > > > but it will modify pointer tag into 0xff, so there is a false positive.
> > > > > >
> > > > > > When enable tag-based kasan, phys_to_virt() function need to rewrite
> > > > > > its original pointer tag in order to avoid kasan report an incorrect
> > > > > > memory corruption.
> > > > >
> > > > > Hmm. Which tree did you see this on? We've recently queued a load of fixes
> > > > > in this area, but I /thought/ they were only needed after the support for
> > > > > 52-bit virtual addressing in the kernel.
> > > >
> > > > I'm seeing similar issues in the virtio blk code (splat below), atop of
> > > > the arm64 for-next/core branch. I think this is a latent issue, and
> > > > people are only just starting to test with KASAN_SW_TAGS.
> > > >
> > > > It looks like the virtio blk code will round-trip a SLUB-allocated pointer from
> > > > virt->page->virt, losing the per-object tag in the process.
> > > >
> > > > Our page_to_virt() seems to get a per-page tag, but this only makes
> > > > sense if you're dealing with the page allocator, rather than something
> > > > like SLUB which carves a page into smaller objects giving each object a
> > > > distinct tag.
> > > >
> > > > Any round-trip of a pointer from SLUB is going to lose the per-object
> > > > tag.
> > >
> > > Urgh, I wonder how this is supposed to work?
> > >
> > > If we end up having to check the KASAN shadow for *_to_virt(), then why
> > > do we need to store anything in the page flags at all? Andrey?
> >
> > As per 2813b9c0 ("kasan, mm, arm64: tag non slab memory allocated via
> > pagealloc") we should only save a non-0xff tag in page flags for non
> > slab pages.
> >
> > Could you share your .config so I can reproduce this?
>
> I wrote a test (below) to do so. :)
>
> It fires with arm64 defconfig, + CONFIG_TEST_KASAN=m.
>
> With Andrey Ryabinin's patch it works as expected with no KASAN splats
> for the two new test cases.

OK, Andrey's patch makes sense and fixes both Mark's test patch and
reports from CONFIG_IOMMU_IO_PGTABLE_ARMV7S_SELFTEST.

Tested-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

on both patches.

>
> Thanks,
> Mark.
>
> ---->8----
> From 7e8569b558fca21ad4e80fddae659591bc84ce1f Mon Sep 17 00:00:00 2001
> From: Mark Rutland <mark.rutland@arm.com>
> Date: Mon, 19 Aug 2019 15:39:32 +0100
> Subject: [PATCH] lib/test_kasan: add roundtrip tests
>
> In several places we needs to be able to operate on pointers which have

"needs" => "need"

> gone via a roundtrip:
>
>         virt -> {phys,page} -> virt
>
> With KASAN_SW_TAGS, we can't preserve the tag for SLUB objects, and the
> {phys,page} -> virt conversion will use KASAN_TAG_KERNEL.
>
> This patch adds tests to ensure that this works as expected, without
> false positives.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  lib/test_kasan.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index b63b367a94e8..cf7b93f0d90c 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -19,6 +19,8 @@
>  #include <linux/string.h>
>  #include <linux/uaccess.h>
>
> +#include <asm/page.h>
> +
>  /*
>   * Note: test functions are marked noinline so that their names appear in
>   * reports.
> @@ -337,6 +339,42 @@ static noinline void __init kmalloc_uaf2(void)
>         kfree(ptr2);
>  }
>
> +static noinline void __init kfree_via_page(void)
> +{
> +       char *ptr;
> +       size_t size = 8;
> +       struct page *page;
> +       unsigned long offset;
> +
> +       pr_info("invalid-free false positive (via page)\n");
> +       ptr = kmalloc(size, GFP_KERNEL);
> +       if (!ptr) {
> +               pr_err("Allocation failed\n");
> +               return;
> +       }
> +
> +       page = virt_to_page(ptr);
> +       offset = offset_in_page(ptr);
> +       kfree(page_address(page) + offset);
> +}
> +
> +static noinline void __init kfree_via_phys(void)
> +{
> +       char *ptr;
> +       size_t size = 8;
> +       phys_addr_t phys;
> +
> +       pr_info("invalid-free false positive (via phys)\n");
> +       ptr = kmalloc(size, GFP_KERNEL);
> +       if (!ptr) {
> +               pr_err("Allocation failed\n");
> +               return;
> +       }
> +
> +       phys = virt_to_phys(ptr);
> +       kfree(phys_to_virt(phys));
> +}
> +
>  static noinline void __init kmem_cache_oob(void)
>  {
>         char *p;
> @@ -737,6 +775,8 @@ static int __init kmalloc_tests_init(void)
>         kmalloc_uaf();
>         kmalloc_uaf_memset();
>         kmalloc_uaf2();
> +       kfree_via_page();
> +       kfree_via_phys();
>         kmem_cache_oob();
>         memcg_accounted_kmem_cache();
>         kasan_stack_oob();
> --
> 2.11.0
>
