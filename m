Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20E8C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 11:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB46B2173B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 11:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eFbk7M92"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387699AbfGPLNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 07:13:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46317 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387584AbfGPLNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 07:13:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id c73so8943364pfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 04:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8NFJGPVlVAuYMPwOwTl0aBkcJ7/1gJuCLWe4ZLruxuU=;
        b=eFbk7M92HouroEKZP0msAOxYiaXaS/2dbFJatwM4kpmpNxCG2xYCHSOShlXhHmfE/y
         HGkpLzpVjnxwwgeoDQJJKFh0lBYkIHTQa7SmPAqKRACozyFI1kfcxgyGAhe+PYMgiKoV
         TxyhCnO8KPyvyLcGu/qiDr7sGSerQN8PJUUr+ZQITlUAG3FZs1YFtHMqvb5GXWip8Cd6
         x879/KTZqwwgfqf8qTL/8Fhu2rsWdmSFSKgR7tTOmxeuPB4LV1h8KvWPxzLdT/FYmbzt
         Re6WG4jGnGzfkzfMqkQE+3p6FC6FWaId7hHmYWWVkEQiHCKVqOeGmEHXPEfk69iWGxsa
         1r6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8NFJGPVlVAuYMPwOwTl0aBkcJ7/1gJuCLWe4ZLruxuU=;
        b=XL29PB+aGUIbqfCf0Jnx0TAP2WSAR1mem/sYrWKgfqLK867aIc/QTRuLuH7UBYX1BQ
         u8iOqBsI4fzEgyTxHc3RDeEn0nJM+GyTm1PGk/uaRtfg0CKtO26VwiXboMYoZ+RPYBd1
         NhE0K/TzIKwXnOjQC/PIO6V7xpue9Ybce5wnwgeyMsJYAWajNkvusNodyvlUjJqsZGT+
         HsvGYRg2G/772MKlKSZKn7DOQGQ71kShGO2qR59T5LTWokpcOd43D6dGoCB3QmhgSHfj
         UQY6mrpIFriYACh4az+b5l2VfGqNLbwLWbN5Jgv0sDeS+NjXAM7/DFEB4ZxKNVOu8DSw
         PI+g==
X-Gm-Message-State: APjAAAV/nMAGEC/4Imp0503HcEWkn64P0HDxfjVnfk+7VPRC+BiPHnhk
        6DX4pueg3wgarnXnM/pnvKjYrA==
X-Google-Smtp-Source: APXvYqxM/EzG6XkGwFUq5lCZpCu7Qc8I2MK4CsmMFswEozlWGhc+DzYVPw/ySuvYYAujJtb6hXwP4Q==
X-Received: by 2002:a17:90a:db52:: with SMTP id u18mr35690859pjx.107.1563275611836;
        Tue, 16 Jul 2019 04:13:31 -0700 (PDT)
Received: from localhost.localdomain (li1433-81.members.linode.com. [45.33.106.81])
        by smtp.gmail.com with ESMTPSA id 21sm19324907pjh.25.2019.07.16.04.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 04:13:31 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Russell King <linux@armlinux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Justin He <Justin.He@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 2/2] arm: Add support for function error injection
Date:   Tue, 16 Jul 2019 19:13:01 +0800
Message-Id: <20190716111301.1855-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190716111301.1855-1-leo.yan@linaro.org>
References: <20190716111301.1855-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implement regs_set_return_value() and
override_function_with_return() to support function error injection
for arm.

In the exception flow, we can update pt_regs::ARM_pc with
pt_regs::ARM_lr so that can override the probed function return.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm/Kconfig                       |  1 +
 arch/arm/include/asm/error-injection.h | 13 +++++++++++++
 arch/arm/include/asm/ptrace.h          |  5 +++++
 arch/arm/lib/Makefile                  |  2 ++
 arch/arm/lib/error-inject.c            | 19 +++++++++++++++++++
 5 files changed, 40 insertions(+)
 create mode 100644 arch/arm/include/asm/error-injection.h
 create mode 100644 arch/arm/lib/error-inject.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8869742a85df..f7932a5e29ea 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -74,6 +74,7 @@ config ARM
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
 	select HAVE_EXIT_THREAD
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
+	select HAVE_FUNCTION_ERROR_INJECTION if !THUMB2_KERNEL
 	select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL && !CC_IS_CLANG
 	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
 	select HAVE_GCC_PLUGINS
diff --git a/arch/arm/include/asm/error-injection.h b/arch/arm/include/asm/error-injection.h
new file mode 100644
index 000000000000..da057e8ed224
--- /dev/null
+++ b/arch/arm/include/asm/error-injection.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __ASM_ERROR_INJECTION_H_
+#define __ASM_ERROR_INJECTION_H_
+
+#include <linux/compiler.h>
+#include <linux/linkage.h>
+#include <asm/ptrace.h>
+#include <asm-generic/error-injection.h>
+
+void override_function_with_return(struct pt_regs *regs);
+
+#endif /* __ASM_ERROR_INJECTION_H_ */
diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index 91d6b7856be4..3b41f37b361a 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -89,6 +89,11 @@ static inline long regs_return_value(struct pt_regs *regs)
 	return regs->ARM_r0;
 }
 
+static inline void regs_set_return_value(struct pt_regs *regs, unsigned long rc)
+{
+	regs->ARM_r0 = rc;
+}
+
 #define instruction_pointer(regs)	(regs)->ARM_pc
 
 #ifdef CONFIG_THUMB2_KERNEL
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 0bff0176db2c..d3d7430ecd76 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -43,3 +43,5 @@ ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
   CFLAGS_xor-neon.o		+= $(NEON_FLAGS)
   obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
 endif
+
+obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
diff --git a/arch/arm/lib/error-inject.c b/arch/arm/lib/error-inject.c
new file mode 100644
index 000000000000..96319d017114
--- /dev/null
+++ b/arch/arm/lib/error-inject.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/error-injection.h>
+#include <linux/kprobes.h>
+
+void override_function_with_return(struct pt_regs *regs)
+{
+	/*
+	 * 'regs' represents the state on entry of a predefined function in
+	 * the kernel/module and which is captured on a kprobe.
+	 *
+	 * 'regs->ARM_lr' contains the the link register for the probed
+	 * function and assign it to 'regs->ARM_pc', so when kprobe returns
+	 * back from exception it will override the end of probed function
+	 * and drirectly return to the predefined function's caller.
+	 */
+	regs->ARM_pc = regs->ARM_lr;
+}
+NOKPROBE_SYMBOL(override_function_with_return);
-- 
2.17.1

