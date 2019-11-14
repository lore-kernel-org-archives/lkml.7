Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A3BC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7617420727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfKNTrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 14:47:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:32894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbfKNTrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 14:47:41 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A7CB20724;
        Thu, 14 Nov 2019 19:47:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iVL5f-0001wn-6Z; Thu, 14 Nov 2019 14:47:39 -0500
Message-Id: <20191114194739.082627934@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Nov 2019 14:46:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [RFC][PATCH 2/2] ftrace/samples: Add a sample module that implements
 modify_ftrace_direct()
References: <20191114194636.811109457@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Add a sample module that tests modify_ftrace_direct(), and this can be used
by the selftests as well.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 samples/ftrace/Makefile               |  1 +
 samples/ftrace/ftrace-direct-modify.c | 88 +++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)
 create mode 100644 samples/ftrace/ftrace-direct-modify.c

diff --git a/samples/ftrace/Makefile b/samples/ftrace/Makefile
index d8217c4e072e..fb0c3ae18295 100644
--- a/samples/ftrace/Makefile
+++ b/samples/ftrace/Makefile
@@ -2,3 +2,4 @@
 
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct.o
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-too.o
+obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-modify.o
diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
new file mode 100644
index 000000000000..e04229d21475
--- /dev/null
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/module.h>
+#include <linux/kthread.h>
+#include <linux/ftrace.h>
+
+void my_direct_func1(void)
+{
+	trace_printk("my direct func1\n");
+}
+
+void my_direct_func2(void)
+{
+	trace_printk("my direct func2\n");
+}
+
+extern void my_tramp1(void *);
+extern void my_tramp2(void *);
+
+static unsigned long my_ip = (unsigned long)schedule;
+
+asm (
+"	.pushsection    .text, \"ax\", @progbits\n"
+"   my_tramp1:"
+"	pushq %rbp\n"
+"	movq %rsp, %rbp\n"
+"	call my_direct_func1\n"
+"	leave\n"
+"	ret\n"
+"   my_tramp2:"
+"	pushq %rbp\n"
+"	movq %rsp, %rbp\n"
+"	call my_direct_func2\n"
+"	leave\n"
+"	ret\n"
+"	.popsection\n"
+);
+
+static unsigned long my_tramp = (unsigned long)my_tramp1;
+static unsigned long tramps[2] = {
+	(unsigned long)my_tramp1,
+	(unsigned long)my_tramp2,
+};
+
+static int simple_thread(void *arg)
+{
+	static int t;
+	int ret = 0;
+
+	while (!kthread_should_stop()) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(2 * HZ);
+
+		if (ret)
+			continue;
+		t ^= 1;
+		ret = modify_ftrace_direct(my_ip, my_tramp, tramps[t]);
+		if (!ret)
+			my_tramp = tramps[t];
+		WARN_ON_ONCE(ret);
+	}
+
+	return 0;
+}
+
+static struct task_struct *simple_tsk;
+
+static int __init ftrace_direct_init(void)
+{
+	int ret;
+
+	ret = register_ftrace_direct(my_ip, my_tramp);
+	if (!ret)
+		simple_tsk = kthread_run(simple_thread, NULL, "event-sample-fn");
+	return ret;
+}
+
+static void __exit ftrace_direct_exit(void)
+{
+	kthread_stop(simple_tsk);
+	unregister_ftrace_direct(my_ip, my_tramp);
+}
+
+module_init(ftrace_direct_init);
+module_exit(ftrace_direct_exit);
+
+MODULE_AUTHOR("Steven Rostedt");
+MODULE_DESCRIPTION("Example use case of using modify_ftrace_direct()");
+MODULE_LICENSE("GPL");
-- 
2.23.0


