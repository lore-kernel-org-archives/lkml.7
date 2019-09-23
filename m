Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1333C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9421520867
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7oIdsvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732451AbfIWM2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:28:00 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39835 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732410AbfIWM2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:28:00 -0400
Received: by mail-pg1-f195.google.com with SMTP id u17so7942781pgi.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 05:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n2eze0t6/k1b+WJqoNEASb7rlpZM6bT/9+WRw0baftU=;
        b=J7oIdsvlzutrmdREBj1gHTAQ7LO9uYo9GeCk+D9xVhHHaWbeBlNkfyqL6gWaP15TaM
         LQAooNLMKERDr0miuk/AuTxsO70X+hvCzj4YvP3I74+6j6tasxOae82GAlfduZmd6q6z
         hhk02rsKsUW6qd5rMjqtMG6JB/zLk9l4Y0pcMBET0J5wvMXHD6PFJazCFUD7Vj/hnJo0
         Hm0d65j3AYeQuoLjJV7kdWwIrkmBGODT1FLQr9nFUI8n5ZgsbDKSeoeolau7wxlGqaLe
         d7f3OVVBaNFJTQyQ+SZx+Dg8NP95u8SUAJoUy9AIoIv8fJ5C9t9dIRV67UZ3NdDUDGlC
         qF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n2eze0t6/k1b+WJqoNEASb7rlpZM6bT/9+WRw0baftU=;
        b=JAWJdMgD4kTC3oP5rQfc+ZvY8mMgbCfejt8ZWaim/CPGM48OkprdO6swB/F7ZLQH6Y
         yit1WGdihYZwBIHiRthRRV7SCsOGxD2b3koKZWVaWKQkRG4bVotd7Jh8HLgcuv8bg0Jl
         VOTkYE5+KaQxC1NL6UhYOSptlCqiXYHoiC7eWJmioujsPMVZ3yS62VydKYmMY8NAbHuP
         U07Un4p5vJ0h+v6MKgplym1PkGBMIBmuJ/yLDBWdw2Cw1jwYrbauWn6QxpUTbvKZpH2v
         diXfEVRlHE8HnuhWGzwS+gFOP2KpvJKeqvcd/5zSClDB6VZDFaEbufvB9rw8odzdse8n
         YYTw==
X-Gm-Message-State: APjAAAX447sZGrDL2HcekhOrXOmHUXiDbUmAJ5BYKnFpBNzdjf3S7L81
        8NTNyQYPmRUpNPFzgi+AQaE=
X-Google-Smtp-Source: APXvYqyiqF6M4Qgya7ubuznNyYPZ9bu/Cm54FKJ6TLYeTzodHH+3ew2B8g6TVOob606udU8kHb+UaQ==
X-Received: by 2002:aa7:8acf:: with SMTP id b15mr26182705pfd.191.1569241679471;
        Mon, 23 Sep 2019 05:27:59 -0700 (PDT)
Received: from mi-OptiPlex-7050.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id 202sm9692016pfu.161.2019.09.23.05.27.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Sep 2019 05:27:59 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, guro@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH v6 2/3] mm, slab: Remove unused kmalloc_size()
Date:   Mon, 23 Sep 2019 20:27:27 +0800
Message-Id: <1569241648-26908-3-git-send-email-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569241648-26908-1-git-send-email-lpf.vector@gmail.com>
References: <1569241648-26908-1-git-send-email-lpf.vector@gmail.com>
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
index 56c9c7e..e773e57 100644
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
index c42b621..7bc4e90 100644
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
index 4e78490..df030cf 100644
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
2.7.4

