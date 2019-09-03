Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F67C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D90523711
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3J24BLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729970AbfICQGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:06:06 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45575 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729709AbfICQGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:06:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id y72so3479859pfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 09:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sCfAZ6FcWE/Ra7JeZeEWDGvzMRc1z2NIPSNI/z4SnG4=;
        b=V3J24BLzylgKwKh6YH7jauZXbnITYVEVj7ZDmCfsKzdE98Rym6ITHptLSyHLk9j+qQ
         Eh7DX/9mRvIH1jMR4AsNEk7Hcu/EdM5OdA9NLcejVpEc22i+WxGtJt1klI+26KfPi8m6
         vXpfw859zeEADTFrb7idJrVIX/n2Ib4Ds6uN0V9355TG55imO0lHfGIFAqh3SVJN8l7P
         DGaT3/zSOaeD4Hbih9tFpj19xrtTvONbee0eKHoyVIG+Ckfq8DywENu3xMmv9AXNuPId
         KOW0JUkZepbrcrLbJCaq3B/kxIU5hQ7xDkd4fme2mJd70Nk5SOkcLR5uT96cLlZ9J7RU
         aj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sCfAZ6FcWE/Ra7JeZeEWDGvzMRc1z2NIPSNI/z4SnG4=;
        b=kCmz90Dj9+qNWVcRW8Z0uhm9/jOBi+9eMGTLMIIPBlKp+W5pRVBKbbB7cVeBB6+qa4
         eLApku7A2w+/mtclNRse9cMlSEY173BWIFTNEkPHGHEB5N9j+XTv0rEDTrtxpXONaDCk
         /1/To3e90+Ya/+CGnm/FW/9YTIDDle9iTGAge56yexlfh4XlhhvIaBVt8Qd0r3pRx7+Y
         /AUfkzFxNmuF05uRDIW7pvzy6T0JWds+QOmZt+nqebcF3fqyrXsGcHKUZ2XLp7Fh0ILJ
         cjL2AjDFH23UtbB/+lMldwCcPrI/QE8lyyNWj8YUmAMbnfkotpBmJvq3je7Qzm3Jmdcr
         xIJg==
X-Gm-Message-State: APjAAAVsSFUfyVrP76qX5CJDZ4V9E4atLTz8zBzJcw0hAMemAK6G2U0p
        noTdMeemvojdWPUx9X38oek=
X-Google-Smtp-Source: APXvYqwgdPLWgf9CQVGxcsYwYCpR2opRVq4DieDZTvtrFChqcqgCZ//VbQIXYX/vaYyIZE3HgbQqNg==
X-Received: by 2002:a65:41c6:: with SMTP id b6mr30842525pgq.269.1567526765171;
        Tue, 03 Sep 2019 09:06:05 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:160:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id t11sm18501567pgb.33.2019.09.03.09.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 09:06:04 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH 3/5] mm, slab: Remove unused kmalloc_size()
Date:   Wed,  4 Sep 2019 00:04:28 +0800
Message-Id: <20190903160430.1368-4-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903160430.1368-1-lpf.vector@gmail.com>
References: <20190903160430.1368-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The size of kmalloc can be obtained from kmalloc_info[],
so remove kmalloc_size() that will not be used anymore.

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
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

