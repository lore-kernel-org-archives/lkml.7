Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA337C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 18:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23362071B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 18:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKWSMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 13:12:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:40250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbfKWSMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 13:12:44 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C821F20726;
        Sat, 23 Nov 2019 18:12:42 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.3)
        (envelope-from <rostedt@goodmis.org>)
        id 1iYZth-000F0l-Uh; Sat, 23 Nov 2019 13:12:41 -0500
Message-Id: <20191123181241.826480096@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 23 Nov 2019 13:12:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
        Divya Indi <divya.indi@oracle.com>
Subject: [for-next][PATCH 08/10] tracing: Sample module to demonstrate kernel access to Ftrace
 instances.
References: <20191123181157.851427201@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Divya Indi <divya.indi@oracle.com>

This is a sample module to demonstrate the use of the newly introduced and
exported APIs to access Ftrace instances from within the kernel.

Newly introduced APIs used here -

1. Create/Lookup a trace array with the given name.
struct trace_array *trace_array_get_by_name(const char *name)

2. Destroy/Remove a trace array.
int trace_array_destroy(struct trace_array *tr)

4. Enable/Disable trace events:
int trace_array_set_clr_event(struct trace_array *tr, const char *system,
        const char *event, bool enable);

Exported APIs -
1. trace_printk equivalent for instances.
int trace_array_printk(struct trace_array *tr,
               unsigned long ip, const char *fmt, ...);

2. Helper function.
void trace_printk_init_buffers(void);

3. To decrement the reference counter.
void trace_array_put(struct trace_array *tr)

Sample output(contents of /sys/kernel/tracing/instances/sample-instance)
NOTE: Tracing disabled after ~5 sec)

                              _-----=> irqs-off
                             / _----=> need-resched
                            | / _---=> hardirq/softirq
                            || / _--=> preempt-depth
                            ||| /     delay
           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
              | |       |   ||||       |         |
sample-instance-1452  [002] ....    49.430948: simple_thread: trace_array_printk: count=0
sample-instance-1452  [002] ....    49.430951: sample_event: count value=0 at jiffies=4294716608
sample-instance-1452  [002] ....    50.454847: simple_thread: trace_array_printk: count=1
sample-instance-1452  [002] ....    50.454849: sample_event: count value=1 at jiffies=4294717632
sample-instance-1452  [002] ....    51.478748: simple_thread: trace_array_printk: count=2
sample-instance-1452  [002] ....    51.478750: sample_event: count value=2 at jiffies=4294718656
sample-instance-1452  [002] ....    52.502652: simple_thread: trace_array_printk: count=3
sample-instance-1452  [002] ....    52.502655: sample_event: count value=3 at jiffies=4294719680
sample-instance-1452  [002] ....    53.526533: simple_thread: trace_array_printk: count=4
sample-instance-1452  [002] ....    53.526535: sample_event: count value=4 at jiffies=4294720704
sample-instance-1452  [002] ....    54.550438: simple_thread: trace_array_printk: count=5
sample-instance-1452  [002] ....    55.574336: simple_thread: trace_array_printk: count=6

Link: http://lkml.kernel.org/r/1574276919-11119-3-git-send-email-divya.indi@oracle.com

Reviewed-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Signed-off-by: Divya Indi <divya.indi@oracle.com>
[ Moved to samples/ftrace ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 samples/Kconfig                     |   7 ++
 samples/Makefile                    |   1 +
 samples/ftrace/Makefile             |   3 +
 samples/ftrace/sample-trace-array.c | 131 ++++++++++++++++++++++++++++
 samples/ftrace/sample-trace-array.h |  84 ++++++++++++++++++
 5 files changed, 226 insertions(+)
 create mode 100644 samples/ftrace/sample-trace-array.c
 create mode 100644 samples/ftrace/sample-trace-array.h

diff --git a/samples/Kconfig b/samples/Kconfig
index 65b5967dac0c..ad64b223f3d0 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -27,6 +27,13 @@ config SAMPLE_FTRACE_DIRECT
 	  This builds an ftrace direct function example
 	  that hooks to wake_up_process and prints the parameters.
 
+config SAMPLE_TRACE_ARRAY
+        tristate "Build sample module for kernel access to Ftrace instancess"
+	depends on EVENT_TRACING && m
+	help
+	 This builds a module that demonstrates the use of various APIs to
+	 access Ftrace instances from within the kernel.
+
 config SAMPLE_KOBJECT
 	tristate "Build kobject examples"
 	help
diff --git a/samples/Makefile b/samples/Makefile
index cd496d633370..297f8934773f 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -18,6 +18,7 @@ subdir-$(CONFIG_SAMPLE_SECCOMP)		+= seccomp
 obj-$(CONFIG_SAMPLE_TRACE_EVENTS)	+= trace_events/
 obj-$(CONFIG_SAMPLE_TRACE_PRINTK)	+= trace_printk/
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT)	+= ftrace/
+obj-$(CONFIG_SAMPLE_TRACE_ARRAY)	+= ftrace/
 obj-$(CONFIG_VIDEO_PCI_SKELETON)	+= v4l/
 obj-y					+= vfio-mdev/
 subdir-$(CONFIG_SAMPLE_VFS)		+= vfs
diff --git a/samples/ftrace/Makefile b/samples/ftrace/Makefile
index fb0c3ae18295..4ce896e10b2e 100644
--- a/samples/ftrace/Makefile
+++ b/samples/ftrace/Makefile
@@ -3,3 +3,6 @@
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct.o
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-too.o
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-modify.o
+
+CFLAGS_sample-trace-array.o := -I$(src)
+obj-$(CONFIG_SAMPLE_TRACE_ARRAY) += sample-trace-array.o
diff --git a/samples/ftrace/sample-trace-array.c b/samples/ftrace/sample-trace-array.c
new file mode 100644
index 000000000000..d523450d73eb
--- /dev/null
+++ b/samples/ftrace/sample-trace-array.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/module.h>
+#include <linux/kthread.h>
+#include <linux/trace.h>
+#include <linux/trace_events.h>
+#include <linux/timer.h>
+#include <linux/err.h>
+#include <linux/jiffies.h>
+
+/*
+ * Any file that uses trace points, must include the header.
+ * But only one file, must include the header by defining
+ * CREATE_TRACE_POINTS first.  This will make the C code that
+ * creates the handles for the trace points.
+ */
+#define CREATE_TRACE_POINTS
+#include "sample-trace-array.h"
+
+struct trace_array *tr;
+static void mytimer_handler(struct timer_list *unused);
+static struct task_struct *simple_tsk;
+
+/*
+ * mytimer: Timer setup to disable tracing for event "sample_event". This
+ * timer is only for the purposes of the sample module to demonstrate access of
+ * Ftrace instances from within kernel.
+ */
+static DEFINE_TIMER(mytimer, mytimer_handler);
+
+static void mytimer_handler(struct timer_list *unused)
+{
+	/*
+	 * Disable tracing for event "sample_event".
+	 */
+	trace_array_set_clr_event(tr, "sample-subsystem", "sample_event",
+			false);
+}
+
+static void simple_thread_func(int count)
+{
+	set_current_state(TASK_INTERRUPTIBLE);
+	schedule_timeout(HZ);
+
+	/*
+	 * Printing count value using trace_array_printk() - trace_printk()
+	 * equivalent for the instance buffers.
+	 */
+	trace_array_printk(tr, _THIS_IP_, "trace_array_printk: count=%d\n",
+			count);
+	/*
+	 * Tracepoint for event "sample_event". This will print the
+	 * current value of count and current jiffies.
+	 */
+	trace_sample_event(count, jiffies);
+}
+
+static int simple_thread(void *arg)
+{
+	int count = 0;
+	unsigned long delay = msecs_to_jiffies(5000);
+
+	/*
+	 * Enable tracing for "sample_event".
+	 */
+	trace_array_set_clr_event(tr, "sample-subsystem", "sample_event", true);
+
+	/*
+	 * Adding timer - mytimer. This timer will disable tracing after
+	 * delay seconds.
+	 *
+	 */
+	add_timer(&mytimer);
+	mod_timer(&mytimer, jiffies+delay);
+
+	while (!kthread_should_stop())
+		simple_thread_func(count++);
+
+	del_timer(&mytimer);
+
+	/*
+	 * trace_array_put() decrements the reference counter associated with
+	 * the trace array - "tr". We are done using the trace array, hence
+	 * decrement the reference counter so that it can be destroyed using
+	 * trace_array_destroy().
+	 */
+	trace_array_put(tr);
+
+	return 0;
+}
+
+static int __init sample_trace_array_init(void)
+{
+	/*
+	 * Return a pointer to the trace array with name "sample-instance" if it
+	 * exists, else create a new trace array.
+	 *
+	 * NOTE: This function increments the reference counter
+	 * associated with the trace array - "tr".
+	 */
+	tr = trace_array_get_by_name("sample-instance");
+
+	if (!tr)
+		return -1;
+	/*
+	 * If context specific per-cpu buffers havent already been allocated.
+	 */
+	trace_printk_init_buffers();
+
+	simple_tsk = kthread_run(simple_thread, NULL, "sample-instance");
+	if (IS_ERR(simple_tsk))
+		return -1;
+	return 0;
+}
+
+static void __exit sample_trace_array_exit(void)
+{
+	kthread_stop(simple_tsk);
+
+	/*
+	 * We are unloading our module and no longer require the trace array.
+	 * Remove/destroy "tr" using trace_array_destroy()
+	 */
+	trace_array_destroy(tr);
+}
+
+module_init(sample_trace_array_init);
+module_exit(sample_trace_array_exit);
+
+MODULE_AUTHOR("Divya Indi");
+MODULE_DESCRIPTION("Sample module for kernel access to Ftrace instances");
+MODULE_LICENSE("GPL");
diff --git a/samples/ftrace/sample-trace-array.h b/samples/ftrace/sample-trace-array.h
new file mode 100644
index 000000000000..6f8962428158
--- /dev/null
+++ b/samples/ftrace/sample-trace-array.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * If TRACE_SYSTEM is defined, that will be the directory created
+ * in the ftrace directory under /sys/kernel/tracing/events/<system>
+ *
+ * The define_trace.h below will also look for a file name of
+ * TRACE_SYSTEM.h where TRACE_SYSTEM is what is defined here.
+ * In this case, it would look for sample-trace.h
+ *
+ * If the header name will be different than the system name
+ * (as in this case), then you can override the header name that
+ * define_trace.h will look up by defining TRACE_INCLUDE_FILE
+ *
+ * This file is called sample-trace-array.h but we want the system
+ * to be called "sample-subsystem". Therefore we must define the name of this
+ * file:
+ *
+ * #define TRACE_INCLUDE_FILE sample-trace-array
+ *
+ * As we do in the bottom of this file.
+ *
+ * Notice that TRACE_SYSTEM should be defined outside of #if
+ * protection, just like TRACE_INCLUDE_FILE.
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM sample-subsystem
+
+/*
+ * TRACE_SYSTEM is expected to be a C valid variable (alpha-numeric
+ * and underscore), although it may start with numbers. If for some
+ * reason it is not, you need to add the following lines:
+ */
+#undef TRACE_SYSTEM_VAR
+#define TRACE_SYSTEM_VAR sample_subsystem
+
+/*
+ * But the above is only needed if TRACE_SYSTEM is not alpha-numeric
+ * and underscored. By default, TRACE_SYSTEM_VAR will be equal to
+ * TRACE_SYSTEM. As TRACE_SYSTEM_VAR must be alpha-numeric, if
+ * TRACE_SYSTEM is not, then TRACE_SYSTEM_VAR must be defined with
+ * only alpha-numeric and underscores.
+ *
+ * The TRACE_SYSTEM_VAR is only used internally and not visible to
+ * user space.
+ */
+
+/*
+ * Notice that this file is not protected like a normal header.
+ * We also must allow for rereading of this file. The
+ *
+ *  || defined(TRACE_HEADER_MULTI_READ)
+ *
+ * serves this purpose.
+ */
+#if !defined(_SAMPLE_TRACE_ARRAY_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _SAMPLE_TRACE_ARRAY_H
+
+#include <linux/tracepoint.h>
+TRACE_EVENT(sample_event,
+
+	TP_PROTO(int count, unsigned long time),
+
+	TP_ARGS(count, time),
+
+	TP_STRUCT__entry(
+		__field(int, count)
+		__field(unsigned long, time)
+	),
+
+	TP_fast_assign(
+		__entry->count = count;
+		__entry->time = time;
+	),
+
+	TP_printk("count value=%d at jiffies=%lu", __entry->count,
+		__entry->time)
+	);
+#endif
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE sample-trace-array
+#include <trace/define_trace.h>
-- 
2.24.0


