Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96881C76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 05:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B04A21783
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 05:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563428635;
	bh=d2K631q1iz4c8zbaSDa5ag8ChRtWqT8DbZvzcJhGp9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hkPc3vjoIH0hEck/coKBGVXw6GZYxXGlNW1/LTA709xcwyX8BXDMklJWkH1DMc8dq
	 aSZjn9PJmALSpSudC7T5NNN6Nwh4/jLOcfKzn8S3l0cfVazQQfUsHng+jfuueDqyoK
	 kfHQ7CAWrHt+BJMboeFKNN/fIef6DTs4LKQICNQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388105AbfGRFny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 01:43:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfGRFnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 01:43:53 -0400
Received: from localhost.localdomain (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5764E2077C;
        Thu, 18 Jul 2019 05:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563428632;
        bh=d2K631q1iz4c8zbaSDa5ag8ChRtWqT8DbZvzcJhGp9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zAerCXhB3BOgWOMlogRoU/hyPegSHhCygHLwo1kd6iwx1RqUL4OSgXUe70hayRlW/
         Btbk7skV3VX7dMrUwTPaM+hv7oVOg2uif7pSskATwDKLs8Zwc2Sr0fwKWVH5gz9nTl
         CbcGME2dhJido3v5LLXRHJMKEEUINj8zcij1ti9c=
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
Subject: [PATCH 2/3] arm64: unwind: Prohibit probing on return_address()
Date:   Thu, 18 Jul 2019 14:43:48 +0900
Message-Id: <156342862798.8565.9291111633472675262.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156342860634.8565.14804606041960884732.stgit@devnote2>
References: <156342860634.8565.14804606041960884732.stgit@devnote2>
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
 arch/arm64/kernel/return_address.c |    4 +++-
 arch/arm64/kernel/stacktrace.c     |    3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/return_address.c b/arch/arm64/kernel/return_address.c
index b21cba90f82d..7f8a143268b0 100644
--- a/arch/arm64/kernel/return_address.c
+++ b/arch/arm64/kernel/return_address.c
@@ -8,6 +8,7 @@
 
 #include <linux/export.h>
 #include <linux/ftrace.h>
+#include <linux/kprobes.h>
 
 #include <asm/stack_pointer.h>
 #include <asm/stacktrace.h>
@@ -17,7 +18,7 @@ struct return_address_data {
 	void *addr;
 };
 
-static int save_return_addr(struct stackframe *frame, void *d)
+static nokprobe_inline int save_return_addr(struct stackframe *frame, void *d)
 {
 	struct return_address_data *data = d;
 
@@ -52,3 +53,4 @@ void *return_address(unsigned int level)
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

