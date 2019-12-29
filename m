Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7A4C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4666F206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641282;
	bh=+2Dmoo25/7H+wwcz8gKLj7/ig1lPYuYss2G1OVsCtYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SygTPxqP+pEiJQYg/8TFLZmv4inPzjo8oDrupX7rLEK5vVka0Scgpw/pQqjvXpymU
	 KMFcrxCG3wYMCoVl6h6f7f0OXFk7kdAk5s2Ft16rqdAiiaZ6mKZ4TZtWaP6dYXQ+qY
	 GDvcThIAQoTT7d8/5CJwZhkrA0XvWLqsHlRJPWtg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfL2Ra1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:30:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:56362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728928AbfL2RaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:30:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 758D220409;
        Sun, 29 Dec 2019 17:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640623;
        bh=+2Dmoo25/7H+wwcz8gKLj7/ig1lPYuYss2G1OVsCtYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dSvcVjvDwEerFpkxF+2By66wsGPwQjAdroGvek73r/3xlxwyRRWt03fzEV+n3cJuY
         W2JULBsJTmHD/gCloQXmdthHHaDBdu3HSFn4QtHNog9DyJK0No1oF72PAsnwRfy2jT
         USmZ7331YeA2KNgb6HVK9c+pP6YFL/RjKEQjVZ3A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 071/219] syscalls/x86: Use the correct function type in SYSCALL_DEFINE0
Date:   Sun, 29 Dec 2019 18:17:53 +0100
Message-Id: <20191229162517.059392918@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162508.458551679@linuxfoundation.org>
References: <20191229162508.458551679@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sami Tolvanen <samitolvanen@google.com>

[ Upstream commit 8661d769ab77c675b5eb6c3351a372b9fbc1bf40 ]

Although a syscall defined using SYSCALL_DEFINE0 doesn't accept
parameters, use the correct function type to avoid type mismatches
with Control-Flow Integrity (CFI) checking.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H . Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191008224049.115427-2-samitolvanen@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/syscall_wrapper.h | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index e046a405743d..90eb70df0b18 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -48,12 +48,13 @@
  * To keep the naming coherent, re-define SYSCALL_DEFINE0 to create an alias
  * named __ia32_sys_*()
  */
-#define SYSCALL_DEFINE0(sname)					\
-	SYSCALL_METADATA(_##sname, 0);				\
-	asmlinkage long __x64_sys_##sname(void);		\
-	ALLOW_ERROR_INJECTION(__x64_sys_##sname, ERRNO);	\
-	SYSCALL_ALIAS(__ia32_sys_##sname, __x64_sys_##sname);	\
-	asmlinkage long __x64_sys_##sname(void)
+
+#define SYSCALL_DEFINE0(sname)						\
+	SYSCALL_METADATA(_##sname, 0);					\
+	asmlinkage long __x64_sys_##sname(const struct pt_regs *__unused);\
+	ALLOW_ERROR_INJECTION(__x64_sys_##sname, ERRNO);		\
+	SYSCALL_ALIAS(__ia32_sys_##sname, __x64_sys_##sname);		\
+	asmlinkage long __x64_sys_##sname(const struct pt_regs *__unused)
 
 #define COND_SYSCALL(name)						\
 	cond_syscall(__x64_sys_##name);					\
@@ -181,11 +182,11 @@
  * macros to work correctly.
  */
 #ifndef SYSCALL_DEFINE0
-#define SYSCALL_DEFINE0(sname)					\
-	SYSCALL_METADATA(_##sname, 0);				\
-	asmlinkage long __x64_sys_##sname(void);		\
-	ALLOW_ERROR_INJECTION(__x64_sys_##sname, ERRNO);	\
-	asmlinkage long __x64_sys_##sname(void)
+#define SYSCALL_DEFINE0(sname)						\
+	SYSCALL_METADATA(_##sname, 0);					\
+	asmlinkage long __x64_sys_##sname(const struct pt_regs *__unused);\
+	ALLOW_ERROR_INJECTION(__x64_sys_##sname, ERRNO);		\
+	asmlinkage long __x64_sys_##sname(const struct pt_regs *__unused)
 #endif
 
 #ifndef COND_SYSCALL
-- 
2.20.1



