Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13DDC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 23:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2DE2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 23:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jTb0CaVw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfHMXEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 19:04:53 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34312 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfHMXEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 19:04:52 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so49924881plt.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 16:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=b+JmorHFxBDjgjp81mdE+eQ+tC1x8WkQJkcE1tgqkc4=;
        b=jTb0CaVwThVYx3vOwD1dWobGZmwwuJFAgFmShIxG1h6tk9h8u+FodDpc7Q6/DMNNBc
         ehUsXMoEmvKIeVHXp+U1thNd/6WXmq2LVXRdui0s7VQWWVv9LLmuV2ZTxBan5mDbUjOw
         F8qCtEw03kbY/4uMFXSgmw0+++sggXhYHCvz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=b+JmorHFxBDjgjp81mdE+eQ+tC1x8WkQJkcE1tgqkc4=;
        b=sGACVJKSeffJqfzFWWXFAnZG1huF8h/e50X7MJSW2npgYpB6yni2NzsyoHdUgOeJVD
         1mk2HVoAAetu/QQmof8+05Qs7T1+Q9IxPy5ftVTJMOrpB3m0ePnVvk+oekrURSaSkhy0
         eHN+6EjoOPuchEo5KRKPOEhMvi7nvAceGaeZHVpLm7NDP28AcsQdN7Isl24ILxGs7TbG
         Ehg2xOnS13NKWTKaPJfOhxow6GRnawQvgVp4gDxT4sfgZsubbSqCJRSRZCt173Q2xiMj
         t/Iq+YEXqT/vopHsgilKl1y+A/JUYcbteFT5uHRhQtaLwrzMKCWJaGPo+WZxkdTO4ptW
         fwfA==
X-Gm-Message-State: APjAAAVf2FVKwe+1Z3sEseDE0rmiulY7GBeGlmL67sJG8/sUcFC8y36o
        rtjuQOt6WQ10fPlLh94kdqEqJg==
X-Google-Smtp-Source: APXvYqykdJqTdHuTeV+7Np9dvpfjLzBbQr3StktyfP/KteJaQUL8ByJ0OL/nBrBxD1YQlNAdMEvNAw==
X-Received: by 2002:a17:902:f30e:: with SMTP id gb14mr6861249plb.32.1565737492192;
        Tue, 13 Aug 2019 16:04:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s11sm116207822pgv.13.2019.08.13.16.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Aug 2019 16:04:51 -0700 (PDT)
Date:   Tue, 13 Aug 2019 16:04:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Fangrui Song <maskray@google.com>,
        Peter Smith <peter.smith@linaro.org>
Subject: [PATCH] arm64/efi: Move variable assignments after SECTIONS
Message-ID: <201908131602.6E858DEC@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that LLVM's linker does not correctly handle variable assignments
involving section positions that are updated during the SECTIONS
parsing. Commit aa69fb62bea1 ("arm64/efi: Mark __efistub_stext_offset as
an absolute symbol explicitly") ran into this too, but found a different
workaround.

However, this was not enough, as other variables were also miscalculated
which manifested as boot failures under UEFI where __efistub__end was
not taking the correct _end value (they should be the same):

$ ld.lld -EL -maarch64elf --no-undefined -X -shared \
	-Bsymbolic -z notext -z norelro --no-apply-dynamic-relocs \
	-o vmlinux.lld -T poc.lds --whole-archive vmlinux.o && \
  readelf -Ws vmlinux.lld | egrep '\b(__efistub_|)_end\b'
368272: ffff000002218000     0 NOTYPE  LOCAL  HIDDEN    38 __efistub__end
368322: ffff000012318000     0 NOTYPE  GLOBAL DEFAULT   38 _end

$ aarch64-linux-gnu-ld.bfd -EL -maarch64elf --no-undefined -X -shared \
	-Bsymbolic -z notext -z norelro --no-apply-dynamic-relocs \
	-o vmlinux.bfd -T poc.lds --whole-archive vmlinux.o && \
  readelf -Ws vmlinux.bfd | egrep '\b(__efistub_|)_end\b'
338124: ffff000012318000     0 NOTYPE  LOCAL  DEFAULT  ABS __efistub__end
383812: ffff000012318000     0 NOTYPE  GLOBAL DEFAULT 15325 _end

To work around this, all of the __efistub_-prefixed variable assignments
need to be moved after the linker script's SECTIONS entry. As it turns
out, this also solves the problem fixed in commit aa69fb62bea1, so those
changes are reverted here.

Link: https://github.com/ClangBuiltLinux/linux/issues/634
Link: https://bugs.llvm.org/show_bug.cgi?id=42990
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kernel/image-vars.h  | 51 +++++++++++++++++++++++++++++++++
 arch/arm64/kernel/image.h       | 42 ---------------------------
 arch/arm64/kernel/vmlinux.lds.S |  2 ++
 3 files changed, 53 insertions(+), 42 deletions(-)
 create mode 100644 arch/arm64/kernel/image-vars.h

diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
new file mode 100644
index 000000000000..25a2a9b479c2
--- /dev/null
+++ b/arch/arm64/kernel/image-vars.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Linker script variables to be set after section resolution, as
+ * ld.lld does not like variables assigned before SECTIONS is processed.
+ */
+#ifndef __ARM64_KERNEL_IMAGE_VARS_H
+#define __ARM64_KERNEL_IMAGE_VARS_H
+
+#ifndef LINKER_SCRIPT
+#error This file should only be included in vmlinux.lds.S
+#endif
+
+#ifdef CONFIG_EFI
+
+__efistub_stext_offset = stext - _text;
+
+/*
+ * The EFI stub has its own symbol namespace prefixed by __efistub_, to
+ * isolate it from the kernel proper. The following symbols are legally
+ * accessed by the stub, so provide some aliases to make them accessible.
+ * Only include data symbols here, or text symbols of functions that are
+ * guaranteed to be safe when executed at another offset than they were
+ * linked at. The routines below are all implemented in assembler in a
+ * position independent manner
+ */
+__efistub_memcmp		= __pi_memcmp;
+__efistub_memchr		= __pi_memchr;
+__efistub_memcpy		= __pi_memcpy;
+__efistub_memmove		= __pi_memmove;
+__efistub_memset		= __pi_memset;
+__efistub_strlen		= __pi_strlen;
+__efistub_strnlen		= __pi_strnlen;
+__efistub_strcmp		= __pi_strcmp;
+__efistub_strncmp		= __pi_strncmp;
+__efistub_strrchr		= __pi_strrchr;
+__efistub___flush_dcache_area	= __pi___flush_dcache_area;
+
+#ifdef CONFIG_KASAN
+__efistub___memcpy		= __pi_memcpy;
+__efistub___memmove		= __pi_memmove;
+__efistub___memset		= __pi_memset;
+#endif
+
+__efistub__text			= _text;
+__efistub__end			= _end;
+__efistub__edata		= _edata;
+__efistub_screen_info		= screen_info;
+
+#endif
+
+#endif /* __ARM64_KERNEL_IMAGE_VARS_H */
diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
index 2b85c0d6fa3d..c7d38c660372 100644
--- a/arch/arm64/kernel/image.h
+++ b/arch/arm64/kernel/image.h
@@ -65,46 +65,4 @@
 	DEFINE_IMAGE_LE64(_kernel_offset_le, TEXT_OFFSET);	\
 	DEFINE_IMAGE_LE64(_kernel_flags_le, __HEAD_FLAGS);
 
-#ifdef CONFIG_EFI
-
-/*
- * Use ABSOLUTE() to avoid ld.lld treating this as a relative symbol:
- * https://github.com/ClangBuiltLinux/linux/issues/561
- */
-__efistub_stext_offset = ABSOLUTE(stext - _text);
-
-/*
- * The EFI stub has its own symbol namespace prefixed by __efistub_, to
- * isolate it from the kernel proper. The following symbols are legally
- * accessed by the stub, so provide some aliases to make them accessible.
- * Only include data symbols here, or text symbols of functions that are
- * guaranteed to be safe when executed at another offset than they were
- * linked at. The routines below are all implemented in assembler in a
- * position independent manner
- */
-__efistub_memcmp		= __pi_memcmp;
-__efistub_memchr		= __pi_memchr;
-__efistub_memcpy		= __pi_memcpy;
-__efistub_memmove		= __pi_memmove;
-__efistub_memset		= __pi_memset;
-__efistub_strlen		= __pi_strlen;
-__efistub_strnlen		= __pi_strnlen;
-__efistub_strcmp		= __pi_strcmp;
-__efistub_strncmp		= __pi_strncmp;
-__efistub_strrchr		= __pi_strrchr;
-__efistub___flush_dcache_area	= __pi___flush_dcache_area;
-
-#ifdef CONFIG_KASAN
-__efistub___memcpy		= __pi_memcpy;
-__efistub___memmove		= __pi_memmove;
-__efistub___memset		= __pi_memset;
-#endif
-
-__efistub__text			= _text;
-__efistub__end			= _end;
-__efistub__edata		= _edata;
-__efistub_screen_info		= screen_info;
-
-#endif
-
 #endif /* __ARM64_KERNEL_IMAGE_H */
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 7fa008374907..803b24d2464a 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -245,6 +245,8 @@ SECTIONS
 	HEAD_SYMBOLS
 }
 
+#include "image-vars.h"
+
 /*
  * The HYP init code and ID map text can't be longer than a page each,
  * and should not cross a page boundary.
-- 
2.17.1


-- 
Kees Cook
