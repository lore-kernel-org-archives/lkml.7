Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0074C4CEC7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 17:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795B3217F4
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 17:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMJj+06m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfIORIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 13:08:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38698 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfIORIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 13:08:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id x10so142412pgi.5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 10:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zr0c07NjDmSH5Cw3kJRhGheNFiNUbd4oIPE+u9OeCKU=;
        b=bMJj+06mx2KCeF5+czFUmggdyS3AWD3yVKsqp5d1AtESbFoVxpD9DFLBgg83bhCE6x
         tkPO/CFOhFNGfImROR/tTFyfMzH/rUlECA9rtUz2zx7+g5+L31x6bT867cCKcuqfhOF/
         2YjfDVJz+AwxOCk5Z3eLbnWLPR0fWap4Rl9IcGqeMSxudfRz2mJ1VOUB/uPmSEngbZ7Q
         EE8Cz0OV5ryE9rZgkODMg7jEi7CFTEIkLGUEtu1ls4IPE8VZSGxe/2K5lPCR75mcoUHw
         ZwhQgUJhmCohWLzGfrFY4FsiYEYQLCs+h5bmAljsUtDw5Ny+NiQyc13+tt63/lKIMGi4
         qM3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zr0c07NjDmSH5Cw3kJRhGheNFiNUbd4oIPE+u9OeCKU=;
        b=WKL1atWb8mtKtE6AoMoYxN2EJCYTGZMCG68NbRYbHUohIIIaVj9Gcxbozima9jjeVQ
         DezqyDyb3ehOvpUMtDHiG5NkUJ9zWuheKBBwseK9FKQwI4lf5IquC1L9/fuL6beDyTHB
         9aow1vwHp7tKGNXLZP9GXTuOgq1bESOs6H8i5FVHbTCaLMg6pSLKUZ5R4YvM1MbVnM+Y
         P//Thh7rmSITLfqbF8MGyBU5g01gTvAzQ98lfEIig8tROZuvnwHu8gnhB2kYoBiNHYmz
         qyQJIH2JJzWT1OZmWyJsqEN7pirgVNbnywpJYKRH0eu6WsFZzvlg99oD1tizfIH99qlt
         IWCA==
X-Gm-Message-State: APjAAAVDDioWbw4nHdHo8EXWaO8s2eV27fV8YeRzjkY4ANUAMD+NnOPm
        y5QZNNL6mWG0xtWmQ9Zc2cw=
X-Google-Smtp-Source: APXvYqxlCLcNUJ4gfIt5Y94i9kDi1PCs2O2NAzHxRSL+j7LpBfj3+Z9B4OG4iTMlK2awRx+JFfBCVQ==
X-Received: by 2002:a65:6709:: with SMTP id u9mr23349139pgf.59.1568567319705;
        Sun, 15 Sep 2019 10:08:39 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:160:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id r28sm62279134pfg.62.2019.09.15.10.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 10:08:39 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guro@fb.com,
        Pengfei Li <lpf.vector@gmail.com>
Subject: [RESEND v4 2/7] mm, slab: Remove unused kmalloc_size()
Date:   Mon, 16 Sep 2019 01:08:04 +0800
Message-Id: <20190915170809.10702-3-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190915170809.10702-1-lpf.vector@gmail.com>
References: <20190915170809.10702-1-lpf.vector@gmail.com>
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

