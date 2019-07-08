Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B14C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B492218A0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fa2IMYp5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404052AbfGHRuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:50:07 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46025 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389898AbfGHRtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:49:31 -0400
Received: by mail-pl1-f194.google.com with SMTP id y8so3933345plr.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 10:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KxfvBRXNL2lxAGR+5TYPhVFxu0m9HvU5t0GmP1NzevA=;
        b=fa2IMYp5yxmb0mlrjbAugQfJQs7wOZE68qWJlUaWJbES77G4ch8hkfqoU7d3UuMROT
         miKgo0y2jPB8lvjuBXfFCgUyDKKKj0ty13J70cwhBpbZ7rgFyu6qjJWJwYvFI5KKEjHo
         0NTiwMOBldPc7y1fEm3F73rASqMQHrgQtOHaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KxfvBRXNL2lxAGR+5TYPhVFxu0m9HvU5t0GmP1NzevA=;
        b=ilFbPnT8BW5AvNlrakN1UAz/cO7Hszjstdsdn20T5ic3tSN8mWIX2dKVfK9KcsAlRV
         oocFsryrDoJ1jF8AHWhHg31NbI0P7YTlc8klCPF+T8UN/rwhsjOb90jlbnP4bBp+LPhd
         KqxwGwFIHtTfFrOdGBhCD2fBkQbPIAYGrAkAlUajT7rwgtk3/vQfy+2PElasHMpivd/k
         Ian025WAcJKX0ZvwnidCLCkl/9/ITFJRSsYDsWTzeOe51sBbe9qdGibhlTMo0QUKPUMm
         uE08cA6XPwNjUDIDiGHZvQZioqVNMUVR6NxDsDA+IAR5oqNICBrBImN8o6PtXOOzUgft
         KSog==
X-Gm-Message-State: APjAAAWtki6G1IcCYNxhEQ90lxnQoLKTdENccBmSIsApairSDa1wZR4m
        Oc4SfUfnHF4uTBuPYR95lTl5ow==
X-Google-Smtp-Source: APXvYqwHxN5CAV58byDjy1sz6I4FOZx29YlNCGS4HMqwy+D7g8iqgYoEjOJKr1IsZSeU5GI09ezrQg==
X-Received: by 2002:a17:902:424:: with SMTP id 33mr26686735ple.151.1562608171183;
        Mon, 08 Jul 2019 10:49:31 -0700 (PDT)
Received: from skynet.sea.corp.google.com ([2620:0:1008:1100:c4b5:ec23:d87b:d6d3])
        by smtp.gmail.com with ESMTPSA id j1sm20151686pfe.101.2019.07.08.10.49.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 10:49:30 -0700 (PDT)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 04/11] x86/entry/64: Adapt assembly for PIE support
Date:   Mon,  8 Jul 2019 10:48:57 -0700
Message-Id: <20190708174913.123308-5-thgarnie@chromium.org>
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
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/entry/entry_64.S | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 0ea4831a72a4..9f55a359c896 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1309,7 +1309,8 @@ ENTRY(error_entry)
 	movl	%ecx, %eax			/* zero extend */
 	cmpq	%rax, RIP+8(%rsp)
 	je	.Lbstep_iret
-	cmpq	$.Lgs_change, RIP+8(%rsp)
+	leaq	.Lgs_change(%rip), %rcx
+	cmpq	%rcx, RIP+8(%rsp)
 	jne	.Lerror_entry_done
 
 	/*
@@ -1506,10 +1507,10 @@ ENTRY(nmi)
 	 * resume the outer NMI.
 	 */
 
-	movq	$repeat_nmi, %rdx
+	leaq	repeat_nmi(%rip), %rdx
 	cmpq	8(%rsp), %rdx
 	ja	1f
-	movq	$end_repeat_nmi, %rdx
+	leaq	end_repeat_nmi(%rip), %rdx
 	cmpq	8(%rsp), %rdx
 	ja	nested_nmi_out
 1:
@@ -1563,7 +1564,8 @@ nested_nmi:
 	pushq	%rdx
 	pushfq
 	pushq	$__KERNEL_CS
-	pushq	$repeat_nmi
+	leaq	repeat_nmi(%rip), %rdx
+	pushq	%rdx
 
 	/* Put stack back */
 	addq	$(6*8), %rsp
@@ -1602,7 +1604,11 @@ first_nmi:
 	addq	$8, (%rsp)	/* Fix up RSP */
 	pushfq			/* RFLAGS */
 	pushq	$__KERNEL_CS	/* CS */
-	pushq	$1f		/* RIP */
+	pushq	$0		/* Future return address */
+	pushq	%rax		/* Save RAX */
+	leaq	1f(%rip), %rax	/* RIP */
+	movq    %rax, 8(%rsp)   /* Put 1f on return address */
+	popq	%rax		/* Restore RAX */
 	iretq			/* continues at repeat_nmi below */
 	UNWIND_HINT_IRET_REGS
 1:
-- 
2.22.0.410.gd8fdbe21b5-goog

