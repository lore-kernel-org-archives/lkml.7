Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD195C606C6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFB92189F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aETGtYD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404042AbfGHRuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:50:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42296 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390390AbfGHRth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:49:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so7947805pff.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 10:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ALQ7xiIfUEWAkaO0QCgTelMKlNIBn53AhhYdy27sZMs=;
        b=aETGtYD3Xt88gXrWEnP+2irAuq2y1fIEjPVspj518Mj7Dcsy9uhdfK4ymYEMlSrYGL
         bCAj5UmBvU++WCaprKwHz5M6OLj9hSv0Ulm4Xpn8obeHD09OKcz7Vuwn62PQxDxvIc0M
         jtR6Z5PocfF+7vkm0UBjtt1TqCI77oqrBgKvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ALQ7xiIfUEWAkaO0QCgTelMKlNIBn53AhhYdy27sZMs=;
        b=eHlyOMx0nknB7Ulk8BAGMG+ecIDZ0rOaIsNsg7HHMtsdBkgdF3lx7VX4Evk8a36AOI
         3mvkhPwe4j+AlnGxNr/NV1Ha8mYQPnSsnAumY9X+/nSctnWQVqAC85PEUWXCwQ1OIrYJ
         6/3MWDED6V1cHZjeu6KEbaQi5zGlMTMqM65TYnIr+E9IgwxOx51/rzjLuNOokWvWFa9u
         xrBxurwwR7dLqrg4EFVz42pWhf+eidHeH45kUsgkg/6StXy1rvO67bezS2MmtgBFTJq/
         02b4iliaZbf7klt0QqbQ9SzeYxR2PgaKHIwxBTiZNA5mwJsg6perDJcMyOQEz/PmkBZo
         d2mg==
X-Gm-Message-State: APjAAAVWqPAIDbMhJHHD6lRLbQWJ2Sez6fwZb0yZ2HhFAZGNmhpsA/lc
        cmzmma8e9SqhNRju1anL0YM6VQ==
X-Google-Smtp-Source: APXvYqx3dVXfvHBooaxAprdB1WDpLargxi1K8L90RVkcv8mbIWfrC+4ozdkMLguK62YY52k7nFnbwQ==
X-Received: by 2002:a17:90a:7787:: with SMTP id v7mr27317571pjk.143.1562608176510;
        Mon, 08 Jul 2019 10:49:36 -0700 (PDT)
Received: from skynet.sea.corp.google.com ([2620:0:1008:1100:c4b5:ec23:d87b:d6d3])
        by smtp.gmail.com with ESMTPSA id j1sm20151686pfe.101.2019.07.08.10.49.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 10:49:36 -0700 (PDT)
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
Subject: [PATCH v8 07/11] x86/acpi: Adapt assembly for PIE support
Date:   Mon,  8 Jul 2019 10:49:00 -0700
Message-Id: <20190708174913.123308-8-thgarnie@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190708174913.123308-1-thgarnie@chromium.org>
References: <20190708174913.123308-1-thgarnie@chromium.org>
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
index b0715c3ac18d..3ec6c1b74ad4 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -15,7 +15,7 @@
 	 * Hooray, we are in Long 64-bit mode (but still running in low memory)
 	 */
 ENTRY(wakeup_long64)
-	movq	saved_magic, %rax
+	movq	saved_magic(%rip), %rax
 	movq	$0x123456789abcdef0, %rdx
 	cmpq	%rdx, %rax
 	jne	bogus_64_magic
@@ -26,14 +26,14 @@ ENTRY(wakeup_long64)
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
 ENDPROC(wakeup_long64)
 
@@ -46,7 +46,7 @@ ENTRY(do_suspend_lowlevel)
 	xorl	%eax, %eax
 	call	save_processor_state
 
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	%rsp, pt_regs_sp(%rax)
 	movq	%rbp, pt_regs_bp(%rax)
 	movq	%rsi, pt_regs_si(%rax)
@@ -65,13 +65,14 @@ ENTRY(do_suspend_lowlevel)
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
@@ -83,7 +84,7 @@ ENTRY(do_suspend_lowlevel)
 	.align 4
 .Lresume_point:
 	/* We don't restore %rax, it must be 0 anyway */
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	saved_context_cr4(%rax), %rbx
 	movq	%rbx, %cr4
 	movq	saved_context_cr3(%rax), %rbx
-- 
2.22.0.410.gd8fdbe21b5-goog

