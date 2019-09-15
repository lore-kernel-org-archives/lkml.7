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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEE3C4CECD
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 16:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2CA2171F
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 16:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNVr74Ef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfIOQxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 12:53:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46632 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfIOQxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 12:53:31 -0400
Received: by mail-pf1-f195.google.com with SMTP id q5so21095254pfg.13
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 09:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ghBrDy6wMKk43GDL/rFQB3qO4WlHynWL3G2LPomcOY=;
        b=GNVr74EfB9Yd2uYnPefFhBBmQCKE3Knv62LLMlXNvbTYAGJRlQxVqX1fM+7unKG6kV
         riqsVWnawXvBUB5IzzoudZ40oNYSksqaqGWoHbz13tdaetpGw9BYfhfOM+vHk6f+JVp2
         gysdAERt9qVhad3h1KUOwW8PKWhS3/gRd+87eMsgvOBgqtYv7JCLuKK+C2DZx/ePvwfD
         n5oTLyCWj8qRZaA7KABAAvcBB8dAOwSjwXOhgXLppv/ctS+c6hdOueYFunkjI1gf9QZD
         DUB69bU6XR/mCJRnuo8zI7jwACH6QfviLuHZO5yTUzogEARXrgct0RkFwptxIhBz5AM7
         4XMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ghBrDy6wMKk43GDL/rFQB3qO4WlHynWL3G2LPomcOY=;
        b=MOeakxvROj7iq9/drcQYBZzBf/ojeW8TFV14NHiQUreqchUfLHmgJeNQA2xIZfy6Tc
         p9uJOpYm6Wgfw9Gk4YBnRT88pQ11vW0o7K8AQGBT7NXn7lWGsmN5Xw784OXJ3Ki1fds1
         2NJPBXHahjxont4p4m2DBg0j/IKCKbZmfZNm6wGpFe5IPuVlDkLV/lG+mYvu9F0JcKnp
         6V6zFA9A4byHMqsDKLLMJE5mIGDO5xEgZj1tczooarIyFgLj7ptSCpHUpqY9feWom01B
         nsNB4CAMGfFLM04Iwy0guaKdc1i+cxwirIc6YrydTlaqXx2EbvU2VzK7iIiESJrptUqM
         RuBw==
X-Gm-Message-State: APjAAAWFKaDWU+LMWHL96oSE/qugejK3+4bvzG4sbokSn4hArvV+7DIB
        RUhn6M/20BD+Eqrqs2RPPXE=
X-Google-Smtp-Source: APXvYqzqIRT/gZCBoy0FPBP/KzPlJj4rPVLTsdlGnh3gQDVSOgFLDPk5UGQH2GGJAS3v9i0xIGbuyA==
X-Received: by 2002:a63:4d4e:: with SMTP id n14mr3585918pgl.88.1568566410788;
        Sun, 15 Sep 2019 09:53:30 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:160:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id a4sm4383259pgq.6.2019.09.15.09.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 09:53:30 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guro@fb.com,
        Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH v4 6/7] mm, slab_common: Initialize the same size of kmalloc_caches[]
Date:   Mon, 16 Sep 2019 00:51:19 +0800
Message-Id: <20190915165121.7237-11-lpf.vector@gmail.com>
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

