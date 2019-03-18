Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68353C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C532085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552895948;
	bh=673SMqkAlXA8cblGV2cyAlD79kgMIFkPnnhL+OUh9L8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Z4sYgR36VgNAz7A+saSTxA8WClAYdM9cyzgadK8WtZA1wvnoG0ItGZwnOaaEIkPMC
	 HG65oaI6ei7vD6MVROXbNuU/Ax9yCd4VFuWVKKcgZXEYeQsIvCk+mcj6Uuj9ZUvkDK
	 SqFaP3LiQlre6roFpLxv8x1ZrxSmykKgdyXfC7pk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfCRH7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 03:59:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbfCRH7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 03:59:06 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8669B20835;
        Mon, 18 Mar 2019 07:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552895945;
        bh=673SMqkAlXA8cblGV2cyAlD79kgMIFkPnnhL+OUh9L8=;
        h=From:To:Cc:Subject:Date:From;
        b=lsBGQbEDhW3pXZVrhWEEE2thxVdaCWqiX1o+Eno5RlYa/YPmlTf9gVIDDH0dWi3D+
         U3rBHsNjm/hpFoYA8PNjfZlBNRrXwbwa2eBIPnY1uO0gq71TowJw/MqRPq16fSCRpn
         w/424whUBcCviOPpYxVDUi3AGNEcAzIIOrktCP5c=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: ptrace: Add function argument access API
Date:   Mon, 18 Mar 2019 16:59:02 +0900
Message-Id: <155289594227.10570.1879705446198840331.stgit@devnote2>
X-Mailer: git-send-email 2.17.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regs_get_argument() which returns N th argument of the function
call. On arm64, it supports up to 8th argument.
Note that this chooses most probably assignment, in some case
it can be incorrect (e.g. passing data structure or floating
point etc.)

This enables ftrace kprobe events to access kernel function
arguments via $argN syntax.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arm64/Kconfig              |    1 +
 arch/arm64/include/asm/ptrace.h |   18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 117b2541ef3d..6ba0da4be73c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -148,6 +148,7 @@ config ARM64
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
+	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_RCU_TABLE_FREE
 	select HAVE_RCU_TABLE_INVALIDATE
 	select HAVE_RSEQ
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index ec60174c8c18..cfa1bc9b8b70 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -305,6 +305,24 @@ static inline unsigned long regs_return_value(struct pt_regs *regs)
 	return regs->regs[0];
 }
 
+/**
+ * regs_get_kernel_argument() - get Nth function argument in kernel
+ * @regs:	pt_regs of that context
+ * @n:		function argument number (start from 0)
+ *
+ * regs_get_argument() returns @n th argument of the function call.
+ * Note that this chooses most probably assignment, in some case
+ * it can be incorrect.
+ */
+static inline unsigned long regs_get_kernel_argument(struct pt_regs *regs,
+						     unsigned int n)
+{
+#define NR_REG_ARGUMENTS 8
+	if (n < NR_REG_ARGUMENTS)
+		return regs_get_register(regs, n << 3);
+	return 0;
+}
+
 /* We must avoid circular header include via sched.h */
 struct task_struct;
 int valid_user_regs(struct user_pt_regs *regs, struct task_struct *task);

