Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67D9C04AB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935BA20644
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 11:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FIM0wqqC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfEILLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 07:11:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40895 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfEILLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 07:11:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so2458444wre.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 04:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bmjB3BHnekjxDNQPFJ4nw5UiA2KYqoVK/B7ROqlZgj4=;
        b=FIM0wqqC9vb6yllf2xV6CMWDAKauyBh4kfVZkhZh/5vsp4pY92k9c9dATliNsxMT31
         +VR+Jx10oE1/jwJuV6UwW5HsHjxx4SN+2jE53jeGQIF4B3u2hSdbVVoiFejaew2vlYnH
         gt5MLztvIC1GOdmJ53wVLf3PPk0QVPcBHe6MuICKjnKSyDRc98GH3lRNPlKyyXWAFEOV
         zlcevWx2NXKT4F8L3NHKfrBVqk9rUDgzAWCN9iJKySopXXdyeXxTZfIfmiHfldk7MsCh
         f430QoUjCXEcbOi0SIZWEDXWsuD9vITW8Dv6w+zBemm0R29BWKeXwbG4aQjveJfquQk/
         5aeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bmjB3BHnekjxDNQPFJ4nw5UiA2KYqoVK/B7ROqlZgj4=;
        b=QQ/7XLUgCnJDHA21juAZR0xdUN7taK7AqkU49nNNATEPwAK4pvDhG0PvDOhspLARAl
         NYKtIgZVdCVGgeILR87TDt94Cu1uPajzv3+d9DGt6AM9+niaRRwKtP1dO5NIO50FMIto
         QxKlxeBwUWXxCggq0ZoiYK+39iIM5CO0/HzIfh/QaYtmdPVRmGS0xKUV1CJq0YikdxE+
         VMSVrmg6S/Gqec0kjQPenH5mQCd2XxV9+NhK+K7ruS5CZhScelEwh6AUmRRicJ66FiFU
         1RYZsK/8xKduXp2unfBQav6YPb8G7DgtyjIM++VegFI9LLV8M+7iXppkEK8BPqWSjcXD
         VZ2g==
X-Gm-Message-State: APjAAAWNc4DHy0owYirFQyYxK5ekst/6Y7vYOz9g36cC048VpGKSNG1Q
        TvfWA9kHHznuvmy2/ZKS3bQqzA==
X-Google-Smtp-Source: APXvYqxLj5tt2/1wq0URNUB3A98KhTBLetp3g708tPUndgIYoMMlJ5Hlv5QnfU8b+GlSXAJ50rGxyw==
X-Received: by 2002:adf:f487:: with SMTP id l7mr2700119wro.127.1557400297092;
        Thu, 09 May 2019 04:11:37 -0700 (PDT)
Received: from mai.irit.fr ([141.115.39.235])
        by smtp.gmail.com with ESMTPSA id z7sm2299778wme.26.2019.05.09.04.11.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 04:11:36 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:MICROCHIP TIMER
        COUNTER (TC) AND CLOCKSOURCE DR...)
Subject: [PATCH 08/15] clocksource/drivers/tcb_clksrc: Stop depending on atmel_tclib
Date:   Thu,  9 May 2019 13:10:41 +0200
Message-Id: <20190509111048.11151-8-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509111048.11151-1-daniel.lezcano@linaro.org>
References: <7e786ba3-a664-8fd9-dd17-6a5be996a712@linaro.org>
 <20190509111048.11151-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

atmel_tclib is probed too late in the boot process to be able to use the
TCB as the boot clocksource. This is an issue for SoCs without the PIT
(sams70, samv70 and samv71 families) as they simply currently can't boot.

Get rid of the atmel_tclib dependency and probe everything on our own using
the correct device tree binding.

This also allows getting rid of ATMEL_TCB_CLKSRC_BLOCK and makes the driver
a bit more flexible as the TCB is not hardcoded in the kernel anymore.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/tcb_clksrc.c | 108 +++++++++++++++++++------------
 drivers/misc/Kconfig             |  14 +---
 2 files changed, 70 insertions(+), 52 deletions(-)

diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
index 138a12090149..bf68504da94a 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -9,7 +9,8 @@
 #include <linux/err.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
-#include <linux/platform_device.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/syscore_ops.h>
 #include <soc/at91/atmel_tcb.h>
 
@@ -28,13 +29,6 @@
  *     source, used in either periodic or oneshot mode.  This runs
  *     at 32 KiHZ, and can handle delays of up to two seconds.
  *
- * A boot clocksource and clockevent source are also currently needed,
- * unless the relevant platforms (ARM/AT91, AVR32/AT32) are changed so
- * this code can be used when init_timers() is called, well before most
- * devices are set up.  (Some low end AT91 parts, which can run uClinux,
- * have only the timers in one TC block... they currently don't support
- * the tclib code, because of that initialization issue.)
- *
  * REVISIT behavior during system suspend states... we should disable
  * all clocks and save the power.  Easily done for clockevent devices,
  * but clocksources won't necessarily get the needed notifications.
@@ -112,7 +106,6 @@ void tc_clksrc_resume(struct clocksource *cs)
 }
 
 static struct clocksource clksrc = {
-	.name           = "tcb_clksrc",
 	.rating         = 200,
 	.read           = tc_get_cycles,
 	.mask           = CLOCKSOURCE_MASK(32),
@@ -214,7 +207,6 @@ static int tc_next_event(unsigned long delta, struct clock_event_device *d)
 
 static struct tc_clkevt_device clkevt = {
 	.clkevt	= {
-		.name			= "tc_clkevt",
 		.features		= CLOCK_EVT_FEAT_PERIODIC |
 					  CLOCK_EVT_FEAT_ONESHOT,
 		/* Should be lower than at91rm9200's system timer */
@@ -330,39 +322,73 @@ static void __init tcb_setup_single_chan(struct atmel_tc *tc, int mck_divisor_id
 	writel(ATMEL_TC_SYNC, tcaddr + ATMEL_TC_BCR);
 }
 
-static int __init tcb_clksrc_init(void)
-{
-	static char bootinfo[] __initdata
-		= KERN_DEBUG "%s: tc%d at %d.%03d MHz\n";
+static const u8 atmel_tcb_divisors[5] = { 2, 8, 32, 128, 0, };
+
+static const struct of_device_id atmel_tcb_of_match[] = {
+	{ .compatible = "atmel,at91rm9200-tcb", .data = (void *)16, },
+	{ .compatible = "atmel,at91sam9x5-tcb", .data = (void *)32, },
+	{ /* sentinel */ }
+};
 
-	struct platform_device *pdev;
-	struct atmel_tc *tc;
+static int __init tcb_clksrc_init(struct device_node *node)
+{
+	struct atmel_tc tc;
 	struct clk *t0_clk;
+	const struct of_device_id *match;
 	u32 rate, divided_rate = 0;
 	int best_divisor_idx = -1;
 	int clk32k_divisor_idx = -1;
+	int bits;
 	int i;
 	int ret;
 
-	tc = atmel_tc_alloc(CONFIG_ATMEL_TCB_CLKSRC_BLOCK);
-	if (!tc) {
-		pr_debug("can't alloc TC for clocksource\n");
-		return -ENODEV;
+	/* Protect against multiple calls */
+	if (tcaddr)
+		return 0;
+
+	tc.regs = of_iomap(node->parent, 0);
+	if (!tc.regs)
+		return -ENXIO;
+
+	t0_clk = of_clk_get_by_name(node->parent, "t0_clk");
+	if (IS_ERR(t0_clk))
+		return PTR_ERR(t0_clk);
+
+	tc.slow_clk = of_clk_get_by_name(node->parent, "slow_clk");
+	if (IS_ERR(tc.slow_clk))
+		return PTR_ERR(tc.slow_clk);
+
+	tc.clk[0] = t0_clk;
+	tc.clk[1] = of_clk_get_by_name(node->parent, "t1_clk");
+	if (IS_ERR(tc.clk[1]))
+		tc.clk[1] = t0_clk;
+	tc.clk[2] = of_clk_get_by_name(node->parent, "t2_clk");
+	if (IS_ERR(tc.clk[2]))
+		tc.clk[2] = t0_clk;
+
+	tc.irq[2] = of_irq_get(node->parent, 2);
+	if (tc.irq[2] <= 0) {
+		tc.irq[2] = of_irq_get(node->parent, 0);
+		if (tc.irq[2] <= 0)
+			return -EINVAL;
 	}
-	tcaddr = tc->regs;
-	pdev = tc->pdev;
 
-	t0_clk = tc->clk[0];
+	match = of_match_node(atmel_tcb_of_match, node->parent);
+	bits = (uintptr_t)match->data;
+
+	for (i = 0; i < ARRAY_SIZE(tc.irq); i++)
+		writel(ATMEL_TC_ALL_IRQ, tc.regs + ATMEL_TC_REG(i, IDR));
+
 	ret = clk_prepare_enable(t0_clk);
 	if (ret) {
 		pr_debug("can't enable T0 clk\n");
-		goto err_free_tc;
+		return ret;
 	}
 
 	/* How fast will we be counting?  Pick something over 5 MHz.  */
 	rate = (u32) clk_get_rate(t0_clk);
-	for (i = 0; i < 5; i++) {
-		unsigned divisor = atmel_tc_divisors[i];
+	for (i = 0; i < ARRAY_SIZE(atmel_tcb_divisors); i++) {
+		unsigned divisor = atmel_tcb_divisors[i];
 		unsigned tmp;
 
 		/* remember 32 KiHz clock for later */
@@ -381,27 +407,29 @@ static int __init tcb_clksrc_init(void)
 		best_divisor_idx = i;
 	}
 
-
-	printk(bootinfo, clksrc.name, CONFIG_ATMEL_TCB_CLKSRC_BLOCK,
-			divided_rate / 1000000,
+	clksrc.name = kbasename(node->parent->full_name);
+	clkevt.clkevt.name = kbasename(node->parent->full_name);
+	pr_debug("%s at %d.%03d MHz\n", clksrc.name, divided_rate / 1000000,
 			((divided_rate % 1000000) + 500) / 1000);
 
-	if (tc->tcb_config && tc->tcb_config->counter_width == 32) {
+	tcaddr = tc.regs;
+
+	if (bits == 32) {
 		/* use apropriate function to read 32 bit counter */
 		clksrc.read = tc_get_cycles32;
 		/* setup ony channel 0 */
-		tcb_setup_single_chan(tc, best_divisor_idx);
+		tcb_setup_single_chan(&tc, best_divisor_idx);
 	} else {
-		/* tclib will give us three clocks no matter what the
+		/* we have three clocks no matter what the
 		 * underlying platform supports.
 		 */
-		ret = clk_prepare_enable(tc->clk[1]);
+		ret = clk_prepare_enable(tc.clk[1]);
 		if (ret) {
 			pr_debug("can't enable T1 clk\n");
 			goto err_disable_t0;
 		}
 		/* setup both channel 0 & 1 */
-		tcb_setup_dual_chan(tc, best_divisor_idx);
+		tcb_setup_dual_chan(&tc, best_divisor_idx);
 	}
 
 	/* and away we go! */
@@ -410,7 +438,7 @@ static int __init tcb_clksrc_init(void)
 		goto err_disable_t1;
 
 	/* channel 2:  periodic and oneshot timer support */
-	ret = setup_clkevents(tc, clk32k_divisor_idx);
+	ret = setup_clkevents(&tc, clk32k_divisor_idx);
 	if (ret)
 		goto err_unregister_clksrc;
 
@@ -420,14 +448,14 @@ static int __init tcb_clksrc_init(void)
 	clocksource_unregister(&clksrc);
 
 err_disable_t1:
-	if (!tc->tcb_config || tc->tcb_config->counter_width != 32)
-		clk_disable_unprepare(tc->clk[1]);
+	if (bits != 32)
+		clk_disable_unprepare(tc.clk[1]);
 
 err_disable_t0:
 	clk_disable_unprepare(t0_clk);
 
-err_free_tc:
-	atmel_tc_free(tc);
+	tcaddr = NULL;
+
 	return ret;
 }
-arch_initcall(tcb_clksrc_init);
+TIMER_OF_DECLARE(atmel_tcb_clksrc, "atmel,tcb-timer", tcb_clksrc_init);
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 42ab8ec92a04..268a01d3d6f3 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -61,7 +61,8 @@ config ATMEL_TCLIB
 
 config ATMEL_TCB_CLKSRC
 	bool "TC Block Clocksource"
-	depends on ATMEL_TCLIB
+	depends on ARCH_AT91
+	select TIMER_OF if OF
 	default y
 	help
 	  Select this to get a high precision clocksource based on a
@@ -72,17 +73,6 @@ config ATMEL_TCB_CLKSRC
 	  may be used as a clock event device supporting oneshot mode
 	  (delays of up to two seconds) based on the 32 KiHz clock.
 
-config ATMEL_TCB_CLKSRC_BLOCK
-	int
-	depends on ATMEL_TCB_CLKSRC
-	default 0
-	range 0 1
-	help
-	  Some chips provide more than one TC block, so you have the
-	  choice of which one to use for the clock framework.  The other
-	  TC can be used for other purposes, such as PWM generation and
-	  interval timing.
-
 config DUMMY_IRQ
 	tristate "Dummy IRQ handler"
 	default n
-- 
2.17.1

