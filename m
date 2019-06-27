Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B545C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 09:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFDC2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 09:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J0Ci+Hl2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfF0JpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 05:45:16 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:51144 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfF0JpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 05:45:14 -0400
Received: by mail-yb1-f201.google.com with SMTP id v83so3242008ybv.17
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 02:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/Bjb3ErsQTLw+YrlSLkjBcr6K+fvu3f9fORDBwR/vbU=;
        b=J0Ci+Hl2dklL61XlDu+L7c3zA5n+Cr6/DaQOIbrhOtnPcC74yySQ+I5nkFakrDmsxW
         4bi1Q4JaIWXmIUOCc4DIdh/ds39jpfRXGtDW6mU0xdjNAlM9Jda9tH6hbUAdTGAZEeX8
         49vYKspcn666nQb3sq8SwovKzlb21N9T7d8GljQX+tyOtgPUiOjtZI/gKE936+eoqNHx
         rxxaGWQaPKCugOiKAzguIJfywBy0nNvgisRy5RigGtGBtBdfJH3TJYPgtpjGV0zoyJTK
         ZjYB1aD0xLPDgs/tqbM7lVH6PjLItziSxZ1iovnz/Tq5P9P4Rc8eKOb7vfjUUS6OEaiR
         c5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/Bjb3ErsQTLw+YrlSLkjBcr6K+fvu3f9fORDBwR/vbU=;
        b=Q4HsObcTxK7/wasNJR4bMQm/qAkiW+WU/uDIWRQ5t0Ox2WK2E4+AAxnbkIkpMJCW8m
         oai6LnfDn2H9KrEzgCX6wXZ3CXkEhpcLwsn32iZyN5VZvFdSQ0ooVhLlFpXvNlwaBfim
         CyKJO07oopUbCLCRVSP7zfKV/kqWP07abzQzX2NiGDYdnf4LSYo/BxgbtZLU7es0U7J0
         2bPBNmviqmFVwiUws81CAtCBsyKlaRBcFmBKIrbEr1fTPAYlQyIDECeFkMOUZ2ef6rU6
         eBQMIaDc85Y4YsH8aL5yvaywclVoOxmsPMIz4gUlDdDMesAr/Rnnk5woIzKyRU0T1zXs
         uopw==
X-Gm-Message-State: APjAAAUVYWQvJE72uM5CxIzp1A8jn8437HzAtiWPGvNZp+DyOQT7jPT+
        BYuPJz3wn2b6lAY6MxwLzRRrx/PYHQ==
X-Google-Smtp-Source: APXvYqzrzpOQbBKJXfxXILWs07ouSrOOgu0C1a7VRkp0utCzl0DRrXpztivBKMFnbS0DUZY3rM1cYhRiLQ==
X-Received: by 2002:a25:9a44:: with SMTP id r4mr1814342ybo.393.1561628713265;
 Thu, 27 Jun 2019 02:45:13 -0700 (PDT)
Date:   Thu, 27 Jun 2019 11:44:43 +0200
In-Reply-To: <20190627094445.216365-1-elver@google.com>
Message-Id: <20190627094445.216365-4-elver@google.com>
Mime-Version: 1.0
References: <20190627094445.216365-1-elver@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v4 3/5] lib/test_kasan: Add test for double-kzfree detection
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

