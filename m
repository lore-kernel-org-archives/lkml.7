Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A111CC2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636C224676
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohpdRq1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfLSO17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:27:59 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46438 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfLSO16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 09:27:58 -0500
Received: by mail-lf1-f65.google.com with SMTP id f15so4469075lfl.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 06:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i6l4Uk50/oOL+noZcGuNL6lOSRLFGNzbE/1V5CB31ww=;
        b=ohpdRq1KxvYwDxSyHLjzosO3l8bonluKTIhNc1I3nHbfz9VEgqSKXgWFpY/u7pYJ4y
         /NEFUEFd1oSpvynygS/xqLBM+Eu5z1diGzg1hM+zt6YYEkiOQpnssyn+OzTm7bmfF24L
         zDOS7EJOm+AymdkE+K9O5dwnTWvANcwz7Cg6WIN9BjRLJunmKPNV0TVpwwx1CivcNV05
         48Gi2eNcNWT/sUMMUaPN1YXaCoNdCpaeIN0zN/TWc+p9M4vfI+blktIv8FV+c1m4r089
         4ahG8Ac0O5khHOCz2qTiukHq0k8jYyOzKSe7QgRV9TufxVXRIsagoHlS+xIMXqV6ixpC
         JI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i6l4Uk50/oOL+noZcGuNL6lOSRLFGNzbE/1V5CB31ww=;
        b=EowAEmopqrRc8NdF63DBFA076EMbbO5ioexUjegFl2qfJZUecdDRmJCKFqxT6HPny7
         ivoGPmTH4Dcz+YpXhzVhBTfcj1ZbXt1ikxAVRgwzfoECs9v1hzTZpqQxPK0iRNAP7epf
         1ojctn0Wvhb6nH0z1ta/HeTH2Msea8kBsfxHOHc8GsYrrGkgD8aB070zdLKMiBqUF7lq
         OOI0wnkeovOn5mbft7oowmSa9eq6F0BurnRKq3KbZFSMvsZYevQleHqt0xD460d2bu6m
         QAnWqu6gT8L1tZDdpkjXT4VnWCxZ9ujBkJXoOSlvcPux+dE3RGy2bhl2Fb3Zicx7syIQ
         c8pA==
X-Gm-Message-State: APjAAAVKjAm6Ql4ExQtpg4kLwLVBPIiK/aXK/DztbHn+Wx7GJrGtG/zw
        FrsWBqiePmszYdpHIR6GEJI=
X-Google-Smtp-Source: APXvYqzoT884kgnRIRU9V8Sq7UVdq/29Qc6jrSLd/4jjgnrwznFdrLGJHcj3JwXwfhOf5x38i8G42Q==
X-Received: by 2002:a05:6512:48c:: with SMTP id v12mr5684318lfq.56.1576765675232;
        Thu, 19 Dec 2019 06:27:55 -0800 (PST)
Received: from assa (109-252-14-238.nat.spd-mgts.ru. [109.252.14.238])
        by smtp.gmail.com with ESMTPSA id p12sm2668497lfc.43.2019.12.19.06.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 06:27:54 -0800 (PST)
Date:   Thu, 19 Dec 2019 15:27:53 +0100
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
Subject: [PATCHv2 3/3] zram: use common zpool interface
Message-Id: <20191219152753.b30262676a6a3261490a49ab@gmail.com>
In-Reply-To: <20191219151928.ad4ccf732b64b7f8a26116db@gmail.com>
References: <20191219151928.ad4ccf732b64b7f8a26116db@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies ZRAM use a common "small allocator" API
(zpool). This is done to address increasing demand to deploy
ZRAM in systems where zsmalloc (which is currently the only
available ZRAM allocator backend) is not a perfect match or is
not applicable at all. An example of a system of the first type
is an embedded system using ZRAM block device as a swap where
quick application launch is critical for good user experience
since z3fold is substantially faster on read than zsmalloc [1].
A system of the second type is, for instance, the one with
hardware on-the-fly RAM compression/decompression where the
saved RAM space could be used for ZRAM but would require a
special allocator. These cases wre also discussed in detail
at LPC'2019 [2].

zpool-registered backend can be selected using ZRAM sysfs
interface on a per-device basis. 'zsmalloc' is taken by default.

This patch is transparent with regard to the existing ZRAM
functionality and does not change its default behavior.

[1] https://lkml.org/lkml/2019/10/21/743
[2] https://linuxplumbersconf.org/event/4/contributions/551/

Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
---
 drivers/block/zram/Kconfig    |   3 +-
 drivers/block/zram/zram_drv.c | 100 ++++++++++++++++++++++++----------
 drivers/block/zram/zram_drv.h |   6 +-
 3 files changed, 76 insertions(+), 33 deletions(-)

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
index 4285e75e52c3..189c326cbeee 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -43,6 +43,8 @@ static DEFINE_MUTEX(zram_index_mutex);
 static int zram_major;
 static const char *default_compressor = "lzo-rle";
 
+static const char *default_allocator = "zsmalloc";
+
 /* Module params (documentation at end) */
 static unsigned int num_devices = 1;
 /*
@@ -245,6 +247,14 @@ static ssize_t disksize_show(struct device *dev,
 	return scnprintf(buf, PAGE_SIZE, "%llu\n", zram->disksize);
 }
 
+static ssize_t allocator_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct zram *zram = dev_to_zram(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n", zram->allocator);
+}
+
 static ssize_t mem_limit_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 {
@@ -277,7 +287,7 @@ static ssize_t mem_used_max_store(struct device *dev,
 	down_read(&zram->init_lock);
 	if (init_done(zram)) {
 		atomic_long_set(&zram->stats.max_used_pages,
-				zs_get_total_pages(zram->mem_pool));
+			zpool_get_total_size(zram->mem_pool) >> PAGE_SHIFT);
 	}
 	up_read(&zram->init_lock);
 
@@ -1021,7 +1031,7 @@ static ssize_t compact_store(struct device *dev,
 		return -EINVAL;
 	}
 
-	zs_compact(zram->mem_pool);
+	zpool_compact(zram->mem_pool);
 	up_read(&zram->init_lock);
 
 	return len;
@@ -1049,17 +1059,14 @@ static ssize_t mm_stat_show(struct device *dev,
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
@@ -1069,11 +1076,11 @@ static ssize_t mm_stat_show(struct device *dev,
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
 
@@ -1134,7 +1141,7 @@ static void zram_meta_free(struct zram *zram, u64 disksize)
 	for (index = 0; index < num_pages; index++)
 		zram_free_page(zram, index);
 
-	zs_destroy_pool(zram->mem_pool);
+	zpool_destroy_pool(zram->mem_pool);
 	vfree(zram->table);
 }
 
@@ -1147,14 +1154,18 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 	if (!zram->table)
 		return false;
 
-	zram->mem_pool = zs_create_pool(zram->disk->disk_name);
+	zram->mem_pool = zpool_create_pool(zram->allocator,
+					zram->disk->disk_name,
+					GFP_NOIO, NULL);
 	if (!zram->mem_pool) {
+		pr_err("%s: not enough memory or wrong allocator '%s'\n",
+			__func__, zram->allocator);
 		vfree(zram->table);
 		return false;
 	}
 
 	if (!huge_class_size)
-		huge_class_size = zs_huge_class_size(zram->mem_pool);
+		huge_class_size = zpool_huge_class_size(zram->mem_pool);
 	return true;
 }
 
@@ -1198,7 +1209,7 @@ static void zram_free_page(struct zram *zram, size_t index)
 	if (!handle)
 		return;
 
-	zs_free(zram->mem_pool, handle);
+	zpool_free(zram->mem_pool, handle);
 
 	atomic64_sub(zram_get_obj_size(zram, index),
 			&zram->stats.compr_data_size);
@@ -1247,7 +1258,7 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 
 	size = zram_get_obj_size(zram, index);
 
-	src = zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
+	src = zpool_map_handle(zram->mem_pool, handle, ZPOOL_MM_RO);
 	if (size == PAGE_SIZE) {
 		dst = kmap_atomic(page);
 		memcpy(dst, src, PAGE_SIZE);
@@ -1261,7 +1272,7 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 		kunmap_atomic(dst);
 		zcomp_stream_put(zram->comp);
 	}
-	zs_unmap_object(zram->mem_pool, handle);
+	zpool_unmap_handle(zram->mem_pool, handle);
 	zram_slot_unlock(zram, index);
 
 	/* Should NEVER happen. Return bio error if it does. */
@@ -1336,7 +1347,7 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 	if (unlikely(ret)) {
 		zcomp_stream_put(zram->comp);
 		pr_err("Compression failed! err=%d\n", ret);
-		zs_free(zram->mem_pool, handle);
+		zpool_free(zram->mem_pool, handle);
 		return ret;
 	}
 
@@ -1355,33 +1366,34 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
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
@@ -1391,7 +1403,7 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 		kunmap_atomic(src);
 
 	zcomp_stream_put(zram->comp);
-	zs_unmap_object(zram->mem_pool, handle);
+	zpool_unmap_handle(zram->mem_pool, handle);
 	atomic64_add(comp_len, &zram->stats.compr_data_size);
 out:
 	/*
@@ -1752,6 +1764,32 @@ static ssize_t disksize_store(struct device *dev,
 	return err;
 }
 
+static ssize_t allocator_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t len)
+{
+	struct zram *zram = dev_to_zram(dev);
+	int ret;
+
+	down_write(&zram->init_lock);
+	if (init_done(zram)) {
+		pr_info("Cannot change disksize for initialized device\n");
+		ret = -EBUSY;
+		goto out;
+	}
+
+	if (len > sizeof(zram->allocator)) {
+		pr_info("Allocator backend name too long\n");
+		ret = -EINVAL;
+		goto out;
+	}
+	strlcpy(zram->allocator, buf, len);
+	ret = len;
+
+out:
+	up_write(&zram->init_lock);
+	return ret;
+}
+
 static ssize_t reset_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 {
@@ -1834,6 +1872,7 @@ static DEVICE_ATTR_WO(writeback);
 static DEVICE_ATTR_RW(writeback_limit);
 static DEVICE_ATTR_RW(writeback_limit_enable);
 #endif
+static DEVICE_ATTR_RW(allocator);
 
 static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_disksize.attr,
@@ -1857,6 +1896,7 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_bd_stat.attr,
 #endif
 	&dev_attr_debug_stat.attr,
+	&dev_attr_allocator.attr,
 	NULL,
 };
 
@@ -1954,7 +1994,7 @@ static int zram_add(void)
 	device_add_disk(NULL, zram->disk, zram_disk_attr_groups);
 
 	strlcpy(zram->compressor, default_compressor, sizeof(zram->compressor));
-
+	strlcpy(zram->allocator, default_allocator, sizeof(zram->allocator));
 	zram_debugfs_register(zram);
 	pr_info("Added device: %s\n", zram->disk->disk_name);
 	return device_id;
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index f2fd46daa760..8a649a553a7a 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -16,7 +16,7 @@
 #define _ZRAM_DRV_H_
 
 #include <linux/rwsem.h>
-#include <linux/zsmalloc.h>
+#include <linux/zpool.h>
 #include <linux/crypto.h>
 
 #include "zcomp.h"
@@ -28,6 +28,7 @@
 #define ZRAM_SECTOR_PER_LOGICAL_BLOCK	\
 	(1 << (ZRAM_LOGICAL_BLOCK_SHIFT - SECTOR_SHIFT))
 
+#define ZRAM_MAX_ALLOCATOR_NAME	64
 
 /*
  * The lower ZRAM_FLAG_SHIFT bits of table.flags is for
@@ -91,7 +92,7 @@ struct zram_stats {
 
 struct zram {
 	struct zram_table_entry *table;
-	struct zs_pool *mem_pool;
+	struct zpool *mem_pool;
 	struct zcomp *comp;
 	struct gendisk *disk;
 	/* Prevent concurrent execution of device init */
@@ -108,6 +109,7 @@ struct zram {
 	 */
 	u64 disksize;	/* bytes */
 	char compressor[CRYPTO_MAX_ALG_NAME];
+	char allocator[ZRAM_MAX_ALLOCATOR_NAME];
 	/*
 	 * zram is claimed so open request will be failed
 	 */
-- 
2.20.1
