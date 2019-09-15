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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D7DC4CEC7
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 17:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3506F21479
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 17:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChR4G6GA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfIORI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 13:08:56 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44454 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfIORIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 13:08:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id k1so15560103pls.11
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 10:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nii43oMTaFtktKbnijjugyrLFfb5ZKvbiN8kMj3vNPE=;
        b=ChR4G6GAPaZdbwdfKHEQSYy9/d3o+YfQNx9G6ElCWcdroi5oVcnCWZ0D9ltIPZcxkW
         6rJ9OuFwAUTeyoZmJKyvA8c2HlyUN6MpflA36FPfDaPlhN+8MpDJUOmABIkQg3IXj+5X
         5GGwg62qwPXQcBlF8QNS+M7Ww5yDUu66qX1T3mwv+tCVYVOPi/njgfU5BoChKExCRBny
         VNLOKJDxONTTBugsfaTwNW7FyBDRyj+Q5kKt/Ha5YmiJiNDCnU7Gu5uW3D9KCPPbmdFC
         gb7aTCIP08Su+wr3nLOXUv7Efdy5ovyi9gRj9ZiRgHiCatS9jLsNmuvQeojVZrAlXuA8
         BVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nii43oMTaFtktKbnijjugyrLFfb5ZKvbiN8kMj3vNPE=;
        b=aEiRyxPiRW/ABsn4O62W5S/D3qR40GakG+84fQIYDzVw5jFc7x9EC3Yy04zHssie6q
         N44rSQWnJMuqBGjuhkgcS0DbdpLK7Zg+TVgo19yExZgoByMn7oTJ38wIL3Zgk3EZbupi
         46nhCE5IMIu9bbCa9/2UlXFJx2gCsC+Hqc0p5G/3avIEHp2aMdWH76D7ON+hp6naRGL/
         IHWi0sPD1lmxwOwtbxxWZ5cBQq1qMfKs8czdcYfu/sS+0p5TbGtAdx5zfmU/yqyclRHR
         +r4UVPr9rttbsA9EWtuhoRACx931oJGXxU1Hsf+BO6fKEsOgXRXbMUvjRfa+HFkhb/K2
         5bBw==
X-Gm-Message-State: APjAAAU8bnG+GorFrTqhmP6hVpHUVqhvsgZDj9LsrBnDZAtxGRHNw1xb
        rh5SGZeIokE2vpi8+Ssv0EY=
X-Google-Smtp-Source: APXvYqxIpfa3q8cGvHRTwJ6lHu6xR8cG8RIe6yRmztIbu+l53V7wTKsneEQe0JI+j7ru62hQqZv6Ag==
X-Received: by 2002:a17:902:a606:: with SMTP id u6mr46467079plq.224.1568567335179;
        Sun, 15 Sep 2019 10:08:55 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:160:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id r28sm62279134pfg.62.2019.09.15.10.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 10:08:54 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guro@fb.com,
        Pengfei Li <lpf.vector@gmail.com>
Subject: [RESEND v4 4/7] mm, slab: Return ZERO_SIZE_ALLOC for zero sized kmalloc requests
Date:   Mon, 16 Sep 2019 01:08:06 +0800
Message-Id: <20190915170809.10702-5-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190915170809.10702-1-lpf.vector@gmail.com>
References: <20190915170809.10702-1-lpf.vector@gmail.com>
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

