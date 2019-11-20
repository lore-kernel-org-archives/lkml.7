Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26945C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E386B20878
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="mWZOm0wD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbfKTRHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:07:46 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45768 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbfKTRHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:07:46 -0500
Received: by mail-pg1-f193.google.com with SMTP id k1so6557pgg.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 09:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7CMguEqa5ooTINEAp0OYYFprU33z3N9YF14yQe2fceo=;
        b=mWZOm0wDbw1+aYo5N0PRrQqifoB+3mn72HxlNF5S+2igM6cRZXVOqhIo65OOtpvwav
         EqOEUNxxZ3Qv9cK2qOa30IBF8mYW6FMgF4tVBYDP/e9FWVFXzi1WYNsuk+bmwoRcj0tZ
         BIBKwz2u1+x5Fk8sds/3nvzrvV/B+ZoKw0Nf3zcxlJ07yb3hShQGz6sn/3IH9NNmoFxR
         OhjEs1LbYi9UpgDAuzOXpGJKZa1j9Bz8eTF9tiVBftJMNZbXUyIStBvUvskaUe6qVshW
         4fYjKvxqfPZSfwkOJG2Lij6LfOxct5Lgpsk+rbAI1hOHQ34zugz2M1LOX0zbTTWgGMGd
         QxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7CMguEqa5ooTINEAp0OYYFprU33z3N9YF14yQe2fceo=;
        b=PlwFLX5TVblBiYTKdnop7AxuJMT7zzypQpBW2OnLMyHh/9aWA3zlluzDy78VsWi8qS
         zTZOWY6Fs80FTngAh7EwoY9jZEhLb1ntbe7kzTo6Bz3VSycyzDN9q7Xj9y7z5uBVyQCW
         wkorcw3YzADEMzNrvw9B7CoAvSh3UJx2wuEsjGUTu9Pnu0mZltQFg93hG5f3NHnwqhh9
         OhNUEXF5dKid3eACrPcoJWGeC1MENeyJI1RGmGanI5WY0BC+/+qN1AeIiPOpysJdHJn7
         fY96eGm30jI2QXPg6YKKq4RtyutWug2s3LZSxVw2pLdfBckEIq9jbdLuQMNRquGcB38n
         oY5A==
X-Gm-Message-State: APjAAAXVWvuocEPmPhyri6u7C2/O82s4PIKX3A92fsjkaPl7EMC/qpUT
        Fj6Tamyh4vYOCgS99n2u7jIZSw==
X-Google-Smtp-Source: APXvYqw8uiIiopBjLjYpJ209OUDsXBbQMwr7vVihJIvBpIvNVsV6tPtlg2O2JmZzeyGtUowxv2oPHQ==
X-Received: by 2002:aa7:9a86:: with SMTP id w6mr5182468pfi.169.1574269665089;
        Wed, 20 Nov 2019 09:07:45 -0800 (PST)
Received: from xakep.corp.microsoft.com (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id r203sm28326401pfr.184.2019.11.20.09.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 09:07:44 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, steve.capper@arm.com,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com, mark.rutland@arm.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com
Subject: [PATCH] arm64: kernel: remove uaccess_*_not_uao asm macros
Date:   Wed, 20 Nov 2019 12:07:40 -0500
Message-Id: <20191120170740.260224-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is safer, and less code to maintain to keep uaccess_*
as inline C functions instead of ASM macros.

There is no performance overhead from this change because
the generated code is almost identical.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/asm-uaccess.h | 17 -----------------
 arch/arm64/include/asm/uaccess.h     | 27 ++++++++++++++++++++++-----
 arch/arm64/lib/clear_user.S          |  3 ---
 arch/arm64/lib/copy_from_user.S      |  3 ---
 arch/arm64/lib/copy_in_user.S        |  3 ---
 arch/arm64/lib/copy_to_user.S        |  3 ---
 arch/arm64/lib/uaccess_flushcache.c  |  6 +++++-
 7 files changed, 27 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
index 5bf963830b17..c764cc8fb3b6 100644
--- a/arch/arm64/include/asm/asm-uaccess.h
+++ b/arch/arm64/include/asm/asm-uaccess.h
@@ -58,23 +58,6 @@ alternative_else_nop_endif
 	.endm
 #endif
 
-/*
- * These macros are no-ops when UAO is present.
- */
-	.macro	uaccess_disable_not_uao, tmp1, tmp2
-	uaccess_ttbr0_disable \tmp1, \tmp2
-alternative_if ARM64_ALT_PAN_NOT_UAO
-	SET_PSTATE_PAN(1)
-alternative_else_nop_endif
-	.endm
-
-	.macro	uaccess_enable_not_uao, tmp1, tmp2, tmp3
-	uaccess_ttbr0_enable \tmp1, \tmp2, \tmp3
-alternative_if ARM64_ALT_PAN_NOT_UAO
-	SET_PSTATE_PAN(0)
-alternative_else_nop_endif
-	.endm
-
 /*
  * Remove the address tag from a virtual address, if present.
  */
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 097d6bfac0b7..f9c75d623d0f 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -378,20 +378,34 @@ do {									\
 extern unsigned long __must_check __arch_copy_from_user(void *to, const void __user *from, unsigned long n);
 #define raw_copy_from_user(to, from, n)					\
 ({									\
-	__arch_copy_from_user((to), __uaccess_mask_ptr(from), (n));	\
+	unsigned long __cpy;						\
+	uaccess_enable_not_uao();					\
+	__cpy = __arch_copy_from_user((to),				\
+				      __uaccess_mask_ptr(from), (n));	\
+	uaccess_disable_not_uao();					\
+	__cpy;								\
 })
 
 extern unsigned long __must_check __arch_copy_to_user(void __user *to, const void *from, unsigned long n);
 #define raw_copy_to_user(to, from, n)					\
 ({									\
-	__arch_copy_to_user(__uaccess_mask_ptr(to), (from), (n));	\
+	unsigned long __cpy;						\
+	uaccess_enable_not_uao();					\
+	__cpy = __arch_copy_to_user(__uaccess_mask_ptr(to),		\
+				    (from), (n));			\
+	uaccess_disable_not_uao();					\
+	__cpy;								\
 })
 
 extern unsigned long __must_check __arch_copy_in_user(void __user *to, const void __user *from, unsigned long n);
 #define raw_copy_in_user(to, from, n)					\
 ({									\
-	__arch_copy_in_user(__uaccess_mask_ptr(to),			\
-			    __uaccess_mask_ptr(from), (n));		\
+	unsigned long __cpy;						\
+	uaccess_enable_not_uao();					\
+	__cpy = __arch_copy_in_user(__uaccess_mask_ptr(to),		\
+				    __uaccess_mask_ptr(from), (n));	\
+	uaccess_disable_not_uao();					\
+	__cpy;								\
 })
 
 #define INLINE_COPY_TO_USER
@@ -400,8 +414,11 @@ extern unsigned long __must_check __arch_copy_in_user(void __user *to, const voi
 extern unsigned long __must_check __arch_clear_user(void __user *to, unsigned long n);
 static inline unsigned long __must_check __clear_user(void __user *to, unsigned long n)
 {
-	if (access_ok(to, n))
+	if (access_ok(to, n)) {
+		uaccess_enable_not_uao();
 		n = __arch_clear_user(__uaccess_mask_ptr(to), n);
+		uaccess_disable_not_uao();
+	}
 	return n;
 }
 #define clear_user	__clear_user
diff --git a/arch/arm64/lib/clear_user.S b/arch/arm64/lib/clear_user.S
index 322b55664cca..aeafc03e961a 100644
--- a/arch/arm64/lib/clear_user.S
+++ b/arch/arm64/lib/clear_user.S
@@ -20,7 +20,6 @@
  * Alignment fixed up by hardware.
  */
 ENTRY(__arch_clear_user)
-	uaccess_enable_not_uao x2, x3, x4
 	mov	x2, x1			// save the size for fixup return
 	subs	x1, x1, #8
 	b.mi	2f
@@ -40,7 +39,6 @@ uao_user_alternative 9f, strh, sttrh, wzr, x0, 2
 	b.mi	5f
 uao_user_alternative 9f, strb, sttrb, wzr, x0, 0
 5:	mov	x0, #0
-	uaccess_disable_not_uao x2, x3
 	ret
 ENDPROC(__arch_clear_user)
 EXPORT_SYMBOL(__arch_clear_user)
@@ -48,6 +46,5 @@ EXPORT_SYMBOL(__arch_clear_user)
 	.section .fixup,"ax"
 	.align	2
 9:	mov	x0, x2			// return the original size
-	uaccess_disable_not_uao x2, x3
 	ret
 	.previous
diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
index 8472dc7798b3..ebb3c06cbb5d 100644
--- a/arch/arm64/lib/copy_from_user.S
+++ b/arch/arm64/lib/copy_from_user.S
@@ -54,10 +54,8 @@
 
 end	.req	x5
 ENTRY(__arch_copy_from_user)
-	uaccess_enable_not_uao x3, x4, x5
 	add	end, x0, x2
 #include "copy_template.S"
-	uaccess_disable_not_uao x3, x4
 	mov	x0, #0				// Nothing to copy
 	ret
 ENDPROC(__arch_copy_from_user)
@@ -66,6 +64,5 @@ EXPORT_SYMBOL(__arch_copy_from_user)
 	.section .fixup,"ax"
 	.align	2
 9998:	sub	x0, end, dst			// bytes not copied
-	uaccess_disable_not_uao x3, x4
 	ret
 	.previous
diff --git a/arch/arm64/lib/copy_in_user.S b/arch/arm64/lib/copy_in_user.S
index 8e0355c1e318..3d8153a1ebce 100644
--- a/arch/arm64/lib/copy_in_user.S
+++ b/arch/arm64/lib/copy_in_user.S
@@ -56,10 +56,8 @@
 end	.req	x5
 
 ENTRY(__arch_copy_in_user)
-	uaccess_enable_not_uao x3, x4, x5
 	add	end, x0, x2
 #include "copy_template.S"
-	uaccess_disable_not_uao x3, x4
 	mov	x0, #0
 	ret
 ENDPROC(__arch_copy_in_user)
@@ -68,6 +66,5 @@ EXPORT_SYMBOL(__arch_copy_in_user)
 	.section .fixup,"ax"
 	.align	2
 9998:	sub	x0, end, dst			// bytes not copied
-	uaccess_disable_not_uao x3, x4
 	ret
 	.previous
diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
index 6085214654dc..357eae2c18eb 100644
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -53,10 +53,8 @@
 
 end	.req	x5
 ENTRY(__arch_copy_to_user)
-	uaccess_enable_not_uao x3, x4, x5
 	add	end, x0, x2
 #include "copy_template.S"
-	uaccess_disable_not_uao x3, x4
 	mov	x0, #0
 	ret
 ENDPROC(__arch_copy_to_user)
@@ -65,6 +63,5 @@ EXPORT_SYMBOL(__arch_copy_to_user)
 	.section .fixup,"ax"
 	.align	2
 9998:	sub	x0, end, dst			// bytes not copied
-	uaccess_disable_not_uao x3, x4
 	ret
 	.previous
diff --git a/arch/arm64/lib/uaccess_flushcache.c b/arch/arm64/lib/uaccess_flushcache.c
index cbfcbe6470a5..bfa30b75b2b8 100644
--- a/arch/arm64/lib/uaccess_flushcache.c
+++ b/arch/arm64/lib/uaccess_flushcache.c
@@ -28,7 +28,11 @@ void memcpy_page_flushcache(char *to, struct page *page, size_t offset,
 unsigned long __copy_user_flushcache(void *to, const void __user *from,
 				     unsigned long n)
 {
-	unsigned long rc = __arch_copy_from_user(to, from, n);
+	unsigned long rc;
+
+	uaccess_enable_not_uao();
+	rc = __arch_copy_from_user(to, from, n);
+	uaccess_disable_not_uao();
 
 	/* See above */
 	__clean_dcache_area_pop(to, n - rc);
-- 
2.24.0

