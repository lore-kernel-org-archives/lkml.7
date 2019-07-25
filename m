Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B30EC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 08:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B85222BEF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 08:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564042572;
	bh=lpvJdO31en1wcj0t6J2VjwvDEWvWEgYER3oV5jINp3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vTCM+yQJ23CC98VdVObTx/VIAF0Sc4z9aGyfsex99zSEtZKou5ZBjrlWr8bX4SjKi
	 Uf/uVxJYOy3+H+kozj5WGkagMhJWLqE2TmdC3/hwzJyAor/5dNHC3kP/2a/k8Ll0DC
	 XIPWII3+PRDLeoYqgh541bAG3285FPpchp9Edl3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389339AbfGYIQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 04:16:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389263AbfGYIQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 04:16:10 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EE7E22CB8;
        Thu, 25 Jul 2019 08:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564042569;
        bh=lpvJdO31en1wcj0t6J2VjwvDEWvWEgYER3oV5jINp3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yCBi3i5GNbP+BcE7uzuOnYI8PH4hvoK5Lt/RiP2fH/9Deft2CUfD/wr6auPp71Z1i
         h1CxJs+S620wwqO1qPW3WJnCdi5LsmUJdPlB8dG7e76rgNhdplMD0xTPuwbK1JuvaL
         dADXYfUpDnu80TGFFkfpwas36rIkqVTBS6sFk/XQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     mhiramat@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Dan Rue <dan.rue@linaro.org>,
        Matt Hart <matthew.hart@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel Diaz <daniel.diaz@linaro.org>
Subject: [PATCH v3 2/4] arm64: unwind: Prohibit probing on return_address()
Date:   Thu, 25 Jul 2019 17:16:05 +0900
Message-Id: <156404256479.2020.11810441013424601533.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156404254387.2020.886452004489353899.stgit@devnote2>
References: <156404254387.2020.886452004489353899.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prohibit probing on return_address() and subroutines which
is called from return_address(), since the it is invoked from
trace_hardirqs_off() which is also kprobe blacklisted.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v3:
  - Fix to use NOKPROBE_SYMBOL() for save_return_addr instead
    of nokprobe_inline.
---
 arch/arm64/kernel/return_address.c |    3 +++
 arch/arm64/kernel/stacktrace.c     |    3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/kernel/return_address.c b/arch/arm64/kernel/return_address.c
index b21cba90f82d..491184a9f081 100644
--- a/arch/arm64/kernel/return_address.c
+++ b/arch/arm64/kernel/return_address.c
@@ -8,6 +8,7 @@
 
 #include <linux/export.h>
 #include <linux/ftrace.h>
+#include <linux/kprobes.h>
 
 #include <asm/stack_pointer.h>
 #include <asm/stacktrace.h>
@@ -29,6 +30,7 @@ static int save_return_addr(struct stackframe *frame, void *d)
 		return 0;
 	}
 }
+NOKPROBE_SYMBOL(save_return_addr);
 
 void *return_address(unsigned int level)
 {
@@ -52,3 +54,4 @@ void *return_address(unsigned int level)
 		return NULL;
 }
 EXPORT_SYMBOL_GPL(return_address);
+NOKPROBE_SYMBOL(return_address);
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 62d395151abe..cd7dab54d17b 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/ftrace.h>
+#include <linux/kprobes.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
@@ -73,6 +74,7 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 
 	return 0;
 }
+NOKPROBE_SYMBOL(unwind_frame);
 
 void notrace walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
 		     int (*fn)(struct stackframe *, void *), void *data)
@@ -87,6 +89,7 @@ void notrace walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
 			break;
 	}
 }
+NOKPROBE_SYMBOL(walk_stackframe);
 
 #ifdef CONFIG_STACKTRACE
 struct stack_trace_data {

