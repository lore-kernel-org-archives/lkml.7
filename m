Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149AAC4CECE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 22:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D528521929
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 22:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Teqamxsy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731895AbfIRWqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 18:46:34 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:49644 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731880AbfIRWqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 18:46:32 -0400
Received: by mail-pf1-f202.google.com with SMTP id i28so824667pfq.16
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 15:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qsuvIphZtGpPCvHXppyQWEcKW9OLq3yS4knwFzCYvZ0=;
        b=TeqamxsyXselwyoldv2KrjiUx31XmC5nXp9XLFKCNrCxXzy2exgyZqSeUZileIU4py
         KXVInzV0YpjVXdMxtep5zBIgtbwIXM2lG/LoA2ME1HQfrDVbm1ZbrGwU39YIVInTMqyo
         g/KUYtsgrc1xVWvyJXuY0aRQhs/HJ84EFKhADbYIn0kvyhM0EknT2jxYwnur8EbzQ9PK
         +dJ5bJsF99mXbTmMYN+VKM5Kn/jLhytg/rGJcQE1sHT7qy28F+WBdQnTe4RT9eoj8jb8
         nQmzIo1Ry5LFbGox3fLiCSxUvUG+yJyG63W/sJmXJ0FGpFeJQMU85tycS/Y4LOEiTPTb
         cguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qsuvIphZtGpPCvHXppyQWEcKW9OLq3yS4knwFzCYvZ0=;
        b=rnSKnDvButjAoAV0k90BgD0ToLWpK0kR/4v2l+DHv/DRZcNkQdI4x3Oaq7LJszAa8x
         t0EQxrkG/eOioIxr7fV2HTJidIWmANJ24EHxUsSsBbjgSnXoA1p0EaPee4o4Q9BGsY95
         la+LQJsQgf4loRzBJnJ7f9H5GTI66LHHT3pZlzP1ZbvvohopXxopKiZicjuR0ci07z6V
         Z+Nb+4uPvEZxBf5uIp08Rh/isX1HlDr0gGiabGKWr2j68bagKbV1PUDxtGrcLL5eHJ5P
         A9AxxhATeqfDilP8oxZFduOFQZsEwRoK7zprEkvG9o4aqzoMSb3/9wGuAy3GRbl+ls3U
         ADWw==
X-Gm-Message-State: APjAAAXDFobXkTC+7ByYixeajVZpMwaS383+tJRmG2Z+WzABNVJjlqYx
        0SMDyM8+Eg2xx7tDXNTYbGj2Juayt4fl5cfPMMg=
X-Google-Smtp-Source: APXvYqx/siB7/8K2qhfO6DFO6QftdYVM4NHpkANv0SRQ/9vo7syH+IVGSk6lCcXM6ccaCeZhn43G0MhAqea+1Xr0c14=
X-Received: by 2002:a65:6102:: with SMTP id z2mr6123243pgu.391.1568846791311;
 Wed, 18 Sep 2019 15:46:31 -0700 (PDT)
Date:   Wed, 18 Sep 2019 15:46:08 -0700
In-Reply-To: <20190918224608.77973-1-samitolvanen@google.com>
Message-Id: <20190918224608.77973-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20190913210018.125266-1-samitolvanen@google.com> <20190918224608.77973-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v2 5/5] x86: fix function types in COND_SYSCALL
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
2.23.0.351.gc4317032e6-goog

