Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557C5C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 23:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA9E2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 23:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgoRjWXY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfG3X7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 19:59:23 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35460 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfG3X7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 19:59:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id w20so64023046edd.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 16:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m6L07MYm2XUREWdGGxm/q3wDS0RhzZLGHAZkdnpAJv0=;
        b=UgoRjWXYlcZIgPmz9GDErbiOBm3M9jhIFl9wjh+Dc2ZlNE/L6VSVht0anlDxUG9UVu
         gb6hEZgc0N+p+UpQGFv34suB0UnrI0mhggxyBth8Xw35Uf9L1TZDS25N0DLJeI9qQvpF
         24a5+ulOqpD4mdk6/DBaFTR5ttxB7qwMTP7v1qMY4RxK/Xw3d5i4iD1N9gHf1G1YqWj5
         K8uWQvPYDlxPjIijdnoyLAiF7unrjLDI0ANrpXfDj1/3v+gTv1QSobwf6UJkHw8H+gdV
         pz1pQX4vpuFheYB0xJxgL7BLyqo0HnXZI6rfwpF1fIU5iFjOQC7OmqpN6gN1rkJM+NzR
         eRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m6L07MYm2XUREWdGGxm/q3wDS0RhzZLGHAZkdnpAJv0=;
        b=lUzwHj6d269omDsU9xp+d/Ujw+Xp+0YT1rHNjxZ7GJL+zLASvBUrw84IGbq4wP5Gos
         M0q/VkjAiRhCV7BtGLVUvkff12aPRXy2DYVYwU8kEGn3CdKxQkETNjau8OafpIn0b950
         /zJUIzrzG2urGfYh4/lxdLyZ2j1Hq92dMWwWpoCOGPlL9j7EcHYd5xvkocbd/gVxBAK1
         jeAOBj/PXIHcTbbHN/nAy+rbHn+s4ySau8JjpwrIkXhuIXntZaCDVp0/mOoLe7NqLKZK
         6iL69z20FrhYG+tcs+gFDr/A7fexxHq3Rwrcl3LIuRy/KMq9Heq0/tn1j8x1z1pE42UD
         kLyQ==
X-Gm-Message-State: APjAAAWEmPQRgW+0NpTKjK6xvgD5mjJRj1S0Qu4rztTbX1Ktrw4VUwPf
        cblJpT/weRKWJJRXqlJRfQjy6o93/Kmpp9T0eC0=
X-Google-Smtp-Source: APXvYqx4PX+CqhLKT8Fr6q2Ml2NHtV/F3E2eYjRMIvt5WgPWUpc5t44qvE7khZiUJJWtb50UqV+XTKXefqw+cMeXC74=
X-Received: by 2002:a17:906:6bc4:: with SMTP id t4mr94346685ejs.256.1564531161620;
 Tue, 30 Jul 2019 16:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190730225852.30319-1-robdclark@gmail.com>
In-Reply-To: <20190730225852.30319-1-robdclark@gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 30 Jul 2019 16:59:10 -0700
Message-ID: <CAF6AEGvLTbTQjH+-Gbk4Vr1Cp8aL5e+3XD=XoTabzX2YoRoBCw@mail.gmail.com>
Subject: Re: [PATCH] drm: add cache support for arm64
To:     dri-devel <dri-devel@lists.freedesktop.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 4:01 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
> Not sure about 32b arm, but at least for aarch64 this is relatively
> easy.  So lets at least enable for arm64.

hmm, bleh, I thought this was too easy.. I hadn't noticed that (even
though driver was =m) CONFIG_DRM was =y

Can we make drm_cache.o built-in even if the rest of drm is a module?

BR,
-R

>
>  drivers/gpu/drm/drm_cache.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_cache.c b/drivers/gpu/drm/drm_cache.c
> index 3bd76e918b5d..90105c637797 100644
> --- a/drivers/gpu/drm/drm_cache.c
> +++ b/drivers/gpu/drm/drm_cache.c
> @@ -69,6 +69,14 @@ static void drm_cache_flush_clflush(struct page *pages[],
>  }
>  #endif
>
> +#if defined(__powerpc__)
> +static void __flush_dcache_area(void *addr, size_t len)
> +{
> +       flush_dcache_range((unsigned long)addr,
> +                          (unsigned long)addr + PAGE_SIZE);
> +}
> +#endif
> +
>  /**
>   * drm_clflush_pages - Flush dcache lines of a set of pages.
>   * @pages: List of pages to be flushed.
> @@ -90,7 +98,7 @@ drm_clflush_pages(struct page *pages[], unsigned long num_pages)
>         if (wbinvd_on_all_cpus())
>                 pr_err("Timed out waiting for cache flush\n");
>
> -#elif defined(__powerpc__)
> +#elif defined(__powerpc__) || defined(CONFIG_ARM64)
>         unsigned long i;
>         for (i = 0; i < num_pages; i++) {
>                 struct page *page = pages[i];
> @@ -100,8 +108,7 @@ drm_clflush_pages(struct page *pages[], unsigned long num_pages)
>                         continue;
>
>                 page_virtual = kmap_atomic(page);
> -               flush_dcache_range((unsigned long)page_virtual,
> -                                  (unsigned long)page_virtual + PAGE_SIZE);
> +               __flush_dcache_area(page_virtual, PAGE_SIZE);
>                 kunmap_atomic(page_virtual);
>         }
>  #else
> @@ -135,6 +142,13 @@ drm_clflush_sg(struct sg_table *st)
>
>         if (wbinvd_on_all_cpus())
>                 pr_err("Timed out waiting for cache flush\n");
> +#elif defined(CONFIG_ARM64)
> +       struct sg_page_iter sg_iter;
> +
> +       for_each_sg_page(st->sgl, &sg_iter, st->nents, 0) {
> +               struct page *p = sg_page_iter_page(&sg_iter);
> +               drm_clflush_pages(&p, 1);
> +       }
>  #else
>         pr_err("Architecture has no drm_cache.c support\n");
>         WARN_ON_ONCE(1);
> --
> 2.21.0
>
