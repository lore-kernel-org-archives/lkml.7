Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A8FC3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213EE23431
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="FR2A8WMD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbfICOzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:55:53 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36452 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfICOzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:55:52 -0400
Received: by mail-pf1-f195.google.com with SMTP id y22so5308525pfr.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 07:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HNDV9DT7O32N2h9l7CrACdWJSzNVfR3Dv9pnUT55kOg=;
        b=FR2A8WMD+DnhNMxW/AdS1tEdkZRXiPpMUgFAehGpzfwPiADje+HGwN/tXiTSg49kjs
         8axf1yK6lckfmwIzBX6evzvsGC+UBpSQ5lgI/sc1uFwoQLHw2slgHM1nEaZg/UP3PXxr
         2SPS4jhPXzi9sV3nsNx99PY1dXpjYVpzCMVE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HNDV9DT7O32N2h9l7CrACdWJSzNVfR3Dv9pnUT55kOg=;
        b=pz9OFYPqbiaaBgXQ2SSJ2YsJZzvbXvsHKNM4ydpYCZz0Q51FTt6Mr/iCjMYZxel4O9
         70dUSfks0sLJJCuUDpkGMUe0ms9gWgGwOT/VQYnB42yXE8eFIpfZwuypfeMHNgExelv/
         G9xlP4/p0FVUcM7dzfijnBCQIgWGTNdPnoI07iOUBo3A3x8M64DOEg3Bxqo5uYuoZVs4
         +Jz9O/kgR3LfrUezRCpA4g2MQ9yz1lA7OfHXbVCYielysBw0Kd1PDZesXCRwATtODaLh
         VkWM2sUMl+oSDNApVvWQlressZmij7RF4sfsbJ2c9jKt88Gr5tOu2Bh3uPbzWRnchkZI
         Hlow==
X-Gm-Message-State: APjAAAUEYucE5FruCwAA7er+xlyum+0pakECKR0lEZlzhImLX6+8Slyw
        x+uZtOHB/lcADGDOiG5yI8TaCQ==
X-Google-Smtp-Source: APXvYqyssI9EpWOcemmTKjSWeJkp8pesyl80zlv7UbppPhIyxvFpoEZSj4nDikJ0w4fVrnzAh6rdPw==
X-Received: by 2002:a17:90a:fe0e:: with SMTP id ck14mr466805pjb.78.1567522551845;
        Tue, 03 Sep 2019 07:55:51 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id b19sm16216868pgs.10.2019.09.03.07.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 07:55:51 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v7 2/5] kasan: add test for vmalloc
Date:   Wed,  4 Sep 2019 00:55:33 +1000
Message-Id: <20190903145536.3390-3-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903145536.3390-1-dja@axtens.net>
References: <20190903145536.3390-1-dja@axtens.net>
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

