Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891FAC76195
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627602229C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563781734;
	bh=d2K631q1iz4c8zbaSDa5ag8ChRtWqT8DbZvzcJhGp9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d2c6TBLwPeDug4iuyuHFZHOUJXlKOJasjvvs4q4rYLJaHTF2x4keNwZPn2W6uOyBD
	 ZVj9TC8rVrUvXRc8Wn/9NmD9WEwmjeF/KLyuCObiS8e9zlU8SzgUJN/W5QubwEcMnK
	 VmfxezC0rQkhZW7+m81JWX58JDSmQRs5/k2mIob8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfGVHsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 03:48:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:32962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbfGVHsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 03:48:52 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37CEA2199C;
        Mon, 22 Jul 2019 07:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563781732;
        bh=d2K631q1iz4c8zbaSDa5ag8ChRtWqT8DbZvzcJhGp9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w81PoW6MwyECbd2TTy5PRj1Ackc3EGzTbwwzyZ4/qk5SvwfWbiAnsaPPjJrmXgY1u
         jhbfidnmkbwNquWIPG6/GTz7+fjsxSOVmWZ+3F4k92Ou80g5P3DL+UdSvMgCYqYtLc
         1OlgcNAAxqm5a5q8K5U6Wn2+W0xjC4x0HpsBDDoo=
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
Subject: [PATCH v2 2/4] arm64: unwind: Prohibit probing on return_address()
Date:   Mon, 22 Jul 2019 16:48:48 +0900
Message-Id: <156378172702.12011.1144595747474511323.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156378170297.12011.17385386326930403235.stgit@devnote2>
References: <156378170297.12011.17385386326930403235.stgit@devnote2>
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

