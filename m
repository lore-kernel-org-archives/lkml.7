Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3861DC28CC5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 09:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE41278AC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 09:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfFBJqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 05:46:31 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:37016 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725977AbfFBJqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 05:46:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TTD1lNX_1559468776;
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0TTD1lNX_1559468776)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 02 Jun 2019 17:46:25 +0800
From:   Hui Zhu <teawaterz@linux.alibaba.com>
To:     ddstreet@ieee.org, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, sjenning@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hui Zhu <teawaterz@linux.alibaba.com>
Subject: [PATCH V2 1/2] zpool: Add malloc_support_movable to zpool_driver
Date:   Sun,  2 Jun 2019 17:46:06 +0800
Message-Id: <20190602094607.41840-1-teawaterz@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a zpool_driver, zsmalloc can allocate movable memory because it
support migate pages.
But zbud and z3fold cannot allocate movable memory.

This commit adds malloc_support_movable to zpool_driver.
If a zpool_driver support allocate movable memory, set it to true.
And add zpool_malloc_support_movable check malloc_support_movable
to make sure if a zpool support allocate movable memory.

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 include/linux/zpool.h |  3 +++
 mm/zpool.c            | 16 ++++++++++++++++
 mm/zsmalloc.c         | 19 ++++++++++---------
 3 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/include/linux/zpool.h b/include/linux/zpool.h
index 7238865e75b0..51bf43076165 100644
--- a/include/linux/zpool.h
+++ b/include/linux/zpool.h
@@ -46,6 +46,8 @@ const char *zpool_get_type(struct zpool *pool);
 
 void zpool_destroy_pool(struct zpool *pool);
 
+bool zpool_malloc_support_movable(struct zpool *pool);
+
 int zpool_malloc(struct zpool *pool, size_t size, gfp_t gfp,
 			unsigned long *handle);
 
@@ -90,6 +92,7 @@ struct zpool_driver {
 			struct zpool *zpool);
 	void (*destroy)(void *pool);
 
+	bool malloc_support_movable;
 	int (*malloc)(void *pool, size_t size, gfp_t gfp,
 				unsigned long *handle);
 	void (*free)(void *pool, unsigned long handle);
diff --git a/mm/zpool.c b/mm/zpool.c
index a2dd9107857d..863669212070 100644
--- a/mm/zpool.c
+++ b/mm/zpool.c
@@ -238,6 +238,22 @@ const char *zpool_get_type(struct zpool *zpool)
 	return zpool->driver->type;
 }
 
+/**
+ * zpool_malloc_support_movable() - Check if the zpool support
+ * allocate movable memory
+ * @zpool:	The zpool to check
+ *
+ * This returns if the zpool support allocate movable memory.
+ *
+ * Implementations must guarantee this to be thread-safe.
+ *
+ * Returns: true if if the zpool support allocate movable memory, false if not
+ */
+bool zpool_malloc_support_movable(struct zpool *zpool)
+{
+	return zpool->driver->malloc_support_movable;
+}
+
 /**
  * zpool_malloc() - Allocate memory
  * @zpool:	The zpool to allocate from.
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 0787d33b80d8..8f3d9a4d46f4 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -437,15 +437,16 @@ static u64 zs_zpool_total_size(void *pool)
 }
 
 static struct zpool_driver zs_zpool_driver = {
-	.type =		"zsmalloc",
-	.owner =	THIS_MODULE,
-	.create =	zs_zpool_create,
-	.destroy =	zs_zpool_destroy,
-	.malloc =	zs_zpool_malloc,
-	.free =		zs_zpool_free,
-	.map =		zs_zpool_map,
-	.unmap =	zs_zpool_unmap,
-	.total_size =	zs_zpool_total_size,
+	.type =			  "zsmalloc",
+	.owner =		  THIS_MODULE,
+	.create =		  zs_zpool_create,
+	.destroy =		  zs_zpool_destroy,
+	.malloc_support_movable = true,
+	.malloc =		  zs_zpool_malloc,
+	.free =			  zs_zpool_free,
+	.map =			  zs_zpool_map,
+	.unmap =		  zs_zpool_unmap,
+	.total_size =		  zs_zpool_total_size,
 };
 
 MODULE_ALIAS("zpool-zsmalloc");
-- 
2.20.1 (Apple Git-117)

