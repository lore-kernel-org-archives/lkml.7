Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20E9C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 00:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84AE921823
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 00:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZJRP8vF3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfLEAKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 19:10:17 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:44401 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbfLEAKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 19:10:15 -0500
Received: by mail-pj1-f67.google.com with SMTP id w5so484167pjh.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 16:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sl9+RtgVbb7KwtMxDxQLj2F2VAZGCx1aAKzBbfOxt1g=;
        b=ZJRP8vF30U0k7vaqJoBuANMFiYYfPxKnryHE+msf40PIzZ2XSlMmsYPF0mGufSJdUR
         4H2AxF8qdpgOFyXbO2LGTs5xyhXmVdZWKtNq5VikWN//N+UtZBGPCJGRg0Anl75AVr85
         uHT83t8RIonezj2yYKWA+eGP1srhqMzW/Z7Ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sl9+RtgVbb7KwtMxDxQLj2F2VAZGCx1aAKzBbfOxt1g=;
        b=oXvlUMIXo2vmzKLMprLKuUzspTrYmNIUiqweULUG0N+wCokV+6+W3I4mFLjUPIqMp3
         UrOsGA6gfAPD1GibiJrw0BKkgdBpVH223NLc5HNR7Gr7LSTcW3Avuj1IThUi4IJL/6iO
         RO0SlBHBSJJ7J8tbK37BCud6U0mBTpyFWeTwrBabPf0lo/DfxWmSbqEJG5xXWPv738z/
         Gm2lE+LEUKRki29Btc1oqDuNejmmECTgKg2PGEiJ31ZmG1j2tdzn3P2vnlIYkEvaZK7+
         B8DlJgQqW2nLK7ARXSVOSm8PXj5jQEwpR7sq7YvgdBl0mIxHVLQE1qAXwe31Jl+K9OsB
         WlAA==
X-Gm-Message-State: APjAAAVfVssnP/5kNJtokNRADo4xV6LvMgtw1GQwq9PrF7bQqYGCz0Sx
        LHrw2+AG28GAK0lfffXueTQX7A==
X-Google-Smtp-Source: APXvYqyUZRhwcUxDg88BSvcVoZjK0y9Ie8prRgjXiPT5oLIYZyeO09SYIVpYFNvdP8jyPMYnr2JPiw==
X-Received: by 2002:a17:902:d881:: with SMTP id b1mr6107230plz.170.1575504615218;
        Wed, 04 Dec 2019 16:10:15 -0800 (PST)
Received: from thgarnie.kir.corp.google.com ([2620:0:1008:1100:d6ba:ac27:4f7b:28d7])
        by smtp.gmail.com with ESMTPSA id 73sm8422303pgc.13.2019.12.04.16.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 16:10:14 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 04/11] x86/entry/64: Adapt assembly for PIE support
Date:   Wed,  4 Dec 2019 16:09:41 -0800
Message-Id: <20191205000957.112719-5-thgarnie@chromium.org>
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
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/entry/entry_64.S | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 76942cbd95a1..f14363625f4b 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1329,7 +1329,8 @@ SYM_CODE_START_LOCAL(error_entry)
 	movl	%ecx, %eax			/* zero extend */
 	cmpq	%rax, RIP+8(%rsp)
 	je	.Lbstep_iret
-	cmpq	$.Lgs_change, RIP+8(%rsp)
+	leaq	.Lgs_change(%rip), %rcx
+	cmpq	%rcx, RIP+8(%rsp)
 	jne	.Lerror_entry_done_lfence
 
 	/*
@@ -1529,10 +1530,10 @@ SYM_CODE_START(nmi)
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
@@ -1586,7 +1587,8 @@ nested_nmi:
 	pushq	%rdx
 	pushfq
 	pushq	$__KERNEL_CS
-	pushq	$repeat_nmi
+	leaq	repeat_nmi(%rip), %rdx
+	pushq	%rdx
 
 	/* Put stack back */
 	addq	$(6*8), %rsp
@@ -1625,7 +1627,11 @@ first_nmi:
 	addq	$8, (%rsp)	/* Fix up RSP */
 	pushfq			/* RFLAGS */
 	pushq	$__KERNEL_CS	/* CS */
-	pushq	$1f		/* RIP */
+	pushq	$0		/* Future return address */
+	pushq	%rdx		/* Save RAX */
+	leaq	1f(%rip), %rdx	/* RIP */
+	movq    %rdx, 8(%rsp)   /* Put 1f on return address */
+	popq	%rdx		/* Restore RAX */
 	iretq			/* continues at repeat_nmi below */
 	UNWIND_HINT_IRET_REGS
 1:
-- 
2.24.0.393.g34dc348eaf-goog

