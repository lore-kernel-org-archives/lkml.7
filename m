Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F53C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 01:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2141020708
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 01:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a82EApFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfKTBGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 20:06:47 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:43505 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbfKTBGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 20:06:44 -0500
Received: by mail-pj1-f67.google.com with SMTP id a10so3417178pju.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 17:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0T61AzxnAvwa4rB+CZumfDDidufAJnp+U8GPCQMxTB4=;
        b=a82EApFVTEe9phvCSrJOP3TlCmeHwEbc7lBntv/Y4A3SIjXWLzIYaza53B34WSAvIO
         M/p/3ECy6DvVgT1DcT27ZKc9hqk61OMYWbeg8Ie4sWtPigLH57V9lJaYWI9PwzZgGuQN
         +goyCf8HKTHNdfpJZrJyL8SxxITM+b1kefwFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0T61AzxnAvwa4rB+CZumfDDidufAJnp+U8GPCQMxTB4=;
        b=kvMEKd5jr04u5IySxAqgxNJw40TGhaFXwyUgTC+CxKAdn1uaauP1g+hmWwrL33U8hN
         qN9A9l0N3K9sHwsnqxsWqIysoqMO/iTTjioe1V0B/Jrc/7FbLYFWVt9I1MihCeuXA7fP
         gz5glAVAZlpzqiHw9ws2PH9O2RzO3zFoMIIXbxDep7uqTYutC+PCX7+qI7jcZbUeMSsX
         cjJZr9GHIOO7ZFGouHWMEyQMcMCQk6/adbafGqqLFt0hiwFRCAAYsFPMrMY2doJslvMD
         evVduGQb0laz1WjIq9D0w0PF0meUzI4m9BaYjnLfZyfQ9xS+kY++pt0MtfGvsrkBEnO9
         Ul7g==
X-Gm-Message-State: APjAAAWJcqRVZHzX2xVjTjtKdVeBRhe0LQ+TgrM4MT7dtXgs4J5IJ8rG
        6ryOSclWg3NgiXxvSoLzVHMMmg==
X-Google-Smtp-Source: APXvYqwMjjdQ2rf3CZ9jjyiv4G3ZP7tQU+Lm0RTG8f4dInndtCYLfPklkPViLPE1GjBEoqneZ6KF6w==
X-Received: by 2002:a17:902:561:: with SMTP id 88mr155318plf.127.1574212003854;
        Tue, 19 Nov 2019 17:06:43 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u24sm24440563pgf.6.2019.11.19.17.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 17:06:41 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Elena Petrova <lenaptr@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH 3/3] lkdtm/bugs: Add arithmetic overflow and array bounds checks
Date:   Tue, 19 Nov 2019 17:06:36 -0800
Message-Id: <20191120010636.27368-4-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191120010636.27368-1-keescook@chromium.org>
References: <20191120010636.27368-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds LKDTM tests for arithmetic overflow (both signed and unsigned),
as well as array bounds checking.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/bugs.c  | 75 ++++++++++++++++++++++++++++++++++++++
 drivers/misc/lkdtm/core.c  |  3 ++
 drivers/misc/lkdtm/lkdtm.h |  3 ++
 3 files changed, 81 insertions(+)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 7284a22b1a09..8b4ef30f53c6 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -11,6 +11,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/task_stack.h>
 #include <linux/uaccess.h>
+#include <linux/slab.h>
 
 struct lkdtm_list {
 	struct list_head node;
@@ -171,6 +172,80 @@ void lkdtm_HUNG_TASK(void)
 	schedule();
 }
 
+volatile unsigned int huge = INT_MAX - 2;
+volatile unsigned int ignored;
+
+void lkdtm_OVERFLOW_SIGNED(void)
+{
+	int value;
+
+	value = huge;
+	pr_info("Normal signed addition ...\n");
+	value += 1;
+	ignored = value;
+
+	pr_info("Overflowing signed addition ...\n");
+	value += 4;
+	ignored = value;
+}
+
+
+void lkdtm_OVERFLOW_UNSIGNED(void)
+{
+	unsigned int value;
+
+	value = huge;
+	pr_info("Normal unsigned addition ...\n");
+	value += 1;
+	ignored = value;
+
+	pr_info("Overflowing unsigned addition ...\n");
+	value += 4;
+	ignored = value;
+}
+
+/* Intentially using old-style flex array definition of 1 byte. */
+struct array_bounds_flex_array {
+	int one;
+	int two;
+	char data[1];
+};
+
+struct array_bounds {
+	int one;
+	int two;
+	char data[8];
+	int three;
+};
+
+void lkdtm_ARRAY_BOUNDS(void)
+{
+	struct array_bounds_flex_array *not_checked;
+	struct array_bounds *checked;
+	int i;
+
+	not_checked = kmalloc(sizeof(*not_checked) * 2, GFP_KERNEL);
+	checked = kmalloc(sizeof(*checked) * 2, GFP_KERNEL);
+
+	pr_info("Array access within bounds ...\n");
+	/* For both, touch all bytes in the actual member size. */
+	for (i = 0; i < sizeof(checked->data); i++)
+		checked->data[i] = 'A';
+	/*
+	 * For the uninstrumented flex array member, also touch 1 byte
+	 * beyond to verify it is correctly uninstrumented.
+	 */
+	for (i = 0; i < sizeof(not_checked->data) + 1; i++)
+		not_checked->data[i] = 'A';
+
+	pr_info("Array access beyond bounds ...\n");
+	for (i = 0; i < sizeof(checked->data) + 1; i++)
+		checked->data[i] = 'B';
+
+	kfree(not_checked);
+	kfree(checked);
+}
+
 void lkdtm_CORRUPT_LIST_ADD(void)
 {
 	/*
diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index cbc4c9045a99..25879f7b0768 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -129,6 +129,9 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(HARDLOCKUP),
 	CRASHTYPE(SPINLOCKUP),
 	CRASHTYPE(HUNG_TASK),
+	CRASHTYPE(OVERFLOW_SIGNED),
+	CRASHTYPE(OVERFLOW_UNSIGNED),
+	CRASHTYPE(ARRAY_BOUNDS),
 	CRASHTYPE(EXEC_DATA),
 	CRASHTYPE(EXEC_STACK),
 	CRASHTYPE(EXEC_KMALLOC),
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index ab446e0bde97..2cd0c5031eea 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -22,6 +22,9 @@ void lkdtm_SOFTLOCKUP(void);
 void lkdtm_HARDLOCKUP(void);
 void lkdtm_SPINLOCKUP(void);
 void lkdtm_HUNG_TASK(void);
+void lkdtm_OVERFLOW_SIGNED(void);
+void lkdtm_OVERFLOW_UNSIGNED(void);
+void lkdtm_ARRAY_BOUNDS(void);
 void lkdtm_CORRUPT_LIST_ADD(void);
 void lkdtm_CORRUPT_LIST_DEL(void);
 void lkdtm_CORRUPT_USER_DS(void);
-- 
2.17.1

