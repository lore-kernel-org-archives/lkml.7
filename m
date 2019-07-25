Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CB4C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 20:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67FA922BEF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 20:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m+T3VBZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfGYUGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 16:06:45 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:42063 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfGYUGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 16:06:45 -0400
Received: by mail-pf1-f202.google.com with SMTP id 21so31593411pfu.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 13:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bLZyVx2d9+4mutQVBosXKh2ZSsxE7Nf0cA/U+GJuG+A=;
        b=m+T3VBZIJljmJqRqMRQDcbzAAQaa/9uOr8Q/ElYMWK1MgCq5Qv2UQckai6yVrCbHv2
         zJxRaIWjigCrCQ6bVKnnhM3sZuQmugPabgGX/mdzGe4TaQsRVUb6STzU3xWyJISmQ+1m
         5MA3V19qnAuxHoayJsCsP8wjTc9GYvpeL4psfoJSqkCaqHKnsS0OTxyb/NfJFitxA7j1
         vH+tl/UfuEdxiydFhJ8d5VsEvRrMrHKdNGqZIwy7E4QS39cujJ3+GXOu/Xl2mkmnlLQE
         ZMmqNehZbAuLZYZ2DentulKe+kfFpiGueOUoRWEO+IiHSlc7AyQwFiDOnjIK68b5Fk3z
         WOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bLZyVx2d9+4mutQVBosXKh2ZSsxE7Nf0cA/U+GJuG+A=;
        b=ozgQknvhF0Js2LnqX1HI24I9NiIVogFBO49pm4yQiE4lO/N29490iNIUltK8Fcrm8J
         /Y8cZT3ecjAGioMFEdCOi6ffq4hg+GPvTLnkFw9U8S/+f2GEHUF5+mgQAyXSVck3LoEK
         476dYfMlIFldH1tETwIwEwO6HdfeLdqrRxBAvyK9qVwn2y0uuXjhJo1aPR0ZpYSa9xB6
         o2P1FmtXxSaCTyupgpDjkP0xXmHIXHftcbIiHVzdC2fxJBncG+pfzoiNSSRU9w7Nh7jh
         fId4wVX5RHy4v2iDusb4rCtcbk4L2cRNrlV8FTFQ5rkK0RfrsAjFgm0m3+K6sbZrMW1r
         zAtQ==
X-Gm-Message-State: APjAAAUOCF+FXDgc0F4rmAlzgDa4Zz/PmpzGJ+5/HUWtSVibMO8ZKs45
        0qfISZ7dqfJrGuduUTWhXhZ8eZUODCXqm/yQKCY=
X-Google-Smtp-Source: APXvYqzlu8Pc/ZmabwCgd6G8CfIMY0/jgeef1KnAmg1gswTazxkq4Yfox6edHAKDSm+qrDyYlC88PNt06VhJIYqc+eE=
X-Received: by 2002:a63:6901:: with SMTP id e1mr57594206pgc.390.1564085203941;
 Thu, 25 Jul 2019 13:06:43 -0700 (PDT)
Date:   Thu, 25 Jul 2019 13:06:17 -0700
Message-Id: <20190725200625.174838-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v4 1/2] x86/purgatory: do not use __builtin_memcpy and __builtin_memset
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     peterz@infradead.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vaibhav Rustagi <vaibhavrustagi@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Alistair Delva <adelva@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Enrico Weigelt <info@metux.net>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Uros Bizjak <ubizjak@gmail.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>
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
if we define warn as a symbol. Also, Clang may lower memcmp's that
compare against 0 to bcmp's, so add a small definition, too. See also:
commit 5f074f3e192f ("lib/string.c: implement a basic bcmp")

Fixes: 8fc5b4d4121c ("purgatory: core purgatory functionality")
Link: https://bugs.chromium.org/p/chromium/issues/detail?id=984056
Reported-by: Vaibhav Rustagi <vaibhavrustagi@google.com>
Debugged-by: Vaibhav Rustagi <vaibhavrustagi@google.com>
Debugged-by: Manoj Gupta <manojgupta@google.com>
Suggested-by: Alistair Delva <adelva@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Vaibhav Rustagi <vaibhavrustagi@google.com>
---
Changes v3 -> v4:
* (style) open brace on newline
* drop Vaibhav's SOB tag that was accidentally copy+pasta'd from v1.
* Carry Vaibhav's tested by tag from v3 since v4 is strictly stylistic
  change from v3.
* Drop cc'ing stable. Sasha's bot reports v1 doesn't cherry pick cleanly
  5.1, so this series will require manual backports.
Changes v2 -> v3:
* Add bcmp implementation.
* Drop tested-by tag (Vaibhav will help retest).
* Cc stable
Changes v1 -> v2:
* Add Fixes tag.
* Move this patch to first in the series.

 arch/x86/boot/string.c         |  8 ++++++++
 arch/x86/purgatory/Makefile    |  3 +++
 arch/x86/purgatory/purgatory.c |  6 ++++++
 arch/x86/purgatory/string.c    | 23 -----------------------
 4 files changed, 17 insertions(+), 23 deletions(-)
 delete mode 100644 arch/x86/purgatory/string.c

diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
index 401e30ca0a75..8272a4492844 100644
--- a/arch/x86/boot/string.c
+++ b/arch/x86/boot/string.c
@@ -37,6 +37,14 @@ int memcmp(const void *s1, const void *s2, size_t len)
 	return diff;
 }
 
+/*
+ * Clang may lower `memcmp == 0` to `bcmp == 0`.
+ */
+int bcmp(const void *s1, const void *s2, size_t len)
+{
+	return memcmp(s1, s2, len);
+}
+
 int strcmp(const char *str1, const char *str2)
 {
 	const unsigned char *s1 = (const unsigned char *)str1;
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
2.22.0.709.g102302147b-goog

