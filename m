Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D0BC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F01E2196E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="carhZDVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfJKAGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 20:06:31 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35684 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbfJKAG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 20:06:29 -0400
Received: by mail-pf1-f195.google.com with SMTP id 205so4958382pfw.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 17:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n5VmKDs7q8vdBz4+9T2sJG9hHU7BSOvzC0pvhvZX8so=;
        b=carhZDVuV7aWHe/mVOzWup+o5oNODCRSaKYDJLBEexacyYhrHfUMNbKXFo59HsfLdT
         wZ6hMFSRQexCI22v5IG5NUFM2WcEObK5BgW99c0DZtHkj30esilAfjApmPDIP3pjvWiL
         pfzZb27IerlCy8SvvnyBoQgndOKKC0Ory7bvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n5VmKDs7q8vdBz4+9T2sJG9hHU7BSOvzC0pvhvZX8so=;
        b=mAsLXNYAEGgILBC0b7JqsLvklj3/yrFML85EkF+/FeDT3/gjbdYCPr99+MbwKFy1Hd
         M9L0l0+qFjWtKOAQKk/i2P2K5byzzQxGHdb/8mr6/WoUVxuRuMyP+CF+kIGmjvq9N4uW
         DctZa4tBeRIEMNPXTNZzT+w74CaZ3hx2m7xuVxTtfZEOoPrYKWIRHklgWBdkoGKBvMTu
         70vQH2+6tOjUQpueSpmGQOBbklRg1HkyObZGVb0LEgEw3et5jJFKrFNvxvBsISZrzC6O
         fjFtTylU/c9Jx2xOOLtdB3yJ8S/yL/iK5gpH39xQpkZhb/RJCwYcF2eeKWNuJZRH2YrA
         2Tcw==
X-Gm-Message-State: APjAAAXGKCHq0/ZEv3T/qCuhsW9QHB7NBMbhNq7v2+YPEhCYBr5Qk0w+
        hnDIz8G4W0BkmBNDlQ1nCimBRA==
X-Google-Smtp-Source: APXvYqx8Gwnw4oVnhwjvlupfQ+jLMpTkOFUHSLw0DgIUj0K31Z94tjG2CFAjw0mYBaG87MVpGGwzjQ==
X-Received: by 2002:a62:1b45:: with SMTP id b66mr13449656pfb.34.1570752387906;
        Thu, 10 Oct 2019 17:06:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d19sm6444280pjz.5.2019.10.10.17.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:06:24 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/29] vmlinux.lds.h: Provide EMIT_PT_NOTE to indicate export of .notes
Date:   Thu, 10 Oct 2019 17:05:48 -0700
Message-Id: <20191011000609.29728-9-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011000609.29728-1-keescook@chromium.org>
References: <20191011000609.29728-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for moving NOTES into RO_DATA, provide a mechanism for
architectures that want to emit a PT_NOTE Program Header to do so.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/alpha/kernel/vmlinux.lds.S   |  3 +++
 arch/ia64/kernel/vmlinux.lds.S    |  2 ++
 arch/mips/kernel/vmlinux.lds.S    | 12 ++++++------
 arch/powerpc/kernel/vmlinux.lds.S |  1 +
 arch/s390/kernel/vmlinux.lds.S    |  2 ++
 arch/x86/kernel/vmlinux.lds.S     |  2 ++
 include/asm-generic/vmlinux.lds.h |  8 ++++++++
 7 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/alpha/kernel/vmlinux.lds.S b/arch/alpha/kernel/vmlinux.lds.S
index 781090cacc96..363a60ba7c31 100644
--- a/arch/alpha/kernel/vmlinux.lds.S
+++ b/arch/alpha/kernel/vmlinux.lds.S
@@ -1,4 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+
+#define EMITS_PT_NOTE
+
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/thread_info.h>
 #include <asm/cache.h>
diff --git a/arch/ia64/kernel/vmlinux.lds.S b/arch/ia64/kernel/vmlinux.lds.S
index 2c4f23c390ad..7cf4958b732d 100644
--- a/arch/ia64/kernel/vmlinux.lds.S
+++ b/arch/ia64/kernel/vmlinux.lds.S
@@ -5,6 +5,8 @@
 #include <asm/pgtable.h>
 #include <asm/thread_info.h>
 
+#define EMITS_PT_NOTE
+
 #include <asm-generic/vmlinux.lds.h>
 
 OUTPUT_FORMAT("elf64-ia64-little")
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 33ee0d18fb0a..1c95612eb800 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -10,6 +10,11 @@
  */
 #define BSS_FIRST_SECTIONS *(.bss..swapper_pg_dir)
 
+/* Cavium Octeon should not have a separate PT_NOTE Program Header. */
+#ifndef CONFIG_CAVIUM_OCTEON_SOC
+#define EMITS_PT_NOTE
+#endif
+
 #include <asm-generic/vmlinux.lds.h>
 
 #undef mips
@@ -76,12 +81,7 @@ SECTIONS
 		__stop___dbe_table = .;
 	}
 
-#ifdef CONFIG_CAVIUM_OCTEON_SOC
-#define NOTES_HEADER
-#else /* CONFIG_CAVIUM_OCTEON_SOC */
-#define NOTES_HEADER :note
-#endif /* CONFIG_CAVIUM_OCTEON_SOC */
-	NOTES :text NOTES_HEADER
+	NOTES NOTES_HEADERS
 	.dummy : { *(.dummy) } :text
 
 	_sdata = .;			/* Start of data section */
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index e184a63aa5b0..7e26e20c8324 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -6,6 +6,7 @@
 #endif
 
 #define BSS_FIRST_SECTIONS *(.bss.prominit)
+#define EMITS_PT_NOTE
 
 #include <asm/page.h>
 #include <asm-generic/vmlinux.lds.h>
diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 13294fef473e..646d939346df 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -15,6 +15,8 @@
 /* Handle ro_after_init data on our own. */
 #define RO_AFTER_INIT_DATA
 
+#define EMITS_PT_NOTE
+
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/vmlinux.lds.h>
 
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 788e78978030..2e18bf5c1aed 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -21,6 +21,8 @@
 #define LOAD_OFFSET __START_KERNEL_map
 #endif
 
+#define EMITS_PT_NOTE
+
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index dae64600ccbf..f5dd45ce73f1 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -54,6 +54,14 @@
 #define LOAD_OFFSET 0
 #endif
 
+/*
+ * Only some architectures want to have the .notes segment visible in
+ * a separate PT_NOTE ELF Program Header.
+ */
+#ifdef EMITS_PT_NOTE
+#define NOTES_HEADERS		:text :note
+#endif
+
 /* Align . to a 8 byte boundary equals to maximum function alignment. */
 #define ALIGN_FUNCTION()  . = ALIGN(8)
 
-- 
2.17.1

