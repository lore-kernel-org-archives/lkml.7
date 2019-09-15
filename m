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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A25C4CECC
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 16:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8884C214DA
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 16:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jo+e4APs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfIOQwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 12:52:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46237 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfIOQwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 12:52:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id a3so167060pgm.13
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 09:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nii43oMTaFtktKbnijjugyrLFfb5ZKvbiN8kMj3vNPE=;
        b=jo+e4APs5xDRR8vZnH8rVBXMdzgGhpBwxw1z0mC3zae1JlCpMP62+atbzfzG4DzlJ4
         weLCzW1zyxAYbUHZEPNrQtsLGmmxNCJWoa02cfILoRJfidraJ/kiXJgAl7L/E8Q0fs9c
         Dn/J+0SvCTaHBHWnlM2UnCAVBdLyy6KgR6bwLi7xR2wQwJ/MXLv8ynXcZwlUN4nwfe+s
         mxH+qYSu1vigjSVG1BrMLQUwD7FpJli522rbBGlbnGrt3xKG30eSKffnD0Y2HkDdyYzk
         pUuTC/IUU8TzL15qlK7Wzrw6vMLteSA9xTkhgzsInyxQftpd8Cy5PZjQZfwwplgw50+k
         yv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nii43oMTaFtktKbnijjugyrLFfb5ZKvbiN8kMj3vNPE=;
        b=Zq91PpKX3VEkJzbS296rsYU0B9asGM2QUcmX60YlCCGPdHXEphtFuPfBfZ85tQnwEY
         2gVnZZzIiha8NC5krB4Fa/9QvmcMm0s+GgYGZtQkEa7pcNe7pKS1mOD3C15nY0K6WzKo
         wDCDrht8uagqJcvP4cRq3eCbV2s5u3FN0Usq8ZrdfrMxgLhhAVxTt0CQ3qEokAYkJ30P
         aHNMuwJnpbEzF3CeXG+4C6jTe+vwqvk7jCnWBtMOJfmtu697h5E+jB/hS4jf4RJVvXMk
         GFofWRCM6p5FZOOTEtDq4pvsrpXzR7jJ/s+8VUBa1f35rsKSbOVu8YafVaPpofaiZc8h
         iWzA==
X-Gm-Message-State: APjAAAXhudvkoxQjMIE/tlfhCAJX9TZbyps1Uj3kY4nFCTGVlPCG7vlc
        jp2Tv+ziuSBb/xXoSgmTEOs=
X-Google-Smtp-Source: APXvYqyTb4DRsLUcRsbIEyib6eSVHgjnGgZ0zUwvJ1lKLEu0+d9WiS+28E8PoS/0ro55mhxu8KF8iA==
X-Received: by 2002:a62:7c4d:: with SMTP id x74mr7837018pfc.95.1568566368554;
        Sun, 15 Sep 2019 09:52:48 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:160:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id a4sm4383259pgq.6.2019.09.15.09.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 09:52:48 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guro@fb.com,
        Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH v4 4/7] mm, slab: Return ZERO_SIZE_ALLOC for zero sized kmalloc requests
Date:   Mon, 16 Sep 2019 00:51:15 +0800
Message-Id: <20190915165121.7237-7-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190915165121.7237-1-lpf.vector@gmail.com>
References: <20190915165121.7237-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation patch, just replace 0 with ZERO_SIZE_ALLOC
as the return value of zero sized requests.

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
---
 include/linux/slab.h | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index e773e5764b7b..1f05f68f2c3e 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -121,14 +121,20 @@
 #define SLAB_DEACTIVATED	((slab_flags_t __force)0x10000000U)
 
 /*
- * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
+ * ZERO_SIZE_ALLOC will be returned by kmalloc_index() if it was zero sized
+ * requests.
  *
+ * After that, ZERO_SIZE_PTR will be returned by the function that called
+ * kmalloc_index().
+
  * Dereferencing ZERO_SIZE_PTR will lead to a distinct access fault.
  *
  * ZERO_SIZE_PTR can be passed to kfree though in the same way that NULL can.
  * Both make kfree a no-op.
  */
-#define ZERO_SIZE_PTR ((void *)16)
+#define ZERO_SIZE_ALLOC		(UINT_MAX)
+
+#define ZERO_SIZE_PTR		((void *)16)
 
 #define ZERO_OR_NULL_PTR(x) ((unsigned long)(x) <= \
 				(unsigned long)ZERO_SIZE_PTR)
@@ -350,7 +356,7 @@ static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
 static __always_inline unsigned int kmalloc_index(size_t size)
 {
 	if (!size)
-		return 0;
+		return ZERO_SIZE_ALLOC;
 
 	if (size <= KMALLOC_MIN_SIZE)
 		return KMALLOC_SHIFT_LOW;
@@ -546,7 +552,7 @@ static __always_inline void *kmalloc(size_t size, gfp_t flags)
 #ifndef CONFIG_SLOB
 		index = kmalloc_index(size);
 
-		if (!index)
+		if (index == ZERO_SIZE_ALLOC)
 			return ZERO_SIZE_PTR;
 
 		return kmem_cache_alloc_trace(
@@ -564,7 +570,7 @@ static __always_inline void *kmalloc_node(size_t size, gfp_t flags, int node)
 		size <= KMALLOC_MAX_CACHE_SIZE) {
 		unsigned int i = kmalloc_index(size);
 
-		if (!i)
+		if (i == ZERO_SIZE_ALLOC)
 			return ZERO_SIZE_PTR;
 
 		return kmem_cache_alloc_node_trace(
-- 
2.21.0

