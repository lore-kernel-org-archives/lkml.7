Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31664C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 14:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D4B2184D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 14:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YR9U5b2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732762AbfIPOrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 10:47:06 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42075 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732374AbfIPOrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 10:47:05 -0400
Received: by mail-pl1-f194.google.com with SMTP id e5so5967965pls.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 07:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QbVF1PSqvP2xnQhufiGK8AJvI4iylUVt8uZ1yhy2wwc=;
        b=YR9U5b2Al2uZzdBiRyBtWDbXpGBtWrT4PMKL+x1AZt3LYMS+m3xzN98uaYTyO+CFUF
         7IhKvR0RKbfMl53lB1Ph16DPrOSZmSqW+QKgSAysJpNWZ2zntkD2HbA5vaUegHGgsgAZ
         oJ+A1++3S4ceNlCIng74lZeCWfICtAWZCEdhaZQwsZKVTrdPCKh0WuGIjZhjI4aE+o5m
         +BxDxp98Qw4Z9Bnmonbf1saR7UI/vHeAMNjYTplEWhlTdWKZdRVyuv56bI+tizq7Sit9
         GdxJfk7bGuackN22jFCiFIs8FrfIzZC0RtxbQiBgucqMNmxnwNsiCOCCLWLgf4vxn6CR
         44lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QbVF1PSqvP2xnQhufiGK8AJvI4iylUVt8uZ1yhy2wwc=;
        b=jOdVKXNynXSWBZHRCMcBvEUCzlC3HeEoik3vNBhjqY5vPS3fijXz7A9JETTOVWCws+
         FGJ9UttYYyV1ZJ6jcGO24CbFNudVEee1AlQ9Rv6gtZNLqvyMd0ctRfKC9cJxegLT2Btm
         3gZoxFbRyUaySF/G1xq0y8FpuLnwUUpIpp3NBbwMWFqx9Unt65wFVeUf6dNx2SbsdTLz
         Zx7mHjGHTRCoculS3lzBoKRpeRHTm+EWAlqsCPpvtlnhz9ag3JuG4p6GLrNwkSPgPKn/
         bD0sm2EhWo1tuFxBbLhZXitAyX6w49BM/QJmkMAROrSyQ7OZL57z9rkRiHgjL3Lf2t7P
         tf0g==
X-Gm-Message-State: APjAAAUn4xsak5KMciRiVJSuRo9gArmo8OB3bhpYsmaHAiUJMIG3aRr0
        q6hIZa4ND6QH8T2TIqnLDbQ=
X-Google-Smtp-Source: APXvYqx+StnT131uYw7DO0XD9HWiydJc/EU947IkydJV5DEyZ1C4JCqpo96WEbZQgnCh54f/is3EFg==
X-Received: by 2002:a17:902:a418:: with SMTP id p24mr161368plq.312.1568645225140;
        Mon, 16 Sep 2019 07:47:05 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:160:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id d190sm15036004pgc.25.2019.09.16.07.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 07:47:04 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guro@fb.com,
        Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH v5 4/7] mm, slab: Return ZERO_SIZE_ALLOC for zero sized kmalloc requests
Date:   Mon, 16 Sep 2019 22:45:55 +0800
Message-Id: <20190916144558.27282-5-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916144558.27282-1-lpf.vector@gmail.com>
References: <20190916144558.27282-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation patch, just replace 0 with ZERO_SIZE_ALLOC
as the return value of zero sized requests.

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
Acked-by: David Rientjes <rientjes@google.com>
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

