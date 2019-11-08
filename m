Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB2DFC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844EA2178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733118AbfKHVe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:34:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:34864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732926AbfKHVew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:34:52 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF9C622475;
        Fri,  8 Nov 2019 21:34:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iTBu6-0007yX-NY; Fri, 08 Nov 2019 16:34:50 -0500
Message-Id: <20191108213450.605293413@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 08 Nov 2019 16:28:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 07/10] ftrace: Add another example of register_ftrace_direct() use case
References: <20191108212834.594904349@goodmis.org>
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


