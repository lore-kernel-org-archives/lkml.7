Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D32C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7035206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fR+1en1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389098AbfFMPW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:22:57 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:45064 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731956AbfFMMdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 08:33:45 -0400
Received: by mail-yw1-f73.google.com with SMTP id b63so20684047ywc.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 05:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=//K/wTWvNMc+RMO2RQcyAERyaT1WE90cBRxP/iyLlLo=;
        b=fR+1en1evD0MGrGBi3hUWX+CNKyGi7J9sEviw1Qrh0jxu9JAsa0TlayXXqRBmXB9Fu
         k2segKqgrqoLbWAMcXkua1ePfxiYwoPYYuXRmwn7kYHsiqkpY/FaATe/wa84loPTZKnL
         /1U01cRNgqqIZfQj/tvJehUN352E2l7VjRnvjVURh3FkVhdjItGp06izb7SKvMawSnE5
         89r4ZO7rsEaQdffbAMg+8pLxRfsf0x38X/4YhOZhISUCFyF8Q6i0jNLnSdSqgsw2JzHE
         YH6jK7PgWG457O8pmeQePXaw8XovBW0hRF6zcirIF1KQOLpC/ckVZC0Tf8wZB3Vu72T+
         iRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=//K/wTWvNMc+RMO2RQcyAERyaT1WE90cBRxP/iyLlLo=;
        b=cioPzdvEqzyggz/h6wj25DnffNloIFEydrx0odYz/chjQJZg2oiR9VCezKxLtSmhyM
         MrFcMvMc/1lOkzED5cgOI0/jGvdOIe8cFlPMXSq/YkKp3oHNZZKNWpCpOQsT+WxkWp0/
         IqVOQ1CHWbpfpMCPvPdaPZcXkMtuoCocV8ZXiGo+vhYdKPLsAO5OjM2OKnzaceWYansL
         FuOmAOnvICNrobHE/6YhOtBvroXQ3reQEwLN/eh8N5QKWSRo9R/dVrRRYAv9sWrj+scq
         Ohns0fzpvGFJIIKYKmV/yuY0KEGAKJu08YKWAjKsccfqY5EVt+1v50TlXCq6CNHQDUDc
         g8DA==
X-Gm-Message-State: APjAAAW6L67wPllPPg6WVN6Y47W5EWU4gcSh9aoFpbP94jwRVtnCvIcn
        0uVHdVwkKWbQqyGtIm+92mafkeUh9Q==
X-Google-Smtp-Source: APXvYqxjLPfvWXQtpqx7odwmGVSJ6XsWQaBo/pStvqT+sA+KBQ8ee/sHG2SR+y5HkEiU4QWyhwMcKrG+6g==
X-Received: by 2002:a25:d708:: with SMTP id o8mr4839586ybg.410.1560429221914;
 Thu, 13 Jun 2019 05:33:41 -0700 (PDT)
Date:   Thu, 13 Jun 2019 14:30:26 +0200
In-Reply-To: <20190613123028.179447-1-elver@google.com>
Message-Id: <20190613123028.179447-2-elver@google.com>
Mime-Version: 1.0
References: <20190613123028.179447-1-elver@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v4 1/3] lib/test_kasan: Add bitops tests
From:   Marco Elver <elver@google.com>
To:     peterz@infradead.org, aryabinin@virtuozzo.com, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com, mark.rutland@arm.com,
        hpa@zytor.com
Cc:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        x86@kernel.org, arnd@arndb.de, jpoimboe@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kasan-dev@googlegroups.com,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds bitops tests to the test_kasan module. In a follow-up patch,
support for bitops instrumentation will be added.

Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
Changes in v4:
* Remove "within-bounds" tests.
* Allocate sizeof(*bite) + 1, to not actually corrupt other memory in
  case instrumentation isn't working.
* Clarify that accesses operate on whole longs, which causes OOB
  regardless of the bit accessed beyond the first long in the test.

Changes in v3:
* Use kzalloc instead of kmalloc.
* Use sizeof(*bits).

Changes in v2:
* Use BITS_PER_LONG.
* Use heap allocated memory for test, as newer compilers (correctly)
  warn on OOB stack access.
---
 lib/test_kasan.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 3 deletions(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 7de2702621dc..e76a4711d456 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -11,16 +11,17 @@
 
 #define pr_fmt(fmt) "kasan test: %s " fmt, __func__
 
+#include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/kasan.h>
 #include <linux/kernel.h>
-#include <linux/mman.h>
 #include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/module.h>
 #include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
-#include <linux/module.h>
-#include <linux/kasan.h>
 
 /*
  * Note: test functions are marked noinline so that their names appear in
@@ -623,6 +624,80 @@ static noinline void __init kasan_strings(void)
 	strnlen(ptr, 1);
 }
 
+static noinline void __init kasan_bitops(void)
+{
+	/*
+	 * Allocate 1 more byte, which causes kzalloc to round up to 16-bytes;
+	 * this way we do not actually corrupt other memory, in case
+	 * instrumentation is not working as intended.
+	 */
+	long *bits = kzalloc(sizeof(*bits) + 1, GFP_KERNEL);
+	if (!bits)
+		return;
+
+	/*
+	 * Below calls try to access bit within allocated memory; however, the
+	 * below accesses are still out-of-bounds, since bitops are defined to
+	 * operate on the whole long the bit is in.
+	 */
+	pr_info("out-of-bounds in set_bit\n");
+	set_bit(BITS_PER_LONG, bits);
+
+	pr_info("out-of-bounds in __set_bit\n");
+	__set_bit(BITS_PER_LONG, bits);
+
+	pr_info("out-of-bounds in clear_bit\n");
+	clear_bit(BITS_PER_LONG, bits);
+
+	pr_info("out-of-bounds in __clear_bit\n");
+	__clear_bit(BITS_PER_LONG, bits);
+
+	pr_info("out-of-bounds in clear_bit_unlock\n");
+	clear_bit_unlock(BITS_PER_LONG, bits);
+
+	pr_info("out-of-bounds in __clear_bit_unlock\n");
+	__clear_bit_unlock(BITS_PER_LONG, bits);
+
+	pr_info("out-of-bounds in change_bit\n");
+	change_bit(BITS_PER_LONG, bits);
+
+	pr_info("out-of-bounds in __change_bit\n");
+	__change_bit(BITS_PER_LONG, bits);
+
+	/*
+	 * Below calls try to access bit beyond allocated memory.
+	 */
+	pr_info("out-of-bounds in test_and_set_bit\n");
+	test_and_set_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
+
+	pr_info("out-of-bounds in __test_and_set_bit\n");
+	__test_and_set_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
+
+	pr_info("out-of-bounds in test_and_set_bit_lock\n");
+	test_and_set_bit_lock(BITS_PER_LONG + BITS_PER_BYTE, bits);
+
+	pr_info("out-of-bounds in test_and_clear_bit\n");
+	test_and_clear_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
+
+	pr_info("out-of-bounds in __test_and_clear_bit\n");
+	__test_and_clear_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
+
+	pr_info("out-of-bounds in test_and_change_bit\n");
+	test_and_change_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
+
+	pr_info("out-of-bounds in __test_and_change_bit\n");
+	__test_and_change_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
+
+	pr_info("out-of-bounds in test_bit\n");
+	(void)test_bit(BITS_PER_LONG + BITS_PER_BYTE, bits);
+
+#if defined(clear_bit_unlock_is_negative_byte)
+	pr_info("out-of-bounds in clear_bit_unlock_is_negative_byte\n");
+	clear_bit_unlock_is_negative_byte(BITS_PER_LONG + BITS_PER_BYTE, bits);
+#endif
+	kfree(bits);
+}
+
 static int __init kmalloc_tests_init(void)
 {
 	/*
@@ -664,6 +739,7 @@ static int __init kmalloc_tests_init(void)
 	kasan_memchr();
 	kasan_memcmp();
 	kasan_strings();
+	kasan_bitops();
 
 	kasan_restore_multi_shot(multishot);
 
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

