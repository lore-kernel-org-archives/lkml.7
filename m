Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6428AC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F6B20727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfKNSUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:20:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:35744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727540AbfKNSS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:18:26 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75E43207DD;
        Thu, 14 Nov 2019 18:18:25 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iVJhI-00011l-Mb; Thu, 14 Nov 2019 13:18:24 -0500
Message-Id: <20191114181824.581104664@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Nov 2019 13:17:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 08/33] ftrace: Add sample module that uses register_ftrace_direct()
References: <20191114181734.067922168@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add a sample module that shows a simple use case for
regsiter_ftrace_direct(), and how to use it.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 samples/Kconfig                |  8 ++++++
 samples/Makefile               |  1 +
 samples/ftrace/Makefile        |  3 +++
 samples/ftrace/ftrace-direct.c | 45 ++++++++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+)
 create mode 100644 samples/ftrace/Makefile
 create mode 100644 samples/ftrace/ftrace-direct.c

diff --git a/samples/Kconfig b/samples/Kconfig
index c8dacb4dda80..65b5967dac0c 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -19,6 +19,14 @@ config SAMPLE_TRACE_PRINTK
 	 This builds a module that calls trace_printk() and can be used to
 	 test various trace_printk() calls from a module.
 
+config SAMPLE_FTRACE_DIRECT
+	tristate "Build register_ftrace_direct() example"
+	depends on DYNAMIC_FTRACE_WITH_DIRECT_CALLS && m
+	depends on X86_64 # has x86_64 inlined asm
+	help
+	  This builds an ftrace direct function example
+	  that hooks to wake_up_process and prints the parameters.
+
 config SAMPLE_KOBJECT
 	tristate "Build kobject examples"
 	help
diff --git a/samples/Makefile b/samples/Makefile
index 7d6e4ca28d69..cd496d633370 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_SAMPLE_RPMSG_CLIENT)	+= rpmsg/
 subdir-$(CONFIG_SAMPLE_SECCOMP)		+= seccomp
 obj-$(CONFIG_SAMPLE_TRACE_EVENTS)	+= trace_events/
 obj-$(CONFIG_SAMPLE_TRACE_PRINTK)	+= trace_printk/
+obj-$(CONFIG_SAMPLE_FTRACE_DIRECT)	+= ftrace/
 obj-$(CONFIG_VIDEO_PCI_SKELETON)	+= v4l/
 obj-y					+= vfio-mdev/
 subdir-$(CONFIG_SAMPLE_VFS)		+= vfs
diff --git a/samples/ftrace/Makefile b/samples/ftrace/Makefile
new file mode 100644
index 000000000000..3718ab39eba3
--- /dev/null
+++ b/samples/ftrace/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct.o
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
new file mode 100644
index 000000000000..1483f067b000
--- /dev/null
+++ b/samples/ftrace/ftrace-direct.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/module.h>
+
+#include <linux/sched.h> /* for wake_up_process() */
+#include <linux/ftrace.h>
+
+void my_direct_func(struct task_struct *p)
+{
+	trace_printk("wakeing up %s-%d\n", p->comm, p->pid);
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
+"	call my_direct_func\n"
+"	popq %rdi\n"
+"	leave\n"
+"	ret\n"
+"	.popsection\n"
+);
+
+
+static int __init ftrace_direct_init(void)
+{
+	return register_ftrace_direct((unsigned long)wake_up_process,
+				     (unsigned long)my_tramp);
+}
+
+static void __exit ftrace_direct_exit(void)
+{
+	unregister_ftrace_direct((unsigned long)wake_up_process,
+				 (unsigned long)my_tramp);
+}
+
+module_init(ftrace_direct_init);
+module_exit(ftrace_direct_exit);
+
+MODULE_AUTHOR("Steven Rostedt");
+MODULE_DESCRIPTION("Example use case of using register_ftrace_direct()");
+MODULE_LICENSE("GPL");
-- 
2.23.0


