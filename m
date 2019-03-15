Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3652C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0431218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GVf2d9dO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfCOUyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 16:54:53 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36473 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfCOUyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 16:54:52 -0400
Received: by mail-yw1-f66.google.com with SMTP id 189so8354875ywi.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 13:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:mime-version:date:message-id:subject:to:cc;
        bh=RrMRJ6eH/hjzKu3LR3gIVFNgcuO2FP49mrXuRHGUiak=;
        b=GVf2d9dO3nefq4cMFR+0ytUIwdUdB0qS96eysTUaOBft3WkZrDUyJd0rCZQ4joMSj5
         hX/C/xOJfkduIcHFW4H+dpqBl/jEaaINWQfSTCfmRXp1UPLhE3De0hkEFwWkH5ksmADS
         zIpNPOvl7I4PHQzfnZoiDQe0tcLIp1z7qtdT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:date:message-id:subject:to:cc;
        bh=RrMRJ6eH/hjzKu3LR3gIVFNgcuO2FP49mrXuRHGUiak=;
        b=ZaYMgKdCzuZqouVNPrOsPNwTtTPoSscRkOoLF9WoneF2g8p+KUGmlKtiILRkA5T+Ke
         ABR6kK9SmjkRbTBarZH8+VmJl7D0/gH/lBTjFIW78NQx/Z+KJafKsg+gkDi0asBXSDsO
         qUKYu4IUPKrXEfcwtkKsdPd0pEVB2jzSGuAEQIl2lswTxgbIqc71jS/Fm1RbQB/OYy7N
         gDRpT4vRx6IstEcSOPz63tJTXLn+OfkZIF10syRiMbqJUOY/W9172ahgBSEZUzbMZV8G
         TdKd5OgB5AD8K3uAEL0fzVOsfWATw5wKMNPV4zYkOH972n1Mp+3VZydMfxT7Zht5KENW
         +i/g==
X-Gm-Message-State: APjAAAXz57DupCM6+x4lsTKxB9JR5pbwAO8PhulUFM+Xtfp1EkwiAup0
        c29EPwMjBQpdZBZFp4Js8Opzk95fx7GgxdVf3Jv91A==
X-Google-Smtp-Source: APXvYqwoLYWwNokX5rTE69qOq/XHHC2zaF8rnRXfVQCD+iZFA9rtNYWrL6xXo0G9i8AaCdp1nICl5pYlNH3aOdqnCtw=
X-Received: by 2002:a25:e68d:: with SMTP id d135mr4764890ybh.334.1552683291744;
 Fri, 15 Mar 2019 13:54:51 -0700 (PDT)
Received: from 764776645087 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 15 Mar 2019 13:54:50 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
MIME-Version: 1.0
Date:   Fri, 15 Mar 2019 13:54:50 -0700
Message-ID: <CAG5bF+S6OvBnsaR6UpMCqjDR9_hMo6qRMHGiW+iCaRYQW4C3YA@mail.gmail.com>
Subject: [PATCH] lib: Add shared copy of __lshrti3 from libgcc
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@chromium.org>,
        Tiancong Wang <tcwang@chromium.org>,
        Stephen Hines <srhines@google.com>,
        clang-built-linux@googlegroups.com,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compiler may emit calls to __lshrti3 from the compiler runtime
library, which results in undefined references:

arch/x86/kvm/x86.o: In function `mul_u64_u64_shr':
  include/linux/math64.h:186: undefined reference to `__lshrti3'

Add a copy of the __lshrti3 libgcc routine (from gcc v4.9.2).

Include the function for x86 builds with clang, which is the
environment where the above error was observed.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/x86/Kconfig       |  1 +
 include/linux/libgcc.h | 16 ++++++++++++++++
 lib/Kconfig            |  3 +++
 lib/Makefile           |  1 +
 lib/lshrti3.c          | 31 +++++++++++++++++++++++++++++++
 5 files changed, 52 insertions(+)
 create mode 100644 lib/lshrti3.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c1f9b3cf437c..a5e0d923845d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -105,6 +105,7 @@ config X86
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_RESERVATION_MODE
 	select GENERIC_IRQ_SHOW
+	select GENERIC_LIB_LSHRTI3		if CC_IS_CLANG
 	select GENERIC_PENDING_IRQ		if SMP
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_STRNCPY_FROM_USER
diff --git a/include/linux/libgcc.h b/include/linux/libgcc.h
index 32e1e0f4b2d0..a71036471838 100644
--- a/include/linux/libgcc.h
+++ b/include/linux/libgcc.h
@@ -22,15 +22,26 @@
 #include <asm/byteorder.h>

 typedef int word_type __attribute__ ((mode (__word__)));
+typedef int TItype __attribute__ ((mode (TI)));

 #ifdef __BIG_ENDIAN
 struct DWstruct {
 	int high, low;
 };
+
+struct DWstruct128 {
+	long long high, low;
+};
+
 #elif defined(__LITTLE_ENDIAN)
 struct DWstruct {
 	int low, high;
 };
+
+struct DWstruct128 {
+	long long low, high;
+};
+
 #else
 #error I feel sick.
 #endif
@@ -40,4 +51,9 @@ typedef union {
 	long long ll;
 } DWunion;

+typedef union {
+	struct DWstruct128 s;
+	TItype ll;
+} DWunion128;
+
 #endif /* __ASM_LIBGCC_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index a9e56539bd11..369e10259ea6 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -624,6 +624,9 @@ config GENERIC_LIB_ASHRDI3
 config GENERIC_LIB_LSHRDI3
 	bool

+config GENERIC_LIB_LSHRTI3
+	bool
+
 config GENERIC_LIB_MULDI3
 	bool

diff --git a/lib/Makefile b/lib/Makefile
index 4e066120a0d6..42648411f451 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -277,6 +277,7 @@ obj-$(CONFIG_PARMAN) += parman.o
 obj-$(CONFIG_GENERIC_LIB_ASHLDI3) += ashldi3.o
 obj-$(CONFIG_GENERIC_LIB_ASHRDI3) += ashrdi3.o
 obj-$(CONFIG_GENERIC_LIB_LSHRDI3) += lshrdi3.o
+obj-$(CONFIG_GENERIC_LIB_LSHRTI3) += lshrti3.o
 obj-$(CONFIG_GENERIC_LIB_MULDI3) += muldi3.o
 obj-$(CONFIG_GENERIC_LIB_CMPDI2) += cmpdi2.o
 obj-$(CONFIG_GENERIC_LIB_UCMPDI2) += ucmpdi2.o
diff --git a/lib/lshrti3.c b/lib/lshrti3.c
new file mode 100644
index 000000000000..2d2123bb3030
--- /dev/null
+++ b/lib/lshrti3.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/export.h>
+#include <linux/libgcc.h>
+
+long long __lshrti3(long long u, word_type b)
+{
+	DWunion128 uu, w;
+	word_type bm;
+
+	if (b == 0)
+		return u;
+
+	uu.ll = u;
+	bm = 64 - b;
+
+	if (bm <= 0) {
+		w.s.high = 0;
+		w.s.low = (unsigned long long) uu.s.high >> -bm;
+	} else {
+		const unsigned long long carries =
+			(unsigned long long) uu.s.high << bm;
+		w.s.high = (unsigned long long) uu.s.high >> b;
+		w.s.low = ((unsigned long long) uu.s.low >> b) | carries;
+	}
+
+	return w.ll;
+}
+#ifndef BUILD_VDSO
+EXPORT_SYMBOL(__lshrti3);
+#endif
-- 
2.21.0.360.g471c308f928-goog
