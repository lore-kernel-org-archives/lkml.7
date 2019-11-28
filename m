Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85754C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 01:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EDA21569
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 01:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfK1BxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 20:53:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45756 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbfK1BxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 20:53:04 -0500
Received: from [5.158.153.53] (helo=g2noscherz.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1ia8zK-00083b-Qc; Thu, 28 Nov 2019 02:52:58 +0100
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
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        kexec@lists.infradead.org
Subject: [RFC PATCH v5 3/3] printk-rb: add test module
Date:   Thu, 28 Nov 2019 02:58:35 +0106
Message-Id: <20191128015235.12940-4-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191128015235.12940-1-john.ogness@linutronix.de>
References: <20191128015235.12940-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This module does some heavy write stress testing on the ringbuffer
with a reader that is checking for integrity.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/Makefile   |   3 +
 kernel/printk/test_prb.c | 347 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 350 insertions(+)
 create mode 100644 kernel/printk/test_prb.c

diff --git a/kernel/printk/Makefile b/kernel/printk/Makefile
index 4d052fc6bcde..2aabbe561efc 100644
--- a/kernel/printk/Makefile
+++ b/kernel/printk/Makefile
@@ -2,3 +2,6 @@
 obj-y	= printk.o
 obj-$(CONFIG_PRINTK)	+= printk_safe.o
 obj-$(CONFIG_A11Y_BRAILLE_CONSOLE)	+= braille.o
+
+prbtest-y = printk_ringbuffer.o test_prb.o
+obj-m += prbtest.o
diff --git a/kernel/printk/test_prb.c b/kernel/printk/test_prb.c
new file mode 100644
index 000000000000..d038b16bf01b
--- /dev/null
+++ b/kernel/printk/test_prb.c
@@ -0,0 +1,347 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kthread.h>
+#include <linux/delay.h>
+#include <linux/random.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+#include "printk_ringbuffer.h"
+
+/*
+ * This is a test module that starts "num_online_cpus()" writer threads
+ * that each write data of varying length. They do this as fast as
+ * they can.
+ *
+ * Dictionary data is stored in a separate data ring. The writers will
+ * only write dictionary data about half the time. This is to make the
+ * test more realistic with text and dict data rings containing
+ * different data blocks.
+ *
+ * Because the threads are running in such tight loops, they will call
+ * schedule() from time to time so the system stays alive.
+ *
+ * If the writers encounter an error, the test is aborted. Test results are
+ * recorded to the ftrace buffers, with some additional information also
+ * provided via printk. The test can be aborted manually by removing the
+ * module. (Ideally the test should never abort on its own.)
+ */
+
+/* not used right now */
+DECLARE_WAIT_QUEUE_HEAD(test_wait);
+
+/* test data structure */
+struct rbdata {
+	int len;
+	char text[0];
+};
+
+static char *test_running;
+static int halt_test;
+
+/* dump text or dictionary data to the trace buffers */
+static void print_record(const char *name, struct rbdata *dat, u64 seq)
+{
+	char buf[160];
+
+	snprintf(buf, sizeof(buf), "%s", dat->text);
+	buf[sizeof(buf) - 1] = 0;
+
+	trace_printk("seq=%llu len=%d %sval=%s\n",
+		     seq, dat->len, name,
+		     dat->len < sizeof(buf) ? buf : "<invalid>");
+}
+
+/*
+ * sequentially dump all the valid records in the ringbuffer
+ * (used to verify memory integrity)
+ *
+ * Since there is no reader interface, the internal members are
+ * directly accessed. This function is called after all writers
+ * are finished so there is no need for any memory barriers.
+ */
+static void dump_rb(struct printk_ringbuffer *rb)
+{
+	struct printk_info info;
+	struct printk_record r;
+	char text_buf[200];
+	char dict_buf[200];
+	u64 seq = 0;
+
+	r.info = &info;
+	r.text_buf = &text_buf[0];
+	r.dict_buf = &dict_buf[0];
+	r.text_buf_size = sizeof(text_buf);
+	r.dict_buf_size = sizeof(dict_buf);
+
+	trace_printk("BEGIN full dump\n");
+
+	while (prb_read_valid(rb, seq, &r)) {
+		/* check/track the sequence */
+		if (info.seq != seq)
+			trace_printk("DROPPED %llu\n", info.seq - seq);
+
+		print_record("TEXT", (struct rbdata *)&r.text_buf[0],
+			     info.seq);
+		if (info.dict_len) {
+			print_record("DICT", (struct rbdata *)&r.dict_buf[0],
+				     info.seq);
+		}
+
+		seq = info.seq + 1;
+	}
+
+	trace_printk("END full dump\n");
+}
+
+DECLARE_PRINTKRB(test_rb, 15, 5, 5);
+
+static int prbtest_writer(void *data)
+{
+	unsigned long num = (unsigned long)data;
+	struct prb_reserved_entry e;
+	char text_id = 'A' + num;
+	char dict_id = 'a' + num;
+	unsigned long count = 0;
+	struct printk_record r;
+	struct rbdata *dat;
+	int len;
+
+	pr_err("prbtest: start thread %03lu (writer)\n", num);
+
+	for (;;) {
+		len = sizeof(struct rbdata) + (prandom_u32() & 0x7f) + 2;
+
+		/* specify the text/dict sizes for reservation */
+		r.text_buf_size = len;
+		/* only add a dictionary on some records */
+		if (len % 2)
+			r.dict_buf_size = len;
+		else
+			r.dict_buf_size = 0;
+
+		if (prb_reserve(&e, &test_rb, &r)) {
+			len -= sizeof(struct rbdata) + 1;
+
+			dat = (struct rbdata *)&r.text_buf[0];
+			dat->len = len;
+			memset(&dat->text[0], text_id, len);
+			dat->text[len] = 0;
+
+			/* dictionary reservation is allowed to fail */
+			if (r.dict_buf) {
+				dat = (struct rbdata *)&r.dict_buf[0];
+				dat->len = len;
+				memset(&dat->text[0], dict_id, len);
+				dat->text[len] = 0;
+			} else if (r.text_buf_size % 2) {
+				trace_printk(
+				    "writer%lu (%c) dict dropped: seq=%llu\n",
+				    num, text_id, r.info->seq);
+			}
+
+			prb_commit(&e);
+			wake_up_interruptible(&test_wait);
+		} else {
+			WRITE_ONCE(halt_test, 1);
+			trace_printk("writer%lu (%c) reserve failed\n",
+				     num, text_id);
+		}
+
+		if ((count++ & 0x3fff) == 0)
+			schedule();
+
+		if (READ_ONCE(halt_test) == 1)
+			break;
+	}
+
+	pr_err("prbtest: end thread %03lu (writer, wrote %lu)\n", num, count);
+
+	test_running[num] = 0;
+
+	return 0;
+}
+
+static bool check_data(struct rbdata *dat, u64 seq, unsigned long num)
+{
+	int len;
+
+	len = strnlen(dat->text, 160);
+
+	if (len != dat->len || len >= 160) {
+		WRITE_ONCE(halt_test, 1);
+		trace_printk("reader%lu invalid len for %llu (%d<->%d)\n",
+			     num, seq, len, dat->len);
+		return false;
+	}
+
+	while (len) {
+		len--;
+		if (dat->text[len] != dat->text[0]) {
+			WRITE_ONCE(halt_test, 1);
+			trace_printk("reader%lu bad data\n", num);
+			return false;
+		}
+	}
+
+	return true;
+}
+
+static int prbtest_reader(void *data)
+{
+	unsigned long num = (unsigned long)data;
+	unsigned long total_lost = 0;
+	unsigned long max_lost = 0;
+	unsigned long count = 0;
+	struct printk_info info;
+	struct printk_record r;
+	char text_buf[200];
+	char dict_buf[200];
+	int did_sched = 1;
+	u64 seq = 0;
+
+	r.info = &info;
+	r.text_buf = &text_buf[0];
+	r.dict_buf = &dict_buf[0];
+	r.text_buf_size = sizeof(text_buf);
+	r.dict_buf_size = sizeof(dict_buf);
+
+	pr_err("prbtest: start thread %03lu (reader)\n", num);
+
+	while (!wait_event_interruptible(test_wait,
+				kthread_should_stop() ||
+				prb_read_valid(&test_rb, seq, &r))) {
+		if (kthread_should_stop())
+			break;
+		/* check/track the sequence */
+		if (info.seq < seq) {
+			WRITE_ONCE(halt_test, 1);
+			trace_printk("reader%lu invalid seq %llu -> %llu\n",
+				num, seq, info.seq);
+			break;
+		} else if (info.seq != seq && !did_sched) {
+			total_lost += info.seq - seq;
+			if (max_lost < info.seq - seq)
+				max_lost = info.seq - seq;
+		}
+
+		if (!check_data((struct rbdata *)&r.text_buf[0],
+				info.seq, num)) {
+			trace_printk("text error\n");
+			break;
+		}
+
+		if (info.dict_len) {
+			if (!check_data((struct rbdata *)&r.dict_buf[0],
+					info.seq, num)) {
+				trace_printk("dict error\n");
+				break;
+			}
+		} else if (info.text_len % 2) {
+			trace_printk("dict dropped: seq=%llu\n", info.seq);
+		}
+
+		did_sched = 0;
+		if ((count++ & 0x3fff) == 0) {
+			did_sched = 1;
+			schedule();
+		}
+
+		if (READ_ONCE(halt_test) == 1)
+			break;
+
+		seq = info.seq + 1;
+	}
+
+	pr_err(
+	 "reader%lu: total_lost=%lu max_lost=%lu total_read=%lu seq=%llu\n",
+	 num, total_lost, max_lost, count, info.seq);
+
+	pr_err("prbtest: end thread %03lu (reader)\n", num);
+
+	while (!kthread_should_stop())
+		msleep(1000);
+	test_running[num] = 0;
+
+	return 0;
+}
+
+static int module_test_running;
+static struct task_struct *reader_thread;
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
+			reader_thread = thread;
+		}
+		if (IS_ERR(thread)) {
+			pr_err("prbtest: unable to create thread %lu\n", i);
+			test_running[i] = 0;
+		}
+	}
+
+	for (;;) {
+		msleep(1000);
+
+		for (i = 0; i < num_cpus; i++) {
+			if (test_running[i] == 1)
+				break;
+		}
+		if (i == num_cpus)
+			break;
+	}
+
+	pr_err("prbtest: completed test\n");
+
+	dump_rb(&test_rb);
+
+	module_test_running = 0;
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
+	if (reader_thread && !IS_ERR(reader_thread))
+		kthread_stop(reader_thread);
+
+	WRITE_ONCE(halt_test, 1);
+
+	while (module_test_running)
+		msleep(1000);
+	kfree(test_running);
+}
+
+module_init(prbtest_init);
+module_exit(prbtest_exit);
+
+MODULE_AUTHOR("John Ogness <john.ogness@linutronix.de>");
+MODULE_DESCRIPTION("printk ringbuffer test");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

