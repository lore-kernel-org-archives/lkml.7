Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96796C48BDB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9DD21670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 14:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gU068bo8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfFZO2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 10:28:05 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:46437 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFZO2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:28:04 -0400
Received: by mail-vs1-f73.google.com with SMTP id 129so525165vsx.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 07:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/Bjb3ErsQTLw+YrlSLkjBcr6K+fvu3f9fORDBwR/vbU=;
        b=gU068bo8xI9L4oRs1xcqv6j6N8grLH+AVjMocfTmuM4/QLKQLZ9QIslBwFDqGkRaKR
         Nalu2EhT83YJzP8X3y3VqF99al81l3vbeMWMq6Vv8cV0pT2GHKQG6TiZyPyxGWJJH0+w
         uiXHRZi806sGyKzldGWmP+mv8uuH2IL46hSwD0xgwvmeXYFr1mZmXJNtmnOpcpCZ2TU9
         LlX+Hvk2kLpmjnlVLNn+CmX1fXrBN8qP38IAz7RxpAbrzukzszYTb5z7N1xNWI48iTPq
         KFLfb5HFylzoR1RIOZsvqdTxQbst5LNBijEISkOESca8sUNG/W0wbcjbhJs6XTeJjxqH
         +W8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/Bjb3ErsQTLw+YrlSLkjBcr6K+fvu3f9fORDBwR/vbU=;
        b=qe2lhwP1ljVfaKRe4M4ddXt7X73JZNtRG63P8BiON5qw2o3hATrbuJjao/uaz+Jxxg
         qIE+mv2V8REq1SEQUNZX5hX7CrgWKtU94sprwQJY1JX3Gdo4Uai1k0hUcA4TtSexMvsz
         CV1NVUNAPSaXH4OFwiTcWMt1ZvRpdqe+J6k0OcUuyY/MCwbWjQrOJo1g8N82jJMrcEE3
         sreBVHtfbErst2HVlhOdNfwnZLGzSaP1uUIfi+wg6nbXJuaFrzGXoy0j9t93b+X+thbw
         JUQw3XpjjYQYED9nhGXj7+KVLRnHkxDUkTSppnIFXdQ8Zs+QJH3nHPts11U/5/E2poAP
         tQRw==
X-Gm-Message-State: APjAAAWKsZTqSpYy4mFJG+2dhTMe7MuZM8c4A0YHH9ld9PEgQ+7pm7RQ
        vECZuQCnnph6hL4e22E9m8jfR0c+Ow==
X-Google-Smtp-Source: APXvYqyFzpguQlvg2yrB3GTEFA5hP/raLtejdwArbzB/ifkPk8m/SyboHpSof39lpBUIHCeFgRv34I646g==
X-Received: by 2002:ac5:c2d2:: with SMTP id i18mr1273686vkk.36.1561559282687;
 Wed, 26 Jun 2019 07:28:02 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:20:12 +0200
In-Reply-To: <20190626142014.141844-1-elver@google.com>
Message-Id: <20190626142014.141844-4-elver@google.com>
Mime-Version: 1.0
References: <20190626142014.141844-1-elver@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v3 3/5] lib/test_kasan: Add test for double-kzfree detection
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a simple test that checks if double-kzfree is being detected
correctly.

Signed-off-by: Marco Elver <elver@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: kasan-dev@googlegroups.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 lib/test_kasan.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index e3c593c38eff..dda5da9f5bd4 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -619,6 +619,22 @@ static noinline void __init kasan_strings(void)
 	strnlen(ptr, 1);
 }
 
+static noinline void __init kmalloc_double_kzfree(void)
+{
+	char *ptr;
+	size_t size = 16;
+
+	pr_info("double-free (kzfree)\n");
+	ptr = kmalloc(size, GFP_KERNEL);
+	if (!ptr) {
+		pr_err("Allocation failed\n");
+		return;
+	}
+
+	kzfree(ptr);
+	kzfree(ptr);
+}
+
 static int __init kmalloc_tests_init(void)
 {
 	/*
@@ -660,6 +676,7 @@ static int __init kmalloc_tests_init(void)
 	kasan_memchr();
 	kasan_memcmp();
 	kasan_strings();
+	kmalloc_double_kzfree();
 
 	kasan_restore_multi_shot(multishot);
 
-- 
2.22.0.410.gd8fdbe21b5-goog

