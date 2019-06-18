Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D36C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565DE20863
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbfFRIcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 04:32:08 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:21018 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfFRIcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:32:07 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 6503C51319;
        Tue, 18 Jun 2019 10:32:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id CGbYZOAwNtNM; Tue, 18 Jun 2019 10:32:01 +0200 (CEST)
From:   Stefan Roese <sr@denx.de>
To:     linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH 1/3 v8] serial: mctrl_gpio: Check if GPIO property exisits before requesting it
Date:   Tue, 18 Jun 2019 10:31:58 +0200
Message-Id: <20190618083200.30234-1-sr@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a check for the GPIOs property existence, before the
GPIO is requested. This fixes an issue seen when the 8250 mctrl_gpio
support is added (2nd patch in this patch series) on x86 platforms using
ACPI.

Here Mika's comments from 2016-08-09:

"
I noticed that with v4.8-rc1 serial console of some of our Broxton
systems does not work properly anymore. I'm able to see output but input
does not work.

I bisected it down to commit 4ef03d328769eddbfeca1f1c958fdb181a69c341
("tty/serial/8250: use mctrl_gpio helpers").

The reason why it fails is that in ACPI we do not have names for GPIOs
(except when _DSD is used) so we use the "idx" to index into _CRS GPIO
resources. Now mctrl_gpio_init_noauto() goes through a list of GPIOs
calling devm_gpiod_get_index_optional() passing "idx" of 0 for each. The
UART device in Broxton has following (simplified) ACPI description:

    Device (URT4)
    {
        ...
        Name (_CRS, ResourceTemplate () {
            GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
                    "\\_SB.GPO0", 0x00, ResourceConsumer)
            {
                0x003A
            }
            GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
                    "\\_SB.GPO0", 0x00, ResourceConsumer)
            {
                0x003D
            }
        })

In this case it finds the first GPIO (0x003A which happens to be RX pin
for that UART), turns it into GPIO which then breaks input for the UART
device. This also breaks systems with bluetooth connected to UART (those
typically have some GPIOs in their _CRS).

Any ideas how to fix this?

We cannot just drop the _CRS index lookup fallback because that would
break many existing machines out there so maybe we can limit this to
only DT enabled machines. Or alternatively probe if the property first
exists before trying to acquire the GPIOs (using
device_property_present()).
"

This patch implements the fix suggested by Mika in his statement above.

Signed-off-by: Stefan Roese <sr@denx.de>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Yegor Yefremov <yegorslists@googlemail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Yegor Yefremov <yegorslists@googlemail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
v8:
- Rebased on top of "tty-next"

v7:
- Include <linux/property.h> to fix compile breakage on OMAP

v6:
- No change

v5:
- Simplified the code a bit (Andy)
- Added gpio_str == NULL handling (Andy)

v4:
- Add missing free() calls (Johan)
- Added Mika's reviewed by tag
- Added Johan to Cc

v3:
- No change

v2:
- Include the problem description and analysis from Mika into the commit
  text, as suggested by Greg.

 drivers/tty/serial/serial_mctrl_gpio.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
index 39ed56214cd3..2b400189be91 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -12,6 +12,7 @@
 #include <linux/termios.h>
 #include <linux/serial_core.h>
 #include <linux/module.h>
+#include <linux/property.h>
 
 #include "serial_mctrl_gpio.h"
 
@@ -116,6 +117,19 @@ struct mctrl_gpios *mctrl_gpio_init_noauto(struct device *dev, unsigned int idx)
 
 	for (i = 0; i < UART_GPIO_MAX; i++) {
 		enum gpiod_flags flags;
+		char *gpio_str;
+		bool present;
+
+		/* Check if GPIO property exists and continue if not */
+		gpio_str = kasprintf(GFP_KERNEL, "%s-gpios",
+				     mctrl_gpios_desc[i].name);
+		if (!gpio_str)
+			continue;
+
+		present = device_property_present(dev, gpio_str);
+		kfree(gpio_str);
+		if (!present)
+			continue;
 
 		if (mctrl_gpios_desc[i].dir_out)
 			flags = GPIOD_OUT_LOW;
-- 
2.22.0

