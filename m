Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4EBC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27822208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfD0Mx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:53:27 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:39275 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbfD0MxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:24 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MVNF1-1hBGYO2EDP-00SLNE; Sat, 27 Apr 2019 14:52:59 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, andrew@aj.id.au,
        andriy.shevchenko@linux.intel.com, macro@linux-mips.org,
        vz@mleia.com, slemieux.tyco@gmail.com, khilman@baylibre.com,
        liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com, davem@davemloft.net, jacmet@sunsite.dk,
        linux@prisktech.co.nz, matthias.bgg@gmail.com,
        linux-mips@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: [PATCH 30/41] drivers: tty: serial: ioc4_serial: use dev_warn() instead of printk()
Date:   Sat, 27 Apr 2019 14:52:11 +0200
Message-Id: <1556369542-13247-31-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:feZjQEPGewpWSo2bykBkAQkXP9Lb/ZtVsJ70Hc9aX4own7v09FA
 e65s7fBpQb+RWeo/XsvBCLQDRKkUOdSWYbg6QCmXdWbNheYrxgq5Ys1L3nrokeJAVzT8JZ+
 6QZ7hrXczsjiQ2m1ogHA/r87Uy8zuLwqRpXTsIxH63Kg2ZR+GURXbvN2XWzuqCWUQaBZhlg
 o8S6PJbm8wTsqW6D1wobQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8TG/EySvt9A=:VKahn7CYd/R5vatknv4CIz
 CuHG0PZc2i5j9rVD60N2maMJL4Ee3r65/zW8DaiDk+zAPuKZD49EeMp7iaffcOumkyFaqiM8t
 +luCUaXSLZIf7RHuNFPwRYcBWNJ43cJi7sjf0EHHDGmub/EKExgGhgCrjEfa0v+n+448YXMgE
 lGF3w6/V6Mgt1QZ5pNXeWF0kTQsNJjAb7Y4RqIw7ZbAc+O3V+I9zXf7nSK2JbDaCL8Him2L7f
 l8QQc+xgVlpNQR0jiD9vdU52hQtY39fI4sqfbvjUsfJnu4SqVjwhNe4jH1PXOZTv5gTw84KBZ
 NkibSYlQFV3awhW8T9jAFhE9jtPnkYU0Vs7Ac1Oe4MMGZFJvBTZRRyNkitSl8XQbZ1WJfAlbB
 QS1OAIo9avolslFua/Nuq/y/iOLsNuT9C2ZFuqk4vJzoHfqjcS7qf3z/aagtWWj2Cq7D07Jvt
 HRLmuFLEuheS+vbBf2jp8nw1xQnRmOgDpcdn5L0cxoJx5Y57gx7DwS6uPN2nKaFxix4vbFLNZ
 AfH6XBWoj2lDLI2NKOg+owgscan6/eCmalRceowjyuyrdih0blP0ytyJ94NiELQlWc6HPoOGw
 OFryiG/2U3f/JVqdBhE2/2V0LKzJG1PwuuFYf5G3HVrAhwcwAJIDkFusy40yS4hP/fLgStVPA
 +nzeqpksFBXQvdpgCQwJ1DcGyWuv+kODQ2uT2nLMPRKYF2bVBXURnsDyBNucI4/XBJ4wnPMl7
 6d+ueE0QRBCjWMFi9IaYeMV9hXPhSTm8QIcgHQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using dev_warn() instead of printk() for more consistent output.
(prints device name, etc).

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/ioc4_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/ioc4_serial.c b/drivers/tty/serial/ioc4_serial.c
index db5b979..21c1b8f 100644
--- a/drivers/tty/serial/ioc4_serial.c
+++ b/drivers/tty/serial/ioc4_serial.c
@@ -2752,7 +2752,7 @@ static int ioc4_serial_remove_one(struct ioc4_driver_data *idd)
 		the_port->dev = &pdev->dev;
 		spin_lock_init(&the_port->lock);
 		if (uart_add_one_port(u_driver, the_port) < 0) {
-			printk(KERN_WARNING
+			dev_warn(&pdev->dev,
 		           "%s: unable to add port %d bus %d\n",
 			       __func__, the_port->line, pdev->bus->number);
 		} else {
-- 
1.9.1

