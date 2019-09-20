Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18A9C4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C241208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HO7CGcqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393387AbfITPWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 11:22:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54451 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391458AbfITPW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 11:22:28 -0400
Received: by mail-wm1-f65.google.com with SMTP id p7so2944072wmp.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 08:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JkpXeZCgMJQGW2lIVg4AcFsQ6X3nTfvPuHJRVifczks=;
        b=HO7CGcqUmUu/idEbYcmYTvZ1P7k5C+UyqZ2yC5yeKXUIhY4XKKeHclJBKRpOb86Ioq
         Emv0B8Y45iSA80OadQMc5FilCsFl22/1je9s8bdsfBptCuTdPNy0sGTetetBF2t5pBo9
         WtEKyvrj+JvEJWZM93S8rfVGT98vhefF5+4bKoSvTRQFkLHKNfnsy4QAkHpKLzTwTXkz
         atgHQqSA4sKAl/wtiu9thza3PvCjH/Z+UlnJLstA9BzrmwlZXI1aaOAdk4qYmEUwhzZx
         gAID4+ME/GE3laQJGJhwewtinDpVqI8x8+MTzeL6qji09ubzBDPZPcKSd2ZM/cTFBS74
         HRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JkpXeZCgMJQGW2lIVg4AcFsQ6X3nTfvPuHJRVifczks=;
        b=aD985nrvkOaLCFx57BNpbdYXMnpIBh5W0cxL+v/jeJjx3BCZuTqJ+Zi7k2oGwHUE10
         KKy218ihbk1f+pOvnp5SktMbf5X5g4RBl18bt+0ErNvpIkx3KJLXyIAKhLV67ycRlKSc
         ScXw5SxUrg/OT+KGkha4A8wufXvyRFSMSpJWGBp65arihpgAsS5igO+DlT9WdAiSQWQl
         o4sjW4kPgdMSw5AHnlQsmwSVauWXjxXwCfHdM5aIQ8gxplFsBlCy4/rOsZTIMLnBvlU5
         +LDppt+A4skzKtnSNhUFKKeqzaEfrxucLktNy6j5th/T5Wq+RqgDrswvFtLlfo/uIYLE
         k7Ng==
X-Gm-Message-State: APjAAAUMUN9LmlJ5dboIsxi8xZfXpSTbp8jPiGwn+uIej/JhxeK9agQf
        Vak+lU5KrOqJWWJDFemy2w==
X-Google-Smtp-Source: APXvYqxsD8mxutHDGxgi/q5uoS3HmSUiO2LLHJwye32LMCJEqAi50kNxE3tymmsEY5t7vFn/8vuAXg==
X-Received: by 2002:a7b:c353:: with SMTP id l19mr3733555wmj.173.1568992946028;
        Fri, 20 Sep 2019 08:22:26 -0700 (PDT)
Received: from buster-jangle.bmw-carit.intra ([217.89.178.117])
        by smtp.gmail.com with ESMTPSA id x2sm3152901wrn.81.2019.09.20.08.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 08:22:25 -0700 (PDT)
From:   "Viktor Rosendahl (BMW)" <viktor.rosendahl@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Viktor Rosendahl (BMW)" <viktor.rosendahl@gmail.com>
Subject: [PATCH v7 2/4] preemptirq_delay_test: Add the burst feature and a sysfs trigger
Date:   Fri, 20 Sep 2019 17:22:17 +0200
Message-Id: <20190920152219.12920-3-viktor.rosendahl@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190920152219.12920-1-viktor.rosendahl@gmail.com>
References: <20190920152219.12920-1-viktor.rosendahl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This burst feature enables the user to generate a burst of
preempt/irqsoff latencies. This makes it possible to test whether we
are able to detect latencies that systematically occur very close to
each other.

The maximum burst size is 10. We also create 10 identical test
functions, so that we get 10 different backtraces; this is useful
when we want to test whether we can detect all the latencies in a
burst. Otherwise, there would be no easy way of differentiating
between which latency in a burst was captured by the tracer.

In addition, there is a sysfs trigger, so that it's not necessary to
reload the module to repeat the test. The trigger will appear as
/sys/kernel/preemptirq_delay_test/trigger in sysfs.

Signed-off-by: Viktor Rosendahl (BMW) <viktor.rosendahl@gmail.com>
---
 kernel/trace/Kconfig                 |   6 +-
 kernel/trace/preemptirq_delay_test.c | 144 +++++++++++++++++++++++----
 2 files changed, 128 insertions(+), 22 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index e08527f50d2a..2a58380ea310 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -752,9 +752,9 @@ config PREEMPTIRQ_DELAY_TEST
 	  configurable delay. The module busy waits for the duration of the
 	  critical section.
 
-	  For example, the following invocation forces a one-time irq-disabled
-	  critical section for 500us:
-	  modprobe preemptirq_delay_test test_mode=irq delay=500000
+	  For example, the following invocation generates a burst of three
+	  irq-disabled critical sections for 500us:
+	  modprobe preemptirq_delay_test test_mode=irq delay=500 burst_size=3
 
 	  If unsure, say N
 
diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
index d8765c952fab..31c0fad4cb9e 100644
--- a/kernel/trace/preemptirq_delay_test.c
+++ b/kernel/trace/preemptirq_delay_test.c
@@ -10,18 +10,25 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/kthread.h>
 #include <linux/module.h>
 #include <linux/printk.h>
 #include <linux/string.h>
+#include <linux/sysfs.h>
 
 static ulong delay = 100;
-static char test_mode[10] = "irq";
+static char test_mode[12] = "irq";
+static uint burst_size = 1;
 
-module_param_named(delay, delay, ulong, S_IRUGO);
-module_param_string(test_mode, test_mode, 10, S_IRUGO);
-MODULE_PARM_DESC(delay, "Period in microseconds (100 uS default)");
-MODULE_PARM_DESC(test_mode, "Mode of the test such as preempt or irq (default irq)");
+module_param_named(delay, delay, ulong, 0444);
+module_param_string(test_mode, test_mode, 12, 0444);
+module_param_named(burst_size, burst_size, uint, 0444);
+MODULE_PARM_DESC(delay, "Period in microseconds (100 us default)");
+MODULE_PARM_DESC(test_mode, "Mode of the test such as preempt, irq, or alternate (default irq)");
+MODULE_PARM_DESC(burst_size, "The size of a burst (default 1)");
+
+#define MIN(x, y) ((x) < (y) ? (x) : (y))
 
 static void busy_wait(ulong time)
 {
@@ -34,37 +41,136 @@ static void busy_wait(ulong time)
 	} while ((end - start) < (time * 1000));
 }
 
-static int preemptirq_delay_run(void *data)
+static __always_inline void irqoff_test(void)
 {
 	unsigned long flags;
+	local_irq_save(flags);
+	busy_wait(delay);
+	local_irq_restore(flags);
+}
 
-	if (!strcmp(test_mode, "irq")) {
-		local_irq_save(flags);
-		busy_wait(delay);
-		local_irq_restore(flags);
-	} else if (!strcmp(test_mode, "preempt")) {
-		preempt_disable();
-		busy_wait(delay);
-		preempt_enable();
+static __always_inline void preemptoff_test(void)
+{
+	preempt_disable();
+	busy_wait(delay);
+	preempt_enable();
+}
+
+static void execute_preemptirqtest(int idx)
+{
+	if (!strcmp(test_mode, "irq"))
+		irqoff_test();
+	else if (!strcmp(test_mode, "preempt"))
+		preemptoff_test();
+	else if (!strcmp(test_mode, "alternate")) {
+		if (idx % 2 == 0)
+			irqoff_test();
+		else
+			preemptoff_test();
 	}
+}
+
+#define DECLARE_TESTFN(POSTFIX)				\
+	static void preemptirqtest_##POSTFIX(int idx)	\
+	{						\
+		execute_preemptirqtest(idx);		\
+	}						\
 
+/*
+ * We create 10 different functions, so that we can get 10 different
+ * backtraces.
+ */
+DECLARE_TESTFN(0)
+DECLARE_TESTFN(1)
+DECLARE_TESTFN(2)
+DECLARE_TESTFN(3)
+DECLARE_TESTFN(4)
+DECLARE_TESTFN(5)
+DECLARE_TESTFN(6)
+DECLARE_TESTFN(7)
+DECLARE_TESTFN(8)
+DECLARE_TESTFN(9)
+
+static void (*testfuncs[])(int)  = {
+	preemptirqtest_0,
+	preemptirqtest_1,
+	preemptirqtest_2,
+	preemptirqtest_3,
+	preemptirqtest_4,
+	preemptirqtest_5,
+	preemptirqtest_6,
+	preemptirqtest_7,
+	preemptirqtest_8,
+	preemptirqtest_9,
+};
+
+#define NR_TEST_FUNCS ARRAY_SIZE(testfuncs)
+
+static int preemptirq_delay_run(void *data)
+{
+	int i;
+	int s = MIN(burst_size, NR_TEST_FUNCS);
+
+	for (i = 0; i < s; i++)
+		(testfuncs[i])(i);
 	return 0;
 }
 
-static int __init preemptirq_delay_init(void)
+static struct task_struct *preemptirq_start_test(void)
 {
 	char task_name[50];
-	struct task_struct *test_task;
 
 	snprintf(task_name, sizeof(task_name), "%s_test", test_mode);
+	return kthread_run(preemptirq_delay_run, NULL, task_name);
+}
+
+
+static ssize_t trigger_store(struct kobject *kobj, struct kobj_attribute *attr,
+			 const char *buf, size_t count)
+{
+	preemptirq_start_test();
+	return count;
+}
+
+static struct kobj_attribute trigger_attribute =
+	__ATTR(trigger, 0200, NULL, trigger_store);
+
+static struct attribute *attrs[] = {
+	&trigger_attribute.attr,
+	NULL,
+};
+
+static struct attribute_group attr_group = {
+	.attrs = attrs,
+};
+
+static struct kobject *preemptirq_delay_kobj;
+
+static int __init preemptirq_delay_init(void)
+{
+	struct task_struct *test_task;
+	int retval;
+
+	test_task = preemptirq_start_test();
+	retval = PTR_ERR_OR_ZERO(test_task);
+	if (retval != 0)
+		return retval;
+
+	preemptirq_delay_kobj = kobject_create_and_add("preemptirq_delay_test",
+						       kernel_kobj);
+	if (!preemptirq_delay_kobj)
+		return -ENOMEM;
+
+	retval = sysfs_create_group(preemptirq_delay_kobj, &attr_group);
+	if (retval)
+		kobject_put(preemptirq_delay_kobj);
 
-	test_task = kthread_run(preemptirq_delay_run, NULL, task_name);
-	return PTR_ERR_OR_ZERO(test_task);
+	return retval;
 }
 
 static void __exit preemptirq_delay_exit(void)
 {
-	return;
+	kobject_put(preemptirq_delay_kobj);
 }
 
 module_init(preemptirq_delay_init)
-- 
2.17.1

