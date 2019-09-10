Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB62C49ED6
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 01:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9600D21A4C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 01:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+2JgqiH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392330AbfIJB1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 21:27:31 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37189 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729327AbfIJB1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 21:27:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id y5so7767330pfo.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 18:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zr0c07NjDmSH5Cw3kJRhGheNFiNUbd4oIPE+u9OeCKU=;
        b=i+2JgqiHkfJqcmzDqkcs4qfcvNvhNPQ3REVa3oPc44GAf/7bIImiNi23ef48RY0uXG
         uKU+2tPJ52bKlMa7MrKaA0tnzTftXyCCwmfi5EBQIRusrsDX/fPM75jVUx7X1X3+4ouG
         /c4cPU+TGRKtyKS23awFLVBrWcU/RoWn3iKWtkUo7eSzgrM6pKnmxzMPXlbfO2Wk+pXV
         7tAamR30FgWwmyX5Rva5xni34jf1N+kq2QJstiyGbb6zdH4GDPlxuh+co+QD3A5mvhTD
         HBQFUNGbiWjKCRLU0n98d6+RnJ/n025w3S5UPUNOEstnpJzxEoyGoha9fLmkJ4YEpz/+
         G4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zr0c07NjDmSH5Cw3kJRhGheNFiNUbd4oIPE+u9OeCKU=;
        b=tSCzmNbu0C3RnYQJ1c7EWTZoU2zfyDwPkr5e4A8rPTtR3bcFQFgqn4k9Uag9/VJUxx
         GM70NM277czVdxDbBgpucp2x92AotrRHTDMy4JQYq2Qs1vmnBVJ8vGQNnAPSNrUXrk59
         VHgd4KglH1+qwtDJDu3RmaBSNl9WBoyJIIereiG+fvivm/Ntkn6Zz1TspPIGKKvpkETj
         55XQZVKGYzmGvR1SiO0M/mSoVfLXHkAhkeby84YgDJzmqo1xDRh0HjigwW7b/wpr50jg
         +e/LheXehG6X+UWTNDbAzKAlGOBz3Dkc+SfC1+o0FZIrIQHFmUb2dWPcJHQTLeXsz0DI
         4cfw==
X-Gm-Message-State: APjAAAW24s5ANOcKxSRXj4Qr2H5XZdKMEOovNTcuiw4YmL/IP5FBvNTg
        xIKZndnEk3418asv6VoZ4ZQ=
X-Google-Smtp-Source: APXvYqzf04YdXqiSmGL21oobu5CZLUls6gvxBAfgeGtrP48LXGtZBgSeIhrPeSKpa770i5E7JSZSog==
X-Received: by 2002:a63:c118:: with SMTP id w24mr25202712pgf.347.1568078850216;
        Mon, 09 Sep 2019 18:27:30 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:160:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id b20sm19558629pff.158.2019.09.09.18.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 18:27:29 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guro@fb.com,
        Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH v3 2/4] mm, slab: Remove unused kmalloc_size()
Date:   Tue, 10 Sep 2019 09:26:50 +0800
Message-Id: <20190910012652.3723-3-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910012652.3723-1-lpf.vector@gmail.com>
References: <20190910012652.3723-1-lpf.vector@gmail.com>
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
index 002e16673581..8b542cfcc4f2 100644
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

