Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE927C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 00:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C566121823
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 00:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bEkm8Gxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfLEAK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 19:10:29 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43354 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbfLEAKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 19:10:23 -0500
Received: by mail-pf1-f194.google.com with SMTP id h14so655496pfe.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 16:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bvtp7PhLfJQZeHXECkSv3FhI1NErWyMTeUAZ1On118k=;
        b=bEkm8Gxis3TcLMrQK/O3kffjb1WvsBNakAbPX0QbwZ1pwClz/FKwdldVkZ8SoGnhuq
         Gu09c92s2HUmTipHCa6Qomcdu6FUNz+30JcUXlMMe8UgQDsNboOQc5uCn1QnbC/a9JwJ
         gkncFq9vbXJAS0ui3YNCs92RDjLvMC0X5jdpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bvtp7PhLfJQZeHXECkSv3FhI1NErWyMTeUAZ1On118k=;
        b=MEPR/a4w+TABhcj25t/3fcF+tWG9+uV24UMrJ+AD307Jy14mdytqMvJNKuIBfDlkFW
         rRoBB9JJn9Hro9SvkYhuFUu+Wu28d/94yvCh37JlSasLS5do0Z2PTDS08CAj+OK1Q4VO
         VbbBlcMyz39hI41yVsjjvan8gFT9MK3YxIZL76VGBZOIFQIsZ/IW2yILc4w7sB10W7d8
         mM8/tG09d8izaT1ZMfjJavyJYZDsyU5X6QuOCRbwOir73s+L5zTi3bxy9vRtLu+njDFm
         gEqNYYHT1Pnskq5Fqpg8hdNMmTXAOoNRjB2F+D98DwD87q9XjAcou7FW+6do73Vm23Dl
         a+WQ==
X-Gm-Message-State: APjAAAWaSNMT02jb+/XoMyfnacYAurwhigVnm0UHeFg/0FFaa6dqnfl0
        /KdmsErgvx+GKaqvls55B3feew==
X-Google-Smtp-Source: APXvYqxnbG88LdR3MCSnkD4TJXy10ExbjaE5WpyEp4RxlLVQEHycA/D0B77X7KbnCQ7VIqp8L5Jl6g==
X-Received: by 2002:aa7:8146:: with SMTP id d6mr5975089pfn.171.1575504622966;
        Wed, 04 Dec 2019 16:10:22 -0800 (PST)
Received: from thgarnie.kir.corp.google.com ([2620:0:1008:1100:d6ba:ac27:4f7b:28d7])
        by smtp.gmail.com with ESMTPSA id 73sm8422303pgc.13.2019.12.04.16.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 16:10:22 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 08/11] x86/boot/64: Adapt assembly for PIE support
Date:   Wed,  4 Dec 2019 16:09:45 -0800
Message-Id: <20191205000957.112719-9-thgarnie@chromium.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
In-Reply-To: <20191205000957.112719-1-thgarnie@chromium.org>
References: <20191205000957.112719-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the assembly code to use absolute reference for transition
between address spaces and relative references when referencing global
variables in the same address space. Ensure the kernel built with PIE
references the correct addresses based on context.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/head_64.S | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 4bbc770af632..40a467f8e116 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -87,7 +87,8 @@ SYM_CODE_START_NOALIGN(startup_64)
 	popq	%rsi
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
-	addq	$(early_top_pgt - __START_KERNEL_map), %rax
+	movabs  $(early_top_pgt - __START_KERNEL_map), %rcx
+	addq    %rcx, %rax
 	jmp 1f
 SYM_CODE_END(startup_64)
 
@@ -119,7 +120,8 @@ SYM_CODE_START(secondary_startup_64)
 	popq	%rsi
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
-	addq	$(init_top_pgt - __START_KERNEL_map), %rax
+	movabs	$(init_top_pgt - __START_KERNEL_map), %rcx
+	addq    %rcx, %rax
 1:
 
 	/* Enable PAE mode, PGE and LA57 */
@@ -137,7 +139,7 @@ SYM_CODE_START(secondary_startup_64)
 	movq	%rax, %cr3
 
 	/* Ensure I am executing from virtual addresses */
-	movq	$1f, %rax
+	movabs  $1f, %rax
 	ANNOTATE_RETPOLINE_SAFE
 	jmp	*%rax
 1:
@@ -234,11 +236,12 @@ SYM_CODE_START(secondary_startup_64)
 	 *	REX.W + FF /5 JMP m16:64 Jump far, absolute indirect,
 	 *		address given in m16:64.
 	 */
-	pushq	$.Lafter_lret	# put return address on stack for unwinder
+	movabs  $.Lafter_lret, %rax
+	pushq	%rax		# put return address on stack for unwinder
 	xorl	%ebp, %ebp	# clear frame pointer
-	movq	initial_code(%rip), %rax
+	leaq	initial_code(%rip), %rax
 	pushq	$__KERNEL_CS	# set correct cs
-	pushq	%rax		# target address in negative space
+	pushq	(%rax)		# target address in negative space
 	lretq
 .Lafter_lret:
 SYM_CODE_END(secondary_startup_64)
-- 
2.24.0.393.g34dc348eaf-goog

