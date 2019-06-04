Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB67C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335662075B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gBDHtkDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfFDRML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 13:12:11 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41888 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbfFDRML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 13:12:11 -0400
Received: by mail-yw1-f67.google.com with SMTP id y185so4121993ywy.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 10:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2htaCOivl5sTuLqYX7DBsUd0R0AxIhk6VW2s3pZYFbg=;
        b=gBDHtkDlkiEXkZDK7DqLEXR9KIC8iQ6US7e3B/MS/Xe2ggmln1v9lBBLoX1n7KBEdR
         +Z1skXE5N9KSUfRFN7bFLbBI2PXVIwqhF0srbQOoTt+IBuE+IPstonebw8ER0ejx3Jfu
         QiCZiWVkBuh0gMTef01fniwzPzmjvzrQQcOIxPgxM4KcwL+sC/Dm30PBe9pixcE5nl2o
         l11wfLa8FXKXaHJecuf9ZSmqzE7QjinPlX3s4iivEcVM0FXEP0aohbRJZnAktQx3CSE+
         WNBFb9aGQIiUzCoUM1Tvl8CZ5o900oXa6v4VtA2uKGt2lSPxJMuVwiRh9vts9i1/lMHN
         pumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2htaCOivl5sTuLqYX7DBsUd0R0AxIhk6VW2s3pZYFbg=;
        b=pVLGWyNIqe1g4KSC+gF/0OW+0V+ymearRCUUcJ8+qWjND3to60zbC5cf6pi9MOSzdD
         Q+BssjzC50pNMJQMrJOwmDKsufvdofbMzosnzgiNz7GOoRv85cPk4RHdQLSzIrDWwRal
         V2KKbCrsTvkCsOzJ+lMQkTB9GDyrrq3MBRPHpU/R22kOqnOec7gHjTqMiOpLB+EGN9t4
         TZU/xMM+JTVd/QF+lQIWxVyWfFYdy1NdEWQsHEin6/DXo/n9u5e7ksQYV278Ev4/gCrq
         KYJIDKl+ArArjaIBorjuHSDSqGSdbsOpTbF0sWn7on1UL4+fwr1cRyUDziPL2k1Yo1RN
         /xRQ==
X-Gm-Message-State: APjAAAVaGTWYNY3wGhNTBwoRE9XE8vzZ5GKnAwOkAXyut0m3g5K9VkT2
        PzDWtebbBtcV7vmhDlpEYewkv9y89zExMYNEbKs5yfWJzqc=
X-Google-Smtp-Source: APXvYqyC1KlVktZJWE/L0OLH7BkBTiKvAxjSWjPPEGSAjnfDlH8KuO3J18ld1TsQ3Oi+hVy3SZRNT8CelnL4zUPfI20=
X-Received: by 2002:a81:4e94:: with SMTP id c142mr4317513ywb.398.1559668329458;
 Tue, 04 Jun 2019 10:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190602094607.41840-1-teawaterz@linux.alibaba.com> <20190602094607.41840-2-teawaterz@linux.alibaba.com>
In-Reply-To: <20190602094607.41840-2-teawaterz@linux.alibaba.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 4 Jun 2019 10:11:58 -0700
Message-ID: <CALvZod7WX0_Eu8eDLSwze=Kf07d6ysAM5DdSqqtkscVikPpSWQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] zswap: Add module parameter malloc_movable_if_support
To:     Hui Zhu <teawaterz@linux.alibaba.com>
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

On Sun, Jun 2, 2019 at 2:47 AM Hui Zhu <teawaterz@linux.alibaba.com> wrote:
>
> This is the second version that was updated according to the comments
> from Sergey Senozhatsky in https://lkml.org/lkml/2019/5/29/73
>
> zswap compresses swap pages into a dynamically allocated RAM-based
> memory pool.  The memory pool should be zbud, z3fold or zsmalloc.
> All of them will allocate unmovable pages.  It will increase the
> number of unmovable page blocks that will bad for anti-fragment.
>
> zsmalloc support page migration if request movable page:
>         handle = zs_malloc(zram->mem_pool, comp_len,
>                 GFP_NOIO | __GFP_HIGHMEM |
>                 __GFP_MOVABLE);
>
> And commit "zpool: Add malloc_support_movable to zpool_driver" add
> zpool_malloc_support_movable check malloc_support_movable to make
> sure if a zpool support allocate movable memory.
>
> This commit adds module parameter malloc_movable_if_support to enable
> or disable zpool allocate block with gfp __GFP_HIGHMEM | __GFP_MOVABLE
> if it support allocate movable memory (disabled by default).
>
> Following part is test log in a pc that has 8G memory and 2G swap.
>
> When it disabled:
>  echo lz4 > /sys/module/zswap/parameters/compressor
>  echo zsmalloc > /sys/module/zswap/parameters/zpool
>  echo 1 > /sys/module/zswap/parameters/enabled
>  swapon /swapfile
>  cd /home/teawater/kernel/vm-scalability/
> /home/teawater/kernel/vm-scalability# export unit_size=$((9 * 1024 * 1024 * 1024))
> /home/teawater/kernel/vm-scalability# ./case-anon-w-seq
> 2717908992 bytes / 3977932 usecs = 667233 KB/s
> 2717908992 bytes / 4160702 usecs = 637923 KB/s
> 2717908992 bytes / 4354611 usecs = 609516 KB/s
> 293359 usecs to free memory
> 340304 usecs to free memory
> 205781 usecs to free memory
> 2717908992 bytes / 5588016 usecs = 474982 KB/s
> 166124 usecs to free memory
> /home/teawater/kernel/vm-scalability# cat /proc/pagetypeinfo
> Page block order: 9
> Pages per block:  512
>
> Free pages count per migrate type at order       0      1      2      3      4      5      6      7      8      9     10
> Node    0, zone      DMA, type    Unmovable      1      1      1      0      2      1      1      0      1      0      0
> Node    0, zone      DMA, type      Movable      0      0      0      0      0      0      0      0      0      1      3
> Node    0, zone      DMA, type  Reclaimable      0      0      0      0      0      0      0      0      0      0      0
> Node    0, zone      DMA, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
> Node    0, zone      DMA, type          CMA      0      0      0      0      0      0      0      0      0      0      0
> Node    0, zone      DMA, type      Isolate      0      0      0      0      0      0      0      0      0      0      0
> Node    0, zone    DMA32, type    Unmovable      5     10      9      8      8      5      1      2      3      0      0
> Node    0, zone    DMA32, type      Movable     15     16     14     12     14     10      9      6      6      5    776
> Node    0, zone    DMA32, type  Reclaimable      0      0      0      0      0      0      0      0      0      0      0
> Node    0, zone    DMA32, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
> Node    0, zone    DMA32, type          CMA      0      0      0      0      0      0      0      0      0      0      0
> Node    0, zone    DMA32, type      Isolate      0      0      0      0      0      0      0      0      0      0      0
> Node    0, zone   Normal, type    Unmovable   7097   6914   6473   5642   4373   2664   1220    319     78      4      0
> Node    0, zone   Normal, type      Movable   2092   3216   2820   2266   1585    946    559    359    237    258    378
> Node    0, zone   Normal, type  Reclaimable     47     88    122     80     34      9      5      4      2      1      2
> Node    0, zone   Normal, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
> Node    0, zone   Normal, type          CMA      0      0      0      0      0      0      0      0      0      0      0
> Node    0, zone   Normal, type      Isolate      0      0      0      0      0      0      0      0      0      0      0
>
> Number of blocks type     Unmovable      Movable  Reclaimable   HighAtomic          CMA      Isolate
> Node 0, zone      DMA            1            7            0            0            0            0
> Node 0, zone    DMA32            4         1652            0            0            0            0
> Node 0, zone   Normal          834         1572           25            0            0            0
>
> When it enabled:
>  echo lz4 > /sys/module/zswap/parameters/compressor
>  echo zsmalloc > /sys/module/zswap/parameters/zpool
>  echo 1 > /sys/module/zswap/parameters/enabled
>  echo 1 > /sys/module/zswap/parameters/malloc_movable_if_support
>  swapon /swapfile
>  cd /home/teawater/kernel/vm-scalability/
> /home/teawater/kernel/vm-scalability# export unit_size=$((9 * 1024 * 1024 * 1024))
> /home/teawater/kernel/vm-scalability# ./case-anon-w-seq
> 2717908992 bytes / 4721401 usecs = 562165 KB/s
> 2717908992 bytes / 4783167 usecs = 554905 KB/s
> 2717908992 bytes / 4802125 usecs = 552715 KB/s
> 2717908992 bytes / 4866579 usecs = 545395 KB/s
> 323605 usecs to free memory
> 414817 usecs to free memory
> 458576 usecs to free memory
> 355827 usecs to free memory
> /home/teawater/kernel/vm-scalability# cat /proc/pagetypeinfo
> Page block order: 9
> Pages per block:  512
>
> Free pages count per migrate type at order       0      1      2      3      4      5      6      7      8      9     10
> Node    0, zone      DMA, type    Unmovable      1      1      1      0      2      1      1      0      1      0      0
> Node    0, zone      DMA, type      Movable      0      0      0      0      0      0      0      0      0      1      3
> Node    0, zone      DMA, type  Reclaimable      0      0      0      0      0      0      0      0      0      0      0
> Node    0, zone      DMA, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
> Node    0, zone      DMA, type          CMA      0      0      0      0      0      0      0      0      0      0      0
> Node    0, zone      DMA, type      Isolate      0      0      0      0      0      0      0      0      0      0      0
> Node    0, zone    DMA32, type    Unmovable      8     10      8      7      7      6      5      3      2      0      0
> Node    0, zone    DMA32, type      Movable     23     21     18     15     13     14     14     10     11      6    766
> Node    0, zone    DMA32, type  Reclaimable      0      0      0      0      0      0      0      0      0      0      1
> Node    0, zone    DMA32, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
> Node    0, zone    DMA32, type          CMA      0      0      0      0      0      0      0      0      0      0      0
> Node    0, zone    DMA32, type      Isolate      0      0      0      0      0      0      0      0      0      0      0
> Node    0, zone   Normal, type    Unmovable   2660   1295    460    102     11      5      3     11      2      4      0
> Node    0, zone   Normal, type      Movable   4178   5760   5045   4137   3324   2306   1482    930    497    254    460
> Node    0, zone   Normal, type  Reclaimable     50     83    114     93     28     12     10      6      3      3      0
> Node    0, zone   Normal, type   HighAtomic      0      0      0      0      0      0      0      0      0      0      0
> Node    0, zone   Normal, type          CMA      0      0      0      0      0      0      0      0      0      0      0
> Node    0, zone   Normal, type      Isolate      0      0      0      0      0      0      0      0      0      0      0
>
> Number of blocks type     Unmovable      Movable  Reclaimable   HighAtomic          CMA      Isolate
> Node 0, zone      DMA            1            7            0            0            0            0
> Node 0, zone    DMA32            4         1650            2            0            0            0
> Node 0, zone   Normal           81         2325           25            0            0            0
>
> You can see that the number of unmovable page blocks is decreased
> when malloc_movable_if_support is enabled.
>
> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
> ---
>  mm/zswap.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index a4e4d36ec085..2fc45de92383 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -123,6 +123,13 @@ static bool zswap_same_filled_pages_enabled = true;
>  module_param_named(same_filled_pages_enabled, zswap_same_filled_pages_enabled,
>                    bool, 0644);
>
> +/* Enable/disable zpool allocate block with gfp __GFP_HIGHMEM | __GFP_MOVABLE
> + * if it support allocate movable memory (disabled by default).
> + */
> +static bool __read_mostly zswap_malloc_movable_if_support;
> +module_param_cb(malloc_movable_if_support, &param_ops_bool,
> +               &zswap_malloc_movable_if_support, 0644);
> +

Any reason for the above tunable? Do we ever want to disable movable
for zswap+zsmalloc?

>  /*********************************
>  * data structures
>  **********************************/
> @@ -1006,6 +1013,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
>         char *buf;
>         u8 *src, *dst;
>         struct zswap_header zhdr = { .swpentry = swp_entry(type, offset) };
> +       gfp_t gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
>
>         /* THP isn't supported */
>         if (PageTransHuge(page)) {
> @@ -1079,9 +1087,11 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
>
>         /* store */
>         hlen = zpool_evictable(entry->pool->zpool) ? sizeof(zhdr) : 0;
> -       ret = zpool_malloc(entry->pool->zpool, hlen + dlen,
> -                          __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM,
> -                          &handle);
> +       if (zswap_malloc_movable_if_support &&
> +               zpool_malloc_support_movable(entry->pool->zpool)) {
> +               gfp |= __GFP_HIGHMEM | __GFP_MOVABLE;
> +       }
> +       ret = zpool_malloc(entry->pool->zpool, hlen + dlen, gfp, &handle);
>         if (ret == -ENOSPC) {
>                 zswap_reject_compress_poor++;
>                 goto put_dstmem;
> --
> 2.20.1 (Apple Git-117)
>
