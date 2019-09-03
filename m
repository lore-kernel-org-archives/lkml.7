Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82C1C3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B404F23697
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvETlv82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbfICN0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 09:26:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50382 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbfICN03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:26:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id c10so6266843wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 06:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qNBMU1RdNWs1Aqt+gLJ90XqZHF7ok44KwrUzYqkz31w=;
        b=QvETlv827rEVTy9dwBJSRawNR0YK+zAHEFeg6hbCbp8f2G7VRP5W/aUU+DMIYomckJ
         FhUXW9yQoXyFvjDqSgs9JQRHqk8Pffh9O3vNv98fCxOulRxr0KipH229JJNcZqssYG5O
         RDNyJYPhv7t0OpshGddwW4Z+JhWg76HkK1zjFCK+EC88ubuYY2oVGnTuebXcPCcZJlwR
         Wf8bLaw7F+N/MWLvHwsuKrqZc9kKfNaKA7QsuwbpxUmxRRqpvlfYiOqVMWpZ+1GbtYFL
         QdAdjKmG9Gb2Atfr2MCgG4OLCdaTg5D50boZHJXjivG0ng2tQ5ymC+q5WR7NvWtQh2hw
         wARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qNBMU1RdNWs1Aqt+gLJ90XqZHF7ok44KwrUzYqkz31w=;
        b=EfLbxYQ98Nbq2SWJm4ZGTgwNWmQmTAiKL7siWdWNS/8np52GeLIDRiT0XEs+XaAY26
         TIkEXU2lw6bHpx+8dtp83aFAtRxWGPXEQJzaaHFZUn6u87ulXEwQyjtJtnkQxjaaXQUf
         PyXtg/W0aDai/RQja4A5WwGP4j2y7zLNnsWqqM/TvhrFQn/uDhNeKgXkvP8Fxz0phPLZ
         YQrrxsEcLrjAfiIp0snssPvA9r6Sq6JXYXJku9tmXxrRoLztwKoeefK8lPGuJuXhCp4s
         4jHGl/p8QFwoQR+FyEc5p/TDf2DGXO0vWw/5NiR6Kt3pcN6povwQAtg49jxFF7mm7u+d
         p+xA==
X-Gm-Message-State: APjAAAVkR05NSc/av2cfH2fBIaN9ZxxnQuCCDtUkrqkonEemCFw+Ubkg
        er3zfTbpSF7K53vCjaxEmw==
X-Google-Smtp-Source: APXvYqz+W46o6TkE5A3STjm8DOiTKgZVtcmb03VOBSDgttWgcnziPVvBiiiJXGAIr6QIPCzfEDC7Rw==
X-Received: by 2002:a7b:c250:: with SMTP id b16mr9616wmj.130.1567517186655;
        Tue, 03 Sep 2019 06:26:26 -0700 (PDT)
Received: from buster-jangle.bmw-carit.intra ([217.89.178.117])
        by smtp.gmail.com with ESMTPSA id w9sm3906668wra.15.2019.09.03.06.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 06:26:25 -0700 (PDT)
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Viktor Rosendahl <viktor.rosendahl@gmail.com>
Subject: [PATCH v5 2/4] preemptirq_delay_test: Add the burst feature and a sysfs trigger
Date:   Tue,  3 Sep 2019 15:26:00 +0200
Message-Id: <20190903132602.3440-3-viktor.rosendahl@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903132602.3440-1-viktor.rosendahl@gmail.com>
References: <20190903132602.3440-1-viktor.rosendahl@gmail.com>
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

Signed-off-by: Viktor Rosendahl <viktor.rosendahl@gmail.com>
---
 kernel/trace/Kconfig                 |   6 +-
 kernel/trace/preemptirq_delay_test.c | 145 +++++++++++++++++++++++----
 2 files changed, 129 insertions(+), 22 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 98da8998c25c..5ff573d844e4 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -751,9 +751,9 @@ config PREEMPTIRQ_DELAY_TEST
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
index d8765c952fab..dc281fa75198 100644
--- a/kernel/trace/preemptirq_delay_test.c
+++ b/kernel/trace/preemptirq_delay_test.c
@@ -3,6 +3,7 @@
  * Preempt / IRQ disable delay thread to test latency tracers
  *
  * Copyright (C) 2018 Joel Fernandes (Google) <joel@joelfernandes.org>
+ * Copyright (C) 2018, 2019 BMW Car IT GmbH
  */
 
 #include <linux/trace_clock.h>
@@ -10,18 +11,25 @@
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
@@ -34,37 +42,136 @@ static void busy_wait(ulong time)
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

