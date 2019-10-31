Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0ADCA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 09:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20122083E
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 09:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="WNnsrZjR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfJaJjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 05:39:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43894 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbfJaJjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 05:39:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id 3so3972247pfb.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 02:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bVXjkvYDDmbnxsC38vuCWt+2DP5YT7XnHdrJpHAvWR8=;
        b=WNnsrZjRTgHN6z6qKlm3PPgDZ1DUQyGBME1hqttIlhCsP6pp51i+VPTsPipTm3KOvJ
         GEptraycQIRKuAP1Hj9aeVXUefmzwkWW5fefm1hacJjRHsvlIYfTLhVRVB97p5euRlwi
         jr0ph8pnjBiRogObdVC2UZwlO/vOSBdYij0G4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bVXjkvYDDmbnxsC38vuCWt+2DP5YT7XnHdrJpHAvWR8=;
        b=p4O+kF0yQ/7Ay5j7omf8pdYDyXAI8rRQdJTpxEmM9Z+nGkRfuFaXOklsRD4hm+n2kn
         lBhQXvB/X9dFR3KFcTQ8K9961akNFRdXK5JD8BW60B38p57jH/viE3im85KMO8xWtezD
         5JMw0oxTjNM//dJdL5ycY1D5yoU/NIoXa9SdCLWl6bNF+/X9C3Co710juMaOvQGqBC8u
         SvH0dvW3Ijxuexd6UFSRLNcY/X5zK6dmNtML1o6rD75vu+oTuCzhifoTfew6wgbBIxkO
         3pvSx6NRUHhA2dSevwq2g52u6hbVBH7BiSBmNtRuzpP/dI+X00gsAv3HWi6+NvpQs1eb
         A1nw==
X-Gm-Message-State: APjAAAXoSkds6+d2bCRHaBPtU79PWbsPThHSR86TZZMkGCH/oEYcXCJm
        Pba0mrRbD+cdJ1jg+QMrmMcEvA==
X-Google-Smtp-Source: APXvYqzVRXl1zQigZoY89DcUqTx/QAdcydg/VNoN51Ltb+z4DjNulE5WAl6UPNAKeADCABZ+amSUTQ==
X-Received: by 2002:a17:90a:1f4b:: with SMTP id y11mr5863515pjy.123.1572514764668;
        Thu, 31 Oct 2019 02:39:24 -0700 (PDT)
Received: from localhost (2001-44b8-1113-6700-783a-2bb9-f7cb-7c3c.static.ipv6.internode.on.net. [2001:44b8:1113:6700:783a:2bb9:f7cb:7c3c])
        by smtp.gmail.com with ESMTPSA id n15sm2785042pfq.146.2019.10.31.02.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 02:39:23 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v11 2/4] kasan: add test for vmalloc
Date:   Thu, 31 Oct 2019 20:39:07 +1100
Message-Id: <20191031093909.9228-3-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191031093909.9228-1-dja@axtens.net>
References: <20191031093909.9228-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test kasan vmalloc support by adding a new test to the module.

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
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

