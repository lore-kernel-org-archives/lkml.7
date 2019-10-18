Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BF6CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 11:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D836221925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 11:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="YYyHH7Ap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442648AbfJRLYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 07:24:36 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:32907 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437774AbfJRLYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 07:24:36 -0400
Received: by mail-io1-f65.google.com with SMTP id z19so7044020ior.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 04:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jJSMc+2+5GYqksSKufbXgO26yb1io6vD/iUr7n3hUso=;
        b=YYyHH7ApNZr5FFuoNe0dGSJfF5aN+Z4j38b8z+cRkDPErsoPvRNNNa6YYLrRIPn8TP
         h1Gkq1+X3nN+P8GL8cNC+Le8Z3KXPpix4qwOEfpceBH8jKAQmjPfNY3JLaJjWZWMg9oc
         reWl/vUZVPN8q5NMqJheNzxehtFqksQCN99dU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jJSMc+2+5GYqksSKufbXgO26yb1io6vD/iUr7n3hUso=;
        b=g2X7msW4UlvASRtZMKcUdF0MUDtm6e+xbS7UojIOKyA/kkv0Y/2YOWFUCMy4t1SPJ9
         7gtIkconUSltqGOg2up7xQrRJEoPIE/BYe2/JciK3kqcEviUaVUUXGYpK3zuF4H6Tz0c
         73fDqAu5FBThtFIe5BXYcIWleXsAyjYH1G+apUeZ89FOBpx3GmZojNwo/2OgmSbufqTo
         gjWD3nqya4w3F+MJUr3LBily6cDhV/JpkvpiG+SBBgjpY4U4kTWGkj1cMXkaJaz58PQ+
         COaLuf9nhNXsd7xTAU5oPDVd/ceyNRZIBDIOVpD8YmrpdJclES5eXeLojBsydGA9g0fa
         0y6A==
X-Gm-Message-State: APjAAAXf0rdB6bU2RTU1p0Cydl97Gi/8tQDh4XV+7cU35CPt3DqN9R/d
        bFFqF7Ts39O4BvJbNrvQdc5fRRxUQYSqsTELwMDJjw==
X-Google-Smtp-Source: APXvYqw3YSi4qSvSEZjuGN+jEFZsDIFqYKZSpyJKLi9ZHmKjVvE+KHdERkAXWnm2qgZFcQVKW++oJDa8ftO/fNBqZjY=
X-Received: by 2002:a6b:b54c:: with SMTP id e73mr2692190iof.259.1571397874384;
 Fri, 18 Oct 2019 04:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20191010230414.647c29f34665ca26103879c4@gmail.com> <20191010230915.f68401e9c9e0fa053dcbe199@gmail.com>
In-Reply-To: <20191010230915.f68401e9c9e0fa053dcbe199@gmail.com>
From:   Dan Streetman <ddstreet@ieee.org>
Date:   Fri, 18 Oct 2019 07:23:57 -0400
Message-ID: <CALZtONAuO4FfM6z19qRCW8x9PvjocN-RT=0cJ7eRaH3kXDJqrg@mail.gmail.com>
Subject: Re: [PATCH 1/3] zpool: extend API to match zsmalloc
To:     Vitaly Wool <vitalywool@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Henry Burns <henrywolfeburns@gmail.com>,
        "Theodore Ts'o" <tytso@thunk.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 4:09 PM Vitaly Wool <vitalywool@gmail.com> wrote:
>
> This patch adds the following functions to the zpool API:
> - zpool_compact()
> - zpool_get_num_compacted()
> - zpool_huge_class_size()
>
> The first one triggers compaction for the underlying allocator, the
> second retrieves the number of pages migrated due to compaction for
> the whole time of this pool's existence and the third one returns
> the huge class size.
>
> This API extension is done to align zpool API with zsmalloc API.
>
> Signed-off-by: Vitaly Wool <vitalywool@gmail.com>

Seems reasonable to me.

Reviewed-by: Dan Streetman <ddstreet@ieee.org>

> ---
>  include/linux/zpool.h | 14 +++++++++++++-
>  mm/zpool.c            | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/zpool.h b/include/linux/zpool.h
> index 51bf43076165..31f0c1360569 100644
> --- a/include/linux/zpool.h
> +++ b/include/linux/zpool.h
> @@ -61,8 +61,13 @@ void *zpool_map_handle(struct zpool *pool, unsigned long handle,
>
>  void zpool_unmap_handle(struct zpool *pool, unsigned long handle);
>
> +unsigned long zpool_compact(struct zpool *pool);
> +
> +unsigned long zpool_get_num_compacted(struct zpool *pool);
> +
>  u64 zpool_get_total_size(struct zpool *pool);
>
> +size_t zpool_huge_class_size(struct zpool *zpool);
>
>  /**
>   * struct zpool_driver - driver implementation for zpool
> @@ -75,7 +80,10 @@ u64 zpool_get_total_size(struct zpool *pool);
>   * @shrink:    shrink the pool.
>   * @map:       map a handle.
>   * @unmap:     unmap a handle.
> - * @total_size:        get total size of a pool.
> + * @compact:   try to run compaction over a pool
> + * @get_num_compacted: get amount of compacted pages for a pool
> + * @total_size:        get total size of a pool
> + * @huge_class_size: huge class threshold for pool pages.
>   *
>   * This is created by a zpool implementation and registered
>   * with zpool.
> @@ -104,7 +112,11 @@ struct zpool_driver {
>                                 enum zpool_mapmode mm);
>         void (*unmap)(void *pool, unsigned long handle);
>
> +       unsigned long (*compact)(void *pool);
> +       unsigned long (*get_num_compacted)(void *pool);
> +
>         u64 (*total_size)(void *pool);
> +       size_t (*huge_class_size)(void *pool);
>  };
>
>  void zpool_register_driver(struct zpool_driver *driver);
> diff --git a/mm/zpool.c b/mm/zpool.c
> index 863669212070..55e69213c2eb 100644
> --- a/mm/zpool.c
> +++ b/mm/zpool.c
> @@ -362,6 +362,30 @@ void zpool_unmap_handle(struct zpool *zpool, unsigned long handle)
>         zpool->driver->unmap(zpool->pool, handle);
>  }
>
> + /**
> + * zpool_compact() - try to run compaction over zpool
> + * @pool       The zpool to compact
> + *
> + * Returns: the number of migrated pages
> + */
> +unsigned long zpool_compact(struct zpool *zpool)
> +{
> +       return zpool->driver->compact ? zpool->driver->compact(zpool->pool) : 0;
> +}
> +
> +
> +/**
> + * zpool_get_num_compacted() - get the number of migrated/compacted pages
> + * @pool       The zpool to get compaction statistic for
> + *
> + * Returns: the total number of migrated pages for the pool
> + */
> +unsigned long zpool_get_num_compacted(struct zpool *zpool)
> +{
> +       return zpool->driver->get_num_compacted ?
> +               zpool->driver->get_num_compacted(zpool->pool) : 0;
> +}
> +
>  /**
>   * zpool_get_total_size() - The total size of the pool
>   * @zpool:     The zpool to check
> @@ -375,6 +399,18 @@ u64 zpool_get_total_size(struct zpool *zpool)
>         return zpool->driver->total_size(zpool->pool);
>  }
>
> +/**
> + * zpool_huge_class_size() - get size for the "huge" class
> + * @pool       The zpool to check
> + *
> + * Returns: size of the huge class
> + */
> +size_t zpool_huge_class_size(struct zpool *zpool)
> +{
> +       return zpool->driver->huge_class_size ?
> +               zpool->driver->huge_class_size(zpool->pool) : 0;
> +}
> +
>  /**
>   * zpool_evictable() - Test if zpool is potentially evictable
>   * @zpool:     The zpool to test
> --
> 2.20.1
