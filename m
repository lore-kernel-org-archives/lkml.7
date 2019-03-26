Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65153C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3174A20863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553588573;
	bh=gwtDLMqGQYA0no8ugNIMSIAnIHbgXvBIxNKUdY2t1PA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=M+ID8Xlej5lTYSv+uJXXFyKxgnpsctzFYb/Vfzpsv6/Wyi5oGUMw4RtdRnnG6ec5k
	 /5Q+cVqD1TCQQfKL3CC3gZOxww9gch9JHZw8DiqrMlB+L2b5ro65N4SQQaOTyDae2M
	 6FfUfWzwjN/PS1ExkpBu2kWTaRttO7mG7F6QewRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731129AbfCZIWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:22:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfCZIWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:22:51 -0400
Received: from localhost.localdomain (unknown [115.199.178.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F69820857;
        Tue, 26 Mar 2019 08:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553588571;
        bh=gwtDLMqGQYA0no8ugNIMSIAnIHbgXvBIxNKUdY2t1PA=;
        h=From:To:Cc:Subject:Date:From;
        b=qkStPLbGBQZ5w8wKEDmx+ZaLILe0s7zvROp/ERmC5nbOv/jvt+xhEZUeOs6sSBZqT
         uxOjr92nuVOhM/ItRd3L2bR9pCvOPJhi5Q4OxwIahsxzOnEpUIC6z7xZa7CQQ3LOgM
         bCaR/zl331r0E2DD5kCx9sAPwAibyJSyytbXOuwQ=
From:   guoren@kernel.org
To:     arnd@arndb.de, ldv@altlinux.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        ren_guo@c-sky.com, strace-devel@lists.strace.io
Subject: [PATCH] csky: Add non-uapi asm/ptrace.h namespace
Date:   Tue, 26 Mar 2019 16:22:31 +0800
Message-Id: <1553588551-30020-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Move #ifdef __KERNEL__ code in the uapi namespace to non-uapi
include/asm/ptrace.h namespace and remove #ifdef __KERNEL__ in
include/asm/ptrace.h. Seperate ptrace.h in uapi and non-uapi is more
common and clear.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Dmitry V. Levin <ldv@altlinux.org>
---
 arch/csky/include/asm/ptrace.h      | 29 +++++++++++++++++++++++++++++
 arch/csky/include/uapi/asm/ptrace.h | 20 --------------------
 2 files changed, 29 insertions(+), 20 deletions(-)
 create mode 100644 arch/csky/include/asm/ptrace.h

diff --git a/arch/csky/include/asm/ptrace.h b/arch/csky/include/asm/ptrace.h
new file mode 100644
index 0000000..1e00578
--- /dev/null
+++ b/arch/csky/include/asm/ptrace.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
+
+#ifndef __ASM_CSKY_PTRACE_H
+#define __ASM_CSKY_PTRACE_H
+
+#include <uapi/asm/ptrace.h>
+
+#ifndef __ASSEMBLY__
+
+#define PS_S	0x80000000 /* Supervisor Mode */
+
+#define arch_has_single_step() (1)
+#define current_pt_regs() \
+({ (struct pt_regs *)((char *)current_thread_info() + THREAD_SIZE) - 1; })
+
+#define user_stack_pointer(regs) ((regs)->usp)
+
+#define user_mode(regs) (!((regs)->sr & PS_S))
+#define instruction_pointer(regs) ((regs)->pc)
+#define profile_pc(regs) instruction_pointer(regs)
+
+static inline unsigned long regs_return_value(struct pt_regs *regs)
+{
+	return regs->a0;
+}
+
+#endif /* __ASSEMBLY__ */
+#endif /* __ASM_CSKY_PTRACE_H */
diff --git a/arch/csky/include/uapi/asm/ptrace.h b/arch/csky/include/uapi/asm/ptrace.h
index 9bf5b1a..4e248d5 100644
--- a/arch/csky/include/uapi/asm/ptrace.h
+++ b/arch/csky/include/uapi/asm/ptrace.h
@@ -48,25 +48,5 @@ struct user_fp {
 	unsigned long	reserved;
 };
 
-#ifdef __KERNEL__
-
-#define PS_S	0x80000000 /* Supervisor Mode */
-
-#define arch_has_single_step() (1)
-#define current_pt_regs() \
-({ (struct pt_regs *)((char *)current_thread_info() + THREAD_SIZE) - 1; })
-
-#define user_stack_pointer(regs) ((regs)->usp)
-
-#define user_mode(regs) (!((regs)->sr & PS_S))
-#define instruction_pointer(regs) ((regs)->pc)
-#define profile_pc(regs) instruction_pointer(regs)
-
-static inline unsigned long regs_return_value(struct pt_regs *regs)
-{
-	return regs->a0;
-}
-
-#endif /* __KERNEL__ */
 #endif /* __ASSEMBLY__ */
 #endif /* _CSKY_PTRACE_H */
-- 
2.7.4

