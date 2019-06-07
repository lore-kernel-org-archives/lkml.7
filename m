Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C0BC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C6920840
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbfFGQY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 12:24:28 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50581 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730446AbfFGQY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 12:24:26 -0400
Received: from [5.158.153.52] (helo=noscherz.tec.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hZHes-0000ei-BJ; Fri, 07 Jun 2019 18:24:02 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [RFC PATCH v2 2/2] printk-rb: add test module
Date:   Fri,  7 Jun 2019 18:29:49 +0206
Message-Id: <20190607162349.18199-3-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190607162349.18199-1-john.ogness@linutronix.de>
References: <20190607162349.18199-1-john.ogness@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This module does some heavy write stress testing on the ringbuffer
with a reader that is checking for integrity.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 lib/Makefile   |   2 +
 lib/test_prb.c | 237 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 239 insertions(+)
 create mode 100644 lib/test_prb.c

diff --git a/lib/Makefile b/lib/Makefile
index fb7697031a79..9a485274b6ba 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -292,3 +292,5 @@ obj-$(CONFIG_GENERIC_LIB_MULDI3) += muldi3.o
 obj-$(CONFIG_GENERIC_LIB_CMPDI2) += cmpdi2.o
 obj-$(CONFIG_GENERIC_LIB_UCMPDI2) += ucmpdi2.o
 obj-$(CONFIG_OBJAGG) += objagg.o
+
+obj-m += test_prb.o
diff --git a/lib/test_prb.c b/lib/test_prb.c
new file mode 100644
index 000000000000..2c365028f4e4
--- /dev/null
+++ b/lib/test_prb.c
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kthread.h>
+#include <linux/delay.h>
+#include <linux/random.h>
+#include <linux/slab.h>
+#include <linux/printk_ringbuffer.h>
+
+/*
+ * This is a test module that starts "num_online_cpus() - 1" writer threads
+ * and 1 reader thread. The writer threads each write strings of varying
+ * length. They do this as fast as they can.
+ *
+ * The reader thread reads as fast as it can and performs sanity checks on
+ * the data.
+ *
+ * Because the threads are running in such tight loops, they will call
+ * schedule() from time to time so the system stays alive.
+ *
+ * If either the writers or the reader encounter an error, the test is
+ * aborted. Test results are recorded to the ftrace buffers. The test can
+ * be aborted manually by removing the module. (Ideally the test should
+ * never abort on its own.)
+ */
+
+struct rbdata {
+	int len;
+	char text[0];
+};
+
+static char *test_running;
+static int halt_test;
+
+static void dump_rb(struct printk_ringbuffer *rb)
+{
+	DECLARE_PRINTKRB_ENTRY(entry, 140);
+	DECLARE_PRINTKRB_ITER(iter, rb, &entry);
+	struct rbdata *dat;
+	u64 last_seq = 0;
+	int len;
+
+	trace_printk("BEGIN full dump\n");
+
+	prb_for_each_entry(&iter, len) {
+		if (entry.seq - last_seq != 1) {
+			trace_printk("LOST %llu\n",
+				     entry.seq - (last_seq + 1));
+		}
+		last_seq = entry.seq;
+
+		dat = (struct rbdata *)&entry.buffer[0];
+
+		trace_printk("seq=%llu len=%d textlen=%d dataval=%s\n",
+			     entry.seq, len, dat->len, dat->text);
+	}
+
+	trace_printk("END full dump\n");
+}
+
+DECLARE_PRINTKRB(test_rb, 7, 5);
+
+static int prbtest_writer(void *data)
+{
+	unsigned long num = (unsigned long)data;
+	struct prb_reserved_entry e;
+	char id = 'A' + num;
+	struct rbdata *dat;
+	int count = 0;
+	int len;
+
+	pr_err("prbtest: start thread %lu (writer)\n", num);
+
+	for (;;) {
+		len = sizeof(struct rbdata) + (prandom_u32() & 0x7f) + 1;
+
+		dat = (struct rbdata *)prb_reserve(&e, &test_rb, len);
+		if (dat) {
+			len -= sizeof(struct rbdata) + 1;
+			memset(&dat->text[0], id, len);
+			dat->text[len] = 0;
+			dat->len = len;
+			prb_commit(&e);
+		} else {
+			WRITE_ONCE(halt_test, 1);
+			trace_printk("writer%lu (%c) failed to reserve\n",
+				     num, id);
+		}
+
+		if ((count++ & 0x3fff) == 0)
+			schedule();
+
+		if (READ_ONCE(halt_test) == 1)
+			break;
+	}
+
+	pr_err("prbtest: end thread %lu (writer)\n", num);
+
+	test_running[num] = 0;
+
+	return 0;
+}
+
+static int prbtest_reader(void *data)
+{
+	unsigned long num = (unsigned long)data;
+	DECLARE_PRINTKRB_ENTRY(entry, 140);
+	DECLARE_PRINTKRB_ITER(iter, &test_rb, &entry);
+	unsigned long total_lost = 0;
+	unsigned long max_lost = 0;
+	struct rbdata *dat;
+	int did_sched = 1;
+	u64 last_seq = 0;
+	int count = 0;
+	int len;
+
+	pr_err("prbtest: start thread %lu (reader)\n", num);
+
+	for (;;) {
+		prb_for_each_entry(&iter, len) {
+			if (entry.seq - last_seq != 1 && !did_sched) {
+				total_lost += entry.seq - (last_seq + 1);
+				if (max_lost < entry.seq - (last_seq + 1))
+					max_lost = entry.seq - (last_seq + 1);
+			}
+			last_seq = entry.seq;
+			did_sched = 0;
+
+			dat = (struct rbdata *)&entry.buffer[0];
+
+			len = strlen(dat->text);
+			if (len != dat->len) {
+				WRITE_ONCE(halt_test, 1);
+				trace_printk("reader%lu invalid length\n",
+					     num);
+			}
+			while (len) {
+				len--;
+				if (dat->text[len] != dat->text[0]) {
+					WRITE_ONCE(halt_test, 1);
+					trace_printk("reader%lu invalid data\n",
+						     num);
+				}
+			}
+
+			if ((count++ & 0x3fff) == 0) {
+				did_sched = 1;
+				schedule();
+			}
+
+			if (READ_ONCE(halt_test) == 1)
+				goto out;
+		}
+	}
+out:
+	pr_err("reader%lu: total_lost=%lu max_lost=%lu seq=%llu\n",
+	       num, total_lost, max_lost, entry.seq);
+	pr_err("prbtest: end thread %lu (reader)\n", num);
+
+	test_running[num] = 0;
+
+	return 0;
+}
+
+static int module_test_running;
+
+static int start_test(void *arg)
+{
+	struct task_struct *thread;
+	unsigned long i;
+	int num_cpus;
+
+	num_cpus = num_online_cpus();
+	test_running = kzalloc(num_cpus, GFP_KERNEL);
+	if (!test_running)
+		return -ENOMEM;
+
+	module_test_running = 1;
+
+	pr_err("prbtest: starting test\n");
+
+	for (i = 0; i < num_cpus; i++) {
+		test_running[i] = 1;
+		if (i < num_cpus - 1) {
+			thread = kthread_run(prbtest_writer, (void *)i,
+					     "prbtest writer");
+		} else {
+			thread = kthread_run(prbtest_reader, (void *)i,
+					     "prbtest reader");
+		}
+		if (IS_ERR(thread)) {
+			pr_err("prbtest: unable to create thread %lu\n", i);
+			test_running[i] = 0;
+		}
+	}
+
+	for (;;) {
+		for (i = 0; i < num_cpus; i++) {
+			if (test_running[i] == 1)
+				break;
+		}
+		if (i == num_cpus)
+			break;
+		msleep(1000);
+	}
+
+	pr_err("prbtest: completed test\n");
+
+	dump_rb(&test_rb);
+
+	module_test_running = 0;
+
+	kfree(test_running);
+
+	return 0;
+}
+
+static int prbtest_init(void)
+{
+	kthread_run(start_test, NULL, "prbtest");
+	return 0;
+}
+
+static void prbtest_exit(void)
+{
+	WRITE_ONCE(halt_test, 1);
+
+	while (module_test_running)
+		msleep(1000);
+}
+
+module_init(prbtest_init);
+module_exit(prbtest_exit);
+
+MODULE_AUTHOR("John Ogness <john.ogness@linutronix.de>");
+MODULE_DESCRIPTION("printk ringbuffer test");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0

