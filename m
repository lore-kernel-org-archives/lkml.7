Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF208C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918C620693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dUh629Cx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388108AbfG3TNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 15:13:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42202 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbfG3TNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:13:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so30321356pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 12:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g8F81aPRcXP2Hl/h5880SBWLCYrdCb9mGhwAq1nau08=;
        b=dUh629CxLDWe2ICkvFeC4qXjIQGvvsjijYV4+IzjvPROpIi+iYdIzNRfF6AXW9yD7j
         6av49IFog/hErgPxDo8LO6KszfGUsQuRVtAukrJN89JRjJOTeTiYRi4ZcCu0cfmC3eUo
         7R5M5POv61QFetY8gle4w1aDZ1RV9FSIBJtlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g8F81aPRcXP2Hl/h5880SBWLCYrdCb9mGhwAq1nau08=;
        b=sIJuqaBNthkfHIFzFqjkfUa15s4ip/Pc1chUCV/CnzXGmeYCZ24BswyoMXjU3lXu5J
         JIz9FhpWY0wCKMolhV+9C40NEnjG9LrVjjp0vF9dGWvecEAMbq0nzm0pFBCBD3xVmgwV
         HGlDbc3+Y32/zUPACfidyZTr6cI+oLfddj8VaENxx3kYZCvOBtQjmT00huB9qOw4RjPO
         BrcZTVxSkgJ+KBacqkkuR8I/6kPLShEFMZuOJO350k6rFduceogjba3JGLl32nbZSghY
         XFScVthx/Ry6Dvxq4LU5N2WFDm+28GmMrOLTo3pJY+y3iynwll17YISMPasO7Gjrdg1H
         qZ1g==
X-Gm-Message-State: APjAAAUODclboLXIyEIbxHKPdQyycEs7+rsSeD16eyFCsy3XO8lx1HFT
        2cTzzxWY086y1VGJL3Lg1CKpwA==
X-Google-Smtp-Source: APXvYqwGmbprmSHopN+BDz1XZeLfq9alpJ09UTr1PphowM1pkkwfMHHOEjFK6E/ulqm8Y3g/IHWAbQ==
X-Received: by 2002:a65:6108:: with SMTP id z8mr78911177pgu.289.1564513995418;
        Tue, 30 Jul 2019 12:13:15 -0700 (PDT)
Received: from skynet.sea.corp.google.com ([2620:0:1008:1100:c4b5:ec23:d87b:d6d3])
        by smtp.gmail.com with ESMTPSA id n89sm84649540pjc.0.2019.07.30.12.13.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 12:13:15 -0700 (PDT)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 04/11] x86/entry/64: Adapt assembly for PIE support
Date:   Tue, 30 Jul 2019 12:12:48 -0700
Message-Id: <20190730191303.206365-5-thgarnie@chromium.org>
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

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/entry/entry_64.S | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 3f5a978a02a7..4b588a902009 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1317,7 +1317,8 @@ ENTRY(error_entry)
 	movl	%ecx, %eax			/* zero extend */
 	cmpq	%rax, RIP+8(%rsp)
 	je	.Lbstep_iret
-	cmpq	$.Lgs_change, RIP+8(%rsp)
+	leaq	.Lgs_change(%rip), %rcx
+	cmpq	%rcx, RIP+8(%rsp)
 	jne	.Lerror_entry_done
 
 	/*
@@ -1514,10 +1515,10 @@ ENTRY(nmi)
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
@@ -1571,7 +1572,8 @@ nested_nmi:
 	pushq	%rdx
 	pushfq
 	pushq	$__KERNEL_CS
-	pushq	$repeat_nmi
+	leaq	repeat_nmi(%rip), %rdx
+	pushq	%rdx
 
 	/* Put stack back */
 	addq	$(6*8), %rsp
@@ -1610,7 +1612,11 @@ first_nmi:
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
2.22.0.770.g0f2c4a37fd-goog

