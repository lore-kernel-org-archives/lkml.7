Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBA7CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 22:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B114218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 22:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LtAl7Dty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfKAWMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 18:12:33 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:43382 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbfKAWMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 18:12:32 -0400
Received: by mail-vs1-f74.google.com with SMTP id x2so1933928vse.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 15:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oPoEfiJ829HFiTJF4c1zGL5TdlrTqAGNgCQhkPxdZv8=;
        b=LtAl7DtyP3CWOemlPwjpOVNnzn34lyrO0lR489D5hiJ2VdFoF7EvYDq2wfAcUETMUj
         AJJV9M7q6HlU6FTXIdD1nVIYYwLxTKh17kUwJIBUkK7g2ckd+p7WgRLwUL+U4LhnUrbS
         88BQeTCyX9oSneGkX/XIJMANH1JIMKlq987kvfi9Jwu3IO8heBNjQe3JNyCoyIBcqE5C
         r14KyfVUCK2DPs+EL3vCGkIShUp8wmIdLEHOjtbfUl144pnEGGFEFKJlhFi/qSds+L4C
         EczTWrE0OgWD8kqUXRcCY/eBf8by4lrn14g7ldLKqA66pCBxbbWJBFgW5xjq+nWP9ZjC
         NtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oPoEfiJ829HFiTJF4c1zGL5TdlrTqAGNgCQhkPxdZv8=;
        b=tfrqcr3Afq+Ib+rxD1ye5D/duRDNXgyd2EHLfdTGwzpz4aCIAatEwDfOSD4owGR1Ga
         eJsvkLH1nIdkorGCHKMPdj8h7v7s+sNdYpG9gUYdzfnMuxht018Ejoi17tVhpnSBoIla
         6QlkHo2P/CHyDnmBdW3UtFTr0pAVZIhfKdj23Okua8BcutYDUSRKyiB+puj5SFC1PZ2S
         GSsKgLUgp6zrJ3/zsQdnau2c1CPgo1mAS79gGM8NGO5ZIc/NJTnh+hMIP4aQyI/BfY84
         u6LGDgcVf/y93ZyipTp3eUknUI4nmOvHp1CtYxoQWMXGugzyVtLvI9Pmf70aMta4t254
         Tk4Q==
X-Gm-Message-State: APjAAAUFWtmMNnYtxRfZ9N2qjKefQ2rm6BzIb6H9TTdgbGLw84+k3gBK
        x8bmsVRkY9dPSYdDqLDJ2Mls30+J2kyafC4cUQY=
X-Google-Smtp-Source: APXvYqxf6pyuy2b0C7kGwVb9cMM9HBx/dT4rTM6z4dJTmBDml32z4MNPrDuebbuZ9ExwOLM18YhheN7oDa5AKWC4xdM=
X-Received: by 2002:a67:f7d0:: with SMTP id a16mr2505843vsp.108.1572646349491;
 Fri, 01 Nov 2019 15:12:29 -0700 (PDT)
Date:   Fri,  1 Nov 2019 15:11:46 -0700
In-Reply-To: <20191101221150.116536-1-samitolvanen@google.com>
Message-Id: <20191101221150.116536-14-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191101221150.116536-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v4 13/17] arm64: preserve x18 when CPU is suspended
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
 arch/arm64/mm/proc.S             | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

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
index fdabf40a83c8..5616dc52a033 100644
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
@@ -73,6 +75,9 @@ alternative_endif
 	stp	x8, x9, [x0, #48]
 	stp	x10, x11, [x0, #64]
 	stp	x12, x13, [x0, #80]
+#ifdef CONFIG_SHADOW_CALL_STACK
+	str	x18, [x0, #96]
+#endif
 	ret
 ENDPROC(cpu_do_suspend)
 
@@ -89,6 +94,11 @@ ENTRY(cpu_do_resume)
 	ldp	x9, x10, [x0, #48]
 	ldp	x11, x12, [x0, #64]
 	ldp	x13, x14, [x0, #80]
+#ifdef CONFIG_SHADOW_CALL_STACK
+	ldr	x18, [x0, #96]
+	/* Clear the SCS pointer from the state buffer */
+	str	xzr, [x0, #96]
+#endif
 	msr	tpidr_el0, x2
 	msr	tpidrro_el0, x3
 	msr	contextidr_el1, x4
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

