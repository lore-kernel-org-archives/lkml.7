Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C16C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 22:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D3A24673
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 22:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XpQfC+Me"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfLFWOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 17:14:25 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:46193 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfLFWOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 17:14:22 -0500
Received: by mail-pf1-f202.google.com with SMTP id w127so4797142pfb.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 14:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q0VCePxuQrqw4BBZGnamleajd+Jt3fiHSwLdib7c23k=;
        b=XpQfC+MeF/x/58JAAU0Gq9P6sK3UThDbiX4tokqcmE5W2JlFjupWk3t7S6fJEl7bmQ
         uG77IKQKNCjwNeXL5gKTK4hYsXwcw3IEb3xYsQMThtapSpkH/6n8NZA1P7BK9GoJvjlv
         gjsgrx6f2M8YtuUoFz6xW2/sVs3avmftC2FD9rLUg7uPIxxu1nky1tI+067SAycFIIZv
         I5Ox0b34VKtUQTfOqlCtC7ANi+wPbCIGo5s06hQc0p9ToPPN7U2DDRK+8/gr5u99Ip8U
         6665xOHYKE53S80IzppbeI1PtBJzI2Bw2DR42y5FZrTsuJwM4wsLA+y323NiZkNZTWXF
         YfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q0VCePxuQrqw4BBZGnamleajd+Jt3fiHSwLdib7c23k=;
        b=q1pv+iRVNHZnsIdZiRTXIYX200OVNUOKUqX/id/9pwxUhyhWAFOSSobcaokoE1DG8a
         26OC1Fsz/kAcuJQCKOmBpEkitT4kbUG7QnIxHR2PKVeOG5gKrdpxDY1MpVWqt5aCQ1Gb
         fGt8iqHgiDKL9bwn5Gv7N7UowNKMFXjxo3eAwJ01aopYXiMpXWkLhl5rXjsY/VGTrFEP
         jr6UqTwrldR48YNvokDPsFFMJ1R2/YhnZk6xU2zdZ3EAI9oerPJ96HCuKcr3VyqrXFjc
         k05WcJZyWsLnjnkH0pAZRXSLW9MLbzDsBFzwlTSJKzW14zpQMZiLExyB+nF82PrOvnSy
         Tnjg==
X-Gm-Message-State: APjAAAXAu4ES0SBaBTjG1PVeKxhd0ggOKMbQ8k/1GsnVoBetA4zAf2ux
        34nE2sbF0FXAhobn88N4vqqVIKSw8FYU30iMm8Y=
X-Google-Smtp-Source: APXvYqxcGyciG3MMD7PbQn8IKkK3yA7MJ/fwU2YEUvmtPTk2dDChHbcnuIxBvmADPyGDroBjAeLdoXj34UKB4SrRjVg=
X-Received: by 2002:a63:d543:: with SMTP id v3mr5881958pgi.285.1575670461425;
 Fri, 06 Dec 2019 14:14:21 -0800 (PST)
Date:   Fri,  6 Dec 2019 14:13:46 -0800
In-Reply-To: <20191206221351.38241-1-samitolvanen@google.com>
Message-Id: <20191206221351.38241-11-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191206221351.38241-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v6 10/15] arm64: preserve x18 when CPU is suspended
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
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
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
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
2.24.0.393.g34dc348eaf-goog

