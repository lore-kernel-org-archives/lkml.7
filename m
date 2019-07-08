Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E384C606C2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5099A21479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PgglRjVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403830AbfGHRJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:09:12 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:56299 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390600AbfGHRJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:09:05 -0400
Received: by mail-yw1-f74.google.com with SMTP id n139so7669238ywd.22
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 10:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/Bjb3ErsQTLw+YrlSLkjBcr6K+fvu3f9fORDBwR/vbU=;
        b=PgglRjVjhE72uthaYPgUkIA+L8Ic1IQKCjcb8XRTj87DCO10kaCcE306+6CbVNMvau
         SM1ka9Ic90hEIZxLQuIrW1jY3Vm6ESsEkj4IYF0TQ3+Fb38HOfRfZ6jc+goC1Vp402VA
         kMjKtNquIeLszR/h3t7e1dLItihhLNJ7YiN1g5fRoFKUsgOzwMwZ8toOK/16ArpBe9tF
         grBf339F217k5k/S6+fB3KbnXoO2Q0m6y/mS9TLUd2/nhXEGmHLG7x/xDi7tzYoCXGpA
         afNpmmQHXf9ZbTj7qJiAD426/t1VpxFKdDNos9FKE3egTSIsrvnwFas4LujNH5/S9+iA
         q5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/Bjb3ErsQTLw+YrlSLkjBcr6K+fvu3f9fORDBwR/vbU=;
        b=jKsmA5FEfQQUWUAR5LhRDTqH8+8jCkGHKv2p7W687BMg9tdui23ClJ1BEt2AegTD3g
         U7qpm4c6RkAnlvo470gaKTR+MioRTL+pMqILkG3bn7HbHoBMKfg5sso1o18houiopMDe
         5i33bgODTEg+qu55ioKWmCXVccdutXkkZ0IHBN5oXdOcvP4vbCWqevRa7rtMM811uF9I
         NiQhEE+h3A+P1pGRhfLW8b6qqnY04I9rljzWNPJOII6sNaUOsXBSUuDQrlrSG6U9RgCY
         4DETAx8v1yICjSXzu9PPlxJcTaCSW63zXATtHJJPnk1LuZ1BKkwHvqZ1PYrJNQ8C1cuW
         FWVg==
X-Gm-Message-State: APjAAAUlrLaL7OVdYnYURz+Ru6EjN4rG+JQXKbb/+mWsVG3c8S75nK5z
        oTwwNZQFh45sglKLxHWpGGJDh9jswQ==
X-Google-Smtp-Source: APXvYqxP+FPSf7rO7/ibi5Fz8cPbpk061VoEiwZkeVQq8DuTHnSF07hV2+HQ/wDAVE8vywm9H1aztfDkIA==
X-Received: by 2002:a81:a95:: with SMTP id 143mr12306291ywk.279.1562605743974;
 Mon, 08 Jul 2019 10:09:03 -0700 (PDT)
Date:   Mon,  8 Jul 2019 19:07:05 +0200
In-Reply-To: <20190708170706.174189-1-elver@google.com>
Message-Id: <20190708170706.174189-4-elver@google.com>
Mime-Version: 1.0
References: <20190708170706.174189-1-elver@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v5 3/5] lib/test_kasan: Add test for double-kzfree detection
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

