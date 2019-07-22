Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B58C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA5F21900
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Afs+F9ie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732746AbfGVVdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:33:40 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:54458 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729004AbfGVVdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:33:40 -0400
Received: by mail-pl1-f201.google.com with SMTP id u10so20606940plq.21
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 14:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rVOg24+M5qJa9OkZXsdMYSLJniYg2tsuNVu94YuzcEo=;
        b=Afs+F9ieOa/EPV1dzQyvuiFqLf2MUxuSTxxTY5avgW5jl0yYZ3oLeorckrrFuUDbHK
         UJ64F4gEzWc6mUvllYnymQLfp2a9+3XmoFawqasnXzeWbE9itSbdrmIDjZI71kY26zTg
         bXOKJ8HNTUIVcm8Eipi+ugx0PEg3c/1eQ0dBLu4bHy7VpwSegvZCMW4IBtdyKt+ieIbS
         L/s8bfV/CkShj/5CgmrKlr8hoOBRBJzB+ISlEcxgZAA4RZqk0ByEcemfVkQBkkoHLZWy
         UwyMvWq2sW9LXZp5bUCdhhhu1tPcmLjaNWMZOyg5Jhf0ATcwihm2XMmY6nX2+0N0xzzD
         RRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rVOg24+M5qJa9OkZXsdMYSLJniYg2tsuNVu94YuzcEo=;
        b=S0pNSxC+W2lkThWxG7lno3mCKL1/Ze4CGEcUnKbnkdtWfqQ8zS3HuQTL48jJJQAzeT
         kss3cyS17Cpz0YJcs7u5FaIPC/Bq59JYiGafJvXfzcdbeLdLGwBKCnufRjDdhcySsiXX
         uNJg39HWkUb4qJMcpXhFcv0PIHGNMdLoH8OWQoYN2z5+rnl6o6djBq1UJKkqfCKyAjmj
         0qxz+U+hat7lg6Pu4pG+Mn2+L4w1hOTUm2qMit+pMtYIEvrQtppFgEhG6KXIypZzJRww
         XRyZJrAvISvffFkvPuCMiEHvEKqDPrKtuOJnHZ0aSS/Mr2PMReagz9kqw3G+lQmnwwEh
         +Jpw==
X-Gm-Message-State: APjAAAWtihpKPM8d9CmvyQhKHRhyd1geRhPw1Yhssh7Lrq9tyY/fgegO
        pbSCFY3G7GFVGc1/RazGlB6qc8ijOb+Y6O5y1vY=
X-Google-Smtp-Source: APXvYqxiiEidjjZE2vCTG8UXg1lYh25a/CqJJboWtCObuIQA2sdNULjY0SH46bcBxqRdQ0Wt8gb2ePSOtwdQtk6L9qg=
X-Received: by 2002:a63:724f:: with SMTP id c15mr75142798pgn.257.1563831218735;
 Mon, 22 Jul 2019 14:33:38 -0700 (PDT)
Date:   Mon, 22 Jul 2019 14:32:44 -0700
Message-Id: <20190722213250.238685-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH v2 1/2] x86/purgatory: do not use __builtin_memcpy and __builtin_memset
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     peterz@infradead.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vaibhav Rustagi <vaibhavrustagi@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Alistair Delva <adelva@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implementing memcpy and memset in terms of __builtin_memcpy and
__builtin_memset is problematic.

GCC at -O2 will replace calls to the builtins with calls to memcpy and
memset (but will generate an inline implementation at -Os).  Clang will
replace the builtins with these calls regardless of optimization level.
$ llvm-objdump -dr arch/x86/purgatory/string.o | tail

0000000000000339 memcpy:
     339: 48 b8 00 00 00 00 00 00 00 00 movabsq $0, %rax
                000000000000033b:  R_X86_64_64  memcpy
     343: ff e0                         jmpq    *%rax

0000000000000345 memset:
     345: 48 b8 00 00 00 00 00 00 00 00 movabsq $0, %rax
                0000000000000347:  R_X86_64_64  memset
     34f: ff e0

Such code results in infinite recursion at runtime. This is observed
when doing kexec.

Instead, reuse an implementation from arch/x86/boot/compressed/string.c
if we define warn as a symbol.

Fixes: 8fc5b4d4121c ("purgatory: core purgatory functionality")
Link: https://bugs.chromium.org/p/chromium/issues/detail?id=984056
Reported-by: Vaibhav Rustagi <vaibhavrustagi@google.com>
Tested-by: Vaibhav Rustagi <vaibhavrustagi@google.com>
Debugged-by: Vaibhav Rustagi <vaibhavrustagi@google.com>
Debugged-by: Manoj Gupta <manojgupta@google.com>
Suggested-by: Alistair Delva <adelva@google.com>
Signed-off-by: Vaibhav Rustagi <vaibhavrustagi@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes v1 -> v2:
* Add Fixes tag.
* Move this patch to first in the series.

 arch/x86/purgatory/Makefile    |  3 +++
 arch/x86/purgatory/purgatory.c |  6 ++++++
 arch/x86/purgatory/string.c    | 23 -----------------------
 3 files changed, 9 insertions(+), 23 deletions(-)
 delete mode 100644 arch/x86/purgatory/string.c

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 3cf302b26332..91ef244026d2 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -6,6 +6,9 @@ purgatory-y := purgatory.o stack.o setup-x86_$(BITS).o sha256.o entry64.o string
 targets += $(purgatory-y)
 PURGATORY_OBJS = $(addprefix $(obj)/,$(purgatory-y))
 
+$(obj)/string.o: $(srctree)/arch/x86/boot/compressed/string.c FORCE
+	$(call if_changed_rule,cc_o_c)
+
 $(obj)/sha256.o: $(srctree)/lib/sha256.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
diff --git a/arch/x86/purgatory/purgatory.c b/arch/x86/purgatory/purgatory.c
index 6d8d5a34c377..b607bda786f6 100644
--- a/arch/x86/purgatory/purgatory.c
+++ b/arch/x86/purgatory/purgatory.c
@@ -68,3 +68,9 @@ void purgatory(void)
 	}
 	copy_backup_region();
 }
+
+/*
+ * Defined in order to reuse memcpy() and memset() from
+ * arch/x86/boot/compressed/string.c
+ */
+void warn(const char *msg) {}
diff --git a/arch/x86/purgatory/string.c b/arch/x86/purgatory/string.c
deleted file mode 100644
index 01ad43873ad9..000000000000
--- a/arch/x86/purgatory/string.c
+++ /dev/null
@@ -1,23 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Simple string functions.
- *
- * Copyright (C) 2014 Red Hat Inc.
- *
- * Author:
- *       Vivek Goyal <vgoyal@redhat.com>
- */
-
-#include <linux/types.h>
-
-#include "../boot/string.c"
-
-void *memcpy(void *dst, const void *src, size_t len)
-{
-	return __builtin_memcpy(dst, src, len);
-}
-
-void *memset(void *dst, int c, size_t len)
-{
-	return __builtin_memset(dst, c, len);
-}
-- 
2.22.0.657.g960e92d24f-goog

