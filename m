Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED0CECE58C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC742190F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="flY5qlCG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfJHWlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 18:41:06 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:45203 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbfJHWlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 18:41:05 -0400
Received: by mail-pg1-f201.google.com with SMTP id x31so220257pgl.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 15:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6CRaByPmwZZbYHACg7k1nT3qVKizFi1JIygNj2Eu6tU=;
        b=flY5qlCGmPdESWqrzPRhJ6fA000kiBKtv7ouLl1zCVc9abIPurp5+foDKJes/TAbVP
         BOvnlmpWOKZGnlsbPDIs6d1FSZsgIQHXTjeU58N2yA/eeB3Sw/+OsL1I+GXKq9XNT0AD
         OIclucvqSWN3FFzU9JlGO9HR767pQM/LRt+oGaJM/clIrViIOItWiFv97xjGlBCTMfnZ
         J421CZp9Uc1+eiXJjZLZsmhtYJNUNB1nQZ72C+hcWV69er5Yrp6PWpwIcpC6U8Z9Dv2p
         reYfp1mTlUl4bqOU8FcubPHiMACGVpwptF2AZ6R0BI/4SXQwP5VnqDzht2vJ5ViwQmyi
         25aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6CRaByPmwZZbYHACg7k1nT3qVKizFi1JIygNj2Eu6tU=;
        b=VbOqhiZxvsIvJkFE7g1DCb4TMr8cBZboaC4vHptNl/0L5buWI3l/aa8VuHo5wCjODm
         0rV3hmoCXELarogrTfFaEel7MtKqks75T34MmsJsfNWYinSQiNgbdtGhbBzeDIl64nHu
         UVYalenxac5S5X8riJzXT5xJmb+w8enQ/iGfrB2fmH9cxW71wbKYaFYbFMDN2IQ6GrzY
         xCrOJNMCBhOodV1vDH1N4Wnmr+h7oKOOPbf7yHR2SZFAec/U1qG9lva4vhLfskjuio/X
         Qit75l6BGtIzWr0XcCOQt/yLf5IZU7RnaCTJbzMKxCZLPT7geGqj+ToF3qVBLiTI29jd
         vfhg==
X-Gm-Message-State: APjAAAX7mquUg6tG7T6HqSSMXi2iESGLLlBnBDrV9q6+fuiUe4Xfo1bg
        AlSs1KNg8DAgx4ygPf9nhBt0x5DrUtlAQYr0kVg=
X-Google-Smtp-Source: APXvYqyx2Zu73kfLvNByNSHZTqrz36zsEhp5z58ZxJrKO+1xLooAIVRmOoecfTmKXbfbRCujP+XgqbeZYdiAL7YQyUk=
X-Received: by 2002:a65:434c:: with SMTP id k12mr820592pgq.141.1570574464142;
 Tue, 08 Oct 2019 15:41:04 -0700 (PDT)
Date:   Tue,  8 Oct 2019 15:40:46 -0700
In-Reply-To: <20191008224049.115427-1-samitolvanen@google.com>
Message-Id: <20191008224049.115427-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20190913210018.125266-1-samitolvanen@google.com> <20191008224049.115427-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [RESEND PATCH v2 2/5] x86/syscalls: Wire up COMPAT_SYSCALL_DEFINE0
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

From: Andy Lutomirski <luto@kernel.org>

x86 has special handling for COMPAT_SYSCALL_DEFINEx, but there was
no override for COMPAT_SYSCALL_DEFINE0.  Wire it up so that we can
use it for rt_sigreturn.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/include/asm/syscall_wrapper.h | 32 ++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index 90eb70df0b18..3dab04841494 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -28,13 +28,21 @@
  * kernel/sys_ni.c and SYS_NI in kernel/time/posix-stubs.c to cover this
  * case as well.
  */
+#define __IA32_COMPAT_SYS_STUB0(x, name)				\
+	asmlinkage long __ia32_compat_sys_##name(const struct pt_regs *regs);\
+	ALLOW_ERROR_INJECTION(__ia32_compat_sys_##name, ERRNO);		\
+	asmlinkage long __ia32_compat_sys_##name(const struct pt_regs *regs)\
+	{								\
+		return __se_compat_sys_##name();			\
+	}
+
 #define __IA32_COMPAT_SYS_STUBx(x, name, ...)				\
 	asmlinkage long __ia32_compat_sys##name(const struct pt_regs *regs);\
 	ALLOW_ERROR_INJECTION(__ia32_compat_sys##name, ERRNO);		\
 	asmlinkage long __ia32_compat_sys##name(const struct pt_regs *regs)\
 	{								\
 		return __se_compat_sys##name(SC_IA32_REGS_TO_ARGS(x,__VA_ARGS__));\
-	}								\
+	}
 
 #define __IA32_SYS_STUBx(x, name, ...)					\
 	asmlinkage long __ia32_sys##name(const struct pt_regs *regs);	\
@@ -76,15 +84,24 @@
  * of the x86-64-style parameter ordering of x32 syscalls. The syscalls common
  * with x86_64 obviously do not need such care.
  */
+#define __X32_COMPAT_SYS_STUB0(x, name, ...)				\
+	asmlinkage long __x32_compat_sys_##name(const struct pt_regs *regs);\
+	ALLOW_ERROR_INJECTION(__x32_compat_sys_##name, ERRNO);		\
+	asmlinkage long __x32_compat_sys_##name(const struct pt_regs *regs)\
+	{								\
+		return __se_compat_sys_##name();\
+	}
+
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)				\
 	asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs);\
 	ALLOW_ERROR_INJECTION(__x32_compat_sys##name, ERRNO);		\
 	asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs)\
 	{								\
 		return __se_compat_sys##name(SC_X86_64_REGS_TO_ARGS(x,__VA_ARGS__));\
-	}								\
+	}
 
 #else /* CONFIG_X86_X32 */
+#define __X32_COMPAT_SYS_STUB0(x, name)
 #define __X32_COMPAT_SYS_STUBx(x, name, ...)
 #endif /* CONFIG_X86_X32 */
 
@@ -95,6 +112,17 @@
  * mapping of registers to parameters, we need to generate stubs for each
  * of them.
  */
+#define COMPAT_SYSCALL_DEFINE0(name)					\
+	static long __se_compat_sys_##name(void);			\
+	static inline long __do_compat_sys_##name(void);		\
+	__IA32_COMPAT_SYS_STUB0(x, name)				\
+	__X32_COMPAT_SYS_STUB0(x, name)					\
+	static long __se_compat_sys_##name(void)			\
+	{								\
+		return __do_compat_sys_##name();			\
+	}								\
+	static inline long __do_compat_sys_##name(void)
+
 #define COMPAT_SYSCALL_DEFINEx(x, name, ...)					\
 	static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
 	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
-- 
2.23.0.581.g78d2f28ef7-goog

