Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4438C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 00:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B913524653
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 00:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WEcqZpbc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbfLEAKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 19:10:32 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41184 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728646AbfLEAKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 19:10:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id s18so658662pfd.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 16:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h4Dt4B0xvb6l2StfkmNXj0JeSmBC5J6hiTtCjiH9uWc=;
        b=WEcqZpbc1pZeNKaytuCxvflJzb3CvyBUE0VhX1AoSwi10PnANDNHhZP08zA68JySCe
         +CW5pEEMug0LNYGtcKsPGjKTUZHY5772Xq4DmJsPO/iZwlo59MHJpSb91SZOLSspoVBN
         S5mWPnOhEPt8Ov9ALUBkzfoWaFPjEMRzvrvd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h4Dt4B0xvb6l2StfkmNXj0JeSmBC5J6hiTtCjiH9uWc=;
        b=YTHsl4XmIKvlPB8j7rKSgZDPVkNklWaaF5jARhIcnX8crTGNeTMlZ0CQmQQEZJ6K6d
         P0qxXymcJSNko4bM1O7lUdCyztFTLFrNWnHQIIxbHVf8e3NHJZT7dSHXeNa/f8ydCc3R
         fj8rgDAaf8TqXM4SUPfobNwJZ8CUrDo8P9r71tcIpa6VD2B+jyBsiPBd7LWBj32sKjrC
         LJz7C3+LQVwhk2H/Ox+tJagNzzZIPIEfVyfrbk43r8d4FpQP4KQXp4n53O2cm6Nf867B
         2umfJmnGUD64s4TUzSuecL2H317ljyNiI1g0I6jycG+ajVVC5W6h19aKSx7ITwWVSz9K
         Bmew==
X-Gm-Message-State: APjAAAVowmOeWNKN8DpI0E45M066M7TT5pf3Cdn3Dbie58ezutp7V08j
        iqohXOAZ/SD3MhVihZxAUq8y0Q==
X-Google-Smtp-Source: APXvYqzs7mYKYZ8RNkTKFC9raPmoZRYlLWxa85CESf7aVhfXMIKbbBi+m+lve2GIK5jr+LhkUWziBQ==
X-Received: by 2002:a63:3484:: with SMTP id b126mr6187685pga.17.1575504620811;
        Wed, 04 Dec 2019 16:10:20 -0800 (PST)
Received: from thgarnie.kir.corp.google.com ([2620:0:1008:1100:d6ba:ac27:4f7b:28d7])
        by smtp.gmail.com with ESMTPSA id 73sm8422303pgc.13.2019.12.04.16.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 16:10:20 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 07/11] x86/acpi: Adapt assembly for PIE support
Date:   Wed,  4 Dec 2019 16:09:44 -0800
Message-Id: <20191205000957.112719-8-thgarnie@chromium.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
In-Reply-To: <20191205000957.112719-1-thgarnie@chromium.org>
References: <20191205000957.112719-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the assembly code to use only relative references of symbols for the
kernel to be PIE compatible.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/acpi/wakeup_64.S | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index c8daa92f38dc..8e221285d9f1 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -15,7 +15,7 @@
 	 * Hooray, we are in Long 64-bit mode (but still running in low memory)
 	 */
 SYM_FUNC_START(wakeup_long64)
-	movq	saved_magic, %rax
+	movq	saved_magic(%rip), %rax
 	movq	$0x123456789abcdef0, %rdx
 	cmpq	%rdx, %rax
 	je	2f
@@ -31,14 +31,14 @@ SYM_FUNC_START(wakeup_long64)
 	movw	%ax, %es
 	movw	%ax, %fs
 	movw	%ax, %gs
-	movq	saved_rsp, %rsp
+	movq	saved_rsp(%rip), %rsp
 
-	movq	saved_rbx, %rbx
-	movq	saved_rdi, %rdi
-	movq	saved_rsi, %rsi
-	movq	saved_rbp, %rbp
+	movq	saved_rbx(%rip), %rbx
+	movq	saved_rdi(%rip), %rdi
+	movq	saved_rsi(%rip), %rsi
+	movq	saved_rbp(%rip), %rbp
 
-	movq	saved_rip, %rax
+	movq	saved_rip(%rip), %rax
 	jmp	*%rax
 SYM_FUNC_END(wakeup_long64)
 
@@ -48,7 +48,7 @@ SYM_FUNC_START(do_suspend_lowlevel)
 	xorl	%eax, %eax
 	call	save_processor_state
 
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	%rsp, pt_regs_sp(%rax)
 	movq	%rbp, pt_regs_bp(%rax)
 	movq	%rsi, pt_regs_si(%rax)
@@ -67,13 +67,14 @@ SYM_FUNC_START(do_suspend_lowlevel)
 	pushfq
 	popq	pt_regs_flags(%rax)
 
-	movq	$.Lresume_point, saved_rip(%rip)
+	leaq	.Lresume_point(%rip), %rax
+	movq	%rax, saved_rip(%rip)
 
-	movq	%rsp, saved_rsp
-	movq	%rbp, saved_rbp
-	movq	%rbx, saved_rbx
-	movq	%rdi, saved_rdi
-	movq	%rsi, saved_rsi
+	movq	%rsp, saved_rsp(%rip)
+	movq	%rbp, saved_rbp(%rip)
+	movq	%rbx, saved_rbx(%rip)
+	movq	%rdi, saved_rdi(%rip)
+	movq	%rsi, saved_rsi(%rip)
 
 	addq	$8, %rsp
 	movl	$3, %edi
@@ -85,7 +86,7 @@ SYM_FUNC_START(do_suspend_lowlevel)
 	.align 4
 .Lresume_point:
 	/* We don't restore %rax, it must be 0 anyway */
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	saved_context_cr4(%rax), %rbx
 	movq	%rbx, %cr4
 	movq	saved_context_cr3(%rax), %rbx
-- 
2.24.0.393.g34dc348eaf-goog

