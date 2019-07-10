Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23CCC74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 18:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707BF21530
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 18:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vh+2Jwx6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfGJSUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 14:20:42 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:41408 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbfGJSUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 14:20:41 -0400
Received: by mail-yb1-f195.google.com with SMTP id 13so1081977ybx.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 11:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i1+UD1I9LOzdxuTZsCLZbyXguKS89Lx3a1U1xfAOFks=;
        b=vh+2Jwx6JrbYMXBMbxhjpIH/ZBTSBPT1Hq0fZUUo4CLxMXsgClXgdGZzdNqBizZYlo
         zhJQA0IIppOmWVwv8uuUvvj0iCesRd6XV0aDIIBVahEILoVe1T9AW8JfH7kgk94vMKro
         1YxRItIpCfOnxBTFOlWh1mbbG3KcV76/yGbOs9SLqSCmWNSxZ4bkBGFjYPPmm0214DZa
         m+/mGrDxki6GraUyhLKD0bMjRthpHkwNJDnmPQhgydiCPDItFS8Qkilhu9XkebC4izeV
         CqeOfzKf7aPgziSQVFITTVtf898bXqVaVQz+XlH3sFvlUn8jPh904YXhpaniInK4iLKF
         YEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i1+UD1I9LOzdxuTZsCLZbyXguKS89Lx3a1U1xfAOFks=;
        b=aaD7Zt4mxYSDZRmcyyjK+JhVwYaKS491gnFoEO75wjAyce0f/V2MQdgEodOPtv848T
         qo8RtrbtOd0nN8JNU3CR5h5X8QbBL1PE+KvgHCo133Hri4l4Gj4zQ4+rcPlbVzg8CDiJ
         AMi03PTlIJXKQg+wSqfFkZ36/9T+/XHod/6AFXouHhPTfOKK5VA1Q+6yey1FTiL4Cr/A
         vTenQw1JCsUpSpGY+R2p12QH7oPxEEVKaKMtTxlqyZH+U+6PTd3J2he1654mV7Cp9Anf
         2GPJtVch/dlco4GX4qL1+IQRyH6DyKds0YXJ8ZCv6cAlzUstomOQKuRUGR35/ag9NlZi
         j3wA==
X-Gm-Message-State: APjAAAXOcHnAIgtsFXrgd9ciMBqFfdv/SaMX9+zOVSz/PVGQt1Ggt8ac
        3vqdZnA5EUKUkWVBc/LV5S0smSkZbe2+hX+nkFcGqg==
X-Google-Smtp-Source: APXvYqx+vlSRtb8++KxN6l3lI5xV7xySoJM2J9G54cgNHJ9R2fIXItQ5mVlTjT+IFK4RmuL4qyjo9+PWSQkFxsipuHY=
X-Received: by 2002:a25:d658:: with SMTP id n85mr19270594ybg.172.1562782840404;
 Wed, 10 Jul 2019 11:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190605100630.13293-1-teawaterz@linux.alibaba.com>
In-Reply-To: <20190605100630.13293-1-teawaterz@linux.alibaba.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 10 Jul 2019 11:20:29 -0700
Message-ID: <CALvZod45JPt_89GRzpWyuxSJHtNQSiweR2-dh+hpbTBi1EbPWw@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] zpool: Add malloc_support_movable to zpool_driver
To:     Hui Zhu <teawaterz@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com,
        Seth Jennings <sjenning@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: akpm@linux-foundation.org

On Wed, Jun 5, 2019 at 3:06 AM Hui Zhu <teawaterz@linux.alibaba.com> wrote:
>
> As a zpool_driver, zsmalloc can allocate movable memory because it
> support migate pages.
> But zbud and z3fold cannot allocate movable memory.
>
> This commit adds malloc_support_movable to zpool_driver.
> If a zpool_driver support allocate movable memory, set it to true.
> And add zpool_malloc_support_movable check malloc_support_movable
> to make sure if a zpool support allocate movable memory.
>
> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>

I was wondering why this patch is not picked up by Andrew yet. You
forgot to CC Andrew.

Andrew, the thread starts at:

http://lkml.kernel.org/r/20190605100630.13293-1-teawaterz@linux.alibaba.com

> ---
>  include/linux/zpool.h |  3 +++
>  mm/zpool.c            | 16 ++++++++++++++++
>  mm/zsmalloc.c         | 19 ++++++++++---------
>  3 files changed, 29 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/zpool.h b/include/linux/zpool.h
> index 7238865e75b0..51bf43076165 100644
> --- a/include/linux/zpool.h
> +++ b/include/linux/zpool.h
> @@ -46,6 +46,8 @@ const char *zpool_get_type(struct zpool *pool);
>
>  void zpool_destroy_pool(struct zpool *pool);
>
> +bool zpool_malloc_support_movable(struct zpool *pool);
> +
>  int zpool_malloc(struct zpool *pool, size_t size, gfp_t gfp,
>                         unsigned long *handle);
>
> @@ -90,6 +92,7 @@ struct zpool_driver {
>                         struct zpool *zpool);
>         void (*destroy)(void *pool);
>
> +       bool malloc_support_movable;
>         int (*malloc)(void *pool, size_t size, gfp_t gfp,
>                                 unsigned long *handle);
>         void (*free)(void *pool, unsigned long handle);
> diff --git a/mm/zpool.c b/mm/zpool.c
> index a2dd9107857d..863669212070 100644
> --- a/mm/zpool.c
> +++ b/mm/zpool.c
> @@ -238,6 +238,22 @@ const char *zpool_get_type(struct zpool *zpool)
>         return zpool->driver->type;
>  }
>
> +/**
> + * zpool_malloc_support_movable() - Check if the zpool support
> + * allocate movable memory
> + * @zpool:     The zpool to check
> + *
> + * This returns if the zpool support allocate movable memory.
> + *
> + * Implementations must guarantee this to be thread-safe.
> + *
> + * Returns: true if if the zpool support allocate movable memory, false if not
> + */
> +bool zpool_malloc_support_movable(struct zpool *zpool)
> +{
> +       return zpool->driver->malloc_support_movable;
> +}
> +
>  /**
>   * zpool_malloc() - Allocate memory
>   * @zpool:     The zpool to allocate from.
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 0787d33b80d8..8f3d9a4d46f4 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -437,15 +437,16 @@ static u64 zs_zpool_total_size(void *pool)
>  }
>
>  static struct zpool_driver zs_zpool_driver = {
> -       .type =         "zsmalloc",
> -       .owner =        THIS_MODULE,
> -       .create =       zs_zpool_create,
> -       .destroy =      zs_zpool_destroy,
> -       .malloc =       zs_zpool_malloc,
> -       .free =         zs_zpool_free,
> -       .map =          zs_zpool_map,
> -       .unmap =        zs_zpool_unmap,
> -       .total_size =   zs_zpool_total_size,
> +       .type =                   "zsmalloc",
> +       .owner =                  THIS_MODULE,
> +       .create =                 zs_zpool_create,
> +       .destroy =                zs_zpool_destroy,
> +       .malloc_support_movable = true,
> +       .malloc =                 zs_zpool_malloc,
> +       .free =                   zs_zpool_free,
> +       .map =                    zs_zpool_map,
> +       .unmap =                  zs_zpool_unmap,
> +       .total_size =             zs_zpool_total_size,
>  };
>
>  MODULE_ALIAS("zpool-zsmalloc");
> --
> 2.21.0 (Apple Git-120)
>
