Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BECC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 01:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233EB217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 01:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbXK+ZRj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfCOBS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 21:18:59 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36420 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbfCOBS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 21:18:59 -0400
Received: by mail-ed1-f68.google.com with SMTP id e4so6270175edi.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 18:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=57nb8+i4njYf0Sx7vK0uz/Fy+Wk35vcKfI9GvYHLB2g=;
        b=JbXK+ZRjGhJk5BgVQdbUDEY/bLWxoWGXnCsqK8tlWR02Wm84qrfAZoWQ3eVrM9eYBC
         meYNhXoP9OMHPFElx0lyW2R4r4o5NnqL+RLQbhZQir++2KxEsNiHoI1ltttcNw05ToNl
         akU1K7vWbmDYV/NiiTS9VWhmxq3Q/2NQhsN9JtP+iT+psUuLDOp/6AnE/s0kT8C93SRb
         NCJ1IMjOR3N0vp0KJqhczBw/nKGRE5qQlW+2yeITcnFLyi60qbnD4tND+jt5kB15W057
         PRvzYzuhGap9BcOBPF6cJXAdtZ44/Aeoonuq9WWQHOuPX2szsAdNMZG/ydJGU+wOvREV
         8HvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=57nb8+i4njYf0Sx7vK0uz/Fy+Wk35vcKfI9GvYHLB2g=;
        b=oZ72XH0vgdclQZTX++eF4v0Rt67UtPmAUjDyHbz3tZsd/CJLRXzg99zpLCDhNdxjSF
         vRAQwv4sgrgtFqJl2DwX8dbfPUIWWrcJd2YG0fDSJEacku1iAkDAUdU9dFTUHOyaew0m
         Y5bLO7X/1U1e0d70ujZWaQbjXYXeA0Im9L6+RKxE1ei/3nxqtRU6Csi5J3rQOm9T0Zi3
         4WB3jsRLGiQH9KavYUcjh02Q0tyvhBv6vAUXPp2OVMWc+za3917ggR45cHDsjDV3wPZC
         RkP8h4k69aJoeZOh9n52mFpAyc+CITS6Z86068qrHtZnKVS/dlaUuorK+MBGR0d0jJq4
         e0YA==
X-Gm-Message-State: APjAAAU60sGO8NU7sQ89eaDrPq0D0ApxjCDuw9rlDfYE9VkPYHQEBkoU
        0IDRJAaqhq6h1/BnOD8s42bUOdZ/kRQ77TVxvSDlEQ==
X-Google-Smtp-Source: APXvYqxfzbc6r2Mr4gddCelRo8xtiwqUia9ABGaHbvMPuZ5Ju7GKsg1KT2Y8qfCbeFBZyEwfpIJW1NZxWX+nY3x4GJU=
X-Received: by 2002:a05:6402:1596:: with SMTP id c22mr876354edv.122.1552612737406;
 Thu, 14 Mar 2019 18:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <1552561932-23776-1-git-send-email-huangzhaoyang@gmail.com>
In-Reply-To: <1552561932-23776-1-git-send-email-huangzhaoyang@gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Fri, 15 Mar 2019 09:18:46 +0800
Message-ID: <CAGWkznF3T-2ZdFex1ZYpwZx8MB_d4+b7fOBxqVfrnYJ6bx3tuw@mail.gmail.com>
Subject: Re: [PATCH] driver : staging : ion: optimization for decreasing
 memory fragmentaion
To:     "open list:ANDROID ION DRIVER" <devel@driverdev.osuosl.org>,
        "open list:ANDROID ION DRIVER" <dri-devel@lists.freedesktop.org>,
        "moderated list:ANDROID ION DRIVER" <linaro-mm-sig@lists.linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
I would like to explain more for the purpose of this patch. During our
daily test on android system, we found that there is always showing
the memory fragmentation after some test cases(etc camera snapshot),
which lead to huge amount of order0 pages which other page blocks
remain none(200M order0 page blocks in a 1G RAM system). By analysing
the DDR dump file, we can find that it is the ION SYSTEM HEAP which
cut the whole memory into pieces. That is to say, Burst huge order0
allocation is alike a knife that cut higher order blocks into small
one and can not back to original buddy somehow.


On Thu, Mar 14, 2019 at 7:12 PM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> Two action for this patch:
> 1. set a batch size for system heap's shrinker, which can have it buffer
> reasonable page blocks in pool for future allocation.
> 2. reverse the order sequence when free page blocks, the purpose is also
> to have system heap keep as more big blocks as it can.
>
> By testing on an android system with 2G RAM, the changes with setting
> batch = 48MB can help reduce the fragmentation obviously and improve
> big block allocation speed for 15%.
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  drivers/staging/android/ion/ion_heap.c        | 12 +++++++++++-
>  drivers/staging/android/ion/ion_system_heap.c |  2 +-
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/android/ion/ion_heap.c b/drivers/staging/android/ion/ion_heap.c
> index 31db510..68aa970 100644
> --- a/drivers/staging/android/ion/ion_heap.c
> +++ b/drivers/staging/android/ion/ion_heap.c
> @@ -16,6 +16,8 @@
>  #include <linux/vmalloc.h>
>  #include "ion.h"
>
> +unsigned long ion_heap_batch;
> +
>  void *ion_heap_map_kernel(struct ion_heap *heap,
>                           struct ion_buffer *buffer)
>  {
> @@ -303,7 +305,15 @@ int ion_heap_init_shrinker(struct ion_heap *heap)
>         heap->shrinker.count_objects = ion_heap_shrink_count;
>         heap->shrinker.scan_objects = ion_heap_shrink_scan;
>         heap->shrinker.seeks = DEFAULT_SEEKS;
> -       heap->shrinker.batch = 0;
> +       heap->shrinker.batch = ion_heap_batch;
>
>         return register_shrinker(&heap->shrinker);
>  }
> +
> +static int __init ion_system_heap_batch_init(char *arg)
> +{
> +        ion_heap_batch = memparse(arg, NULL);
> +
> +       return 0;
> +}
> +early_param("ion_batch", ion_system_heap_batch_init);
> diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
> index 701eb9f..d249f8d 100644
> --- a/drivers/staging/android/ion/ion_system_heap.c
> +++ b/drivers/staging/android/ion/ion_system_heap.c
> @@ -182,7 +182,7 @@ static int ion_system_heap_shrink(struct ion_heap *heap, gfp_t gfp_mask,
>         if (!nr_to_scan)
>                 only_scan = 1;
>
> -       for (i = 0; i < NUM_ORDERS; i++) {
> +       for (i = NUM_ORDERS - 1; i >= 0; i--) {
>                 pool = sys_heap->pools[i];
>
>                 if (only_scan) {
> --
> 1.9.1
>
