Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F76ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346F8218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryxItFlv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfJJUUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 16:20:35 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40816 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJUUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:20:35 -0400
Received: by mail-lj1-f193.google.com with SMTP id 7so7535156ljw.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 13:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=80xeYmJXoz8ke/tvchUiNx1pIg6JQ6gSpQxw+B6BHy4=;
        b=ryxItFlvQpAhiU3n7yNflmHHDCvxFz/gQGPPzl7v7zLfCTGBAduETvbrgHjzqrxWvm
         9oI4hQ+OrHS7R6jMfYvAHsy9cYSFB9iFC6q1cy70UDe/O5vJ3ggtRQv3wZu5zNJeXaIY
         KkxXIqROZB8wzdqcu4PAK92UC8scKvfirQyy2f/W1eKAdFCWlqPjPCZedZPTujHGxaoM
         sRUxnvU6d/0g6RYdoa80mXtetOPjtVTlgb24CaI1BS5mPW5U31hffzdoN3rkO9z61KaZ
         hdgCDszgor29Phmbr0zFmiol0y1lILka+gfMF805ZXDEJEcUHdrf1/I3P73dznoaHBPm
         VRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=80xeYmJXoz8ke/tvchUiNx1pIg6JQ6gSpQxw+B6BHy4=;
        b=Oo4igNUzpQSxjElQCmRj/MZkEmWnlx/9WSb8wroDAzGaP4ajbEOefqDzr1MgHx8g96
         xqVFmdDVXafzXSij74JxKSYUusVtYpZoM7uR5N3vNbi9jPyorIBiLFDPBwssuPIEk9IV
         XtimCVQZiMIwObkE5kqtZKQFQgH+J5S3G+FYAROeSrTe2u2Sc83kdOwyOVHL2i3UcCeM
         9Ld8kYq0KWFYNKE82rKNJD11q0AMt0qjNY6oyDzzgVoCPXK1W2ZlfEJ4p6nbEWK/hMta
         pQBZj+ixpjbUmQSSBoxC4tYaH/mQtaYiIBQR9Br6G9HGMvDZwdRLmrT5XlSKo4lh+2GP
         bjEA==
X-Gm-Message-State: APjAAAXZmEH2waSBqosGwsc9rmZ2i7cuWeKO0q0MH/XlSQXMjMhWLQqS
        wXTSS0btIGUfMxnUwGLqqbI=
X-Google-Smtp-Source: APXvYqzgE/UisNTKPdcJjjUzTZqbUNEv07HwOJf18mUeTq2LPFZ3a5Pc71onpgghBvDxWxRqXo24bA==
X-Received: by 2002:a2e:957:: with SMTP id 84mr7199963ljj.245.1570738832570;
        Thu, 10 Oct 2019 13:20:32 -0700 (PDT)
Received: from vitaly-Dell-System-XPS-L322X (c188-150-241-161.bredband.comhem.se. [188.150.241.161])
        by smtp.gmail.com with ESMTPSA id 21sm1444207ljq.15.2019.10.10.13.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 13:20:31 -0700 (PDT)
Date:   Thu, 10 Oct 2019 23:20:30 +0300
From:   Vitaly Wool <vitalywool@gmail.com>
To:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Henry Burns <henrywolfeburns@gmail.com>,
        Theodore Ts'o <tytso@thunk.org>
Subject: [PATCH 3/3] zram: use common zpool interface
Message-Id: <20191010232030.af6444879413e76a780cd27e@gmail.com>
In-Reply-To: <20191010230414.647c29f34665ca26103879c4@gmail.com>
References: <20191010230414.647c29f34665ca26103879c4@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change ZRAM into using zpool API. This patch allows to use any
zpool compatible allocation backend with ZRAM. It is meant to make
no functional changes to ZRAM.

zpool-registered backend can be selected via the module parameter
or kernel boot string. 'zsmalloc' is taken by default.

Signed-off-by: Vitaly Wool <vitalywool@gmail.com>
---
 drivers/block/zram/Kconfig    |  3 ++-
 drivers/block/zram/zram_drv.c | 64 +++++++++++++++++++----------------
 drivers/block/zram/zram_drv.h |  4 +--
 3 files changed, 39 insertions(+), 32 deletions(-)

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index fe7a4b7d30cf..7248d5aa3468 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -1,8 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 config ZRAM
 	tristate "Compressed RAM block device support"
-	depends on BLOCK && SYSFS && ZSMALLOC && CRYPTO
+	depends on BLOCK && SYSFS && CRYPTO
 	select CRYPTO_LZO
+	select ZPOOL
 	help
 	  Creates virtual block devices called /dev/zramX (X = 0, 1, ...).
 	  Pages written to these disks are compressed and stored in memory
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index d58a359a6622..881f10f99a5d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -43,6 +43,9 @@ static DEFINE_MUTEX(zram_index_mutex);
 static int zram_major;
 static const char *default_compressor = "lzo-rle";
 
+#define BACKEND_PAR_BUF_SIZE	32
+static char backend_par_buf[BACKEND_PAR_BUF_SIZE];
+
 /* Module params (documentation at end) */
 static unsigned int num_devices = 1;
 /*
@@ -277,7 +280,7 @@ static ssize_t mem_used_max_store(struct device *dev,
 	down_read(&zram->init_lock);
 	if (init_done(zram)) {
 		atomic_long_set(&zram->stats.max_used_pages,
-				zs_get_total_pages(zram->mem_pool));
+			zpool_get_total_size(zram->mem_pool) >> PAGE_SHIFT);
 	}
 	up_read(&zram->init_lock);
 
@@ -1020,7 +1023,7 @@ static ssize_t compact_store(struct device *dev,
 		return -EINVAL;
 	}
 
-	zs_compact(zram->mem_pool);
+	zpool_compact(zram->mem_pool);
 	up_read(&zram->init_lock);
 
 	return len;
@@ -1048,17 +1051,14 @@ static ssize_t mm_stat_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct zram *zram = dev_to_zram(dev);
-	struct zs_pool_stats pool_stats;
 	u64 orig_size, mem_used = 0;
-	long max_used;
+	long max_used, num_compacted = 0;
 	ssize_t ret;
 
-	memset(&pool_stats, 0x00, sizeof(struct zs_pool_stats));
-
 	down_read(&zram->init_lock);
 	if (init_done(zram)) {
-		mem_used = zs_get_total_pages(zram->mem_pool);
-		zs_pool_stats(zram->mem_pool, &pool_stats);
+		mem_used = zpool_get_total_size(zram->mem_pool);
+		num_compacted = zpool_get_num_compacted(zram->mem_pool);
 	}
 
 	orig_size = atomic64_read(&zram->stats.pages_stored);
@@ -1068,11 +1068,11 @@ static ssize_t mm_stat_show(struct device *dev,
 			"%8llu %8llu %8llu %8lu %8ld %8llu %8lu %8llu\n",
 			orig_size << PAGE_SHIFT,
 			(u64)atomic64_read(&zram->stats.compr_data_size),
-			mem_used << PAGE_SHIFT,
+			mem_used,
 			zram->limit_pages << PAGE_SHIFT,
 			max_used << PAGE_SHIFT,
 			(u64)atomic64_read(&zram->stats.same_pages),
-			pool_stats.pages_compacted,
+			num_compacted,
 			(u64)atomic64_read(&zram->stats.huge_pages));
 	up_read(&zram->init_lock);
 
@@ -1133,27 +1133,30 @@ static void zram_meta_free(struct zram *zram, u64 disksize)
 	for (index = 0; index < num_pages; index++)
 		zram_free_page(zram, index);
 
-	zs_destroy_pool(zram->mem_pool);
+	zpool_destroy_pool(zram->mem_pool);
 	vfree(zram->table);
 }
 
 static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 {
 	size_t num_pages;
+	char *backend;
 
 	num_pages = disksize >> PAGE_SHIFT;
 	zram->table = vzalloc(array_size(num_pages, sizeof(*zram->table)));
 	if (!zram->table)
 		return false;
 
-	zram->mem_pool = zs_create_pool(zram->disk->disk_name);
+	backend = strlen(backend_par_buf) ? backend_par_buf : "zsmalloc";
+	zram->mem_pool = zpool_create_pool(backend, zram->disk->disk_name,
+					GFP_NOIO, NULL);
 	if (!zram->mem_pool) {
 		vfree(zram->table);
 		return false;
 	}
 
 	if (!huge_class_size)
-		huge_class_size = zs_huge_class_size(zram->mem_pool);
+		huge_class_size = zpool_huge_class_size(zram->mem_pool);
 	return true;
 }
 
@@ -1197,7 +1200,7 @@ static void zram_free_page(struct zram *zram, size_t index)
 	if (!handle)
 		return;
 
-	zs_free(zram->mem_pool, handle);
+	zpool_free(zram->mem_pool, handle);
 
 	atomic64_sub(zram_get_obj_size(zram, index),
 			&zram->stats.compr_data_size);
@@ -1246,7 +1249,7 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 
 	size = zram_get_obj_size(zram, index);
 
-	src = zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
+	src = zpool_map_handle(zram->mem_pool, handle, ZPOOL_MM_RO);
 	if (size == PAGE_SIZE) {
 		dst = kmap_atomic(page);
 		memcpy(dst, src, PAGE_SIZE);
@@ -1260,7 +1263,7 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 		kunmap_atomic(dst);
 		zcomp_stream_put(zram->comp);
 	}
-	zs_unmap_object(zram->mem_pool, handle);
+	zpool_unmap_handle(zram->mem_pool, handle);
 	zram_slot_unlock(zram, index);
 
 	/* Should NEVER happen. Return bio error if it does. */
@@ -1335,7 +1338,7 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 	if (unlikely(ret)) {
 		zcomp_stream_put(zram->comp);
 		pr_err("Compression failed! err=%d\n", ret);
-		zs_free(zram->mem_pool, handle);
+		zpool_free(zram->mem_pool, handle);
 		return ret;
 	}
 
@@ -1354,33 +1357,34 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 	 * if we have a 'non-null' handle here then we are coming
 	 * from the slow path and handle has already been allocated.
 	 */
-	if (!handle)
-		handle = zs_malloc(zram->mem_pool, comp_len,
+	if (handle == 0)
+		ret = zpool_malloc(zram->mem_pool, comp_len,
 				__GFP_KSWAPD_RECLAIM |
 				__GFP_NOWARN |
 				__GFP_HIGHMEM |
-				__GFP_MOVABLE);
-	if (!handle) {
+				__GFP_MOVABLE,
+				&handle);
+	if (ret) {
 		zcomp_stream_put(zram->comp);
 		atomic64_inc(&zram->stats.writestall);
-		handle = zs_malloc(zram->mem_pool, comp_len,
-				GFP_NOIO | __GFP_HIGHMEM |
-				__GFP_MOVABLE);
-		if (handle)
+		ret = zpool_malloc(zram->mem_pool, comp_len,
+				GFP_NOIO | __GFP_HIGHMEM | __GFP_MOVABLE,
+				&handle);
+		if (ret == 0)
 			goto compress_again;
 		return -ENOMEM;
 	}
 
-	alloced_pages = zs_get_total_pages(zram->mem_pool);
+	alloced_pages = zpool_get_total_size(zram->mem_pool) >> PAGE_SHIFT;
 	update_used_max(zram, alloced_pages);
 
 	if (zram->limit_pages && alloced_pages > zram->limit_pages) {
 		zcomp_stream_put(zram->comp);
-		zs_free(zram->mem_pool, handle);
+		zpool_free(zram->mem_pool, handle);
 		return -ENOMEM;
 	}
 
-	dst = zs_map_object(zram->mem_pool, handle, ZS_MM_WO);
+	dst = zpool_map_handle(zram->mem_pool, handle, ZPOOL_MM_WO);
 
 	src = zstrm->buffer;
 	if (comp_len == PAGE_SIZE)
@@ -1390,7 +1394,7 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 		kunmap_atomic(src);
 
 	zcomp_stream_put(zram->comp);
-	zs_unmap_object(zram->mem_pool, handle);
+	zpool_unmap_handle(zram->mem_pool, handle);
 	atomic64_add(comp_len, &zram->stats.compr_data_size);
 out:
 	/*
@@ -2136,6 +2140,8 @@ module_exit(zram_exit);
 
 module_param(num_devices, uint, 0);
 MODULE_PARM_DESC(num_devices, "Number of pre-created zram devices");
+module_param_string(backend, backend_par_buf, BACKEND_PAR_BUF_SIZE, S_IRUGO);
+MODULE_PARM_DESC(backend, "Compression storage (backend) name");
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Nitin Gupta <ngupta@vflare.org>");
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index f2fd46daa760..f4f51c6489ba 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -16,7 +16,7 @@
 #define _ZRAM_DRV_H_
 
 #include <linux/rwsem.h>
-#include <linux/zsmalloc.h>
+#include <linux/zpool.h>
 #include <linux/crypto.h>
 
 #include "zcomp.h"
@@ -91,7 +91,7 @@ struct zram_stats {
 
 struct zram {
 	struct zram_table_entry *table;
-	struct zs_pool *mem_pool;
+	struct zpool *mem_pool;
 	struct zcomp *comp;
 	struct gendisk *disk;
 	/* Prevent concurrent execution of device init */
-- 
2.20.1
