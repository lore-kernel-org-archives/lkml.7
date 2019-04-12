Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360C0C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041B520850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555078938;
	bh=mi+DUCtbq6rqfEJEbag8BIlmPlnfRJ9C7A7zk90Khk0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=t6yTx8aj1fApZhJNIZzNjyg/429hxP6nDAFoecvUsZp6bLxrYIr/r9laMr+WFhEKW
	 P+GTTLvtoD31YYjGMxabXaqd0yNbmLA/qEzAuVfr8eKj96qdn6v2h1PXAYYH4MHPq9
	 hyz3BPyyXfjcQUDeV+2vAz4K0QO/DOTuBumgWiRg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfDLOWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:22:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfDLOWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:22:16 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A96720818;
        Fri, 12 Apr 2019 14:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555078935;
        bh=mi+DUCtbq6rqfEJEbag8BIlmPlnfRJ9C7A7zk90Khk0=;
        h=From:To:Cc:Subject:Date:From;
        b=PY366o9/zzcJs1ULv8vt780nLvoF18zBPy+DJeDBAqZxhrUJTgS3mSHLmEibQh82s
         3XdegsOJXmdF3a+/MdHoPzO01ht5Ed1dZtwM8Jk5KdLeXm/yS3WVmEAwMl3wKphksc
         t9jmnGoUvGoDwGzQXpFYIisLdkNiHO1CjofeOkf4=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: ptrace: Add function argument access API
Date:   Fri, 12 Apr 2019 23:22:01 +0900
Message-Id: <155507892154.27222.12993546518496163452.stgit@devnote2>
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
  Changes in v2:
   - Use pt_regs_read_reg()
   - Update comment for the incorrect corner case.
---
 arch/arm64/Kconfig              |    1 +
 arch/arm64/include/asm/ptrace.h |   22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7e34b9eba5de..dad972cb8b65 100644
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
index ec60174c8c18..2038dca1e2c2 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -305,6 +305,28 @@ static inline unsigned long regs_return_value(struct pt_regs *regs)
 	return regs->regs[0];
 }
 
+/**
+ * regs_get_kernel_argument() - get Nth function argument in kernel
+ * @regs:	pt_regs of that context
+ * @n:		function argument number (start from 0)
+ *
+ * regs_get_argument() returns @n th argument of the function call.
+ *
+ * Note that this chooses most probably assignment. In very rare case
+ * this may not return correct data, for example, one of the function
+ * parameter is 16bytes (128bits) or bigger. In such case, we can not
+ * get that big parameter correctly, but also register assignment of
+ * parameters after that will be shifted.
+ */
+static inline unsigned long regs_get_kernel_argument(struct pt_regs *regs,
+						     unsigned int n)
+{
+#define NR_REG_ARGUMENTS 8
+	if (n < NR_REG_ARGUMENTS)
+		return pt_regs_read_reg(regs, n);
+	return 0;
+}
+
 /* We must avoid circular header include via sched.h */
 struct task_struct;
 int valid_user_regs(struct user_pt_regs *regs, struct task_struct *task);

