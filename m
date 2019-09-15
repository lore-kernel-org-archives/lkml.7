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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F10C4CECC
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 16:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F40216F4
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 16:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVgOxzsa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfIOQxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 12:53:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44432 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfIOQxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 12:53:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so18007586pgl.11
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 09:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ghBrDy6wMKk43GDL/rFQB3qO4WlHynWL3G2LPomcOY=;
        b=jVgOxzsaBL7d6+d3FL3j79i1Fvbge77Zkqt6VNcmsJHg+TdLOdCa9HZ7rqMVW+EkvX
         M7/xxz9g3zkcLp59hc8nHrNfKiXw2o7u5iWTX1afNpqNDKJYUgE1MHiyaiZ/xV7XCwgy
         SRPhmSR5oe9NAe4ppvY6n/YpvWcv+j01Zop8QJilVoYpSccyHjw0sVGVFTv6HYF7rpwv
         LdB7gTH75HT9MzWEd9Vsj+/jtLt62KVzWvqoOGXm6tUnyQKfXuV6gmeFBt0Y6C3lV+vV
         psoqcjB9SSXA4H7rY2x5sTdSp/UqS61F/PdfPB/t3wNoqrb6gNs0hmuW1m3Mohn/ZtKH
         Nzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ghBrDy6wMKk43GDL/rFQB3qO4WlHynWL3G2LPomcOY=;
        b=CjLaR6vmPgcB0mr5soWLZYcN9e8yfX+0wEme40eBaUZLd/cTtVBLvWR1MyanfmfhtN
         u3lrhKJRY3815Dx8we6RqEa5XRKF5Ike21QyrwpXnsqs+gW1eL0suwnkGxsPmsFlC42k
         s2ZA938oxjrzKqYf6/8rrJarvOmBEJ4yi15DdmgzeKSSBn9iFV5Xa7UKWt8tAI6JmsDB
         He2XXHciN4BbY3gBYwqJCN+QBZqR+GnYyAf/XfFIicAzjz2IcHzlBGHcBP8K+VWbexLW
         DIs2azC0F6PTaWKE+LqsPu+U77e7t3tyTcu6meqREnftwP5fjBX+W8tzSKI+8aL232Vf
         HyHg==
X-Gm-Message-State: APjAAAWzb2voyVUdx5fSsyRMgxU5fOZPY5IGPfKIy++tDsgZ8HkNDUmE
        1pXi+pBcuJwU03/pbfvc/QU=
X-Google-Smtp-Source: APXvYqyT0EudM329i6xxR9PsWR8BAYr560iqmnyO6W8R7cfNb0ye4ziGG50q8+ogMrkk+tXgw9rOWw==
X-Received: by 2002:aa7:8a8a:: with SMTP id a10mr52476468pfc.131.1568566402236;
        Sun, 15 Sep 2019 09:53:22 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:160:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id a4sm4383259pgq.6.2019.09.15.09.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 09:53:21 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guro@fb.com,
        Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH v4 6/7] mm, slab_common: initialize the same size of kmalloc_caches[]
Date:   Mon, 16 Sep 2019 00:51:18 +0800
Message-Id: <20190915165121.7237-10-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190915165121.7237-1-lpf.vector@gmail.com>
References: <20190915165121.7237-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current implementation, KMALLOC_RECLAIM is not initialized
until all the KMALLOC_NORMAL sizes have been initialized.

But for a particular size, create_kmalloc_caches() can be executed
faster by initializing different types of kmalloc in order.

$ ./scripts/bloat-o-meter vmlinux.old vmlinux.patch_1-5
add/remove: 1/2 grow/shrink: 6/64 up/down: 872/-1113 (-241)
Function                                     old     new   delta
create_kmalloc_caches                        270     214     -56

$ ./scripts/bloat-o-meter vmlinux.old vmlinux.patch_1-6
add/remove: 1/2 grow/shrink: 6/64 up/down: 872/-1172 (-300)
Function                                     old     new   delta
create_kmalloc_caches                        270     155    -115

We can see that it really gets the benefits.

Besides, KMALLOC_DMA will be initialized after "slab_state = UP",
this does not seem to be necessary.

Commit f97d5f634d3b ("slab: Common function to create the kmalloc
array") introduces create_kmalloc_caches().

And I found that for SLAB, KMALLOC_DMA is initialized before
"slab_state = UP". But for SLUB, KMALLOC_DMA is initialized after
"slab_state = UP".

Based on this fact, I think it is okay to initialize KMALLOC_DMA
before "slab_state = UP".

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
---
 mm/slab_common.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 2aed30deb071..e7903bd28b1f 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1165,12 +1165,9 @@ void __init setup_kmalloc_cache_index_table(void)
 		size_index[size_index_elem(i)] = 0;
 }
 
-static void __init
+static __always_inline void __init
 new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
 {
-	if (type == KMALLOC_RECLAIM)
-		flags |= SLAB_RECLAIM_ACCOUNT;
-
 	kmalloc_caches[type][idx] = create_kmalloc_cache(
 					kmalloc_info[idx].name[type],
 					kmalloc_info[idx].size, flags, 0,
@@ -1185,30 +1182,22 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
 void __init create_kmalloc_caches(slab_flags_t flags)
 {
 	int i;
-	enum kmalloc_cache_type type;
 
-	for (type = KMALLOC_NORMAL; type <= KMALLOC_RECLAIM; type++) {
-		for (i = 0; i < KMALLOC_CACHE_NUM; i++) {
-			if (!kmalloc_caches[type][i])
-				new_kmalloc_cache(i, type, flags);
-		}
-	}
+	for (i = 0; i < KMALLOC_CACHE_NUM; i++) {
+		if (!kmalloc_caches[KMALLOC_NORMAL][i])
+			new_kmalloc_cache(i, KMALLOC_NORMAL, flags);
 
-	/* Kmalloc array is now usable */
-	slab_state = UP;
+		new_kmalloc_cache(i, KMALLOC_RECLAIM,
+					flags | SLAB_RECLAIM_ACCOUNT);
 
 #ifdef CONFIG_ZONE_DMA
-	for (i = 0; i < KMALLOC_CACHE_NUM; i++) {
-		struct kmem_cache *s = kmalloc_caches[KMALLOC_NORMAL][i];
-
-		if (s) {
-			kmalloc_caches[KMALLOC_DMA][i] = create_kmalloc_cache(
-				kmalloc_info[i].name[KMALLOC_DMA],
-				kmalloc_info[i].size,
-				SLAB_CACHE_DMA | flags, 0, 0);
-		}
-	}
+		new_kmalloc_cache(i, KMALLOC_DMA,
+					flags | SLAB_CACHE_DMA);
 #endif
+	}
+
+	/* Kmalloc array is now usable */
+	slab_state = UP;
 }
 #endif /* !CONFIG_SLOB */
 
-- 
2.21.0

