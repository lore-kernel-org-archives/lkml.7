Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C41C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EEB20874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="h1L6MD1P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438963AbfFLMbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:31:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51755 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406351AbfFLMbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:31:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5CCVDO5685731
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 12 Jun 2019 05:31:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5CCVDO5685731
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560342674;
        bh=fE8qwriS3Ge5WxJ+lZ9C0cXDO603FMlG8aqBbvlw9DM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=h1L6MD1P+hiCiEHJX1oecfi6oSm9VmKZdhQNJzE82fEkVCAnPRFc8po+ODe5nZi22
         k24NOLdHD+EGAnaA1CN4WbgEUNckrfXyUId4KHkvte5ZWTuRHiUoScOZ3dVkL5ltfb
         7uqt/8VUvHPN6RRhsT79WE9AYMxxyj//9SqLuVIzZvHAmzitPwRBYAix9ZJBR/7QqK
         2uhQyicUZP3ERCSSX4sTzdBtlNwM/oXnGcoM/hficNl1j6+nET6rtdimp0W0/Nb7V0
         0DVv6GiJRuoxP7oiC+5bNpJNb5I831aOUbL04PM9DPjFxr300ue+EmpKLfqjiXZPFT
         Xtic6hzj2hhDQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5CCVDmR685728;
        Wed, 12 Jun 2019 05:31:13 -0700
Date:   Wed, 12 Jun 2019 05:31:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Daniel Lezcano <tipbot@zytor.com>
Message-ID: <tip-6aed82de719b424bd5548aa4179e95f34fd779ab@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
        mingo@kernel.org, daniel.lezcano@linaro.org
Reply-To: daniel.lezcano@linaro.org, mingo@kernel.org, hpa@zytor.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <20190527205521.12091-7-daniel.lezcano@linaro.org>
References: <20190527205521.12091-7-daniel.lezcano@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/timings: Add selftest for circular array
Git-Commit-ID: 6aed82de719b424bd5548aa4179e95f34fd779ab
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6aed82de719b424bd5548aa4179e95f34fd779ab
Gitweb:     https://git.kernel.org/tip/6aed82de719b424bd5548aa4179e95f34fd779ab
Author:     Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate: Mon, 27 May 2019 22:55:19 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 12 Jun 2019 10:47:04 +0200

genirq/timings: Add selftest for circular array

Due to the complexity of the code and the difficulty to debug it, add some
selftests to the framework in order to spot issues or regression at boot
time when the runtime testing is enabled for this subsystem.

This tests the circular buffer at the limits and validates:
 - the encoding / decoding of the values
 - the macro to browse the irq timings circular buffer
 - the function to push data in the circular buffer

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: andriy.shevchenko@linux.intel.com
Link: https://lkml.kernel.org/r/20190527205521.12091-7-daniel.lezcano@linaro.org

---
 kernel/irq/Makefile  |   3 ++
 kernel/irq/timings.c | 119 +++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug    |   8 ++++
 3 files changed, 130 insertions(+)

diff --git a/kernel/irq/Makefile b/kernel/irq/Makefile
index ff6e352e3a6c..b4f53717d143 100644
--- a/kernel/irq/Makefile
+++ b/kernel/irq/Makefile
@@ -2,6 +2,9 @@
 
 obj-y := irqdesc.o handle.o manage.o spurious.o resend.o chip.o dummychip.o devres.o
 obj-$(CONFIG_IRQ_TIMINGS) += timings.o
+ifeq ($(CONFIG_TEST_IRQ_TIMINGS),y)
+	CFLAGS_timings.o += -DDEBUG
+endif
 obj-$(CONFIG_GENERIC_IRQ_CHIP) += generic-chip.o
 obj-$(CONFIG_GENERIC_IRQ_PROBE) += autoprobe.o
 obj-$(CONFIG_IRQ_DOMAIN) += irqdomain.o
diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index bc04eca6ef84..95b63bdea156 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -1,10 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (C) 2016, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org>
+#define pr_fmt(fmt) "irq_timings: " fmt
 
 #include <linux/kernel.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
 #include <linux/static_key.h>
+#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/idr.h>
 #include <linux/irq.h>
@@ -625,3 +627,120 @@ int irq_timings_alloc(int irq)
 
 	return 0;
 }
+
+#ifdef CONFIG_TEST_IRQ_TIMINGS
+static int __init irq_timings_test_irqts(struct irq_timings *irqts,
+					 unsigned count)
+{
+	int start = count >= IRQ_TIMINGS_SIZE ? count - IRQ_TIMINGS_SIZE : 0;
+	int i, irq, oirq = 0xBEEF;
+	u64 ots = 0xDEAD, ts;
+
+	/*
+	 * Fill the circular buffer by using the dedicated function.
+	 */
+	for (i = 0; i < count; i++) {
+		pr_debug("%d: index=%d, ts=%llX irq=%X\n",
+			 i, i & IRQ_TIMINGS_MASK, ots + i, oirq + i);
+
+		irq_timings_push(ots + i, oirq + i);
+	}
+
+	/*
+	 * Compute the first elements values after the index wrapped
+	 * up or not.
+	 */
+	ots += start;
+	oirq += start;
+
+	/*
+	 * Test the circular buffer count is correct.
+	 */
+	pr_debug("---> Checking timings array count (%d) is right\n", count);
+	if (WARN_ON(irqts->count != count))
+		return -EINVAL;
+
+	/*
+	 * Test the macro allowing to browse all the irqts.
+	 */
+	pr_debug("---> Checking the for_each_irqts() macro\n");
+	for_each_irqts(i, irqts) {
+
+		irq = irq_timing_decode(irqts->values[i], &ts);
+
+		pr_debug("index=%d, ts=%llX / %llX, irq=%X / %X\n",
+			 i, ts, ots, irq, oirq);
+
+		if (WARN_ON(ts != ots || irq != oirq))
+			return -EINVAL;
+
+		ots++; oirq++;
+	}
+
+	/*
+	 * The circular buffer should have be flushed when browsed
+	 * with for_each_irqts
+	 */
+	pr_debug("---> Checking timings array is empty after browsing it\n");
+	if (WARN_ON(irqts->count))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int __init irq_timings_irqts_selftest(void)
+{
+	struct irq_timings *irqts = this_cpu_ptr(&irq_timings);
+	int i, ret;
+
+	/*
+	 * Test the circular buffer with different number of
+	 * elements. The purpose is to test at the limits (empty, half
+	 * full, full, wrapped with the cursor at the boundaries,
+	 * wrapped several times, etc ...
+	 */
+	int count[] = { 0,
+			IRQ_TIMINGS_SIZE >> 1,
+			IRQ_TIMINGS_SIZE,
+			IRQ_TIMINGS_SIZE + (IRQ_TIMINGS_SIZE >> 1),
+			2 * IRQ_TIMINGS_SIZE,
+			(2 * IRQ_TIMINGS_SIZE) + 3,
+	};
+
+	for (i = 0; i < ARRAY_SIZE(count); i++) {
+
+		pr_info("---> Checking the timings with %d/%d values\n",
+			count[i], IRQ_TIMINGS_SIZE);
+
+		ret = irq_timings_test_irqts(irqts, count[i]);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int __init irq_timings_selftest(void)
+{
+	int ret;
+
+	pr_info("------------------- selftest start -----------------\n");
+
+	/*
+	 * At this point, we don't except any subsystem to use the irq
+	 * timings but us, so it should not be enabled.
+	 */
+	if (static_branch_unlikely(&irq_timing_enabled)) {
+		pr_warn("irq timings already initialized, skipping selftest\n");
+		return 0;
+	}
+
+	ret = irq_timings_irqts_selftest();
+
+	pr_info("---------- selftest end with %s -----------\n",
+		ret ? "failure" : "success");
+
+	return ret;
+}
+early_initcall(irq_timings_selftest);
+#endif
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index cbdfae379896..f0788eea64bd 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1858,6 +1858,14 @@ config TEST_PARMAN
 
 	  If unsure, say N.
 
+config TEST_IRQ_TIMINGS
+	bool "IRQ timings selftest"
+	depends on IRQ_TIMINGS
+	help
+	  Enable this option to test the irq timings code on boot.
+
+	  If unsure, say N.
+
 config TEST_LKM
 	tristate "Test module loading with 'hello world' module"
 	depends on m
