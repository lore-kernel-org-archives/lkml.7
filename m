Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF701C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 11:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D8F216C8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 11:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="GKuCbVx1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbfIBLVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 07:21:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43955 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730162AbfIBLVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 07:21:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id u72so3159081pgb.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 04:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HNDV9DT7O32N2h9l7CrACdWJSzNVfR3Dv9pnUT55kOg=;
        b=GKuCbVx1t+eL5NuSXYg24Zb8O/7qTbI6sdxmgVMesG2eQh9g+M4P/EvE8/9CODfonb
         HkkHFG8Jfj0z4u6Wejfvymvg0FJ/jFlvzomETWUK76xRmoT4O1vaYZFlHdPyE8vpCFrZ
         3vAjdReE6wxH63jd/H9o8cAAEV+he33Jb66Vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HNDV9DT7O32N2h9l7CrACdWJSzNVfR3Dv9pnUT55kOg=;
        b=jJzNDmzuo62g9fq/pzTxlcvfIbw/9omVBwZ4S0izz48DazAHkpPWvYScW1QjHvty1O
         19l+emyXpLjf4rAWpmqyhXXTgVFL/5080IMR6bRpl4LP8pXxBocYMAsgHiXBw/SLajWx
         SVdgHqRMU6ke8sNeanL+J5JqV4Bbk4WHO+XgQ8ENHyBmNUHsP/W+DDAI0lzMEEwhazN4
         2aYlOCW8l+jBOlbARSgS35a3jigGU0shL9BLCbVtc/OuHpTM9mp5P4oqVZvJnz65+7Rv
         hz25+Rp+vA4Q3fNMFdGrJbNkPKySN7/LgeDBpIfw705c1JqMdymiBN+3V6s8WBJikwe2
         MMVQ==
X-Gm-Message-State: APjAAAVWNP6wt/iGKQNYYVtvwLOpCWU6rhBe9akgClxK21iLmMED4OJh
        g6PJLCU/lM+Qh8ndTwE5p0mLCw==
X-Google-Smtp-Source: APXvYqxtvaCM3hqb+7Izu1R5iMb3P+H/OrJHoZiO5jXOxIbwph4iMi5iHPiqM6OOmUWJg7dmwTafQA==
X-Received: by 2002:a63:b904:: with SMTP id z4mr24200059pge.388.1567423310696;
        Mon, 02 Sep 2019 04:21:50 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id o64sm7133044pjb.24.2019.09.02.04.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 04:21:50 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v6 2/5] kasan: add test for vmalloc
Date:   Mon,  2 Sep 2019 21:20:25 +1000
Message-Id: <20190902112028.23773-3-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902112028.23773-1-dja@axtens.net>
References: <20190902112028.23773-1-dja@axtens.net>
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

