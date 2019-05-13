Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07DBC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C29208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kKIiE2T7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfEMKaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 06:30:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40667 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbfEMKaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 06:30:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id h11so13074198wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 03:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mR7EEZ3aUUw52vrsHVUGLaXGM2W4darF/cVAQlTAvMk=;
        b=kKIiE2T73q92wZkdJaz59Ou5mIDun42zy5V6pPnKEOEGSnQxfMDbcbjysw/3jRhlEv
         RsZOw2EGYFkZQjh6rf8KA/Gvl728v1s2wexOmRboRdzcAUK5NJdRYU/YfcDfay6uDxBA
         VUdiZlInqKY+ho5wblgw0a+gI4wp/U9Jsm80OOgtTr0wrScZuukLRKQOVH7yvZSMwvUy
         i0vMbsP67tW9bdmxS1NlmFu31iy4d+mlj6uDSy0xvaQDVC3slg3dKwhjCHmaA5R/YO55
         dwrrMl/oKCNqnmabufJSP0v/RhELonzzxhYxluosvhx3v0jtY3knPIoVHEm7pfSe8tDa
         U2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mR7EEZ3aUUw52vrsHVUGLaXGM2W4darF/cVAQlTAvMk=;
        b=hcNW9IIKwOkz6ds1X1ZMb8vrhtq9yLF6A0tLxjx6ogIitoZkhUp3Obv3DTnGLk4w04
         Kx9C3THRlrHVzk6HBaibowmCdRlEKDW+hu+j+BPGtpTqgqEb3AP8U46qMP5aW6atCaXE
         bfwk/FH9W6YgYTqwDixV1KyMuGlcxaxsqZ9cUNMvvqaDPW/m8gzK2+eMIceA3WNVWxrw
         HOgKMI1qo+jg6VTa8aZ0OcZRNPOOHlUUE2060lyuunJVmRwVhM1i9NBVRaZ1GU9VOlZ7
         HjTKmq9tDMOAeZpMn3yFa7wbt3hSXuKNsqe82Ve09h+56yoEOUPsOO5N9UXJNz5TRpoG
         sjAw==
X-Gm-Message-State: APjAAAXVXBDdjhilul2F9sVHbwAlYEFPJGXsTO+ZkzHzacZs1EgzsflN
        GTtW+nfasDkZcGAWyOKyyRmltw==
X-Google-Smtp-Source: APXvYqz0w5vNFmcP8tl6Bl8fJ61vh44CbgiPrKbtW7JcB+h5Ha+NKOOpu0pkUURi1o3cKMjaNB9eLA==
X-Received: by 2002:a1c:9a14:: with SMTP id c20mr14336565wme.61.1557743416890;
        Mon, 13 May 2019 03:30:16 -0700 (PDT)
Received: from clegane.local (205.29.129.77.rev.sfr.net. [77.129.29.205])
        by smtp.gmail.com with ESMTPSA id v192sm13645238wme.24.2019.05.13.03.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 03:30:16 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Robin Murphy <robin.murphy@arm.com>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Changbin Du <changbin.du@intel.com>
Subject: [PATCH 7/9] genirq/timings: Add selftest for circular array
Date:   Mon, 13 May 2019 12:29:51 +0200
Message-Id: <20190513102953.16424-8-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513102953.16424-1-daniel.lezcano@linaro.org>
References: <20190513102953.16424-1-daniel.lezcano@linaro.org>
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
 lib/Kconfig.debug    |   9 ++++
 3 files changed, 131 insertions(+)

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
index 02689e6168c4..dae04117796c 100644
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
@@ -626,3 +628,120 @@ int irq_timings_alloc(int irq)
 
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
index 0d9e81779e37..a05c6695f6f9 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1827,6 +1827,15 @@ config TEST_PARMAN
 
 	  If unsure, say N.
 
+config TEST_IRQ_TIMINGS
+	bool "IRQ timings selftest"
+	default n
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

