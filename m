Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3810BC282E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 22:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B0D206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 22:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RNG0ZKg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404288AbfEXWLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 18:11:35 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:36432 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbfEXWLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 18:11:31 -0400
Received: by mail-yw1-f73.google.com with SMTP id p123so5034461ywg.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 15:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q0pnEpuGpsfO4o4/PpGY6OcjeWOaJUu326iPNm0R3Pc=;
        b=RNG0ZKg6/OghWFPwBoYwNzzYloxIFDIocpLzYRM7vLV5WjfKTdG0n8nzOmvNytNZF6
         sfTW8MpEGAm41YabVTVREGIGWD6JHYrXq8KmQPoaszezFCDN1Dxmz5Qbva8y/LYgPCtO
         ce3D+ayaKaJaDDrKEKplXgZQoRMLisOlwkdsPuJcLrOTxavfI22g+OKZ1MTHn4qK1gA+
         cZqSbSqI5bkynak7VLvlSPeenO0NkiFk5E0iq3pq8ibZbXC5xv6IOnQepuR6bpn9v/S/
         lV75WhtPEZjzQnpCk6/yGlc9a8T5mp/CvOQgr4k8ZchtltDF/h+lqFOKDiP2tL9xS90Y
         n0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q0pnEpuGpsfO4o4/PpGY6OcjeWOaJUu326iPNm0R3Pc=;
        b=p210sebkjZXYLeEoLgXGU5xc/w6R7bqZMJct3G9xeyyLjesMasY1j8xSp0SBy+KPwc
         R/QZkTuV+Hi25z4qdYs+edE7Tt+Y4kTxDTd7DVt1op4SG5W3SiZFmUSynMFoId/n4bVg
         8rmtuGIKhhi6updSdMsVoEdDXB/8EvQlsm5PRAomKvZB1oSoPnLRXPL+0HTC0cre+v+F
         ALeXou+3HRcfbvElMONBkRJmPIlnm5pyfoWy5z5yLJ+sqqfDM/wT0rJDeUfyVv98EZUn
         jKkUYXpv+npWvI3oKab1Ce8ZP7kvtnK2AnNA1gCvHDou6/emDS3SCVCrp4C/UFzanrGB
         Fa9w==
X-Gm-Message-State: APjAAAUWCoNV7AST2Onlf4nRpMfLJCHMMEwWD4z36aCs7u/AGM2ASrM+
        9UTHCl0/TtxXew0+l3MU9bA72JvtVzmrLLRh1Y8=
X-Google-Smtp-Source: APXvYqxDeASkLXDKWGHrVqaBSK/xzXsxmzMcmmg5HzG3TNLITJge2KYm2eHYLxy/MUCdgQ/j1WC7sUY9hOVabnK32vo=
X-Received: by 2002:a81:a34a:: with SMTP id a71mr37463051ywh.318.1558735890589;
 Fri, 24 May 2019 15:11:30 -0700 (PDT)
Date:   Fri, 24 May 2019 15:11:18 -0700
In-Reply-To: <20190524221118.177548-1-samitolvanen@google.com>
Message-Id: <20190524221118.177548-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20190524221118.177548-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH v3 3/3] arm64: use the correct function type for __arm64_sys_ni_syscall
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
 arch/arm64/kernel/sys32.c |  7 ++-----
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
index 6f91e81165147..d8b35cfe5e94e 100644
--- a/arch/arm64/kernel/sys.c
+++ b/arch/arm64/kernel/sys.c
@@ -47,22 +47,26 @@ SYSCALL_DEFINE1(arm64_personality, unsigned int, personality)
 	return ksys_personality(personality);
 }
 
+asmlinkage long sys_ni_syscall(void);
+
+asmlinkage long __arm64_sys_ni_syscall(const struct pt_regs *__unused)
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
index 0f8bcb7de7008..3c80a40c1c9d6 100644
--- a/arch/arm64/kernel/sys32.c
+++ b/arch/arm64/kernel/sys32.c
@@ -133,17 +133,14 @@ COMPAT_SYSCALL_DEFINE6(aarch32_fallocate, int, fd, int, mode,
 	return ksys_fallocate(fd, mode, arg_u64(offset), arg_u64(len));
 }
 
-asmlinkage long sys_ni_syscall(const struct pt_regs *);
-#define __arm64_sys_ni_syscall	sys_ni_syscall
-
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
2.22.0.rc1.257.g3120a18244-goog

