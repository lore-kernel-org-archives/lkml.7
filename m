Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BEECA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 22:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D20021906
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 22:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bzUzyeY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfKAWMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 18:12:06 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:47679 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfKAWMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 18:12:03 -0400
Received: by mail-pf1-f202.google.com with SMTP id i6so8428579pfd.14
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 15:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LP5ER91yDYZoiG1DiO5iJutGGta/8W2YsIEILYrERFw=;
        b=bzUzyeY2Pb66Afq/YuWOrvYc+P88+Nov5leW00IV55yTXjsAAsOwV4Veo8X/xOJcJ4
         ondoceMK37epaHyC4iXnp3iV0xW9o37xNMNCS5+YnzUPDYInCBHdGEQVAgM4EFYIvsze
         U0KH0R+6LV4HKtRGQKKP/z9BhLOXnUh8+dXJh8b3NCoa0aWnVe395JzHp4ESMni67Vsa
         qx0mjSBtsBjrh+oThuzhLBL/bX8C2DLD9Oj+4ukb7J9N50N4TT7aG68H5rehFDpazui3
         jPyL0/ZCDdN1GkSNCkwcVAq/qh9aaSMW7e8c/YGajhmaqVmrnJc5oqhERJW4y1q7jziQ
         Z3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LP5ER91yDYZoiG1DiO5iJutGGta/8W2YsIEILYrERFw=;
        b=g5VLJx4642/yDt7RWVMWAlh7D/VEqVHOHfwv901ppyrtUj7wOuDk5z3fDdh7E1Tzm6
         mCExxh0CGWCrkwuAw1KvUQPJH9W5A1CKIlBBiEAbQkej3fPKQjYXYiFqJ93t1HXOasOs
         mugGw6nhDe6z1KLOW+VJdh00s5u20eOT6QnqtFtsUffACKCAlFSaTwWgN4I0eEAK2Rpj
         R677wB2H9sv2Oe0WsYI57/VWWlbfK4YoMots/x1hqRpk3KufGyzBZ+rVVJYYd8kJUaBg
         X+OTK5r3MRkJAwzFukJ0DRq1ysLZTCO5Qn9PheKhTfJBiWTPL/j+hPQYtPZH6kpob3dL
         Mjow==
X-Gm-Message-State: APjAAAX27Ds8UNwnJ1gVbj93Jj0TEwZZH8GT6ujkHOnijm3fvULdSfmh
        s87Up8ED+nj626UgKKAC4JzevwxeJvhnVAfeTdE=
X-Google-Smtp-Source: APXvYqz206FfV2E+48L9X7nVID4/AGCaj0CfUa7XJhd+U2VCpij5TxmcTYypesImIHmvjNsozEEINFqmvJRBmlZOaoA=
X-Received: by 2002:a63:535c:: with SMTP id t28mr6291818pgl.173.1572646322264;
 Fri, 01 Nov 2019 15:12:02 -0700 (PDT)
Date:   Fri,  1 Nov 2019 15:11:36 -0700
In-Reply-To: <20191101221150.116536-1-samitolvanen@google.com>
Message-Id: <20191101221150.116536-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191101221150.116536-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v4 03/17] arm64: kvm: stop treating register x18 as caller save
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
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

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

In preparation of reserving x18, stop treating it as caller save in
the KVM guest entry/exit code. Currently, the code assumes there is
no need to preserve it for the host, given that it would have been
assumed clobbered anyway by the function call to __guest_enter().
Instead, preserve its value and restore it upon return.

Link: https://patchwork.kernel.org/patch/9836891/
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
[Sami: updated commit message, switched from x18 to x29 for the guest context]
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
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
2.24.0.rc1.363.gb1bccd3e3d-goog

