Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26ACCA9EC2
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 04:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99AC12086A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 04:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="lcDyHdzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbfJ2EVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 00:21:17 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44239 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730445AbfJ2EVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 00:21:16 -0400
Received: by mail-pl1-f196.google.com with SMTP id q16so6653609pll.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 21:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HNDV9DT7O32N2h9l7CrACdWJSzNVfR3Dv9pnUT55kOg=;
        b=lcDyHdzUacgOhucQ6b8IWgwE46Vlk8g9GsG0YiqbvSuRh0midPQjkKTH8pqXZ6eSlf
         M1yH4o7rgNX40yBq5M4PAJVge7qa26A++93dTOcRGcNCrIQhxh5QfkU3EV2DF34ElmZk
         63eYGshNT63iTFBqS5s6pvBKl+7JsqOxJf9F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HNDV9DT7O32N2h9l7CrACdWJSzNVfR3Dv9pnUT55kOg=;
        b=M4M+EN0cn86yzrYaF0T5ibSAJYXWTrllAWAb+GfSnPL1sRAdYyzuXL8v7Gt1ZiovLX
         sYAx94IGlOigYgSfb/T1dwJlchlYUkyFlJAPigw45nyBkrCED9rABpCjSOSKEem1z6bA
         Pk5SKgSBviif26gPD+yC89+BpJsAn5W0Euf8hOrbBz0BvX4ISHQv3NNvw77awqLYsduh
         ELGXsevtnDdL/GNnbKQQ7H8EhhZq7qUe0qJ2Po7uaDZkkuVOyIJBVxjfo5WY8zqZB8XZ
         nhUvTXrNM23Ax9v380isj6ZmaT0yqgZUCrDwYvdSRTgOpLDXBiw1I6tX43u9LfBjzIal
         LfXg==
X-Gm-Message-State: APjAAAUkcdbDQ93LkQM+pIknrNZXvsPm357h5sWBxYYwUaXgNh4ktv4U
        EvKcCkhmMGliwy9FMtg3hGgHC5aviDE=
X-Google-Smtp-Source: APXvYqxLsff9odhBvNICfK+D6Rfn6FtMiU4d244WqDyFRpWs6AJDTPdDv2j0OdBnEo98eZFpsfQ/6A==
X-Received: by 2002:a17:902:68:: with SMTP id 95mr1661194pla.117.1572322874296;
        Mon, 28 Oct 2019 21:21:14 -0700 (PDT)
Received: from localhost ([2001:44b8:802:1120:783a:2bb9:f7cb:7c3c])
        by smtp.gmail.com with ESMTPSA id y11sm15418521pfq.1.2019.10.28.21.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 21:21:13 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v10 2/5] kasan: add test for vmalloc
Date:   Tue, 29 Oct 2019 15:20:56 +1100
Message-Id: <20191029042059.28541-3-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191029042059.28541-1-dja@axtens.net>
References: <20191029042059.28541-1-dja@axtens.net>
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

