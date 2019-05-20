Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1811EC46470
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D833D217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DZY3byJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfETXUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 19:20:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34166 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfETXUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 19:20:10 -0400
Received: by mail-pf1-f195.google.com with SMTP id n19so7994838pfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 16:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k9WR796a769X9J4h5bze31x1W8OGsoWfxSCDq+b4bjQ=;
        b=DZY3byJTKsHTOJbQbyjbYDYJC7o1tExaJVvL5UoXYwmejQldkGgfn8J2FCkvJpGphE
         CeouX7pzk5IbV3210hHH2vAPmXKE35GpfFRaHq1ZV/gIzEMjZN2LGTQ0dTpoGxkYs3Xi
         z7ErB7H/BQN5PZy/d2YvNqRgQj2ApPshSaVls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k9WR796a769X9J4h5bze31x1W8OGsoWfxSCDq+b4bjQ=;
        b=fRlFYiUwMQ8ctQPrBvrjT8yKDdSM5ZIFqGnu0YMfpgVYDrBLAdeARyiVVdorq3gAjZ
         tCCiEKRScFRyi0ShozeJMEw7UfLY1b/eS+qIARoil8d0g7zetOx5M4zPffRRgyNwy3SC
         A+cICBLOmAyNk8ckyKl9jed1Hi3TaISSqoLHadD2MWdqGZd84CJt66uhNaDM51s+EuPr
         SC+bOPljz8IIT8a1IO4R9Ekfc39nxpzwI2hf8XnZiReF9Duj6Y9d3xy1LG1IEsDmppCl
         ULvmyz85G4vIf8H8QM4zHTLSAHvpa8+qJNtMyHqDlhbw4cQGQmSZ41+NqNHg4QWiRP2d
         3Ydw==
X-Gm-Message-State: APjAAAUsXzou1Sws0voy29o6esR6Orceilsx54e3lHnsteuwtBJAiPK2
        9aZH9mxOL0b8zT1+JBnwOnlHjg==
X-Google-Smtp-Source: APXvYqxGuZNjeh1amat9jqj306pSHnIg2I7yAJfVSCaE5txAVQxasyESMs/o/eB1nTUWBJ2/UWizAA==
X-Received: by 2002:a63:d04b:: with SMTP id s11mr78740681pgi.187.1558394410230;
        Mon, 20 May 2019 16:20:10 -0700 (PDT)
Received: from skynet.sea.corp.google.com ([2620:0:1008:1100:c4b5:ec23:d87b:d6d3])
        by smtp.gmail.com with ESMTPSA id h13sm19350861pgk.55.2019.05.20.16.20.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 16:20:09 -0700 (PDT)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, Thomas Garnier <thgarnie@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 05/12] x86/entry/64: Adapt assembly for PIE support
Date:   Mon, 20 May 2019 16:19:30 -0700
Message-Id: <20190520231948.49693-6-thgarnie@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190520231948.49693-1-thgarnie@chromium.org>
References: <20190520231948.49693-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Garnier <thgarnie@google.com>

Change the assembly code to use only relative references of symbols for the
kernel to be PIE compatible.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/entry/entry_64.S | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 20e45d9b4e15..e99b3438aa9b 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1268,7 +1268,8 @@ ENTRY(error_entry)
 	movl	%ecx, %eax			/* zero extend */
 	cmpq	%rax, RIP+8(%rsp)
 	je	.Lbstep_iret
-	cmpq	$.Lgs_change, RIP+8(%rsp)
+	leaq	.Lgs_change(%rip), %rcx
+	cmpq	%rcx, RIP+8(%rsp)
 	jne	.Lerror_entry_done
 
 	/*
@@ -1465,10 +1466,10 @@ ENTRY(nmi)
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
@@ -1522,7 +1523,8 @@ nested_nmi:
 	pushq	%rdx
 	pushfq
 	pushq	$__KERNEL_CS
-	pushq	$repeat_nmi
+	leaq	repeat_nmi(%rip), %rdx
+	pushq	%rdx
 
 	/* Put stack back */
 	addq	$(6*8), %rsp
@@ -1561,7 +1563,11 @@ first_nmi:
 	addq	$8, (%rsp)	/* Fix up RSP */
 	pushfq			/* RFLAGS */
 	pushq	$__KERNEL_CS	/* CS */
-	pushq	$1f		/* RIP */
+	pushq	$0		/* Futur return address */
+	pushq	%rax		/* Save RAX */
+	leaq	1f(%rip), %rax	/* RIP */
+	movq    %rax, 8(%rsp)   /* Put 1f on return address */
+	popq	%rax		/* Restore RAX */
 	iretq			/* continues at repeat_nmi below */
 	UNWIND_HINT_IRET_REGS
 1:
-- 
2.21.0.1020.gf2820cf01a-goog

