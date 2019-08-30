Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69338C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 00:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3887721670
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 00:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="rC80CM3v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfH3AjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 20:39:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38672 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfH3AjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 20:39:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id o70so3321341pfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 17:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HNDV9DT7O32N2h9l7CrACdWJSzNVfR3Dv9pnUT55kOg=;
        b=rC80CM3vg5AM+oCtr2yGiOMkyFX3PwyWe/XtNpAWG+HqpbnDeR7304D9UdEPGcbG1z
         p5Wwn/tzrFn8wuMCtE+W9itdoK1VA57nvODNtfU9ort+tqudg9czalidTRlConko7Q9N
         ZCj2Wv+K+wlO0ZT2El8qdKr16hfYxsr077kTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HNDV9DT7O32N2h9l7CrACdWJSzNVfR3Dv9pnUT55kOg=;
        b=NetYKKxU52MFAHZl61r1JMaPxl/j0XyYK5pdXpL4nB8n3cXCqy2kDmtoRWVzGUCSj8
         MsAb/hhpz7uvWxzS3yNatnN7MoHUWm+yTgTgTgHPdzhYplRdLuXzVVXzLcCQoWLm8Z46
         iXQoLLZy/q9x48+AcQPw0y6OXE2hwFe7h6dGBcUx2xlQrWiss2b1OdSY5GnpK3jvb0xg
         hzbkCvd0GGqFVK/fLccRlBzBd24OPlRVFwit0G/3SXtDCzdK/T9MjxxbXLgTji01II+0
         fYmWTKy6W94+qhRYvbVf1j5PDwnjUEN0oAi1yhWZiOvevAqaQXkR40kyrQDJxCfOSqBj
         LAqQ==
X-Gm-Message-State: APjAAAW3sQIH5cdCTTwSYrOMs2Bm8uu4Pmu9aVaBPKUv+sRmXUh4J/Y5
        g3IjSVgoKOiyQELRDxSm31sE7Q==
X-Google-Smtp-Source: APXvYqxf40ssvyv4OlvQVqWJJ70xy4S4K17zZEo3u0JMMATs1HkRt9dCDVYyGh/84sHT3v5sSG1DHw==
X-Received: by 2002:a63:a66:: with SMTP id z38mr11066655pgk.247.1567125550257;
        Thu, 29 Aug 2019 17:39:10 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id i4sm2211255pfd.168.2019.08.29.17.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 17:39:09 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v5 2/5] kasan: add test for vmalloc
Date:   Fri, 30 Aug 2019 10:38:18 +1000
Message-Id: <20190830003821.10737-3-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190830003821.10737-1-dja@axtens.net>
References: <20190830003821.10737-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test kasan vmalloc support by adding a new test to the module.

Signed-off-by: Daniel Axtens <dja@axtens.net>

--

v5: split out per Christophe Leroy
---
 lib/test_kasan.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 49cc4d570a40..328d33beae36 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -19,6 +19,7 @@
 #include <linux/string.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
+#include <linux/vmalloc.h>
 
 #include <asm/page.h>
 
@@ -748,6 +749,30 @@ static noinline void __init kmalloc_double_kzfree(void)
 	kzfree(ptr);
 }
 
+#ifdef CONFIG_KASAN_VMALLOC
+static noinline void __init vmalloc_oob(void)
+{
+	void *area;
+
+	pr_info("vmalloc out-of-bounds\n");
+
+	/*
+	 * We have to be careful not to hit the guard page.
+	 * The MMU will catch that and crash us.
+	 */
+	area = vmalloc(3000);
+	if (!area) {
+		pr_err("Allocation failed\n");
+		return;
+	}
+
+	((volatile char *)area)[3100];
+	vfree(area);
+}
+#else
+static void __init vmalloc_oob(void) {}
+#endif
+
 static int __init kmalloc_tests_init(void)
 {
 	/*
@@ -793,6 +818,7 @@ static int __init kmalloc_tests_init(void)
 	kasan_strings();
 	kasan_bitops();
 	kmalloc_double_kzfree();
+	vmalloc_oob();
 
 	kasan_restore_multi_shot(multishot);
 
-- 
2.20.1

