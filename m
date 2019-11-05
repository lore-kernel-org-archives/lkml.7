Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A75C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 23:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572CC21A49
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 23:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jWGQrW7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387599AbfKEX4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 18:56:48 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:34558 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387560AbfKEX4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 18:56:44 -0500
Received: by mail-pg1-f202.google.com with SMTP id w9so16295906pgl.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 15:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uzQ8cGBP/iiy1dmy29qxsrkA2y8A3VyyoGWk/X1qxUc=;
        b=jWGQrW7gYc6D9nJteHiWYUXaoKd47FGvgCnUcq1RN0FNUvS12DXoQv/Qs2ZSsEmdsr
         KIrZA7BzUYt42AyztGMVcz/QumFEYK2cJY5/FcPWOE01nPlBEr1XYQMmzvlCuOtePFHy
         BrO2pUitDMPbbMwQ+djW4zvLYrFatsGxSZFpwthI0l0tEUjCd15qBB7CofGFXzjONnIJ
         qdmdd/w16M48KK0143WbpUnJCYAPG0RUwEwhRL4ts3yhMXpE4SQA62x4WivBRaT/AZDF
         1NajHEvW01XhI1VvxrXdeiyPREGJ54AL4BUaLlFQCeTXTsDjryTGcoQgi5Pmte9ZuS+r
         +4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uzQ8cGBP/iiy1dmy29qxsrkA2y8A3VyyoGWk/X1qxUc=;
        b=l4qJpNwxURUWQ2hoBsQapY/6+n3aYqEtVmUXxmCJ0ZsjC6B6lVzq9AJ2jTU6H8c106
         A37Y/wYD0An65H5x7Z/fJwAurOjU1DqO1HsMppqX1mM/inUcX23x8iycmPj8+5bR94WG
         qjPRxf+nAPlKKnU5YalkVvwkAXio6zt3wNCjQmeRl67woU2EM8McNaeFqSbAmn/N8Kdc
         BQ7xYcXbznrf41pSBXYKvWeSaFbN5Auqzwr6LQw9r8yDlso3MRgo27zjVpD0kkUi0oNv
         +mZ40naLCffdIgVG0ju5xxedbm/RGopLrs74JfUNDs4osIPP9CJjOUmFJbVxkK7VFd7R
         cWqg==
X-Gm-Message-State: APjAAAVDAi8172fudrjg3kvIRBunM1AKA4m8SLJbjgu6gKz/x/wfD+9K
        svGk/iX5ogYSg5HOIXV0A6K+VkSM+SuxwqqSMvc=
X-Google-Smtp-Source: APXvYqzhnl/od1+4wqmG+HB56zcHmEodlg2M4/tt0l0rrKjOHl/n60b0sUyw2UaMRpO3OuPN2c7IjdKlcyCGNq68Qz4=
X-Received: by 2002:a65:5382:: with SMTP id x2mr1469482pgq.420.1572998202872;
 Tue, 05 Nov 2019 15:56:42 -0800 (PST)
Date:   Tue,  5 Nov 2019 15:56:04 -0800
In-Reply-To: <20191105235608.107702-1-samitolvanen@google.com>
Message-Id: <20191105235608.107702-11-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191105235608.107702-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v5 10/14] arm64: preserve x18 when CPU is suspended
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

Don't lose the current task's shadow stack when the CPU is suspended.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/include/asm/suspend.h |  2 +-
 arch/arm64/mm/proc.S             | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
index 8939c87c4dce..0cde2f473971 100644
--- a/arch/arm64/include/asm/suspend.h
+++ b/arch/arm64/include/asm/suspend.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_SUSPEND_H
 #define __ASM_SUSPEND_H
 
-#define NR_CTX_REGS 12
+#define NR_CTX_REGS 13
 #define NR_CALLEE_SAVED_REGS 12
 
 /*
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index fdabf40a83c8..5c8219c55948 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -49,6 +49,8 @@
  * cpu_do_suspend - save CPU registers context
  *
  * x0: virtual address of context pointer
+ *
+ * This must be kept in sync with struct cpu_suspend_ctx in <asm/suspend.h>.
  */
 ENTRY(cpu_do_suspend)
 	mrs	x2, tpidr_el0
@@ -73,6 +75,11 @@ alternative_endif
 	stp	x8, x9, [x0, #48]
 	stp	x10, x11, [x0, #64]
 	stp	x12, x13, [x0, #80]
+	/*
+	 * Save x18 as it may be used as a platform register, e.g. by shadow
+	 * call stack.
+	 */
+	str	x18, [x0, #96]
 	ret
 ENDPROC(cpu_do_suspend)
 
@@ -89,6 +96,13 @@ ENTRY(cpu_do_resume)
 	ldp	x9, x10, [x0, #48]
 	ldp	x11, x12, [x0, #64]
 	ldp	x13, x14, [x0, #80]
+	/*
+	 * Restore x18, as it may be used as a platform register, and clear
+	 * the buffer to minimize the risk of exposure when used for shadow
+	 * call stack.
+	 */
+	ldr	x18, [x0, #96]
+	str	xzr, [x0, #96]
 	msr	tpidr_el0, x2
 	msr	tpidrro_el0, x3
 	msr	contextidr_el1, x4
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

