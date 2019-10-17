Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5B0FA372C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 01:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8136421A4C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 01:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="m1ApeOEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395523AbfJQBZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 21:25:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45794 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394535AbfJQBZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 21:25:24 -0400
Received: by mail-pl1-f195.google.com with SMTP id u12so272941pls.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 18:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=whmCcgz4VjZeRv6SREyqmZaNFMJpz8TJQeqtX9KJOOU=;
        b=m1ApeOEBceEitnwnVhSqb3qb8hNwH66tjcLagM1+mI6PFnNgrn5Dqs68VEyged3ZLe
         H/uKj71qyeGCmqzt29SEJYhu5OVDWqcQKVYk4MRoeokuQpyzBpo+zlze/ugO7ZWt0PW/
         0BZ4YdnuvAP9ZUNSyjzYEvtHn3WSIILR8Lnf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=whmCcgz4VjZeRv6SREyqmZaNFMJpz8TJQeqtX9KJOOU=;
        b=MRm2nZYyarU4s6UbSCuoVOjRRu4mZZyCPm1Y5Dt7QUUyXVazxT9UREMQ8BeD+hkLRO
         /XR1KhevJdfM6Kryel6pswH35fMv65RUAp5UGzUSGn9uU3M5QV9KqbX/K4gmkjn25R2x
         qWdGeRpbRRH7iYDQzRlzNkHK6OXbxMTUOkYSfmwaNsAp5dT2eOJmMT8+6H/QIJbjWiuN
         nwvP4nNGxmvOev9yuOsO/7pfjiUy/dxS5eE5p5fWMxzoHomORBmbNPulqN/WFJZWUUyF
         hzVpx7qnuVe/8o9uZOuRh1Zgf7iZgHZDQhK7GirIBfugyJxfR3oHRUtT6HOpCM1GfM8k
         bIdA==
X-Gm-Message-State: APjAAAWogq3quf5qSlmnq4nj4fhYfpzZfTPSN0s8AhsEK03sGRsgb65I
        gtgJNSWDFVGkNiC6qseA3pMn9A==
X-Google-Smtp-Source: APXvYqwsR4962cnxMoM3dLvmhRD0TpVziHNmalYqRChEROjKsnzFNViD40UQgLnKTQ4n4Gd/NeT1qg==
X-Received: by 2002:a17:902:9a88:: with SMTP id w8mr1250860plp.129.1571275523512;
        Wed, 16 Oct 2019 18:25:23 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id 14sm340879pfn.21.2019.10.16.18.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 18:25:22 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v9 2/5] kasan: add test for vmalloc
Date:   Thu, 17 Oct 2019 12:25:03 +1100
Message-Id: <20191017012506.28503-3-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017012506.28503-1-dja@axtens.net>
References: <20191017012506.28503-1-dja@axtens.net>
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

diff --git lib/test_kasan.c lib/test_kasan.c
index 49cc4d570a40..328d33beae36 100644
--- lib/test_kasan.c
+++ lib/test_kasan.c
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

