Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52A8C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 05:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E012077B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 05:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732076AbfLMF05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 00:26:57 -0500
Received: from lucky1.263xmail.com ([211.157.147.135]:42404 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfLMF05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 00:26:57 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Dec 2019 00:26:05 EST
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id D99FC4CEC3;
        Fri, 13 Dec 2019 13:18:50 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (42.17.110.36.static.bjtelecom.net [36.110.17.42])
        by smtp.263.net (postfix) whith ESMTP id P12514T140025888880384S1576214251829137_;
        Fri, 13 Dec 2019 13:18:52 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <02d9743777686192730effedd29ab06d>
X-RL-SENDER: chengang@emindsoft.com.cn
X-SENDER: chengang@emindsoft.com.cn
X-LOGIN-NAME: chengang@emindsoft.com.cn
X-FST-TO: gregkh@linuxfoundation.org
X-SENDER-IP: 36.110.17.42
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 5
From:   chengang@emindsoft.com.cn
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        andriy.shevchenko@linux.intel.com, sr@denx.de,
        mika.westerberg@linux.intel.com, yegorslists@googlemail.com,
        yuehaibing@huawei.com, haolee.swjtu@gmail.com, dsterba@suse.com,
        mojha@codeaurora.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Gang <chengang@emindsoft.com.cn>,
        Lv Li-song <lvlisong@emindsoft.com.cn>
Subject: [PATCH] drivers: tty: serial: 8250: fintek: Can enable or disable irq sharing based on isa or pci bus
Date:   Fri, 13 Dec 2019 13:17:17 +0800
Message-Id: <20191213051717.2058-1-chengang@emindsoft.com.cn>
X-Mailer: git-send-email 2.24.0.308.g228f53135a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Gang <chengang@emindsoft.com.cn>

Sorry for this patch being too late, which is for linux-next 20151127 (
about linux 4.4-rc2).  After 4 years, much things have been changed. But
I think it might be still valuable for some old versions. Welcome anyone
to refact this patch for their own.

Fintek serial ports can share irq, but they need be enabled firstly, so
enable or disable irq sharing based on isa or pci bus. From kconfig, it
can be configured.

For integrated 8250 drivers, kernel always calls pnp driver, which will
not use integrated fintek driver for ever. So let pnp driver try the
other drivers firstly (e.g. fintek), if fail, try pnp driver its own.

Cc: Lv Li-song <lvlisong@emindsoft.com.cn>
Signed-off-by: Chen Gang <chengang@emindsoft.com.cn>
---
 drivers/tty/serial/8250/8250.h        |   9 +++
 drivers/tty/serial/8250/8250_fintek.c | 130 +++++++++++++++++++++-------------
 drivers/tty/serial/8250/8250_pnp.c    |  13 +++-
 drivers/tty/serial/8250/Kconfig       |  26 +++++++
 4 files changed, 129 insertions(+), 49 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index d54dcd8..a6e3245 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -14,6 +14,7 @@
 #include <linux/serial_8250.h>
 #include <linux/serial_reg.h>
 #include <linux/dmaengine.h>
+#include <linux/pnp.h>
 
 struct uart_8250_dma {
 	int (*tx_dma)(struct uart_8250_port *p);
@@ -130,6 +131,9 @@ void serial8250_rpm_put(struct uart_8250_port *p);
 #endif
 
 #ifdef CONFIG_SERIAL_8250_PNP
+struct pnp_base_data {
+	struct pnp_driver *driver;
+};
 int serial8250_pnp_init(void);
 void serial8250_pnp_exit(void);
 #else
@@ -137,6 +141,11 @@ static inline int serial8250_pnp_init(void) { return 0; }
 static inline void serial8250_pnp_exit(void) { }
 #endif
 
+#ifdef CONFIG_SERIAL_8250_FINTEK
+extern int
+fintek_8250_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id);
+#endif
+
 #ifdef CONFIG_ARCH_OMAP1
 static inline int is_omap1_8250(struct uart_8250_port *pt)
 {
diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index 8947439..50c4ed7e 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -38,9 +38,15 @@
 #define RXW4C_IRA BIT(3)
 #define TXW4C_IRA BIT(2)
 
+#define ICSR   0x70
+#define IRQ_SHARING_MOD 0x10
+#define PCI_IRQ_SHARING 0x00
+#define ISA_IRQ_SHARING 0x20
+
 #define DRIVER_NAME "8250_fintek"
 
 struct fintek_8250 {
+	struct pnp_base_data base; /* must be the first */
 	u16 base_port;
 	u8 index;
 	u8 key;
@@ -138,6 +144,31 @@ static int fintek_8250_rs485_config(struct uart_port *port,
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_SERIAL_8250_FINTEK_IRQ_SHARING)
+
+static void set_icsr(u16 base_port, u8 index)
+{
+	uint8_t icsr = 0;
+
+	outb(LDN, base_port + ADDR_PORT);
+	outb(index, base_port + DATA_PORT);
+	outb(ICSR, base_port + ADDR_PORT);
+	icsr = inb(base_port + DATA_PORT);
+
+	if (icsr != 0xff) {
+		icsr |= IRQ_SHARING_MOD;
+#if IS_ENABLED(CONFIG_SERIAL_8250_FINTEK_IRQ_SHARING_ISA)
+		icsr |= ISA_IRQ_SHARING;
+#else
+		icsr |= PCI_IRQ_SHARING;
+#endif
+		outb(ICSR, base_port + ADDR_PORT);
+		outb(icsr, base_port + DATA_PORT);
+	}
+}
+
+#endif
+
 static int fintek_8250_base_port(u16 io_address, u8 *key, u8 *index)
 {
 	static const u16 addr[] = {0x4e, 0x2e};
@@ -166,7 +197,9 @@ static int fintek_8250_base_port(u16 io_address, u8 *key, u8 *index)
 				aux |= inb(addr[i] + DATA_PORT) << 8;
 				if (aux != io_address)
 					continue;
-
+#if IS_ENABLED(CONFIG_SERIAL_8250_FINTEK_IRQ_SHARING)
+				set_icsr(addr[i], k);
+#endif
 				fintek_8250_exit_key(addr[i]);
 				*key = keys[j];
 				*index = k;
@@ -179,53 +212,6 @@ static int fintek_8250_base_port(u16 io_address, u8 *key, u8 *index)
 	return -ENODEV;
 }
 
-static int
-fintek_8250_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
-{
-	struct uart_8250_port uart;
-	struct fintek_8250 *pdata;
-	int base_port;
-	u8 key;
-	u8 index;
-
-	if (!pnp_port_valid(dev, 0))
-		return -ENODEV;
-
-	base_port = fintek_8250_base_port(pnp_port_start(dev, 0), &key, &index);
-	if (base_port < 0)
-		return -ENODEV;
-
-	memset(&uart, 0, sizeof(uart));
-
-	pdata = devm_kzalloc(&dev->dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
-		return -ENOMEM;
-	uart.port.private_data = pdata;
-
-	if (!pnp_irq_valid(dev, 0))
-		return -ENODEV;
-	uart.port.irq = pnp_irq(dev, 0);
-	uart.port.iobase = pnp_port_start(dev, 0);
-	uart.port.iotype = UPIO_PORT;
-	uart.port.rs485_config = fintek_8250_rs485_config;
-
-	uart.port.flags |= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
-	if (pnp_irq_flags(dev, 0) & IORESOURCE_IRQ_SHAREABLE)
-		uart.port.flags |= UPF_SHARE_IRQ;
-	uart.port.uartclk = 1843200;
-	uart.port.dev = &dev->dev;
-
-	pdata->key = key;
-	pdata->base_port = base_port;
-	pdata->index = index;
-	pdata->line = serial8250_register_8250_port(&uart);
-	if (pdata->line < 0)
-		return -ENODEV;
-
-	pnp_set_drvdata(dev, pdata);
-	return 0;
-}
-
 static void fintek_8250_remove(struct pnp_dev *dev)
 {
 	struct fintek_8250 *pdata = pnp_get_drvdata(dev);
@@ -276,6 +262,54 @@ static struct pnp_driver fintek_8250_driver = {
 	.id_table	= fintek_dev_table,
 };
 
+int
+fintek_8250_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
+{
+	struct uart_8250_port uart;
+	struct fintek_8250 *pdata;
+	int base_port;
+	u8 key;
+	u8 index;
+
+	if (!pnp_port_valid(dev, 0))
+		return -ENODEV;
+
+	base_port = fintek_8250_base_port(pnp_port_start(dev, 0), &key, &index);
+	if (base_port < 0)
+		return -ENODEV;
+
+	memset(&uart, 0, sizeof(uart));
+
+	pdata = devm_kzalloc(&dev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+	uart.port.private_data = pdata;
+
+	if (!pnp_irq_valid(dev, 0))
+		return -ENODEV;
+	uart.port.irq = pnp_irq(dev, 0);
+	uart.port.iobase = pnp_port_start(dev, 0);
+	uart.port.iotype = UPIO_PORT;
+	uart.port.rs485_config = fintek_8250_rs485_config;
+
+	uart.port.flags |= UPF_SKIP_TEST | UPF_BOOT_AUTOCONF;
+	if (pnp_irq_flags(dev, 0) & IORESOURCE_IRQ_SHAREABLE)
+		uart.port.flags |= UPF_SHARE_IRQ;
+	uart.port.uartclk = 1843200;
+	uart.port.dev = &dev->dev;
+
+	pdata->key = key;
+	pdata->base_port = base_port;
+	pdata->index = index;
+	pdata->line = serial8250_register_8250_port(&uart);
+	if (pdata->line < 0)
+		return -ENODEV;
+	pdata->base.driver = &fintek_8250_driver;
+
+	pnp_set_drvdata(dev, pdata);
+	return 0;
+}
+
 module_pnp_driver(fintek_8250_driver);
 MODULE_DESCRIPTION("Fintek F812164 module");
 MODULE_AUTHOR("Ricardo Ribalda <ricardo.ribalda@gmail.com>");
diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index 658b392..af43a4c 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -438,8 +438,13 @@ static int
 serial_pnp_probe(struct pnp_dev *dev, const struct pnp_device_id *dev_id)
 {
 	struct uart_8250_port uart, *port;
-	int ret, line, flags = dev_id->driver_data;
+	int ret, line, flags;
 
+#if IS_BUILTIN(CONFIG_SERIAL_8250_FINTEK)
+	if (!fintek_8250_probe(dev, dev_id))
+		return 0;
+#endif
+	flags = dev_id->driver_data;
 	if (flags & UNKNOWN_DEV) {
 		ret = serial_pnp_guess_board(dev);
 		if (ret < 0)
@@ -494,6 +499,8 @@ static void serial_pnp_remove(struct pnp_dev *dev)
 {
 	long line = (long)pnp_get_drvdata(dev);
 
+	if (line > CONFIG_SERIAL_8250_NR_UARTS)
+		((struct pnp_base_data *)line)->driver->remove(dev);
 	dev->capabilities &= ~PNP_CONSOLE;
 	if (line)
 		serial8250_unregister_port(line - 1);
@@ -504,6 +511,8 @@ static int serial_pnp_suspend(struct pnp_dev *dev, pm_message_t state)
 {
 	long line = (long)pnp_get_drvdata(dev);
 
+	if (line > CONFIG_SERIAL_8250_NR_UARTS)
+		((struct pnp_base_data *)line)->driver->suspend(dev, state);
 	if (!line)
 		return -ENODEV;
 	serial8250_suspend_port(line - 1);
@@ -514,6 +523,8 @@ static int serial_pnp_resume(struct pnp_dev *dev)
 {
 	long line = (long)pnp_get_drvdata(dev);
 
+	if (line > CONFIG_SERIAL_8250_NR_UARTS)
+		((struct pnp_base_data *)line)->driver->resume(dev);
 	if (!line)
 		return -ENODEV;
 	serial8250_resume_port(line - 1);
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 6412f14..37d120b 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -337,6 +337,32 @@ config SERIAL_8250_FINTEK
 	  LPC to 4 UART. This device has some RS485 functionality not available
 	  through the PNP driver. If unsure, say N.
 
+config SERIAL_8250_FINTEK_IRQ_SHARING
+	bool "Enable IRQ sharing for Fintek F81216A LPC to 4 UART"
+	depends on SERIAL_8250_FINTEK
+	help
+	  Selecting this option will enable IRQ sharing for the Fintek F81216A
+	  LPC to 4 UART.
+
+choice
+	prompt "IRQ sharing ways for Fintek F81216A LPC to 4 UART"
+	depends on SERIAL_8250_FINTEK_IRQ_SHARING
+	default SERIAL_8250_FINTEK_IRQ_SHARING_ISA
+
+config SERIAL_8250_FINTEK_IRQ_SHARING_ISA
+	bool "ISA bus IRQ sharing"
+	depends on SERIAL_8250_FINTEK_IRQ_SHARING
+	help
+	  Based on ISA bus.
+
+config SERIAL_8250_FINTEK_IRQ_SHARING_PCI
+	bool "PCI bus IRQ sharing"
+	depends on SERIAL_8250_FINTEK_IRQ_SHARING
+	help
+	  Based on PCI bus.
+
+endchoice
+
 config SERIAL_8250_LPC18XX
 	tristate "NXP LPC18xx/43xx serial port support"
 	depends on SERIAL_8250 && OF && (ARCH_LPC18XX || COMPILE_TEST)
-- 
1.9.1



