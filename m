Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E0BC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBEB820C01
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UzfwNipG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbfG3TNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 15:13:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39717 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388250AbfG3TNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:13:24 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so30551229pgi.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 12:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w9qKOvSY58oXoZzqByoYWX1yQMI9BNWXHffy8/37d08=;
        b=UzfwNipG4HY3slWhmBB4ukvohWeOPP67m+ETT6UkK8qvjgImw05klp/yhBxcCntWO2
         Ue5RqYysOk+r2ZuO2MoS6akd/tkiuhAyhsDIFONkGYFFIBErMVturE3dLLSfMd4vh1Fz
         g/7+6diM+H6Lch0wDYcCiTIoZJUM/Ru/YUYHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w9qKOvSY58oXoZzqByoYWX1yQMI9BNWXHffy8/37d08=;
        b=a3uwxpb828yTtroiCXC2xKEfCQB140la+/GV7CgL0sDk5Ry4u3UuvX+DzgMUWWD5IN
         A4Cd7SpYezAWt2G4a6PCCMWeeTQ1D2aIdiXyiKu3UMooYTzJa76a0Okr3JNfI5fjQ2Lu
         5fdHTywLBIe9EKLC2g0ETRB8A6nbtZf5OZ+aEYrvIV55PbCPna8C4NnzPbxfp+sl0zws
         p+OtiXcbEsjQrKdgZdr/pZXqciyoQA8moPeFCMVXSrbqkTbHXVm+hQ51Q9qFVafJ4xNV
         NtPUGO2Pm0+GiHlP9hXnia64sR70beYxgX9/6FcaZVg57jCeijcywXuk7+1TVSk/fWbE
         8zJQ==
X-Gm-Message-State: APjAAAX+xiNP5E4iMB1tlJKsvgiL2o6CiDRFs1R6K2KRv8pDCJk7cy8V
        evBzgU/WC1FsL0I1F5euyREpRw==
X-Google-Smtp-Source: APXvYqy6D4jSuBlQiYSSxJuvYeBUKPk9VGJxOmy0ZoMGLMmWHX1N9VP8jp1Vbly1uFyIRpTQEY74pQ==
X-Received: by 2002:aa7:8102:: with SMTP id b2mr2027397pfi.105.1564514002619;
        Tue, 30 Jul 2019 12:13:22 -0700 (PDT)
Received: from skynet.sea.corp.google.com ([2620:0:1008:1100:c4b5:ec23:d87b:d6d3])
        by smtp.gmail.com with ESMTPSA id n89sm84649540pjc.0.2019.07.30.12.13.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 12:13:22 -0700 (PDT)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Maran Wilson <maran.wilson@oracle.com>,
        Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v9 08/11] x86/boot/64: Adapt assembly for PIE support
Date:   Tue, 30 Jul 2019 12:12:52 -0700
Message-Id: <20190730191303.206365-9-thgarnie@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190730191303.206365-1-thgarnie@chromium.org>
References: <20190730191303.206365-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the assembly code to use only relative references of symbols for the
kernel to be PIE compatible.

Early at boot, the kernel is mapped at a temporary address while preparing
the page table. To know the changes needed for the page table with KASLR,
the boot code calculate the difference between the expected address of the
kernel and the one chosen by KASLR. It does not work with PIE because all
symbols in code are relatives. Instead of getting the future relocated
virtual address, you will get the current temporary mapping.
Instructions were changed to have absolute 64-bit references.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/head_64.S | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index f3d3e9646a99..9a3f96566eb2 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -88,8 +88,10 @@ startup_64:
 	popq	%rsi
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
-	addq	$(early_top_pgt - __START_KERNEL_map), %rax
+	movabs  $(early_top_pgt - __START_KERNEL_map), %rcx
+	addq    %rcx, %rax
 	jmp 1f
+
 ENTRY(secondary_startup_64)
 	UNWIND_HINT_EMPTY
 	/*
@@ -118,7 +120,8 @@ ENTRY(secondary_startup_64)
 	popq	%rsi
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
-	addq	$(init_top_pgt - __START_KERNEL_map), %rax
+	movabs	$(init_top_pgt - __START_KERNEL_map), %rcx
+	addq    %rcx, %rax
 1:
 
 	/* Enable PAE mode, PGE and LA57 */
@@ -136,7 +139,7 @@ ENTRY(secondary_startup_64)
 	movq	%rax, %cr3
 
 	/* Ensure I am executing from virtual addresses */
-	movq	$1f, %rax
+	movabs  $1f, %rax
 	ANNOTATE_RETPOLINE_SAFE
 	jmp	*%rax
 1:
@@ -233,11 +236,12 @@ ENTRY(secondary_startup_64)
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
 END(secondary_startup_64)
-- 
2.22.0.770.g0f2c4a37fd-goog

