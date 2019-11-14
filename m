Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71AFC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB70820727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfKNSU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:20:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:35792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727544AbfKNSS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:18:26 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B685B20830;
        Thu, 14 Nov 2019 18:18:25 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iVJhI-00012j-Vp; Thu, 14 Nov 2019 13:18:24 -0500
Message-Id: <20191114181824.863984836@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Nov 2019 13:17:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 10/33] ftrace: Add another example of register_ftrace_direct() use case
References: <20191114181734.067922168@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add another module sample that registers a direct trampoline to a function
via register_ftrace_direct(). Having another module that does this allows to
test the use case of multiple direct callers registered, as more than one
direct caller goes into another path, and is needed to perform proper
testing of the register_ftrace_direct() call.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 samples/ftrace/Makefile            |  1 +
 samples/ftrace/ftrace-direct-too.c | 51 ++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 samples/ftrace/ftrace-direct-too.c

diff --git a/samples/ftrace/Makefile b/samples/ftrace/Makefile
index 3718ab39eba3..d8217c4e072e 100644
--- a/samples/ftrace/Makefile
+++ b/samples/ftrace/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct.o
+obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-too.o
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
new file mode 100644
index 000000000000..27efa5f6ff52
--- /dev/null
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/module.h>
+
+#include <linux/mm.h> /* for handle_mm_fault() */
+#include <linux/ftrace.h>
+
+void my_direct_func(struct vm_area_struct *vma,
+			unsigned long address, unsigned int flags)
+{
+	trace_printk("handle mm fault vma=%p address=%lx flags=%x\n",
+		     vma, address, flags);
+}
+
+extern void my_tramp(void *);
+
+asm (
+"	.pushsection    .text, \"ax\", @progbits\n"
+"   my_tramp:"
+"	pushq %rbp\n"
+"	movq %rsp, %rbp\n"
+"	pushq %rdi\n"
+"	pushq %rsi\n"
+"	pushq %rdx\n"
+"	call my_direct_func\n"
+"	popq %rdx\n"
+"	popq %rsi\n"
+"	popq %rdi\n"
+"	leave\n"
+"	ret\n"
+"	.popsection\n"
+);
+
+
+static int __init ftrace_direct_init(void)
+{
+	return register_ftrace_direct((unsigned long)handle_mm_fault,
+				     (unsigned long)my_tramp);
+}
+
+static void __exit ftrace_direct_exit(void)
+{
+	unregister_ftrace_direct((unsigned long)handle_mm_fault,
+				 (unsigned long)my_tramp);
+}
+
+module_init(ftrace_direct_init);
+module_exit(ftrace_direct_exit);
+
+MODULE_AUTHOR("Steven Rostedt");
+MODULE_DESCRIPTION("Another example use case of using register_ftrace_direct()");
+MODULE_LICENSE("GPL");
-- 
2.23.0


