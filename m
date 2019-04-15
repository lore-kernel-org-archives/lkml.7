Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4A6C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBB520880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbfDOU3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:29:14 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:56647 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfDOU3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 16:29:13 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MRTAj-1hSSRo2tld-00NPXk; Mon, 15 Apr 2019 22:28:57 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Greg Ungerer <gerg@uclinux.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, arm@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 6/6] ARM: ks8695: split up uart register headers
Date:   Mon, 15 Apr 2019 22:24:18 +0200
Message-Id: <20190415202501.941196-6-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190415202501.941196-1-arnd@arndb.de>
References: <20190415202501.941196-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KiiZGm8YYPg8G/jJRJdkMeVv/8SrVOCElJq1sII8vzv/hVVohtD
 PXnBQ9HYNT07JO6Geh3HLK0DKVIDH0XKqg2a+JWb7TnfhFUflyT3zoLpCzoEnqA6C7s2nDy
 Gjt/2VjQ0Ym97AlIwcyOTNcLvygxk3jZIRJBTKc7x2WpYJs2hfhW5jY6QNnwyc0mu2+7pil
 R5GijGm9Pd6Pa4JxzCxYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DjLmN6oN0FM=:qsjUL+sa3Iq66tbf9oaXwS
 TGy0M39DsDx/w99FJjVK+Pi9xppysOLr7HeNzg2j3Wnp2jHsBqO3g/vRmq504chITM3yIxFfk
 MREELmQtY4xpG9dyCc4DDRqwr4yeuUOLKq7g9ynjh4dh7QOOVYzI6dDZVrd+zhb7jEZ3Q4bIF
 W0Nt2vl9g8UW/+ltxf91e3kzUyR7J+zlUY8AfgN+td9csRJiDdksRRLu6ootqOyB4jz/pZa3Y
 82ZqgAt01S3mkeeeLT9N29MNtp8fkidIy9M+ICm+cXEeqVunmD860OERBPZvFu/vqUCOGS8c7
 uR7rK7zkn6Kt3GGOWbRNHtK5a+0koNf5sf/xwhc0sW3LwF/vCrID0OjHwkyuC1du/bgOgoaxd
 ujbg9Ngjy85qalJXvX1x64OxG3lbYEjj8ueuLTslKc6iPdqX4ezY060yoDCslhwnIso3gsraN
 s3GNKb0x/TX/wHVFEndV7LbUF7svYUKvmZaPkvjBzlVp+rRSE2juDrXZm0hdQ/WQ+gKXMAU4H
 c5BVYBNM3Wq6DOQLlak5NJS+BptOI6xX5HWYk66Tis2wnNEwfH7sdRLUj8z0u6pnQN/JeEQlB
 82NgMzYI0f2NBYPS9x6mNmDBAuDTpJnWGRksC2073/aDCZRl39d0y1FmLDuAhcl3KKN0mEY2e
 lf/Wi088SL52HIhXyOU8iamIHSAwKNZc1wt0kwNOqwqYlTugyMPu7L9RKqbs96cG2/fgWjgbi
 BjDYnYUef0zp+mERSUIpF59U3M7rsIDzCpXbgA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uart driver is tightly coupled with the platform code, without
real need. The uart registers can be moved into the driver itself
(and the uncompress code), and instead of referring to the IRQ
lines by number, we can generally use port->irq.

Finally, the initialization of the uart_port structure gets moved
into the platform code. This cannot use platform_data since we
need it before console_init(), but map_io is called very early,
and the data is all hardcoded.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ks8695/cpu.c                    |  15 ++-
 arch/arm/mach-ks8695/devices.c                |   2 +-
 arch/arm/mach-ks8695/include/mach/regs-uart.h |  92 -------------
 .../arm/mach-ks8695/include/mach/uncompress.h |  16 ++-
 arch/arm/mach-ks8695/regs-uart.h              |  19 +++
 drivers/tty/serial/Kconfig                    |   2 +-
 drivers/tty/serial/serial_ks8695.c            | 123 ++++++++++++++----
 include/linux/platform_data/serial-ks8695.h   |  10 ++
 8 files changed, 157 insertions(+), 122 deletions(-)
 delete mode 100644 arch/arm/mach-ks8695/include/mach/regs-uart.h
 create mode 100644 arch/arm/mach-ks8695/regs-uart.h
 create mode 100644 include/linux/platform_data/serial-ks8695.h

diff --git a/arch/arm/mach-ks8695/cpu.c b/arch/arm/mach-ks8695/cpu.c
index 7eadf73c7e30..680b94641196 100644
--- a/arch/arm/mach-ks8695/cpu.c
+++ b/arch/arm/mach-ks8695/cpu.c
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/platform_data/serial-ks8695.h>
 
 #include <mach/hardware.h>
 #include <asm/mach/arch.h>
@@ -32,7 +33,7 @@
 
 #include "regs-sys.h"
 #include "regs-misc.h"
-
+#include "regs-uart.h"
 
 static struct map_desc ks8695_io_desc[] __initdata = {
 	{
@@ -64,10 +65,22 @@ static void __init ks8695_clock_info(void)
 			sysclk[scdc] / 1000000, cpuclk[scdc] / 1000000);
 }
 
+static void __init ks8695_serial_setup(void)
+{
+	if (!IS_ENABLED(CONFIG_SERIAL_KS8695))
+		return;
+
+	ks8695uart_ports[0].membase = KS8695_UART_VA;
+	ks8695uart_ports[0].mapbase = KS8695_UART_PA;
+	ks8695uart_ports[0].irq     = KS8695_IRQ_UART_TX; /* actaully four IRQs */
+	ks8695uart_ports[0].uartclk = KS8695_CLOCK_RATE * 16;
+}
+
 void __init ks8695_map_io(void)
 {
 	iotable_init(ks8695_io_desc, ARRAY_SIZE(ks8695_io_desc));
 
 	ks8695_processor_info();
 	ks8695_clock_info();
+	ks8695_serial_setup();
 }
diff --git a/arch/arm/mach-ks8695/devices.c b/arch/arm/mach-ks8695/devices.c
index 6bd50a8f12f9..ba9d0f0f47ac 100644
--- a/arch/arm/mach-ks8695/devices.c
+++ b/arch/arm/mach-ks8695/devices.c
@@ -29,6 +29,7 @@
 #include "regs-hpna.h"
 #include "regs-switch.h"
 #include "regs-misc.h"
+#include "regs-uart.h"
 
 /* --------------------------------------------------------------------
  *  Ethernet
@@ -191,7 +192,6 @@ static void __init ks8695_add_device_watchdog(void)
 	platform_device_register(&ks8695_wdt_device);
 }
 
-
 /* -------------------------------------------------------------------- */
 
 /*
diff --git a/arch/arm/mach-ks8695/include/mach/regs-uart.h b/arch/arm/mach-ks8695/include/mach/regs-uart.h
deleted file mode 100644
index 8581fbc6245f..000000000000
--- a/arch/arm/mach-ks8695/include/mach/regs-uart.h
+++ /dev/null
@@ -1,92 +0,0 @@
-/*
- * arch/arm/mach-ks8695/include/mach/regs-uart.h
- *
- * Copyright (C) 2006 Ben Dooks <ben@simtec.co.uk>
- * Copyright (C) 2006 Simtec Electronics
- *
- * KS8695 - UART register and bit definitions.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef KS8695_UART_H
-#define KS8695_UART_H
-
-#define KS8695_UART_OFFSET	(0xF0000 + 0xE000)
-#define KS8695_UART_VA		(KS8695_IO_VA + KS8695_UART_OFFSET)
-#define KS8695_UART_PA		(KS8695_IO_PA + KS8695_UART_OFFSET)
-
-
-/*
- * UART registers
- */
-#define KS8695_URRB	(0x00)		/* Receive Buffer Register */
-#define KS8695_URTH	(0x04)		/* Transmit Holding Register */
-#define KS8695_URFC	(0x08)		/* FIFO Control Register */
-#define KS8695_URLC	(0x0C)		/* Line Control Register */
-#define KS8695_URMC	(0x10)		/* Modem Control Register */
-#define KS8695_URLS	(0x14)		/* Line Status Register */
-#define KS8695_URMS	(0x18)		/* Modem Status Register */
-#define KS8695_URBD	(0x1C)		/* Baud Rate Divisor Register */
-#define KS8695_USR	(0x20)		/* Status Register */
-
-
-/* FIFO Control Register */
-#define URFC_URFRT	(3 << 6)	/* Receive FIFO Trigger Level */
-#define		URFC_URFRT_1	(0 << 6)
-#define		URFC_URFRT_4	(1 << 6)
-#define		URFC_URFRT_8	(2 << 6)
-#define		URFC_URFRT_14	(3 << 6)
-#define URFC_URTFR	(1 << 2)	/* Transmit FIFO Reset */
-#define URFC_URRFR	(1 << 1)	/* Receive FIFO Reset */
-#define URFC_URFE	(1 << 0)	/* FIFO Enable */
-
-/* Line Control Register */
-#define URLC_URSBC	(1 << 6)	/* Set Break Condition */
-#define URLC_PARITY	(7 << 3)	/* Parity */
-#define		URPE_NONE	(0 << 3)
-#define		URPE_ODD	(1 << 3)
-#define		URPE_EVEN	(3 << 3)
-#define		URPE_MARK	(5 << 3)
-#define		URPE_SPACE	(7 << 3)
-#define URLC_URSB	(1 << 2)	/* Stop Bits */
-#define URLC_URCL	(3 << 0)	/* Character Length */
-#define		URCL_5		(0 << 0)
-#define		URCL_6		(1 << 0)
-#define		URCL_7		(2 << 0)
-#define		URCL_8		(3 << 0)
-
-/* Modem Control Register */
-#define URMC_URLB	(1 << 4)	/* Loop-back mode */
-#define URMC_UROUT2	(1 << 3)	/* OUT2 signal */
-#define URMC_UROUT1	(1 << 2)	/* OUT1 signal */
-#define URMC_URRTS	(1 << 1)	/* Request to Send */
-#define URMC_URDTR	(1 << 0)	/* Data Terminal Ready */
-
-/* Line Status Register */
-#define URLS_URRFE	(1 << 7)	/* Receive FIFO Error */
-#define URLS_URTE	(1 << 6)	/* Transmit Empty */
-#define URLS_URTHRE	(1 << 5)	/* Transmit Holding Register Empty */
-#define URLS_URBI	(1 << 4)	/* Break Interrupt */
-#define URLS_URFE	(1 << 3)	/* Framing Error */
-#define URLS_URPE	(1 << 2)	/* Parity Error */
-#define URLS_URROE	(1 << 1)	/* Receive Overrun Error */
-#define URLS_URDR	(1 << 0)	/* Receive Data Ready */
-
-/* Modem Status Register */
-#define URMS_URDCD	(1 << 7)	/* Data Carrier Detect */
-#define URMS_URRI	(1 << 6)	/* Ring Indicator */
-#define URMS_URDSR	(1 << 5)	/* Data Set Ready */
-#define URMS_URCTS	(1 << 4)	/* Clear to Send */
-#define URMS_URDDCD	(1 << 3)	/* Delta Data Carrier Detect */
-#define URMS_URTERI	(1 << 2)	/* Trailing Edge Ring Indicator */
-#define URMS_URDDST	(1 << 1)	/* Delta Data Set Ready */
-#define URMS_URDCTS	(1 << 0)	/* Delta Clear to Send */
-
-/* Status Register */
-#define USR_UTI		(1 << 0)	/* Timeout Indication */
-
-
-#endif
diff --git a/arch/arm/mach-ks8695/include/mach/uncompress.h b/arch/arm/mach-ks8695/include/mach/uncompress.h
index a001c7c34df2..a8ae2e82dcf1 100644
--- a/arch/arm/mach-ks8695/include/mach/uncompress.h
+++ b/arch/arm/mach-ks8695/include/mach/uncompress.h
@@ -15,7 +15,21 @@
 #define __ASM_ARCH_UNCOMPRESS_H
 
 #include <linux/io.h>
-#include <mach/regs-uart.h>
+
+#define KS8695_UART_OFFSET     (0xF0000 + 0xE000)
+#define KS8695_UART_PA          (KS8695_IO_PA + KS8695_UART_OFFSET)
+#define KS8695_URRB     (0x00)          /* Receive Buffer Register */
+#define KS8695_URTH     (0x04)          /* Transmit Holding Register */
+#define KS8695_URFC     (0x08)          /* FIFO Control Register */
+#define KS8695_URLC     (0x0C)          /* Line Control Register */
+#define KS8695_URMC     (0x10)          /* Modem Control Register */
+#define KS8695_URLS     (0x14)          /* Line Status Register */
+#define KS8695_URMS     (0x18)          /* Modem Status Register */
+#define KS8695_URBD     (0x1C)          /* Baud Rate Divisor Register */
+#define KS8695_USR      (0x20)          /* Status Register */
+
+#define URLS_URTE       (1 << 6)
+#define URLS_URTHRE     (1 << 5)
 
 static inline void putc(char c)
 {
diff --git a/arch/arm/mach-ks8695/regs-uart.h b/arch/arm/mach-ks8695/regs-uart.h
new file mode 100644
index 000000000000..ab6c70e8fc7a
--- /dev/null
+++ b/arch/arm/mach-ks8695/regs-uart.h
@@ -0,0 +1,19 @@
+/*
+ * Copyright (C) 2006 Ben Dooks <ben@simtec.co.uk>
+ * Copyright (C) 2006 Simtec Electronics
+ *
+ * KS8695 - UART register and bit definitions.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef KS8695_UART_H
+#define KS8695_UART_H
+
+#define KS8695_UART_OFFSET	(0xF0000 + 0xE000)
+#define KS8695_UART_VA		(KS8695_IO_VA + KS8695_UART_OFFSET)
+#define KS8695_UART_PA		(KS8695_IO_PA + KS8695_UART_OFFSET)
+
+#endif
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 72966bc0ac76..bdb3fc987ea2 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -198,7 +198,7 @@ config SERIAL_KGDB_NMI
 
 config SERIAL_KS8695
 	bool "Micrel KS8695 (Centaur) serial port support"
-	depends on ARCH_KS8695
+	depends on ARCH_KS8695 || COMPILE_TEST
 	select SERIAL_CORE
 	help
 	  This selects the Micrel Centaur KS8695 UART.  Say Y here.
diff --git a/drivers/tty/serial/serial_ks8695.c b/drivers/tty/serial/serial_ks8695.c
index 6c5e9900e69d..6caad7e5ab74 100644
--- a/drivers/tty/serial/serial_ks8695.c
+++ b/drivers/tty/serial/serial_ks8695.c
@@ -15,12 +15,11 @@
 #include <linux/console.h>
 #include <linux/sysrq.h>
 #include <linux/device.h>
+#include <linux/irq.h>
 
-#include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/mach/irq.h>
+#include <linux/platform_data/serial-ks8695.h>
 
-#include <mach/regs-uart.h>
+#include <asm/io.h>
 
 #if defined(CONFIG_SERIAL_KS8695_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
 #define SUPPORT_SYSRQ
@@ -34,6 +33,82 @@
 #define SERIAL_KS8695_DEVNAME	"ttyAM"
 
 #define SERIAL_KS8695_NR	1
+extern struct uart_port ks8695uart_ports[SERIAL_KS8695_NR];
+
+/*
+ * UART registers
+ */
+#define KS8695_URRB	(0x00)		/* Receive Buffer Register */
+#define KS8695_URTH	(0x04)		/* Transmit Holding Register */
+#define KS8695_URFC	(0x08)		/* FIFO Control Register */
+#define KS8695_URLC	(0x0C)		/* Line Control Register */
+#define KS8695_URMC	(0x10)		/* Modem Control Register */
+#define KS8695_URLS	(0x14)		/* Line Status Register */
+#define KS8695_URMS	(0x18)		/* Modem Status Register */
+#define KS8695_URBD	(0x1C)		/* Baud Rate Divisor Register */
+#define KS8695_USR	(0x20)		/* Status Register */
+
+
+/* FIFO Control Register */
+#define URFC_URFRT	(3 << 6)	/* Receive FIFO Trigger Level */
+#define		URFC_URFRT_1	(0 << 6)
+#define		URFC_URFRT_4	(1 << 6)
+#define		URFC_URFRT_8	(2 << 6)
+#define		URFC_URFRT_14	(3 << 6)
+#define URFC_URTFR	(1 << 2)	/* Transmit FIFO Reset */
+#define URFC_URRFR	(1 << 1)	/* Receive FIFO Reset */
+#define URFC_URFE	(1 << 0)	/* FIFO Enable */
+
+/* Line Control Register */
+#define URLC_URSBC	(1 << 6)	/* Set Break Condition */
+#define URLC_PARITY	(7 << 3)	/* Parity */
+#define		URPE_NONE	(0 << 3)
+#define		URPE_ODD	(1 << 3)
+#define		URPE_EVEN	(3 << 3)
+#define		URPE_MARK	(5 << 3)
+#define		URPE_SPACE	(7 << 3)
+#define URLC_URSB	(1 << 2)	/* Stop Bits */
+#define URLC_URCL	(3 << 0)	/* Character Length */
+#define		URCL_5		(0 << 0)
+#define		URCL_6		(1 << 0)
+#define		URCL_7		(2 << 0)
+#define		URCL_8		(3 << 0)
+
+/* Modem Control Register */
+#define URMC_URLB	(1 << 4)	/* Loop-back mode */
+#define URMC_UROUT2	(1 << 3)	/* OUT2 signal */
+#define URMC_UROUT1	(1 << 2)	/* OUT1 signal */
+#define URMC_URRTS	(1 << 1)	/* Request to Send */
+#define URMC_URDTR	(1 << 0)	/* Data Terminal Ready */
+
+/* Line Status Register */
+#define URLS_URRFE	(1 << 7)	/* Receive FIFO Error */
+#define URLS_URTE	(1 << 6)	/* Transmit Empty */
+#define URLS_URTHRE	(1 << 5)	/* Transmit Holding Register Empty */
+#define URLS_URBI	(1 << 4)	/* Break Interrupt */
+#define URLS_URFE	(1 << 3)	/* Framing Error */
+#define URLS_URPE	(1 << 2)	/* Parity Error */
+#define URLS_URROE	(1 << 1)	/* Receive Overrun Error */
+#define URLS_URDR	(1 << 0)	/* Receive Data Ready */
+
+/* Modem Status Register */
+#define URMS_URDCD	(1 << 7)	/* Data Carrier Detect */
+#define URMS_URRI	(1 << 6)	/* Ring Indicator */
+#define URMS_URDSR	(1 << 5)	/* Data Set Ready */
+#define URMS_URCTS	(1 << 4)	/* Clear to Send */
+#define URMS_URDDCD	(1 << 3)	/* Delta Data Carrier Detect */
+#define URMS_URTERI	(1 << 2)	/* Trailing Edge Ring Indicator */
+#define URMS_URDDST	(1 << 1)	/* Delta Data Set Ready */
+#define URMS_URDCTS	(1 << 0)	/* Delta Clear to Send */
+
+/* Status Register */
+#define USR_UTI		(1 << 0)	/* Timeout Indication */
+
+
+#define IRQ_TX			0
+#define IRQ_RX			1
+#define IRQ_LINE_STATUS		2
+#define IRQ_MODEM_STATUS	3
 
 /*
  * Access macros for the KS8695 UART
@@ -105,7 +180,7 @@ static void ks8695uart_stop_tx(struct uart_port *port)
 		 * imposed deadlock by not waiting for irq handler to end,
 		 * since this ks8695uart_stop_tx() is called from interrupt context.
 		 */
-		disable_irq_nosync(KS8695_IRQ_UART_TX);
+		disable_irq_nosync(port->irq + IRQ_TX);
 		tx_enable(port, 0);
 	}
 }
@@ -113,7 +188,7 @@ static void ks8695uart_stop_tx(struct uart_port *port)
 static void ks8695uart_start_tx(struct uart_port *port)
 {
 	if (!tx_enabled(port)) {
-		enable_irq(KS8695_IRQ_UART_TX);
+		enable_irq(port->irq + IRQ_TX);
 		tx_enable(port, 1);
 	}
 }
@@ -121,7 +196,7 @@ static void ks8695uart_start_tx(struct uart_port *port)
 static void ks8695uart_stop_rx(struct uart_port *port)
 {
 	if (rx_enabled(port)) {
-		disable_irq(KS8695_IRQ_UART_RX);
+		disable_irq(port->irq + IRQ_RX);
 		rx_enable(port, 0);
 	}
 }
@@ -129,7 +204,7 @@ static void ks8695uart_stop_rx(struct uart_port *port)
 static void ks8695uart_enable_ms(struct uart_port *port)
 {
 	if (!ms_enabled(port)) {
-		enable_irq(KS8695_IRQ_UART_MODEM_STATUS);
+		enable_irq(port->irq + IRQ_MODEM_STATUS);
 		ms_enable(port,1);
 	}
 }
@@ -137,7 +212,7 @@ static void ks8695uart_enable_ms(struct uart_port *port)
 static void ks8695uart_disable_ms(struct uart_port *port)
 {
 	if (ms_enabled(port)) {
-		disable_irq(KS8695_IRQ_UART_MODEM_STATUS);
+		disable_irq(port->irq + IRQ_MODEM_STATUS);
 		ms_enable(port,0);
 	}
 }
@@ -318,7 +393,7 @@ static int ks8695uart_startup(struct uart_port *port)
 {
 	int retval;
 
-	irq_modify_status(KS8695_IRQ_UART_TX, IRQ_NOREQUEST, IRQ_NOAUTOEN);
+	irq_modify_status(port->irq + IRQ_TX, IRQ_NOREQUEST, IRQ_NOAUTOEN);
 	tx_enable(port, 0);
 	rx_enable(port, 1);
 	ms_enable(port, 1);
@@ -326,30 +401,30 @@ static int ks8695uart_startup(struct uart_port *port)
 	/*
 	 * Allocate the IRQ
 	 */
-	retval = request_irq(KS8695_IRQ_UART_TX, ks8695uart_tx_chars, 0, "UART TX", port);
+	retval = request_irq(port->irq + IRQ_TX, ks8695uart_tx_chars, 0, "UART TX", port);
 	if (retval)
 		goto err_tx;
 
-	retval = request_irq(KS8695_IRQ_UART_RX, ks8695uart_rx_chars, 0, "UART RX", port);
+	retval = request_irq(port->irq + IRQ_RX, ks8695uart_rx_chars, 0, "UART RX", port);
 	if (retval)
 		goto err_rx;
 
-	retval = request_irq(KS8695_IRQ_UART_LINE_STATUS, ks8695uart_rx_chars, 0, "UART LineStatus", port);
+	retval = request_irq(port->irq + IRQ_LINE_STATUS, ks8695uart_rx_chars, 0, "UART LineStatus", port);
 	if (retval)
 		goto err_ls;
 
-	retval = request_irq(KS8695_IRQ_UART_MODEM_STATUS, ks8695uart_modem_status, 0, "UART ModemStatus", port);
+	retval = request_irq(port->irq + IRQ_MODEM_STATUS, ks8695uart_modem_status, 0, "UART ModemStatus", port);
 	if (retval)
 		goto err_ms;
 
 	return 0;
 
 err_ms:
-	free_irq(KS8695_IRQ_UART_LINE_STATUS, port);
+	free_irq(port->irq + IRQ_LINE_STATUS, port);
 err_ls:
-	free_irq(KS8695_IRQ_UART_RX, port);
+	free_irq(port->irq + IRQ_RX, port);
 err_rx:
-	free_irq(KS8695_IRQ_UART_TX, port);
+	free_irq(port->irq + IRQ_TX, port);
 err_tx:
 	return retval;
 }
@@ -359,10 +434,10 @@ static void ks8695uart_shutdown(struct uart_port *port)
 	/*
 	 * Free the interrupt
 	 */
-	free_irq(KS8695_IRQ_UART_RX, port);
-	free_irq(KS8695_IRQ_UART_TX, port);
-	free_irq(KS8695_IRQ_UART_MODEM_STATUS, port);
-	free_irq(KS8695_IRQ_UART_LINE_STATUS, port);
+	free_irq(port->irq + IRQ_TX, port);
+	free_irq(port->irq + IRQ_RX, port);
+	free_irq(port->irq + IRQ_MODEM_STATUS, port);
+	free_irq(port->irq + IRQ_LINE_STATUS, port);
 
 	/* disable break condition and fifos */
 	UART_PUT_LCR(port, UART_GET_LCR(port) & ~URLC_URSBC);
@@ -535,13 +610,9 @@ static struct uart_ops ks8695uart_pops = {
 	.verify_port	= ks8695uart_verify_port,
 };
 
-static struct uart_port ks8695uart_ports[SERIAL_KS8695_NR] = {
+struct uart_port ks8695uart_ports[SERIAL_KS8695_NR] = {
 	{
-		.membase	= KS8695_UART_VA,
-		.mapbase	= KS8695_UART_PA,
 		.iotype		= SERIAL_IO_MEM,
-		.irq		= KS8695_IRQ_UART_TX,
-		.uartclk	= KS8695_CLOCK_RATE * 16,
 		.fifosize	= 16,
 		.ops		= &ks8695uart_pops,
 		.flags		= UPF_BOOT_AUTOCONF,
diff --git a/include/linux/platform_data/serial-ks8695.h b/include/linux/platform_data/serial-ks8695.h
new file mode 100644
index 000000000000..ade3f0a03a75
--- /dev/null
+++ b/include/linux/platform_data/serial-ks8695.h
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
+#ifndef _LINUX_PLATFORM_DATA_SERIAL_KS8695
+#define _LINUX_PLATFORM_DATA_SERIAL_KS8695
+
+#include <linux/serial_core.h>
+
+#define SERIAL_KS8695_NR 1
+extern struct uart_port ks8695uart_ports[SERIAL_KS8695_NR];
+
+#endif
-- 
2.20.0

