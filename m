Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16464ECE597
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF210218AC
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wVVM6OXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbfJHWlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 18:41:14 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:49768 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729587AbfJHWlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 18:41:12 -0400
Received: by mail-pg1-f202.google.com with SMTP id l6so213260pgq.16
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 15:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8L2qH1QoTZdD0WUC7fGvXD/siaordRhaVsVf/d6xKxo=;
        b=wVVM6OXREBMrdgPOj5smFnlMwFkqWSSmmUN5vUJkIAhGAyZv2CG9iYgnsLutojrETa
         FzDXLszEwylsxBefkZ8xK1ie/pbaoq9sfyq7pBizdqD3JU2h7DR65bg+Bvsm5V46vZfV
         SgWzF+JGnXjyzaMetQUu6US0iJCi8M9F4fVSR4aqJzTuayanmcGmWGFDZEuv8r/r/QOw
         eTTB3j7rGY4jabk+Th5ZGZvvrvpSuyInv1ToQ4IYdY+Wk5mMCa/UmmFXGMOdtdY6Wp+Z
         3gonOh6VQ+IJiFW7fkB+ByEwwmnLQ1U4i3B1SNGeLbV1hafSMLjg4/eDDIm18SmuUGy5
         P/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8L2qH1QoTZdD0WUC7fGvXD/siaordRhaVsVf/d6xKxo=;
        b=CZ1aAedCAYN1vgQF/sEGI/vqSoOfuivt7TaVuFWfbe0c+Li+JipNl8JXxpq82pvu9M
         qnUMdTO05t4xLTJa52yYq7GKCkD1lYYpY2nqFsCCxRawvoRkPdsA8qk62WvGjF5dFZKo
         LvO7mdkuepOcTSDTMMMcNFPMgyIJgkCrfV3KEbwaiOvJYBjmlS05Y82Om5/o3FG2HEkw
         ox0b3O5wA+eyIv0CmBj8ESbSu3paprkEPGwPyH24OKY1UDtfc9IpPKgl2OCTqBugw5Iy
         Yiu9hGyBTI2e2RKDKPw/fx61LtW5o/LMCVJKYwynx0M53/HKXzTQ8nRXU3WMNpk7L2D6
         TJPA==
X-Gm-Message-State: APjAAAXdzxrqXdhRApeN24j3nyklxrnwGV91C2STnIk8wStSZexS5+yw
        76qZzu0ofHyo2q7gxT/9Tbfxg9Kt4oeWjvfDXvg=
X-Google-Smtp-Source: APXvYqwQOYqs241suWDjIUAnNq/5wDxNhxISU7w6eaZ3JHU+4LfvfOdnh3yGJxg6s5idw0gH7jHKB9yyr9pw7A/9JpM=
X-Received: by 2002:a63:155e:: with SMTP id 30mr867657pgv.204.1570574471708;
 Tue, 08 Oct 2019 15:41:11 -0700 (PDT)
Date:   Tue,  8 Oct 2019 15:40:49 -0700
In-Reply-To: <20191008224049.115427-1-samitolvanen@google.com>
Message-Id: <20191008224049.115427-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20190913210018.125266-1-samitolvanen@google.com> <20191008224049.115427-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [RESEND PATCH v2 5/5] x86: fix function types in COND_SYSCALL
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a weak function in COND_SYSCALL instead of a weak alias to
sys_ni_syscall, which has an incompatible type. This fixes indirect
call mismatches with Control-Flow Integrity (CFI) checking.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/include/asm/syscall_wrapper.h | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index 3dab04841494..e2389ce9bf58 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -6,6 +6,8 @@
 #ifndef _ASM_X86_SYSCALL_WRAPPER_H
 #define _ASM_X86_SYSCALL_WRAPPER_H
 
+struct pt_regs;
+
 /* Mapping of registers to parameters for syscalls on x86-64 and x32 */
 #define SC_X86_64_REGS_TO_ARGS(x, ...)					\
 	__MAP(x,__SC_ARGS						\
@@ -64,9 +66,15 @@
 	SYSCALL_ALIAS(__ia32_sys_##sname, __x64_sys_##sname);		\
 	asmlinkage long __x64_sys_##sname(const struct pt_regs *__unused)
 
-#define COND_SYSCALL(name)						\
-	cond_syscall(__x64_sys_##name);					\
-	cond_syscall(__ia32_sys_##name)
+#define COND_SYSCALL(name)							\
+	asmlinkage __weak long __x64_sys_##name(const struct pt_regs *__unused)	\
+	{									\
+		return sys_ni_syscall();					\
+	}									\
+	asmlinkage __weak long __ia32_sys_##name(const struct pt_regs *__unused)\
+	{									\
+		return sys_ni_syscall();					\
+	}
 
 #define SYS_NI(name)							\
 	SYSCALL_ALIAS(__x64_sys_##name, sys_ni_posix_timers);		\
@@ -218,7 +226,11 @@
 #endif
 
 #ifndef COND_SYSCALL
-#define COND_SYSCALL(name) cond_syscall(__x64_sys_##name)
+#define COND_SYSCALL(name) 							\
+	asmlinkage __weak long __x64_sys_##name(const struct pt_regs *__unused)	\
+	{									\
+		return sys_ni_syscall();					\
+	}
 #endif
 
 #ifndef SYS_NI
@@ -230,7 +242,6 @@
  * For VSYSCALLS, we need to declare these three syscalls with the new
  * pt_regs-based calling convention for in-kernel use.
  */
-struct pt_regs;
 asmlinkage long __x64_sys_getcpu(const struct pt_regs *regs);
 asmlinkage long __x64_sys_gettimeofday(const struct pt_regs *regs);
 asmlinkage long __x64_sys_time(const struct pt_regs *regs);
-- 
2.23.0.581.g78d2f28ef7-goog

