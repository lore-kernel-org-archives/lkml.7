Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB03C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D5C222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiB/mqAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfLSOV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:21:56 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44557 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfLSOVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 09:21:55 -0500
Received: by mail-lj1-f194.google.com with SMTP id u71so6420148lje.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 06:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gofwvjfHv3OpfgHnS5zABByZ2BwnD9/VLkGxBh/tVfU=;
        b=WiB/mqAZ5AgK4mWB/04pDrsu5J3ScbjcrXxRkJwcLKm91NhUe8IvvUTONor6F0A3gH
         19dDsLf3/hz8GHot/TCP/m0hsK93Oot9SLDUsghv+t7Dgwu6++UWgSFHiVVPUUVq35S6
         EgTddRAERBaqN9C1MwvwsAugoFKdC7Z5KPePDxnXBYP6J9WnTFOddR58Cl2KbsOhyc97
         /V6L2So+t3zvjo5NzniUssdOWQ0WJ6Y6pwxKk5HvpyOBfBRNCoMlD2uuw7ciXjXmzEeT
         uILplQ0AxEos6IXc7g7SRVII1SPd87EcX/migVeLZoNhX1RJhhcK3r+vZ7S2SN+lmE0n
         PHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gofwvjfHv3OpfgHnS5zABByZ2BwnD9/VLkGxBh/tVfU=;
        b=jT71nSMqODdgrwUoMVwkOHTmNsyQfyxNzaDRcxJK0Hn8h8aZOqJNoeuft0/MhYDQhd
         hKJRzrChdD4eNRKiheAjPH0DGmGKxojnGDNCe3hGUmlm2F7Xb4BWSor2NiwOQ1hfFPNQ
         KTUJzyGrMskt/+KzccnqslRo0fuLeJKiq7BUfjR5PGrRhMJKgt8j9CR5mzoBw5piarrY
         /NVLtqMYEeOGwbr9k6dZnrQz317yasP74GzyqMwy7UjiPLVs8ye6J8jHixnwQ+CyDjIa
         lnhe2vMH2f9rdjjlyQm0P3FjeXiWPe8Z+G0Qng2nLGcppwbVlkOdb3R6ns1f8oMzQ4Ql
         7Miw==
X-Gm-Message-State: APjAAAUp50PEt47UNFIOeq0Oax8KTvFLVanU/9iA6WHQFTsk7JQ0jwGr
        vCa9GztcszLDq0D+wl7/nYs=
X-Google-Smtp-Source: APXvYqzf/gl2762BuLOYeikmN5C5VC3CQ+H9Afb70IeusMMpvUcm6hTtOZduBDnKaZt8uHwja2fH7A==
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr6068346ljj.97.1576765312270;
        Thu, 19 Dec 2019 06:21:52 -0800 (PST)
Received: from assa ([109.252.14.238])
        by smtp.gmail.com with ESMTPSA id 140sm2728532lfk.78.2019.12.19.06.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 06:21:51 -0800 (PST)
Date:   Thu, 19 Dec 2019 15:21:50 +0100
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
Subject: [PATCHv2 1/3] zpool: add compaction api
Message-Id: <20191219152150.1ed1900008a6ec867779f82e@gmail.com>
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

This patch adds the following functions to the zpool API:
- zpool_compact()
- zpool_get_num_compacted()
- zpool_huge_class_size()

The first one triggers compaction for the underlying allocator, the
second retrieves the number of pages migrated due to compaction for
the whole time of this pool's existence and the third one returns
the huge class size.

This API extension is done to align zpool API with zsmalloc API.

Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
---
 include/linux/zpool.h | 14 +++++++++++++-
 mm/zpool.c            | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/include/linux/zpool.h b/include/linux/zpool.h
index 51bf43076165..31f0c1360569 100644
--- a/include/linux/zpool.h
+++ b/include/linux/zpool.h
@@ -61,8 +61,13 @@ void *zpool_map_handle(struct zpool *pool, unsigned long handle,
 
 void zpool_unmap_handle(struct zpool *pool, unsigned long handle);
 
+unsigned long zpool_compact(struct zpool *pool);
+
+unsigned long zpool_get_num_compacted(struct zpool *pool);
+
 u64 zpool_get_total_size(struct zpool *pool);
 
+size_t zpool_huge_class_size(struct zpool *zpool);
 
 /**
  * struct zpool_driver - driver implementation for zpool
@@ -75,7 +80,10 @@ u64 zpool_get_total_size(struct zpool *pool);
  * @shrink:	shrink the pool.
  * @map:	map a handle.
  * @unmap:	unmap a handle.
- * @total_size:	get total size of a pool.
+ * @compact:	try to run compaction over a pool
+ * @get_num_compacted:	get amount of compacted pages for a pool
+ * @total_size:	get total size of a pool
+ * @huge_class_size: huge class threshold for pool pages.
  *
  * This is created by a zpool implementation and registered
  * with zpool.
@@ -104,7 +112,11 @@ struct zpool_driver {
 				enum zpool_mapmode mm);
 	void (*unmap)(void *pool, unsigned long handle);
 
+	unsigned long (*compact)(void *pool);
+	unsigned long (*get_num_compacted)(void *pool);
+
 	u64 (*total_size)(void *pool);
+	size_t (*huge_class_size)(void *pool);
 };
 
 void zpool_register_driver(struct zpool_driver *driver);
diff --git a/mm/zpool.c b/mm/zpool.c
index 863669212070..55e69213c2eb 100644
--- a/mm/zpool.c
+++ b/mm/zpool.c
@@ -362,6 +362,30 @@ void zpool_unmap_handle(struct zpool *zpool, unsigned long handle)
 	zpool->driver->unmap(zpool->pool, handle);
 }
 
+ /**
+ * zpool_compact() - try to run compaction over zpool
+ * @pool       The zpool to compact
+ *
+ * Returns: the number of migrated pages
+ */
+unsigned long zpool_compact(struct zpool *zpool)
+{
+	return zpool->driver->compact ? zpool->driver->compact(zpool->pool) : 0;
+}
+
+
+/**
+ * zpool_get_num_compacted() - get the number of migrated/compacted pages
+ * @pool       The zpool to get compaction statistic for
+ *
+ * Returns: the total number of migrated pages for the pool
+ */
+unsigned long zpool_get_num_compacted(struct zpool *zpool)
+{
+	return zpool->driver->get_num_compacted ?
+		zpool->driver->get_num_compacted(zpool->pool) : 0;
+}
+
 /**
  * zpool_get_total_size() - The total size of the pool
  * @zpool:	The zpool to check
@@ -375,6 +399,18 @@ u64 zpool_get_total_size(struct zpool *zpool)
 	return zpool->driver->total_size(zpool->pool);
 }
 
+/**
+ * zpool_huge_class_size() - get size for the "huge" class
+ * @pool	The zpool to check
+ *
+ * Returns: size of the huge class
+ */
+size_t zpool_huge_class_size(struct zpool *zpool)
+{
+	return zpool->driver->huge_class_size ?
+		zpool->driver->huge_class_size(zpool->pool) : 0;
+}
+
 /**
  * zpool_evictable() - Test if zpool is potentially evictable
  * @zpool:	The zpool to test
-- 
2.20.1
