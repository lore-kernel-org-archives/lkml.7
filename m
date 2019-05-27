Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0112DC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF4B20859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H+15z8Hv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfE0U4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 16:56:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38601 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbfE0Uzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 16:55:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id d18so17964082wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 13:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3EcKBS+YKo3m/rDQQfdwEg1iam0jndfNmBU1yOpEDAI=;
        b=H+15z8HvXF/zzfs0l/ZnUHpoMoMdSceLC5gFrtJ5hncag93GyM8kl1Yq3wCL3MEetp
         E1Hc1r88GlXdnI2kzuUz6RwtfM19dfRHQKtVprYw3VoFM4j7ptsEgWYfHW0FFLUjYV1A
         hxJzRY7tfciFd7HVDSUI366zpNXurB5sN2UKRComEIrxmZ28Ndsivwo7pKDdPLWadpk/
         SVkJQmA8IGyyGupkrOsjpmoBJS5clGMkW+glwG3DjuE8aefYMsGDo9zZhEHC/QI8rrQr
         dbJpXLrY9tdIFVK1SOIqctcIt3ZAFHAJaYFlxrIjxkK30rWc1tCQwqfEbZsTfrRQIiXB
         eSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3EcKBS+YKo3m/rDQQfdwEg1iam0jndfNmBU1yOpEDAI=;
        b=r6JqTOFjWVcV7tOiwSGd+i6GpDPeemesVvJznyFpqlrLTr2Q3qpRHuuZkbFnTjIwzO
         A4M1qJZWVm/FBdguIdrSDiIE4SbIMG3BQK2lmTPcv5LejL8ss5TVdfbpoedj4ggxIQqj
         M3mdOQD7HVtXqAJWKNVm73XTCooi9m0oMW3qeEmGFMNVyLs1b+7EaT9VqvmmKTyQucHV
         G04n/OnMw/JTniydY1Jc+qfH4KlMJzGG0bKOGGvVOfDGZc0N0O2Rao07h/VXp8UrE1f0
         iXtO47TDjOTvjJYe8NuXlFJMkVF3S2F3TTd+vALSAsFNAxsn8AI4n2xUIhL+M1ra2anc
         9HwQ==
X-Gm-Message-State: APjAAAX1DGMfVmAe88F879a9XoxfdAFJ14OgY97OplNPG0if7FL9cFo6
        jNVhjC6JjBty3pnsBZgUyewbNA==
X-Google-Smtp-Source: APXvYqzUVBEUQYbYEu3IJ/Auo53ZzZZvSX8WnEY3AnOYhjFIXcB2twRFykVhPJqhZoh9WOxZQNxWmg==
X-Received: by 2002:a5d:4e41:: with SMTP id r1mr1401110wrt.66.1558990548445;
        Mon, 27 May 2019 13:55:48 -0700 (PDT)
Received: from clegane.local (30.94.129.77.rev.sfr.net. [77.129.94.30])
        by smtp.gmail.com with ESMTPSA id a1sm388565wmj.23.2019.05.27.13.55.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 13:55:47 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
Subject: [PATCH V3 6/8] genirq/timings: Add selftest for circular array
Date:   Mon, 27 May 2019 22:55:19 +0200
Message-Id: <20190527205521.12091-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190527205521.12091-1-daniel.lezcano@linaro.org>
References: <20190527205521.12091-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the complexity of the code and the difficulty to debug it,
let's add some selftests to the framework in order to spot issues or
regression at boot time when the runtime testing is enabled for this
subsystem.

This tests the circular buffer at the limits and validates:
 - the encoding / decoding of the values
 - the macro to browse the irq timings circular buffer
 - the function to push data in the circular buffer

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 kernel/irq/Makefile  |   3 ++
 kernel/irq/timings.c | 119 +++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug    |   8 +++
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
index 0d9e81779e37..88e9f398ffd0 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1827,6 +1827,14 @@ config TEST_PARMAN
 
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
-- 
2.17.1

