Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28ABC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF01217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 22:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389422AbfHGW1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:27:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51800 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388848AbfHGW1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 18:27:07 -0400
Received: from [5.158.153.52] (helo=g2noscherz.tec.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hvUOT-0007mg-9b; Thu, 08 Aug 2019 00:26:54 +0200
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
        Brendan Higgins <brendanhiggins@google.com>
Subject: [RFC PATCH v4 2/9] printk-rb: add test module
Date:   Thu,  8 Aug 2019 00:32:27 +0206
Message-Id: <20190807222634.1723-3-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807222634.1723-1-john.ogness@linutronix.de>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This module does some heavy write stress testing on the ringbuffer
with a reader that is checking for integrity.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/Makefile   |   2 +
 kernel/printk/test_prb.c | 256 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 258 insertions(+)
 create mode 100644 kernel/printk/test_prb.c

diff --git a/kernel/printk/Makefile b/kernel/printk/Makefile
index 567999aa93af..24365ecee348 100644
--- a/kernel/printk/Makefile
+++ b/kernel/printk/Makefile
@@ -5,3 +5,5 @@ obj-$(CONFIG_PRINTK)	+= ringbuffer.o
 obj-$(CONFIG_PRINTK)	+= numlist.o
 obj-$(CONFIG_PRINTK)	+= dataring.o
 obj-$(CONFIG_A11Y_BRAILLE_CONSOLE)	+= braille.o
+
+obj-m			+= test_prb.o
diff --git a/kernel/printk/test_prb.c b/kernel/printk/test_prb.c
new file mode 100644
index 000000000000..1ecb4fcbf823
--- /dev/null
+++ b/kernel/printk/test_prb.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kthread.h>
+#include <linux/delay.h>
+#include <linux/random.h>
+#include <linux/slab.h>
+#include "ringbuffer.h"
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
+ * aborted. Test results are recorded to the ftrace buffers, with some
+ * additional information also provided via printk. The test can be aborted
+ * manually by removing the module. (Ideally the test should never abort on
+ * its own.)
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
+	DECLARE_PRINTKRB_ENTRY(entry, 160);
+	DECLARE_PRINTKRB_ITER(iter, rb, &entry);
+	unsigned long last_seq = 0;
+	struct rbdata *dat;
+	char buf[160];
+	int len;
+
+	trace_printk("BEGIN full dump\n");
+
+	prb_for_each_entry_continue(&iter, len) {
+		if (entry.seq - last_seq != 1) {
+			trace_printk("LOST %lu\n",
+				     entry.seq - (last_seq + 1));
+		}
+		last_seq = entry.seq;
+
+		dat = (struct rbdata *)&entry.buffer[0];
+
+		snprintf(buf, sizeof(buf), "%s", dat->text);
+		buf[sizeof(buf) - 1] = 0;
+		trace_printk("seq=%lu len=%d textlen=%d dataval=%s\n",
+			     entry.seq, len, dat->len, buf);
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
+		len = sizeof(struct rbdata) + (prandom_u32() & 0x7f) + 2;
+
+		dat = (struct rbdata *)prb_reserve(&e, &test_rb, len);
+		if (!IS_ERR(dat)) {
+			len -= sizeof(struct rbdata) + 1;
+			memset(&dat->text[0], id, len);
+			dat->text[len] = 0;
+			dat->len = len;
+			prb_commit(&e);
+		} else {
+			WRITE_ONCE(halt_test, 1);
+			trace_printk("writer%lu (%c) reserve failed (%ld)\n",
+				     num, id, PTR_ERR(dat));
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
+	DECLARE_PRINTKRB_ENTRY(entry, 160);
+	DECLARE_PRINTKRB_ITER(iter, &test_rb, &entry);
+	unsigned long total_lost = 0;
+	unsigned long last_seq = 0;
+	unsigned long max_lost = 0;
+	unsigned long count = 0;
+	struct rbdata *dat;
+	int did_sched = 1;
+	int len;
+
+	pr_err("prbtest: start thread %lu (reader)\n", num);
+
+	for (;;) {
+		prb_for_each_entry_continue(&iter, len) {
+			if (entry.seq < last_seq) {
+				WRITE_ONCE(halt_test, 1);
+				trace_printk(
+					"reader%lu invalid seq %lu -> %lu\n",
+					num, last_seq, entry.seq);
+				goto out;
+			}
+
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
+			len = strnlen(dat->text, 160);
+			if (len != dat->len || len >= 160) {
+				WRITE_ONCE(halt_test, 1);
+				trace_printk(
+				 "reader%lu invalid len for %lu (%d<->%d)\n",
+				 num, entry.seq, len, dat->len);
+				goto out;
+			}
+			while (len) {
+				len--;
+				if (dat->text[len] != dat->text[0]) {
+					WRITE_ONCE(halt_test, 1);
+					trace_printk("reader%lu bad data\n",
+						     num);
+					goto out;
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
+		if (READ_ONCE(halt_test) == 1)
+			goto out;
+	}
+out:
+	pr_err(
+	 "reader%lu: total_lost=%lu max_lost=%lu total_read=%lu seq=%lu\n",
+	 num, total_lost, max_lost, count, entry.seq);
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
2.20.1

