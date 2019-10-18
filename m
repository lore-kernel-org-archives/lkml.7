Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFD3CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD9E222C6
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZvzQdFSz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442935AbfJRQK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:10:58 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:42610 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442650AbfJRQK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:10:56 -0400
Received: by mail-yw1-f73.google.com with SMTP id o14so4756872ywa.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=72rGRuWFiviz942NA6zVkn9gcWlAdBMK2y71uV80e5M=;
        b=ZvzQdFSzTLbEjP4zxdusVf3ReL3ljnpZzJfPdrbpnE9rMeefuhQHID/ee1FAoqvYLH
         O+/PdDLy+eoWqhA9UIEIUFRCMC5xqhNowPZWx2ww/HoS+63BhQ5I1HOf+y5t9GV4AlzB
         4wvvMPqaOkuUSsDFHTVS6xJHhNUp3s1c9Y1ghonvzQD2ZPiXv5LmNp53Biqgoh9GKiCJ
         afEukw6/WMLv2boh6kNWUds4TgOnVVcCplvVwI02NOYpPnoOVZxpUv2JWmCC5FcJjdP9
         qyuCgJgGG2jATFBKXIAZK/fXaf2KYXXK+X2rgvP6lspQZZSv0gH/6LOEhAEKe42LtQC+
         cKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=72rGRuWFiviz942NA6zVkn9gcWlAdBMK2y71uV80e5M=;
        b=KM9cLDQVbkXw8R8pQK3de3EhZz+xtiCoX4JVxt8+DtmDiPqQqYjHn+dCOgOEV90ld4
         +3q34txxsMtLjaweWEF4UkcmsRWxBpjGh5C1YFBt3qXyQRJd4As70+Ltbv3GQeMm1hAY
         d5BIZd/6YVCoKg0tLiQSvKoCKWyadw9fpjjVbRNvKWiG30AlNaZYHSz2tscqWviyxZCE
         VXInN0C1viGICmXxbj0xzrvIae7CsofC4AVJcX6QhqCpPuhDrPLV4j9FKWSvRMUIpKSZ
         B54KBby6v3SMApRmZVf8njFRSkfblBXIme0Wtx5xEjlc2hUYvcUwdGT5xIJu1XzB9j0I
         SS9A==
X-Gm-Message-State: APjAAAXQQh1diR16xUFviAghnSLROnVPL5CCiyeCXdAM3tllnSP2ZFBx
        fxsCLfjf/MOfxRp56aMmwOdCE4GAgXEt1RED3d8=
X-Google-Smtp-Source: APXvYqxINkQeafZ9JYtVaWg+qUXlNkxSB5ctm2wREg/j/aMT/J4ez6ebkhDJlYmKEc3YyNUDF8Zxh7j2jKVxFaFkVRU=
X-Received: by 2002:a0d:d804:: with SMTP id a4mr7899178ywe.454.1571415054615;
 Fri, 18 Oct 2019 09:10:54 -0700 (PDT)
Date:   Fri, 18 Oct 2019 09:10:18 -0700
In-Reply-To: <20191018161033.261971-1-samitolvanen@google.com>
Message-Id: <20191018161033.261971-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH 03/18] arm64: kvm: stop treating register x18 as caller save
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
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

In preparation of using x18 as a task struct pointer register when
running in the kernel, stop treating it as caller save in the KVM
guest entry/exit code. Currently, the code assumes there is no need
to preserve it for the host, given that it would have been assumed
clobbered anyway by the function call to __guest_enter(). Instead,
preserve its value and restore it upon return.

Link: https://patchwork.kernel.org/patch/9836891/
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/kvm/hyp/entry.S | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
index e5cc8d66bf53..20bd9a20ea27 100644
--- a/arch/arm64/kvm/hyp/entry.S
+++ b/arch/arm64/kvm/hyp/entry.S
@@ -23,6 +23,7 @@
 	.pushsection	.hyp.text, "ax"
 
 .macro save_callee_saved_regs ctxt
+	str	x18,      [\ctxt, #CPU_XREG_OFFSET(18)]
 	stp	x19, x20, [\ctxt, #CPU_XREG_OFFSET(19)]
 	stp	x21, x22, [\ctxt, #CPU_XREG_OFFSET(21)]
 	stp	x23, x24, [\ctxt, #CPU_XREG_OFFSET(23)]
@@ -38,6 +39,7 @@
 	ldp	x25, x26, [\ctxt, #CPU_XREG_OFFSET(25)]
 	ldp	x27, x28, [\ctxt, #CPU_XREG_OFFSET(27)]
 	ldp	x29, lr,  [\ctxt, #CPU_XREG_OFFSET(29)]
+	ldr	x18,      [\ctxt, #CPU_XREG_OFFSET(18)]
 .endm
 
 /*
@@ -87,12 +89,9 @@ alternative_else_nop_endif
 	ldp	x14, x15, [x18, #CPU_XREG_OFFSET(14)]
 	ldp	x16, x17, [x18, #CPU_XREG_OFFSET(16)]
 
-	// Restore guest regs x19-x29, lr
+	// Restore guest regs x18-x29, lr
 	restore_callee_saved_regs x18
 
-	// Restore guest reg x18
-	ldr	x18,      [x18, #CPU_XREG_OFFSET(18)]
-
 	// Do not touch any register after this!
 	eret
 	sb
@@ -114,7 +113,7 @@ ENTRY(__guest_exit)
 	// Retrieve the guest regs x0-x1 from the stack
 	ldp	x2, x3, [sp], #16	// x0, x1
 
-	// Store the guest regs x0-x1 and x4-x18
+	// Store the guest regs x0-x1 and x4-x17
 	stp	x2, x3,   [x1, #CPU_XREG_OFFSET(0)]
 	stp	x4, x5,   [x1, #CPU_XREG_OFFSET(4)]
 	stp	x6, x7,   [x1, #CPU_XREG_OFFSET(6)]
@@ -123,9 +122,8 @@ ENTRY(__guest_exit)
 	stp	x12, x13, [x1, #CPU_XREG_OFFSET(12)]
 	stp	x14, x15, [x1, #CPU_XREG_OFFSET(14)]
 	stp	x16, x17, [x1, #CPU_XREG_OFFSET(16)]
-	str	x18,      [x1, #CPU_XREG_OFFSET(18)]
 
-	// Store the guest regs x19-x29, lr
+	// Store the guest regs x18-x29, lr
 	save_callee_saved_regs x1
 
 	get_host_ctxt	x2, x3
-- 
2.23.0.866.gb869b98d4c-goog

