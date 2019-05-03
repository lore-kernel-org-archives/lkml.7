Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3496AC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 19:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D722070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 19:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YLFHAU8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfECTMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 15:12:41 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:51732 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfECTMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 15:12:37 -0400
Received: by mail-vs1-f74.google.com with SMTP id g67so1564897vsd.18
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 12:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EcPHLwy0dCi679PF7uGrTMs+xhbUxRGLn32SYROJYvw=;
        b=YLFHAU8YrQv2L3qLUIRIUFaA//HQ2PTUT2tQAQ3bVB5YXHf3sPtdpPJ3AzmtBzMA20
         pl7TJ+wPrFjZN+K0uBhTzkBD8Vqk6Qjh4SgIcmYfdq3zDUrO5lk6zxLHB4SXdw5EEZpL
         3kI7Wh8e2tzg3/hkf5RzXYRjF5PJqtnwYSEvJYv66eYq8nJC4K9CbQp4wyPrsBEB8cxm
         NfNOmDgcFsb44qlE/L+7rGdc4ipvtVM/GabjMDgb8WAk/GJTauCtt4k2JZgka4TxcKJK
         QFD8EthWTMFSTJV4ZCZRDD2nuLtLeblnp5Q0wFfDFnw6mmrLJ+SkorKuCJwF6D5t2TOZ
         GH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EcPHLwy0dCi679PF7uGrTMs+xhbUxRGLn32SYROJYvw=;
        b=KxnygWADhQ3cAtYP0oCK/Udt+Wgm6SfU+s5T64WeFhQkvDggFk3IHlaPzOZX3/9vX8
         7djxwAZ+iBa4Uuy1Iyd1b4oHRZmOlwqfBIHCMGollBxMkskql+Jf9vrGn3BgoOMqnIC5
         /hLxASEmgw8Rpug6uiKjZF4j+LJDuBSkeIemwtqcpgp0lw+uRyEXEGVIqhYW9baCfDw3
         1qNMuHWUD2lmIDFUcynmJiul/i8OZpkWJLknD1r6rYauksTVtIctUi4kXtoxS/5Ss99w
         mkklB3gsXefce+9du6f5fvLUod3WsU8ZO2g841iMIWEerB/gw/gTre9M+IlafoRcMf9w
         hedA==
X-Gm-Message-State: APjAAAVuC/fn8HxYsIVHkksQyF+f+zGGov05OP4xXRFgrhybxCv4OCWT
        bti1cuoMZe64bBVSEI3rCK0C0j1xqKwUPMx4Ao0=
X-Google-Smtp-Source: APXvYqz3X6wLfh9y0/O31fmiME1JiH9Kqs2sD7BYj6u6wf2rTqpjbK4TN6PXWfzH04i2vRVD5JNXI7BgKdBh64F1RVA=
X-Received: by 2002:a67:7b56:: with SMTP id w83mr6710305vsc.79.1556910756261;
 Fri, 03 May 2019 12:12:36 -0700 (PDT)
Date:   Fri,  3 May 2019 12:12:25 -0700
In-Reply-To: <20190503191225.6684-1-samitolvanen@google.com>
Message-Id: <20190503191225.6684-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20190503191225.6684-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v2 3/3] arm64: use the correct function type for __arm64_sys_ni_syscall
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling sys_ni_syscall through a syscall_fn_t pointer trips indirect
call Control-Flow Integrity checking due to a function type
mismatch. Use SYSCALL_DEFINE0 for __arm64_sys_ni_syscall instead and
remove the now unnecessary casts.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/kernel/sys.c   | 14 +++++++++-----
 arch/arm64/kernel/sys32.c | 12 ++++++++----
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
index b44065fb16160..4f8e8a7237a85 100644
--- a/arch/arm64/kernel/sys.c
+++ b/arch/arm64/kernel/sys.c
@@ -47,22 +47,26 @@ SYSCALL_DEFINE1(arm64_personality, unsigned int, personality)
 	return ksys_personality(personality);
 }
 
+asmlinkage long sys_ni_syscall(void);
+
+SYSCALL_DEFINE0(ni_syscall)
+{
+	return sys_ni_syscall();
+}
+
 /*
  * Wrappers to pass the pt_regs argument.
  */
 #define sys_personality		sys_arm64_personality
 
-asmlinkage long sys_ni_syscall(const struct pt_regs *);
-#define __arm64_sys_ni_syscall	sys_ni_syscall
-
 #undef __SYSCALL
 #define __SYSCALL(nr, sym)	asmlinkage long __arm64_##sym(const struct pt_regs *);
 #include <asm/unistd.h>
 
 #undef __SYSCALL
-#define __SYSCALL(nr, sym)	[nr] = (syscall_fn_t)__arm64_##sym,
+#define __SYSCALL(nr, sym)	[nr] = __arm64_##sym,
 
 const syscall_fn_t sys_call_table[__NR_syscalls] = {
-	[0 ... __NR_syscalls - 1] = (syscall_fn_t)sys_ni_syscall,
+	[0 ... __NR_syscalls - 1] = __arm64_sys_ni_syscall,
 #include <asm/unistd.h>
 };
diff --git a/arch/arm64/kernel/sys32.c b/arch/arm64/kernel/sys32.c
index 0f8bcb7de7008..f8f6c26cfd326 100644
--- a/arch/arm64/kernel/sys32.c
+++ b/arch/arm64/kernel/sys32.c
@@ -133,17 +133,21 @@ COMPAT_SYSCALL_DEFINE6(aarch32_fallocate, int, fd, int, mode,
 	return ksys_fallocate(fd, mode, arg_u64(offset), arg_u64(len));
 }
 
-asmlinkage long sys_ni_syscall(const struct pt_regs *);
-#define __arm64_sys_ni_syscall	sys_ni_syscall
+asmlinkage long sys_ni_syscall(void);
+
+COMPAT_SYSCALL_DEFINE0(ni_syscall)
+{
+	return sys_ni_syscall();
+}
 
 #undef __SYSCALL
 #define __SYSCALL(nr, sym)	asmlinkage long __arm64_##sym(const struct pt_regs *);
 #include <asm/unistd32.h>
 
 #undef __SYSCALL
-#define __SYSCALL(nr, sym)	[nr] = (syscall_fn_t)__arm64_##sym,
+#define __SYSCALL(nr, sym)	[nr] = __arm64_##sym,
 
 const syscall_fn_t compat_sys_call_table[__NR_compat_syscalls] = {
-	[0 ... __NR_compat_syscalls - 1] = (syscall_fn_t)sys_ni_syscall,
+	[0 ... __NR_compat_syscalls - 1] = __arm64_sys_ni_syscall,
 #include <asm/unistd32.h>
 };
-- 
2.21.0.1020.gf2820cf01a-goog

