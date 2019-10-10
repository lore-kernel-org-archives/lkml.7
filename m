Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56B8C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98ACE206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SH+HoBZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfJJUJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 16:09:21 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45998 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJUJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:09:20 -0400
Received: by mail-lf1-f66.google.com with SMTP id r134so5337316lff.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 13:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=30hz3u6HKVQsiTqmh/RFo8C++yvFx01bv6SBJxIy2V8=;
        b=SH+HoBZRgBKYncT5ELFt9CejheKjs+0Ekv4JGeAw5r6KbOR5CB5WsrhKvxcb+JBSFX
         wLduQNQTvNPiFvzQ9cmhENZaegY9EvdapgVvRmcCHI/dHFAIvs8n4rad8UIARmpVzARm
         7Gk3udm9WhelqGOhjiEA/4N6fJwMVdkz8Y3RinmWx6E3ohR6v6ENlcVV9NgIiBfMg08q
         o+bbwChuzjoFyLcO0aPRXNykVBqohh+qhnkVD4lmewA00dJ1lLcngLsyqJON33nzg9Ll
         iJunuE0/pJ3V6NGDnZATvkDOUwA+rvt5dz7pNDWIYQ+TBRftcEPqExkOZbiV6Uu7XF0n
         Mayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=30hz3u6HKVQsiTqmh/RFo8C++yvFx01bv6SBJxIy2V8=;
        b=qR+qKrKzNoJHOM9oDQrHBFMu4HfD9bMMZTrMAZTcs5yhnhG7qWwdrTCGCxwKgreqbd
         7XoKAZr1d96gtDKSPKcubEswL7oQAQYzZnobn29EWFyCgcQ1lAzJWa/o023mGnR+Gkz8
         0xGwD55vMNR5PCGKkqOAhSTEQDgqh0YAcm10gzky9SnEq7jG3DxpKmgvUq63SKp/zZfS
         L4V5SGeo8uA8HZFR2LjMXa/ADQwo4mhyeFsjyCHnEpweRkvzAWzc2w6JlU7aEJbKYKie
         CK1fFbk8B+pxeFoEjpWh/Pudrs+MexDnLXJCrXGUL6iq8yZGVixeXEkZtTJ19aqSLeGg
         u9XQ==
X-Gm-Message-State: APjAAAWse5awmT0D+tpLKvmuXnQ2v5RG6D4H0nn53Wa8xGyrOKH2DGqM
        orXo5MK+uqes0FssWFyC3zk=
X-Google-Smtp-Source: APXvYqyi5UGtrwouzNPae0v9xOAN80h6C1gzyxknZjfPCdeHHIFdBqki6pp7lhHiVirvOhINpJdMtA==
X-Received: by 2002:ac2:5924:: with SMTP id v4mr6919119lfi.29.1570738157797;
        Thu, 10 Oct 2019 13:09:17 -0700 (PDT)
Received: from vitaly-Dell-System-XPS-L322X (c188-150-241-161.bredband.comhem.se. [188.150.241.161])
        by smtp.gmail.com with ESMTPSA id i6sm1501422lfo.83.2019.10.10.13.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 13:09:16 -0700 (PDT)
Date:   Thu, 10 Oct 2019 23:09:15 +0300
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
Subject: [PATCH 1/3] zpool: extend API to match zsmalloc
Message-Id: <20191010230915.f68401e9c9e0fa053dcbe199@gmail.com>
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

This patch adds the following functions to the zpool API:
- zpool_compact()
- zpool_get_num_compacted()
- zpool_huge_class_size()

The first one triggers compaction for the underlying allocator, the
second retrieves the number of pages migrated due to compaction for
the whole time of this pool's existence and the third one returns
the huge class size.

This API extension is done to align zpool API with zsmalloc API.

Signed-off-by: Vitaly Wool <vitalywool@gmail.com>
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
