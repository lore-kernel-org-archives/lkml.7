Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D76CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0CE221929
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sq2ixdxK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732179AbfJXWvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 18:51:49 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:56007 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731988AbfJXWvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 18:51:49 -0400
Received: by mail-qk1-f202.google.com with SMTP id h18so336191qkj.22
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 15:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YGQdPM+XBZNSA56L0QR+yPtW5HkUXZWfeQswOtioB60=;
        b=sq2ixdxKcWPgGaYvkHvurUobImgaQEbHj1LNO8mtUiqVZdVAGDIcPVi2+C8vv+9ngy
         +eU+eUFXQ8IhdDYedSvSX6wTGa2uag+3/eXK/MighUqkxL+EB+AY5cxRsZaNbXSpGj9d
         Fc/0ALF+/lL41aJvixVQtmsvEhOAQUmR/SOYVugNxAagb1FNUiE+n/jLrmDK2joueyZS
         4rsA1vxX0EiMtS9e4ucuUMWuu7i5A3/ZN03nN9sc3PviOzgg+k3CZaQCIdmE+MCvOuha
         tLtpAWcT9mazBmjvhKW2WllPlsDifeYk04cU9Rv/jnXlYWCC6AAYQMuWfhz1pBgo35Oz
         130g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YGQdPM+XBZNSA56L0QR+yPtW5HkUXZWfeQswOtioB60=;
        b=LYOSs6YKTjKTTv/c/mEapp44HGwWrxdiHR47R1ujWBr1/vYN7DDmXRpk96vtHAaGWK
         Q5mWC7NekaToN8NbjXNGcupJUWhPaisA4YkDyTHdoo1aaNMqOnP0Uaxhqa4stekDPOk+
         gBFBjfDYOFeZPn3MZ80+TBpR64OLTK2I15hVw+BIhRvqsKxrJh6wNL7mLOPD2UdFrwbh
         ZK98PV5pvO6U8K5/0l8o6KVHbQA3XZ0u58RSytWpDZOEQ4a5Aa4OQXETzd7w6FHS/Lt0
         z6AWkS51by9k85Gewd+2YW65WeJoG+2Qr4OjyHLKttAdKGlG1Wm80WuWqs0htA+PR3mI
         Ci8Q==
X-Gm-Message-State: APjAAAVEgOCvMJZeaYImR/s/FQ2hEfeHpD2Yd6Lt1ELE/bawgrOv09dL
        BeDt8ACCKQ66xS1doxhpKflK81a1+DUzPIP0Ie4=
X-Google-Smtp-Source: APXvYqxMC3wNELiwhFOrPUoaiAPaDs3EckmcMyW4Ouz7/WJye+4iX5nFS46L+/G7TeWF9o4wn94Fzm3AvZtbTUtWKJ0=
X-Received: by 2002:ac8:22b6:: with SMTP id f51mr142245qta.210.1571957505481;
 Thu, 24 Oct 2019 15:51:45 -0700 (PDT)
Date:   Thu, 24 Oct 2019 15:51:18 -0700
In-Reply-To: <20191024225132.13410-1-samitolvanen@google.com>
Message-Id: <20191024225132.13410-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191024225132.13410-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v2 03/17] arm64: kvm: stop treating register x18 as caller save
From:   samitolvanen@google.com
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of reserving x18, stop treating it as caller save in
the KVM guest entry/exit code. Currently, the code assumes there is
no need to preserve it for the host, given that it would have been
assumed clobbered anyway by the function call to __guest_enter().
Instead, preserve its value and restore it upon return.

Co-developed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Link: https://patchwork.kernel.org/patch/9836891/
[ updated commit message, switched from x18 to x29 for the guest context ]
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/kvm/hyp/entry.S | 41 +++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
index e5cc8d66bf53..c3c2d842c609 100644
--- a/arch/arm64/kvm/hyp/entry.S
+++ b/arch/arm64/kvm/hyp/entry.S
@@ -23,6 +23,7 @@
 	.pushsection	.hyp.text, "ax"
 
 .macro save_callee_saved_regs ctxt
+	str	x18,      [\ctxt, #CPU_XREG_OFFSET(18)]
 	stp	x19, x20, [\ctxt, #CPU_XREG_OFFSET(19)]
 	stp	x21, x22, [\ctxt, #CPU_XREG_OFFSET(21)]
 	stp	x23, x24, [\ctxt, #CPU_XREG_OFFSET(23)]
@@ -32,6 +33,8 @@
 .endm
 
 .macro restore_callee_saved_regs ctxt
+	// We assume \ctxt is not x18-x28
+	ldr	x18,      [\ctxt, #CPU_XREG_OFFSET(18)]
 	ldp	x19, x20, [\ctxt, #CPU_XREG_OFFSET(19)]
 	ldp	x21, x22, [\ctxt, #CPU_XREG_OFFSET(21)]
 	ldp	x23, x24, [\ctxt, #CPU_XREG_OFFSET(23)]
@@ -48,7 +51,7 @@ ENTRY(__guest_enter)
 	// x0: vcpu
 	// x1: host context
 	// x2-x17: clobbered by macros
-	// x18: guest context
+	// x29: guest context
 
 	// Store the host regs
 	save_callee_saved_regs x1
@@ -67,31 +70,28 @@ alternative_else_nop_endif
 	ret
 
 1:
-	add	x18, x0, #VCPU_CONTEXT
+	add	x29, x0, #VCPU_CONTEXT
 
 	// Macro ptrauth_switch_to_guest format:
 	// 	ptrauth_switch_to_guest(guest cxt, tmp1, tmp2, tmp3)
 	// The below macro to restore guest keys is not implemented in C code
 	// as it may cause Pointer Authentication key signing mismatch errors
 	// when this feature is enabled for kernel code.
-	ptrauth_switch_to_guest x18, x0, x1, x2
+	ptrauth_switch_to_guest x29, x0, x1, x2
 
 	// Restore guest regs x0-x17
-	ldp	x0, x1,   [x18, #CPU_XREG_OFFSET(0)]
-	ldp	x2, x3,   [x18, #CPU_XREG_OFFSET(2)]
-	ldp	x4, x5,   [x18, #CPU_XREG_OFFSET(4)]
-	ldp	x6, x7,   [x18, #CPU_XREG_OFFSET(6)]
-	ldp	x8, x9,   [x18, #CPU_XREG_OFFSET(8)]
-	ldp	x10, x11, [x18, #CPU_XREG_OFFSET(10)]
-	ldp	x12, x13, [x18, #CPU_XREG_OFFSET(12)]
-	ldp	x14, x15, [x18, #CPU_XREG_OFFSET(14)]
-	ldp	x16, x17, [x18, #CPU_XREG_OFFSET(16)]
-
-	// Restore guest regs x19-x29, lr
-	restore_callee_saved_regs x18
-
-	// Restore guest reg x18
-	ldr	x18,      [x18, #CPU_XREG_OFFSET(18)]
+	ldp	x0, x1,   [x29, #CPU_XREG_OFFSET(0)]
+	ldp	x2, x3,   [x29, #CPU_XREG_OFFSET(2)]
+	ldp	x4, x5,   [x29, #CPU_XREG_OFFSET(4)]
+	ldp	x6, x7,   [x29, #CPU_XREG_OFFSET(6)]
+	ldp	x8, x9,   [x29, #CPU_XREG_OFFSET(8)]
+	ldp	x10, x11, [x29, #CPU_XREG_OFFSET(10)]
+	ldp	x12, x13, [x29, #CPU_XREG_OFFSET(12)]
+	ldp	x14, x15, [x29, #CPU_XREG_OFFSET(14)]
+	ldp	x16, x17, [x29, #CPU_XREG_OFFSET(16)]
+
+	// Restore guest regs x18-x29, lr
+	restore_callee_saved_regs x29
 
 	// Do not touch any register after this!
 	eret
@@ -114,7 +114,7 @@ ENTRY(__guest_exit)
 	// Retrieve the guest regs x0-x1 from the stack
 	ldp	x2, x3, [sp], #16	// x0, x1
 
-	// Store the guest regs x0-x1 and x4-x18
+	// Store the guest regs x0-x1 and x4-x17
 	stp	x2, x3,   [x1, #CPU_XREG_OFFSET(0)]
 	stp	x4, x5,   [x1, #CPU_XREG_OFFSET(4)]
 	stp	x6, x7,   [x1, #CPU_XREG_OFFSET(6)]
@@ -123,9 +123,8 @@ ENTRY(__guest_exit)
 	stp	x12, x13, [x1, #CPU_XREG_OFFSET(12)]
 	stp	x14, x15, [x1, #CPU_XREG_OFFSET(14)]
 	stp	x16, x17, [x1, #CPU_XREG_OFFSET(16)]
-	str	x18,      [x1, #CPU_XREG_OFFSET(18)]
 
-	// Store the guest regs x19-x29, lr
+	// Store the guest regs x18-x29, lr
 	save_callee_saved_regs x1
 
 	get_host_ctxt	x2, x3
-- 
2.24.0.rc0.303.g954a862665-goog

