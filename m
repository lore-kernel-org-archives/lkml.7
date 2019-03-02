Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07949C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 17:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B2D20836
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 17:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="e1c7+Jls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfCBRyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 12:54:22 -0500
Received: from tomli.me ([153.92.126.73]:41934 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbfCBRyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 12:54:19 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id e171ad1a;
        Sat, 2 Mar 2019 17:54:15 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:3d30:3659)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Sat, 02 Mar 2019 17:54:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=1490979754; bh=6LD6rYUgiihDrf8g4Gro8qpoW8HwDq4LErwNr3FWNho=; b=e1c7+Jlsd/4qSLw90KnOm3YRu5lmWsH2kBIG5rEmpZbG9AtcEiCIviorZ+7A9N3YQnVsQ7bX7AMsQWOLqbcLiSP1uQ7VLYh1bqBO6tW+JkWYCV96cpdtX+lqCst2ul1wuLbqVKNNW0jPLayV+cVTOMD3IVjt2MnRre9T7M52eCG73vJHywm30QVhrAspHqjXHD3yIaL1uy3DWhNSBU3wACybg5yhb5NKp13uBAXB8AkJtUoRw95/zRrlKPAxu50Qq5AwoCgWxtUgoi1X4DAXI9D1wUhK5hjcDH0IH3TIjFujZ1qQFP9cATH59krTLGo9RmSTkPuemc/MAMfxU+V//A==
From:   Yifeng Li <tomli@tomli.me>
To:     Lee Jones <lee.jones@linaro.org>, linux-mips@vger.kernel.org
Cc:     Yifeng Li <tomli@tomli.me>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] mips: loongson64: Support System Control Interrupts for Lemote Yeeloong.
Date:   Sun,  3 Mar 2019 01:53:33 +0800
Message-Id: <20190302175334.5103-7-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190302175334.5103-1-tomli@tomli.me>
References: <20190302175334.5103-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware design of Yeeloong laptops is similar to OLPC: low-level
hardware events are processed by the ENE KB3310B Embedded Controller,
which is connected to the AMD CS5536 southbridge through a GPIO port.

When a hardware event occurs, such as a short-circuit on the USB port,
removing the power supply, plugging in a VGA adapter, opening the lid
of the laptop, or pressing a hotkey on the keyboard, the EC sends a
pulse to CS5536, which then fires a System Control Interrupt to notify
the kernel.

In the previous attempted submission, the logic for handling SCI and
hotkeys was tightly-coupled, and the driver was called the "hotkey"
driver, which was misleading. In this implementation of sci.c, we only
handle the minimum number of things that deal with the underlying
platform hardware directly, such as setting up the CS5536 GPIO and IRQ,
handling the the power supply of USB and camera. The vast majority of
events are passed to the subdrivers via a notification chain, thus,
the SCI logic and the specific hotkey handling logic have been decoupled.

Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 arch/mips/loongson64/lemote-2f/Makefile |   2 +-
 arch/mips/loongson64/lemote-2f/sci.c    | 392 ++++++++++++++++++++++++
 2 files changed, 393 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/loongson64/lemote-2f/sci.c

diff --git a/arch/mips/loongson64/lemote-2f/Makefile b/arch/mips/loongson64/lemote-2f/Makefile
index 2b18752424ee..af4a1d347884 100644
--- a/arch/mips/loongson64/lemote-2f/Makefile
+++ b/arch/mips/loongson64/lemote-2f/Makefile
@@ -2,7 +2,7 @@
 # Makefile for lemote loongson2f family machines
 #
 
-obj-y += clock.o machtype.o irq.o reset.o dma.o platform.o
+obj-y += clock.o machtype.o irq.o reset.o dma.o platform.o sci.o
 
 #
 # Suspend Support
diff --git a/arch/mips/loongson64/lemote-2f/sci.c b/arch/mips/loongson64/lemote-2f/sci.c
new file mode 100644
index 000000000000..96e376f00ecc
--- /dev/null
+++ b/arch/mips/loongson64/lemote-2f/sci.c
@@ -0,0 +1,392 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Support for Lemote Yeeloong System Control Interrupts (SCI)
+ *
+ * Copyright (C) 2009 Lemote Inc.
+ * Author: Wu Zhangjin <wuzhangjin@gmail.com>
+ *         Liu Junliang <liujl@lemote.com>
+ *
+ * Copyright (C) 2012, 2013, 2014, 2015 Petr Pisar
+ * Author: Petr Pisar <petr.pisar@atlas.cz> (bugfixes)
+ *
+ * Copyright (C) 2017 Jiaxun Yang
+ * Author: Jiaxun Yang <jiaxun.yang@flygoat.com>
+ *
+ * Copyright (C) 2019 Yifeng Li
+ * Author: Yifeng Li <tomli@tomli.me>
+ *
+ * The hardware design of Yeeloong laptops is similar to OLPC: low-level
+ * hardware events are processed by the ENE KB3310B Embedded Controller,
+ * which is connected to the AMD CS5536 southbridge through a GPIO port.
+ *
+ * When a hardware event occurs, such as a short-circuit on the USB port,
+ * removing the power supply, plugging in a VGA adapter, opening the lid
+ * of the laptop, or pressing a hotkey on the keyboard, the EC sends a
+ * pulse to CS5536, which then fires a System Control Interrupt to notify
+ * the kernel.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/export.h>
+#include <linux/power_supply.h>
+#include <linux/backlight.h>
+#include <linux/mfd/yeeloong_kb3310b.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/suspend.h>
+
+#include <loongson.h>
+#include <cs5536/cs5536.h>
+
+static void usb_power_set(bool power)
+{
+	kb3310b_write(KB3310B_REG_USB0_FLAG, power);
+	kb3310b_write(KB3310B_REG_USB1_FLAG, power);
+	kb3310b_write(KB3310B_REG_USB2_FLAG, power);
+}
+
+static void camera_power_set(bool power)
+{
+	kb3310b_write(KB3310B_REG_CAMERA_CONTROL, power);
+}
+
+/*
+ * Handlers for EC events. We only handles the bare-minimum number of events
+ * directly related to the platform hardware. Other events are reported to
+ * subdrivers and handled by them.
+ */
+static void usb0_handler(void)
+{
+	pr_emerg("USB0 Overcurrent occurred!\n");
+}
+
+static void usb2_handler(void)
+{
+	pr_emerg("USB2 Overcurrent occurred!\n");
+}
+
+static void camera_handler(void)
+{
+	camera_power_set(!kb3310b_read(KB3310B_REG_CAMERA_CONTROL));
+}
+
+/*
+ * SCI notifiers. This notifier reports EC events to various
+ * subdrivers.
+ */
+static BLOCKING_NOTIFIER_HEAD(yeeloong_sci_notifier_list);
+
+int yeeloong_sci_register_notify(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&yeeloong_sci_notifier_list,
+						nb);
+}
+EXPORT_SYMBOL_GPL(yeeloong_sci_register_notify);
+
+int yeeloong_sci_unregister_notify(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&yeeloong_sci_notifier_list,
+						nb);
+}
+EXPORT_SYMBOL_GPL(yeeloong_sci_unregister_notify);
+
+/*
+ * Do not handle or notify other drivers about certain events while we're
+ * going down to reboot or sleep. This avoids unexpected behaviors in the
+ * userspace, such as closing the laptop lid while rebooting.
+ */
+static atomic_t reboot_flag;
+static atomic_t sleep_flag;
+
+static int
+notify_reboot(struct notifier_block *nb, unsigned long event, void *buf)
+{
+	switch (event) {
+	case SYS_RESTART:
+	case SYS_HALT:
+	case SYS_POWER_OFF:
+		atomic_set(&reboot_flag, 1);
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
+static int
+notify_pm(struct notifier_block *nb, unsigned long event, void *buf)
+{
+	switch (event) {
+	case PM_HIBERNATION_PREPARE:
+	case PM_SUSPEND_PREPARE:
+		atomic_inc(&sleep_flag);
+		break;
+	case PM_POST_HIBERNATION:
+	case PM_POST_SUSPEND:
+	case PM_RESTORE_PREPARE:        /* do we need this ?? */
+		atomic_dec(&sleep_flag);
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block reboot_notifier = {
+	.notifier_call = notify_reboot,
+};
+
+static struct notifier_block pm_notifier = {
+	.notifier_call = notify_pm,
+};
+
+static bool is_spurious_event(int event)
+{
+	if (event == KB3310B_EVENT_LID || event == KB3310B_EVENT_SLEEP)
+		return !!(atomic_read(&reboot_flag) | atomic_read(&sleep_flag));
+	else
+		return false;
+}
+
+/*
+ * Invoke the handler of the reported SCI event.
+ */
+static void process_sci_event(int event)
+{
+	if (is_spurious_event(event))
+		return;
+
+	switch (event) {
+	case KB3310B_EVENT_USB_OC0:
+		usb0_handler();
+		break;
+	case KB3310B_EVENT_USB_OC2:
+		usb2_handler();
+		break;
+	case KB3310B_EVENT_CAMERA:
+		camera_handler();
+		break;
+	default:
+		break;
+	}
+
+	/*
+	 * Report this event to other subdrivers, in particular, yeeloong-hotkey
+	 * driver will report the hotkey to userspace.
+	 */
+	blocking_notifier_call_chain(&yeeloong_sci_notifier_list, event, NULL);
+}
+
+/*
+ * Handle the SCI event and perform the needed action.
+ *
+ * A SCI event lasts about 120 microseconds. It means the function must take
+ * longer than 120 microseconds to complete. It has been shown that the function
+ * already takes 3 ms, so no artificial delay is needed.
+ */
+static irqreturn_t sci_irq_handler(int irq, void *dev_id)
+{
+	int ret, event;
+
+	if (irq != KB3310B_SCI_IRQ_NUM)
+		return IRQ_NONE;
+
+	/* query the event number */
+	ret = kb3310b_query_event_num();
+	if (ret < 0)
+		return IRQ_NONE;
+
+	event = kb3310b_get_event_num();
+	if (event < KB3310B_EVENT_START || event > KB3310B_EVENT_END)
+		return IRQ_NONE;
+
+	/* execute the corresponding action */
+	process_sci_event(event);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * Program the GPIO and MSR registers on CS5536.
+ *
+ * TODO: Linux kernel already has a cs5535-gpio kernel driver, but that
+ *       driver not adapted for Loongson. It's desirable to convert these
+ *       raw operations to use cs5535-gpio. Also, Loongson has its own
+ *       CS5536 clocksource driver, though Linux already has cs5535-clockevt,
+ *       but only supports clockevent, not clocksource. Clocksource code
+ *       should be merged into cs5535-clockevt and Loongson should use
+ *       that, too.
+ */
+static int setup_ec_sci(void)
+{
+	u32 hi, lo;
+	u32 gpio_base;
+	unsigned long flags;
+	int ret;
+
+	/* Get GPIO base */
+	_rdmsr(DIVIL_MSR_REG(DIVIL_LBAR_GPIO), &hi, &lo);
+	gpio_base = lo & 0xff00;
+
+	/*
+	 * HACK: to prevent any interrupts from being fired, we query
+	 * the EC to clear the pending event, and wait for a while to
+	 * miss the interrupt intentionally.
+	 */
+	ret = kb3310b_query_event_num();
+	if (ret)
+		return ret;
+
+	/* wait for a while */
+	mdelay(10);
+
+	/*
+	 * Set GPIO native registers and MSRs for GPIO-27 SCI EVENT PIN
+	 *
+	 * MSR:
+	 *     no primary and LPC.
+	 *     Unrestricted Z Input 8 to IG-10 from Virtual GPIO-0.
+	 *
+	 * GPIO mode:
+	 *     input, pull-up, no-invert, event-count and value 0,
+	 *     no-filter, no-edge. GPIO-27 map to Virtual GPIO-0.
+	 */
+	local_irq_save(flags);
+
+	/* set primary mask */
+	_rdmsr(0x80000024, &hi, &lo);
+	lo &= ~(1 << 10);
+	_wrmsr(0x80000024, hi, lo);
+
+	/* set LPC mask */
+	_rdmsr(0x80000025, &hi, &lo);
+	lo &= ~(1 << 10);
+	_wrmsr(0x80000025, hi, lo);
+
+	/* set Unrestricted Z map */
+	_rdmsr(0x80000023, &hi, &lo);
+	lo |= (0x0a << 0);
+	_wrmsr(0x80000023, hi, lo);
+
+	local_irq_restore(flags);
+
+	asm(".set noreorder\n");
+	outl(0x00000800, (gpio_base | 0xA0));  /* GPIO-27 input enable */
+	outl(0x00000800, (gpio_base | 0xA4));  /* GPIO-27 input invert */
+	outl(0x00000800, (gpio_base | 0xB8));  /* GPIO-27 event-int enable */
+	asm(".set reorder\n");
+
+	return 0;
+}
+
+/*
+ * Setup the IRQ handler for SCI. Must be called after setup_ec_sci().
+ */
+static int setup_sci_interrupt(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = request_threaded_irq(KB3310B_SCI_IRQ_NUM, NULL, &sci_irq_handler,
+					IRQF_ONESHOT, "sci", NULL);
+	if (ret)
+		dev_err(&pdev->dev, "unable to request interrupt!\n");
+
+	return ret;
+}
+
+static int yeeloong_sci_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	camera_power_set(KB3310B_BIT_CAMERA_CONTROL_OFF);
+	usb_power_set(KB3310B_BIT_USB_FLAG_ON);
+
+	ret = register_reboot_notifier(&reboot_notifier);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to register reboot_notifier!\n");
+		goto fail;
+	}
+
+	ret = register_pm_notifier(&pm_notifier);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to register pm_notifier!\n");
+		goto fail_reboot;
+	}
+
+	ret = setup_ec_sci();
+	if (ret) {
+		dev_err(&pdev->dev, "unable to setup EC SCI!\n");
+		goto fail_irq;
+	}
+
+	ret = setup_sci_interrupt(pdev);
+	if (ret)
+		goto fail_irq;
+
+	return ret;
+
+fail_irq:
+	free_irq(KB3310B_SCI_IRQ_NUM, NULL);
+	unregister_pm_notifier(&pm_notifier);
+fail_reboot:
+	unregister_reboot_notifier(&reboot_notifier);
+fail:
+	return ret;
+}
+
+#ifdef CONFIG_SUSPEND
+static int
+yeeloong_sci_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	usb_power_set(KB3310B_BIT_USB_FLAG_OFF);
+	camera_power_set(KB3310B_BIT_CAMERA_CONTROL_OFF);
+	return 0;
+}
+
+static int yeeloong_sci_resume(struct platform_device *pdev)
+{
+	int ret;
+
+	usb_power_set(KB3310B_BIT_USB_FLAG_ON);
+
+	ret = setup_ec_sci();
+	if (ret) {
+		dev_err(&pdev->dev, "unable to setup EC SCI!\n");
+		return -EFAULT;
+	}
+
+	/*
+	 * Lid switch and power supply may hawe changed while we were
+	 * asleep, so we generate a KB3310B_EVENT_LID and KB3310B_EVENT_AC_BAT
+	 * events to force the hotkey/battery subdriver to report their new
+	 * states.
+	 */
+	blocking_notifier_call_chain(&yeeloong_sci_notifier_list,
+						KB3310B_EVENT_LID, NULL);
+	blocking_notifier_call_chain(&yeeloong_sci_notifier_list,
+						KB3310B_EVENT_AC_BAT, NULL);
+
+	return 0;
+}
+#endif
+
+static struct platform_driver yeeloong_sci_driver = {
+	.driver = {
+		.name = "yeeloong_sci",
+	},
+	.probe = yeeloong_sci_probe,
+#ifdef CONFIG_SUSPEND
+	.suspend = yeeloong_sci_suspend,
+	.resume = yeeloong_sci_resume,
+#endif
+};
+
+static int __init yeeloong_sci_init(void)
+{
+	return platform_driver_register(&yeeloong_sci_driver);
+}
+arch_initcall(yeeloong_sci_init);
-- 
2.20.1

