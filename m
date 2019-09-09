Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D84C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 17:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDEF1218DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 17:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuVcZXvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405376AbfIIRIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 13:08:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45838 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfIIRIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 13:08:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id y72so9515209pfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 10:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IAG1VLKBZpRTEI8L4+2XUQIRSxmDIwmG8l7u8lqUj7s=;
        b=UuVcZXvRYiGsCOXoX7QtHfrnf25gH30tm3Jr+MLFXtA0xo/UN3oUbJHtk5i1n0Ilb3
         IZL9SiXjwDj+bm3AtV9wLg3n6Jswk30v2yH6HpLhfbrVl6pTWflcxilGtD/kV1H0aJ36
         dB8Pr7vF+PX/NrDC4T6C40H5DtyEHkOJNskSEX+bN2SScynCsurEyZj2XeCPs2wRUr4g
         HXNJk6SrR5OgR+WzJaTTuH0fMzZgKMpJr1BmKVQg6/zn1jE7cWhxg4MlOklK1NkWr0Wn
         b8OpbRs1OD0DzyZNmS10ql7vR4FEOEGP+a/u8M9idhR2f52v15FWTrlXEQyJC8TprYCl
         IaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IAG1VLKBZpRTEI8L4+2XUQIRSxmDIwmG8l7u8lqUj7s=;
        b=DyZJpXWqM0mn2Pr4L3UDZqeWPaWUkUFzBHKQ1DOFrGeaoQcYwofOZ9/tKKLZ6Y1gXY
         TBxLx7nt5jac6XtUxwNza4Ex/n4zbLslPUYRc4PEMXexs+T79wQvUc+QxajNfy8M/lze
         4f2/sWx00EhSItcpE+Jxv/EXgimNw0dcn1Gu+2DuZY3X9Lrx4L7dNXUBry80+27XzmQ7
         y792sQSLS9FPo1LjTnA11K+U4oKb6mvobuyFPH5QdjSWTPzwMirW3kc2RHOyBGeDoJSo
         27qiIaLn1fAWM8qHXNet1/sWzl20DE37btdPlp1Tp9v5W2FyTRmUmuxKFYIGwD5QMs6d
         bnGQ==
X-Gm-Message-State: APjAAAUaZASmEqJ8F8YWlHmdG0IBr330bmwRjyhflqq0oXuVhhQVHUFK
        1vEMnk7A48+a+qF/aDaXihs=
X-Google-Smtp-Source: APXvYqwibHgZWR+jw1Ah4yMCwZtMRhATUb+KbugeO1jo6o8Yxx06YncsTn+5H5M9UI4Gh/rYQvApxA==
X-Received: by 2002:a63:5823:: with SMTP id m35mr23177084pgb.329.1568048892858;
        Mon, 09 Sep 2019 10:08:12 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:160:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id b18sm107015pju.16.2019.09.09.10.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 10:08:12 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH v2 2/4] mm, slab: Remove unused kmalloc_size()
Date:   Tue, 10 Sep 2019 01:07:13 +0800
Message-Id: <20190909170715.32545-3-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190909170715.32545-1-lpf.vector@gmail.com>
References: <20190909170715.32545-1-lpf.vector@gmail.com>
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
index 61c1e2e54263..cae27210e4c3 100644
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

