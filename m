Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4126CC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 14:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168632171F
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 14:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmJ5hx5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732352AbfIPOqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 10:46:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40864 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfIPOqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 10:46:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so130603pgj.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 07:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d7Q0z2EasZ8/1ldA12KLzNbebPjqFp3ShlnBdaO1amY=;
        b=BmJ5hx5bZeYzBaMASNSBw7TKgI8T7IVDzo+AXUN2oSUIlaTP7YJxGtSd0pJWV1Vs9r
         6ZAn7Ja08Yrd3PP4tJ/j03GSLhLfjub1yp/1hMNM4ZACT89L7mS3gWZFe5Y4AS6WuCxv
         Uq1eECAtwGOmRZoCKIImWTnydyaGZJxL77AvGPnUo2bJKH3h9uZZVN9OJ69WldsdCLVb
         BzX/FLRAMZL75nm5ozBNb1RWKrf15wKqnqlVPi60uhPqI5xLdNwDf2yy9htLeVZ5wiNz
         4PqAS9SV/5Huxe9n45jQMKxeLK4Bi9thYUvQiw+3v22lZevqW7D78kaCUJVhKh7bHfsc
         /c6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d7Q0z2EasZ8/1ldA12KLzNbebPjqFp3ShlnBdaO1amY=;
        b=LJbX3xq4rs9BCnYGV2Mx2vP4yGW9YCQIU5eqCfMatID47veLHXKGgq5vDcvdWP4rkZ
         KVw/TSypDD09RsBOkV+WNeOUZf66vgxIrzRVj3/Q9q8iCxu3PUWvnt2zpxU7bZZDKJwY
         0d+kPJLB3M9m/ErNgkix5GEpGJJCjj6TmxKuFdLOAQsytL3REGfFR1ZJJ4huadAcOGC4
         HvvV7XqiR66WKKyxw2DT5GVxG5Mpgknq0aTN2ux4PIai9D+wxHambY0oI68y847zv2ap
         0Th8/COWrppLYh1XXcJNMqrZTjmcYKhoXwClVm0goUthU2Y/A+k7LauNfMiN9lrXctBb
         KxKw==
X-Gm-Message-State: APjAAAUH+3VQbor0aDt1LkAvdrp+sumL7h/B1qJgCInGUV3TzfGNGYXa
        9JHZEf49cRzd14DtcUGZ34g=
X-Google-Smtp-Source: APXvYqyZZupA7waxaBg53lTnH6e5LUJ+eqZAgQ/hO1ZOP8yq6SUAJruqY8t8GbSlhBFk9FUwd8J4Vw==
X-Received: by 2002:a62:75d2:: with SMTP id q201mr71101005pfc.43.1568645203635;
        Mon, 16 Sep 2019 07:46:43 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:160:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id d190sm15036004pgc.25.2019.09.16.07.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 07:46:42 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guro@fb.com,
        Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH v5 2/7] mm, slab: Remove unused kmalloc_size()
Date:   Mon, 16 Sep 2019 22:45:53 +0800
Message-Id: <20190916144558.27282-3-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916144558.27282-1-lpf.vector@gmail.com>
References: <20190916144558.27282-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The size of kmalloc can be obtained from kmalloc_info[],
so remove kmalloc_size() that will not be used anymore.

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: David Rientjes <rientjes@google.com>
---
 include/linux/slab.h | 20 --------------------
 mm/slab.c            |  5 +++--
 mm/slab_common.c     |  5 ++---
 3 files changed, 5 insertions(+), 25 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 56c9c7eed34e..e773e5764b7b 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -557,26 +557,6 @@ static __always_inline void *kmalloc(size_t size, gfp_t flags)
 	return __kmalloc(size, flags);
 }
 
-/*
- * Determine size used for the nth kmalloc cache.
- * return size or 0 if a kmalloc cache for that
- * size does not exist
- */
-static __always_inline unsigned int kmalloc_size(unsigned int n)
-{
-#ifndef CONFIG_SLOB
-	if (n > 2)
-		return 1U << n;
-
-	if (n == 1 && KMALLOC_MIN_SIZE <= 32)
-		return 96;
-
-	if (n == 2 && KMALLOC_MIN_SIZE <= 64)
-		return 192;
-#endif
-	return 0;
-}
-
 static __always_inline void *kmalloc_node(size_t size, gfp_t flags, int node)
 {
 #ifndef CONFIG_SLOB
diff --git a/mm/slab.c b/mm/slab.c
index c42b6211f42e..7bc4e90e1147 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1248,8 +1248,9 @@ void __init kmem_cache_init(void)
 	 */
 	kmalloc_caches[KMALLOC_NORMAL][INDEX_NODE] = create_kmalloc_cache(
 				kmalloc_info[INDEX_NODE].name[KMALLOC_NORMAL],
-				kmalloc_size(INDEX_NODE), ARCH_KMALLOC_FLAGS,
-				0, kmalloc_size(INDEX_NODE));
+				kmalloc_info[INDEX_NODE].size,
+				ARCH_KMALLOC_FLAGS, 0,
+				kmalloc_info[INDEX_NODE].size);
 	slab_state = PARTIAL_NODE;
 	setup_kmalloc_cache_index_table();
 
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 4e78490292df..df030cf9f44f 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1239,11 +1239,10 @@ void __init create_kmalloc_caches(slab_flags_t flags)
 		struct kmem_cache *s = kmalloc_caches[KMALLOC_NORMAL][i];
 
 		if (s) {
-			unsigned int size = kmalloc_size(i);
-
 			kmalloc_caches[KMALLOC_DMA][i] = create_kmalloc_cache(
 				kmalloc_info[i].name[KMALLOC_DMA],
-				size, SLAB_CACHE_DMA | flags, 0, 0);
+				kmalloc_info[i].size,
+				SLAB_CACHE_DMA | flags, 0, 0);
 		}
 	}
 #endif
-- 
2.21.0

