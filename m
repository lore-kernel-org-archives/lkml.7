Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86178C4CEC7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 16:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6A3214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 16:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mddTC6Sg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfIOQwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 12:52:12 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43830 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfIOQwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 12:52:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id u72so18012748pgb.10
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 09:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zr0c07NjDmSH5Cw3kJRhGheNFiNUbd4oIPE+u9OeCKU=;
        b=mddTC6SgYO2Ab78FK7UUhuQd1kwETldDpr5BXxpYb+fc8mge2xlIGeYMxpVaUY7nvR
         uOTQyCbJmz0EEvUKAWI/cQrJjSTlpzkpPRdJKMKc7X1W7v2JE4nGXDqTFvy/O/ovzm97
         lXhRGG1iv1ixHyBj1NEDWSxrw+enMNU4S8QHT60tz59ACuf4xK2fN9cwytHTUk9m9Trc
         A9N9+gwU962IUT+ELhMevHDxVxIR6Fwy8cEdahUQyI1PY8mFjHUEEp2gnuqyC/RkuiCQ
         z5PuGS651NaGM7xzH6WRd5AYpNubAX4kYNWeYgqGN7SAVL1BR0L1gDaUq+6gmu3kwFN4
         1qfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zr0c07NjDmSH5Cw3kJRhGheNFiNUbd4oIPE+u9OeCKU=;
        b=q6DAvRoSpy+/cZ1wObZRmNXzyLCB1ZaUV5ysmvxRU+XUismFR3ZxQehEZdqdm0eGRK
         8eLq0w/Px3g2kFtEn3xGHWL8jdQsXf1QiSMwaI9/0MrCGnjbXobNo9F4aOOcmdputgZX
         rB2np/pKYBuQq0pOgsj/h3dx1mkixuniVrTtrefE6D0OpgTvgg5YDVTMmx3Nk3fpF8/V
         3H3TqNivQGeDV0T7dUBT4fC1BPsoODBPrHwmsuIwu+PBYA2rXiPAZEXT46Dhfo2BK/h8
         CnHeewIHBl/cCuE4g7gw6tY/L5WZIx5bV94p/Alg3viDyvKQwmyhvm85cP/R0kJUzHO7
         sYIQ==
X-Gm-Message-State: APjAAAVs37zKnLO5mxtiRBgoCblAt1IRaD2VgxUuLmr+Qk3w7gohVmDP
        Gqmzohpz3rvBzEjEn9P9rKA=
X-Google-Smtp-Source: APXvYqxRn4ewzSZQkn/FFbl0qa7yiPu7uWCtjRCH+R5ndNnAWNrY7LsBcmNmfGEgVnhOaGKimOoOLg==
X-Received: by 2002:a62:2d3:: with SMTP id 202mr69461597pfc.141.1568566331261;
        Sun, 15 Sep 2019 09:52:11 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:160:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id a4sm4383259pgq.6.2019.09.15.09.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 09:52:10 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guro@fb.com,
        Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH v4 2/7] mm, slab: Remove unused kmalloc_size()
Date:   Mon, 16 Sep 2019 00:51:11 +0800
Message-Id: <20190915165121.7237-3-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190915165121.7237-1-lpf.vector@gmail.com>
References: <20190915165121.7237-1-lpf.vector@gmail.com>
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

