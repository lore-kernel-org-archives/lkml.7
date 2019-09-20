Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF436C49ED7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 00:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A457217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 00:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WD5tfn6r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407306AbfIUAAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 20:00:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51024 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407171AbfIUAAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 20:00:07 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8KNxbQO059610;
        Fri, 20 Sep 2019 23:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=WSEyCToLvAZXybrHckwblgieckhyIA3k9WbkBsSv2Fk=;
 b=WD5tfn6rtBrGo580LOTBWA27qQ5sntcLzURnnLPsDYH3TODkuO+dVJ9iXnfrOOi19Z9C
 Gqrqiwo9q35+JdRcq5Zr+vlWpQFuX3pJmwewpbQ5veKn0G3JtYdadqbwWSu0uz3Fo4sN
 IPlbR4xg5ywyjyOzmeooIqMsoXAbHUxYoJioxM8z0XxHdlMg4rkjFoDRnaPdXztrdUT/
 SM0ChqfjdmanzE81hByZ1Pw3b1i8B3D45LelxEtwDoanVslqino43rBc0+an117Ofxif
 A5HGwUd7AmhIURNRw8SQmTpEFrhARjTRyHco3QuYo8ob7iUafwfKPK+/7D6ITeYO1DHw Og== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2v3vb4w27d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Sep 2019 23:59:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8KNwivm125942;
        Fri, 20 Sep 2019 23:59:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2v51vr3pwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Sep 2019 23:59:36 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8KNxZOb006441;
        Fri, 20 Sep 2019 23:59:35 GMT
Received: from ca-common-hq.us.oracle.com (/10.211.9.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 20 Sep 2019 16:59:35 -0700
From:   Divya Indi <divya.indi@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Divya Indi <divya.indi@oracle.com>, Joe Jin <joe.jin@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>
Subject: [PATCH] tracing: Sample module to demonstrate kernel access to Ftrace instances.
Date:   Fri, 20 Sep 2019 16:59:26 -0700
Message-Id: <1569023966-23004-2-git-send-email-divya.indi@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1569023966-23004-1-git-send-email-divya.indi@oracle.com>
References: <1569023966-23004-1-git-send-email-divya.indi@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9386 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909200203
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9386 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909200203
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a sample module to demostrate the use of the newly introduced and
exported APIs to access Ftrace instances from within the kernel.

Newly introduced APIs used here -

1. Create a new trace array if it does not exist.
struct trace_array *trace_array_create(const char *name)

2. Destroy/Remove a trace array.
int trace_array_destroy(struct trace_array *tr)

3. Lookup a trace array, given its name.
struct trace_array *trace_array_lookup(const char *name)

4. Enable/Disable trace events:
int trace_array_set_clr_event(struct trace_array *tr, const char *system,
        const char *event, int set);

Exported APIs -
1. trace_printk equivalent for instances.
int trace_array_printk(struct trace_array *tr,
               unsigned long ip, const char *fmt, ...);

2. Helper function.
void trace_printk_init_buffers(void);

3. To decrement the reference counter.
void trace_array_put(struct trace_array *tr)

Signed-off-by: Divya Indi <divya.indi@oracle.com>
Reviewed-by: Manjunath Patil <manjunath.b.patil@oracle.com>
Reviewed-by: Joe Jin <joe.jin@oracle.com>
---
 samples/Kconfig                              |   7 ++
 samples/Makefile                             |   1 +
 samples/ftrace_instance/Makefile             |   6 ++
 samples/ftrace_instance/sample-trace-array.c | 134 +++++++++++++++++++++++++++
 samples/ftrace_instance/sample-trace-array.h |  84 +++++++++++++++++
 5 files changed, 232 insertions(+)
 create mode 100644 samples/ftrace_instance/Makefile
 create mode 100644 samples/ftrace_instance/sample-trace-array.c
 create mode 100644 samples/ftrace_instance/sample-trace-array.h

diff --git a/samples/Kconfig b/samples/Kconfig
index d63cc8a..1c7864b 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -20,6 +20,13 @@ config SAMPLE_TRACE_PRINTK
 	 This builds a module that calls trace_printk() and can be used to
 	 test various trace_printk() calls from a module.
 
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
index debf892..02c444e 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_SAMPLE_RPMSG_CLIENT)	+= rpmsg/
 subdir-$(CONFIG_SAMPLE_SECCOMP)		+= seccomp
 obj-$(CONFIG_SAMPLE_TRACE_EVENTS)	+= trace_events/
 obj-$(CONFIG_SAMPLE_TRACE_PRINTK)	+= trace_printk/
+obj-$(CONFIG_SAMPLE_TRACE_ARRAY)	+= ftrace_instance/
 obj-$(CONFIG_VIDEO_PCI_SKELETON)	+= v4l/
 obj-y					+= vfio-mdev/
 subdir-$(CONFIG_SAMPLE_VFS)		+= vfs
diff --git a/samples/ftrace_instance/Makefile b/samples/ftrace_instance/Makefile
new file mode 100644
index 0000000..3603b13
--- /dev/null
+++ b/samples/ftrace_instance/Makefile
@@ -0,0 +1,6 @@
+# Builds a module that calls various routines to access Ftrace instances.
+# To use(as root):  insmod sample-trace-array.ko
+
+CFLAGS_sample-trace-array.o := -I$(src)
+
+obj-$(CONFIG_SAMPLE_TRACE_ARRAY) += sample-trace-array.o
diff --git a/samples/ftrace_instance/sample-trace-array.c b/samples/ftrace_instance/sample-trace-array.c
new file mode 100644
index 0000000..0595bc7
--- /dev/null
+++ b/samples/ftrace_instance/sample-trace-array.c
@@ -0,0 +1,134 @@
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
+	trace_array_set_clr_event(tr, "sample-subsystem", "sample_event", 0);
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
+	trace_array_set_clr_event(tr, "sample-subsystem", "sample_event", 1);
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
+	 * If a trace array with name "sample-instance" already exists, get a
+	 * handle to it via trace_array_lookup. Else, create one using
+	 * trace_array_create().
+	 *
+	 * NOTE: Both these functions increment the reference counter
+	 * associated with the trace array - "tr".
+	 */
+	tr = trace_array_lookup("sample-instance");
+	if (!tr)
+		tr = trace_array_create("sample-instance");
+
+	if (IS_ERR(tr))
+		return PTR_ERR(tr);
+
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
diff --git a/samples/ftrace_instance/sample-trace-array.h b/samples/ftrace_instance/sample-trace-array.h
new file mode 100644
index 0000000..547ad56
--- /dev/null
+++ b/samples/ftrace_instance/sample-trace-array.h
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
+		__field(	int,	count			)
+		__field(	unsigned long,	time		)
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
1.8.3.1

