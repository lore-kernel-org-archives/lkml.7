Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB5EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BCBF218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLSPgSe8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387723AbfB1TjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:39:21 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38155 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729936AbfB1TjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 14:39:20 -0500
Received: by mail-oi1-f194.google.com with SMTP id q81so17490709oic.5;
        Thu, 28 Feb 2019 11:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=cTG+wgdhPgOGUbgLl8AuBvLRJ9TCxSoKJk5xiFfzNWg=;
        b=dLSPgSe8D5WqR/LiDZLI9TXMae/HlHPV2kif6S0jPdAYkIbxFiHpqVgHyHYpF5sNtt
         HP9hXOkQU/rJYBiEMnMFPTBZy1Oy0swVGnVtQzgbvf1nJPvRpiwNWzKt6i73oUnd6n+O
         jtzSJ2KdcZvpQjQ+kIwVXUviegoetNBHLq2xgmufLneRfHHlngk5ch71J9Rf7dsYTCP8
         kNgNqmj6wOVjkT6fH5gQhBoGSZSZGm5PtLU5fBSdAF3Aj0LoDh+/K9mZGpP2dDSC4rfK
         Pqw39QTetWOcS2admqm0H0ycPqRnPO5GYUDbOhtXJEJ5yfz4N3JS/uYo8oRbQo77YGMM
         sMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=cTG+wgdhPgOGUbgLl8AuBvLRJ9TCxSoKJk5xiFfzNWg=;
        b=VfxcOKCivR/n2O0HAOyd8zKLUFVyhGfiwgpy5AP4HfZV9CCy1zC48ZmI49x+zCL4PV
         WTqOYAceP8D1zy0tnPWi6S/VDeoSAn3Rz8Q66grhQtPRrUCl8TqBEUR6shDnaMZsGipU
         gStTn9s84a8gtwgnOKt2jFX3ZEIEPE3Bxq3Y/hRurrapxgAqMyBy8KCsXZCY6kmVEqMI
         3435HPbFy81HrP4Z3z33et2TJHubRJDYSpwjtPljl8W7NQjYKNBkO9kv5QjwCOy9FxNL
         WtyNiY84OCOb0cj7c0+658CO3Vd9Abx6u5twMb+36IeYdapR5NzYx79T1q7VakKqlgDA
         4q8g==
X-Gm-Message-State: AHQUAua7CzGRv3W3nN065V9Z8kdaV5iBuxK45tgdwwEw/sV1lYZmcXLs
        eTHGjQ5xnFMTKIW/AJybHjzBDtc=
X-Google-Smtp-Source: APXvYqysD2RLhzi1JY/xzGXEL4aI1uvAVeVxW1DpmUROhFgzPwwBlZzFKdU2xhdw6sBNimAUdEQY1w==
X-Received: by 2002:aca:ab4d:: with SMTP id u74mr885219oie.64.1551382758210;
        Thu, 28 Feb 2019 11:39:18 -0800 (PST)
Received: from serve.minyard.net ([47.184.128.64])
        by smtp.gmail.com with ESMTPSA id q1sm7955847oth.42.2019.02.28.11.39.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 11:39:17 -0800 (PST)
Received: from t430.minyard.net (unknown [IPv6:2001:470:b8f6:1b:b89e:c7bf:12ab:ad14])
        by serve.minyard.net (Postfix) with ESMTPA id B210B180193;
        Thu, 28 Feb 2019 19:39:15 +0000 (UTC)
Received: by t430.minyard.net (Postfix, from userid 1000)
        id 61ACC3028D0; Thu, 28 Feb 2019 13:39:15 -0600 (CST)
From:   minyard@acm.org
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     minyard@acm.org, linux-kernel@vger.kernel.org,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH] tty/serial: Add a serial port simulator
Date:   Thu, 28 Feb 2019 13:39:11 -0600
Message-Id: <20190228193911.26540-1-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

This creates simulated serial ports, both as echo devices and pipe
devices.  The driver reasonably approximates the serial port speed
and simulates some modem control lines.  It allows error injection
and dirct control of modem control lines.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
I wrote this for doing automated tests on ser2net and the gensio library,
but it's general purpose and other people wanting to test serial port
programs might find it handy.  It has been invaluable for me.

 Documentation/serial/serialsim.rst |  149 ++++
 MAINTAINERS                        |    7 +
 drivers/tty/serial/Kconfig         |   10 +
 drivers/tty/serial/Makefile        |    1 +
 drivers/tty/serial/serialsim.c     | 1086 ++++++++++++++++++++++++++++
 include/uapi/linux/serialsim.h     |   28 +
 6 files changed, 1281 insertions(+)
 create mode 100644 Documentation/serial/serialsim.rst
 create mode 100644 drivers/tty/serial/serialsim.c
 create mode 100644 include/uapi/linux/serialsim.h

diff --git a/Documentation/serial/serialsim.rst b/Documentation/serial/serialsim.rst
new file mode 100644
index 000000000000..655e10b4908e
--- /dev/null
+++ b/Documentation/serial/serialsim.rst
@@ -0,0 +1,149 @@
+.. SPDX-License-Identifier: GPL-2.0+
+=====================================
+serialsim - A kernel serial simualtor
+=====================================
+
+:Author: Corey Minyard <minyard@mvista.com> / <minyard@acm.org>
+
+The serialsim device is a serial simulator with echo and pipe devices.
+It is quite useful for testing programs that use serial ports.
+
+This attempts to emulate a basic serial device.  It uses the baud rate
+and sends the bytes through the loopback or pipe at approximately the
+speed it would on a normal serial device.
+
+There is a python interface to the special ioctls for controlling the
+remote end of the termios in addition to the standard ioctl interface
+documented below.  See https://github.com/cminyard/serialsim
+
+=====
+Using
+=====
+
+The serialsim.ko module creates two types of devices.  Echo devices
+simply echo back the data to the same device.  These devices will
+appear as /dev/ttyEcho<n>.
+
+Pipe devices will transfer the data between two devices.  The
+devices will appear as /dev/ttyPipeA<n> and /dev/ttyPipeB<n>.  And
+data written to PipeA reads from PipeB, and vice-versa.
+
+You may create an arbitrary number of devices by setting the
+nr_echo ports and nr_pipe_ports module parameters.  The default is
+four for both.
+
+This driver supports modifying the modem control lines and
+injecting various serial errors.  It also supports a simulated null
+modem between the two pipes, or in a loopback on the echo device.
+
+By default a pipe or echo comes up in null modem configuration,
+meaning that the DTR line is hooked to the DSR and CD lines on the
+other side and the RTS line on one side is hooked to the CTS line
+on the other side.
+
+The RTS and CTS lines don't currently do anything for flow control.
+
+You can modify null modem and control the lines individually
+through an interface in /sys/class/tty/ttyECHO<n>/ctrl,
+/sys/class/tty/ttyPipeA<n>/ctrl, and
+/sys/class/tty/ttyPipeB<n>/ctrl.  The following may be written to
+those files:
+
+[+-]nullmodem
+    enable/disable null modem
+
+[+-]cd
+    enable/disable Carrier Detect (no effect if +nullmodem)
+
+[+-]dsr
+    enable/disable Data Set Ready (no effect if +nullmodem)
+
+[+-]cts
+    enable/disable Clear To Send (no effect if +nullmodem)
+
+[+-]ring
+    enable/disable Ring
+
+frame
+    inject a frame error on the next byte
+
+parity
+    inject a parity error on the next byte
+
+overrun
+    inject an overrun error on the next byte
+
+The contents of the above files has the following format:
+
+tty[Echo|PipeA|PipeB]<n>
+    <mctrl values>
+
+where <mctrl values> is the modem control values above (not frame,
+parity, or overrun) with the following added:
+
+[+-]dtr
+    value of the Data Terminal Ready
+
+[+-]rts
+    value of the Request To Send
+
+The above values are not settable through this interface, they are
+set through the serial port interface itself.
+
+So, for instance, ttyEcho0 comes up in the following state::
+
+   # cat /sys/class/tty/ttyEcho0/ctrl
+   ttyEcho0: +nullmodem -cd -dsr -cts -ring -dtr -rts
+
+If something connects, it will become::
+
+   ttyEcho0: +nullmodem +cd +dsr +cts -ring +dtr +rts
+
+To enable ring::
+
+   # echo "+ring" >/sys/class/tty/ttyEcho0/ctrl
+   # cat /sys/class/tty/ttyEcho0/ctrl
+   ttyEcho0: +nullmodem +cd +dsr +cts +ring +dtr +rts
+
+Now disable NULL modem and the CD line::
+
+   # echo "-nullmodem -cd" >/sys/class/tty/ttyEcho0/ctrl
+   # cat /sys/class/tty/ttyEcho0/ctrl
+   ttyEcho0: -nullmodem -cd -dsr -cts +ring -dtr -rts
+
+Note that these settings are for the side you are modifying.  So if
+you set nullmodem on ttyPipeA0, that controls whether the DTR/RTS
+lines from ttyPipeB0 affect ttyPipeA0.  It doesn't affect ttyPipeB's
+modem control lines.
+
+The PIPEA and PIPEB devices also have the ability to set these
+values for the other end via an ioctl.  The following ioctls are
+available:
+
+TIOCSERSNULLMODEM
+    Set the null modem value, the arg is a boolean.
+
+TIOCSERSREMMCTRL
+    Set the modem control lines, bits 16-31 of the arg is
+    a 16-bit mask telling which values to set, bits 0-15 are the
+    actual values.  Settable values are TIOCM_CAR, TIOCM_CTS,
+    TIOCM_DSR, and TIOC_RNG.  If NULLMODEM is set to true, then only
+    TIOC_RNG is settable.  The DTR and RTS lines are not here, you can
+    set them through the normal interface.
+
+TIOCSERSREMERR
+    Send an error or errors on the next sent byte.  arg is
+    a bitwise OR of (1 << TTY_xxx).  Allowed errors are TTY_BREAK,
+    TTY_FRAME, TTY_PARITY, and TTY_OVERRUN.
+
+TIOCSERGREMTERMIOS
+    Return the termios structure for the other side of the pipe.
+    arg is a pointer to a standard termios struct.
+
+TIOCSERGREMRS485
+    Return the remote RS485 settings, arg is a pointer to a struct
+    serial_rs485.
+
+Note that unlike the sysfs interface, these ioctls affect the other
+end.  So setting nullmodem on the ttyPipeB0 interface sets whether
+the DTR/RTS lines on ttyPipeB0 affect ttyPipeA0.
diff --git a/MAINTAINERS b/MAINTAINERS
index 9919840d54cd..aa1eb3c07f44 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13702,6 +13702,13 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/rc/serial_ir.c
 
+SERIAL PORT SIMULATOR
+M:	Corey Minyard <cminyard@mvista.com>
+S:	Maintained
+F:	Documentation/serial/serialsim.rst
+F:	drivers/tty/serial/serialsim.c
+F:	include/uapi/linux/serialsim.h
+
 SFC NETWORK DRIVER
 M:	Solarflare linux maintainers <linux-net-drivers@solarflare.com>
 M:	Edward Cree <ecree@solarflare.com>
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 089a6f285d5e..789113055e2f 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1565,4 +1565,14 @@ endmenu
 config SERIAL_MCTRL_GPIO
 	tristate
 
+config SERIAL_SIMULATOR
+	tristate "Serial port simulator"
+	default n
+	help
+	  Support for a simulated device that behaves like a normal
+	  serial port.  It has echo devices and pipe devices.  This
+	  is useful for testing programs that use serial ports.
+
+	  If unsure, say N.
+
 endif # TTY
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 1511e8a9f856..dbd9ee0f1c6b 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -91,6 +91,7 @@ obj-$(CONFIG_SERIAL_PIC32)	+= pic32_uart.o
 obj-$(CONFIG_SERIAL_MPS2_UART)	+= mps2-uart.o
 obj-$(CONFIG_SERIAL_OWL)	+= owl-uart.o
 obj-$(CONFIG_SERIAL_RDA)	+= rda-uart.o
+obj-$(CONFIG_SERIAL_SIMULATOR)	+= serialsim.o
 
 # GPIOLIB helpers for modem control lines
 obj-$(CONFIG_SERIAL_MCTRL_GPIO)	+= serial_mctrl_gpio.o
diff --git a/drivers/tty/serial/serialsim.c b/drivers/tty/serial/serialsim.c
new file mode 100644
index 000000000000..d4b3414a0df0
--- /dev/null
+++ b/drivers/tty/serial/serialsim.c
@@ -0,0 +1,1086 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * serialsim - Emulate a serial device in a loopback and/or pipe
+ *
+ * See the docs for this for more details.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/serial.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+#include <linux/device.h>
+#include <linux/serial_core.h>
+#include <linux/kthread.h>
+#include <linux/hrtimer.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/ctype.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+
+#include <linux/serialsim.h>
+
+#define PORT_SERIALECHO 72549
+#define PORT_SERIALPIPEA 72550
+#define PORT_SERIALPIPEB 72551
+
+#ifdef CONFIG_HIGH_RES_TIMERS
+#define SERIALSIM_WAKES_PER_SEC	1000
+#else
+#define SERIALSIM_WAKES_PER_SEC	HZ
+#endif
+
+#define SERIALSIM_XBUFSIZE	32
+
+/* For things to send on the line, in flags field. */
+#define DO_FRAME_ERR		(1 << TTY_FRAME)
+#define DO_PARITY_ERR		(1 << TTY_PARITY)
+#define DO_OVERRUN_ERR		(1 << TTY_OVERRUN)
+#define DO_BREAK		(1 << TTY_BREAK)
+#define FLAGS_MASK (DO_FRAME_ERR | DO_PARITY_ERR | DO_OVERRUN_ERR | DO_BREAK)
+
+struct serialsim_intf {
+	struct uart_port port;
+
+	/*
+	 * This is my transmit buffer, my thread picks this up and
+	 * injects them into the other port's uart.
+	 */
+	unsigned char xmitbuf[SERIALSIM_XBUFSIZE];
+	struct circ_buf buf;
+
+	/* Error flags to send. */
+	bool break_reported;
+	unsigned int flags;
+
+	/* Modem state. */
+	unsigned int mctrl;
+	bool do_null_modem;
+	spinlock_t mctrl_lock;
+	struct tasklet_struct mctrl_tasklet;
+
+	/* My transmitter is enabled. */
+	bool tx_enabled;
+
+	/* I can receive characters. */
+	bool rx_enabled;
+
+	/* Is the port registered with the uart driver? */
+	bool registered;
+
+	/*
+	 * The serial echo port on the other side of this pipe (or points
+	 * to myself in loopback mode.
+	 */
+	struct serialsim_intf *ointf;
+
+	unsigned int div;
+	unsigned int bytes_per_interval;
+	unsigned int per_interval_residual;
+
+	struct ktermios termios;
+
+	const char *threadname;
+	struct task_struct *thread;
+
+	struct serial_rs485 rs485;
+};
+
+#define circ_sbuf_space(buf) CIRC_SPACE((buf)->head, (buf)->tail, \
+					SERIALSIM_XBUFSIZE)
+#define circ_sbuf_empty(buf) ((buf)->head == (buf)->tail)
+#define circ_sbuf_next(idx) (((idx) + 1) % SERIALSIM_XBUFSIZE)
+
+static struct serialsim_intf *serialsim_port_to_intf(struct uart_port *port)
+{
+	return container_of(port, struct serialsim_intf, port);
+}
+
+static unsigned int serialsim_tx_empty(struct uart_port *port)
+{
+	struct serialsim_intf *intf = serialsim_port_to_intf(port);
+
+	if (circ_sbuf_empty(&intf->buf))
+		return TIOCSER_TEMT;
+	return 0;
+}
+
+/*
+ * We have to lock multiple locks, make sure to do it in the same order all
+ * the time.
+ */
+static void serialsim_null_modem_lock_irq(struct serialsim_intf *intf)
+{
+	spin_lock_irq(&intf->port.lock);
+	if (intf == intf->ointf) {
+		spin_lock(&intf->mctrl_lock);
+	} else if (intf < intf->ointf) {
+		spin_lock(&intf->mctrl_lock);
+		spin_lock(&intf->ointf->mctrl_lock);
+	} else {
+		spin_lock(&intf->ointf->mctrl_lock);
+		spin_lock(&intf->mctrl_lock);
+	}
+}
+
+static void serialsim_null_modem_unlock_irq(struct serialsim_intf *intf)
+{
+	if (intf == intf->ointf) {
+		spin_unlock(&intf->mctrl_lock);
+	} else {
+		/* Order doesn't matter here. */
+		spin_unlock(&intf->mctrl_lock);
+		spin_unlock(&intf->ointf->mctrl_lock);
+	}
+	spin_unlock_irq(&intf->port.lock);
+}
+
+/*
+ * This must be called holding intf->port.lock and intf->mctrl_lock.
+ */
+static void _serialsim_set_modem_lines(struct serialsim_intf *intf,
+					unsigned int mask,
+					unsigned int new_mctrl)
+{
+	unsigned int changes;
+	unsigned int mctrl = (intf->mctrl & ~mask) | (new_mctrl & mask);
+
+	if (mctrl == intf->mctrl)
+		return;
+
+	if (!intf->rx_enabled) {
+		intf->mctrl = mctrl;
+		return;
+	}
+
+	changes = mctrl ^ intf->mctrl;
+	intf->mctrl = mctrl;
+	if (changes & TIOCM_CAR)
+		uart_handle_dcd_change(&intf->port, mctrl & TIOCM_CAR);
+	if (changes & TIOCM_CTS)
+		uart_handle_cts_change(&intf->port, mctrl & TIOCM_CTS);
+	if (changes & TIOCM_RNG)
+		intf->port.icount.rng++;
+	if (changes & TIOCM_DSR)
+		intf->port.icount.dsr++;
+}
+
+#define NULL_MODEM_MCTRL (TIOCM_CAR | TIOCM_CTS | TIOCM_DSR)
+#define LOCAL_MCTRL (NULL_MODEM_MCTRL | TIOCM_RNG)
+
+/*
+ * Must be called holding intf->port.lock, intf->mctrl_lock, and
+ * intf->ointf.mctrl_lock.
+ */
+static void serialsim_handle_null_modem_update(struct serialsim_intf *intf)
+{
+	unsigned int mctrl = 0;
+
+	/* Pull the values from the remote side for myself. */
+	if (intf->ointf->mctrl & TIOCM_DTR)
+		mctrl |= TIOCM_CAR | TIOCM_DSR;
+	if (intf->ointf->mctrl & TIOCM_RTS)
+		mctrl |= TIOCM_CTS;
+
+	_serialsim_set_modem_lines(intf, NULL_MODEM_MCTRL, mctrl);
+}
+
+static void serialsim_set_null_modem(struct serialsim_intf *intf, bool val)
+{
+	serialsim_null_modem_lock_irq(intf);
+
+	if (!!val == !!intf->do_null_modem)
+		goto out_unlock;
+
+	if (!val) {
+		intf->do_null_modem = false;
+		goto out_unlock;
+	}
+
+	/* Enabling NULL modem. */
+	intf->do_null_modem = true;
+
+	serialsim_handle_null_modem_update(intf);
+
+out_unlock:
+	serialsim_null_modem_unlock_irq(intf);
+}
+
+static void serialsim_set_modem_lines(struct serialsim_intf *intf,
+				      unsigned int mask,
+				      unsigned int new_mctrl)
+{
+	mask &= LOCAL_MCTRL;
+
+	spin_lock_irq(&intf->port.lock);
+	spin_lock(&intf->mctrl_lock);
+
+	if (intf->do_null_modem)
+		mask &= ~NULL_MODEM_MCTRL;
+
+	_serialsim_set_modem_lines(intf, mask, new_mctrl);
+
+	spin_unlock(&intf->mctrl_lock);
+	spin_unlock_irq(&intf->port.lock);
+}
+
+static void mctrl_tasklet(unsigned long data)
+{
+	struct serialsim_intf *intf = (void *) data;
+
+	serialsim_null_modem_lock_irq(intf);
+	if (intf->ointf->do_null_modem)
+		serialsim_handle_null_modem_update(intf);
+	serialsim_null_modem_unlock_irq(intf);
+}
+
+#define SETTABLE_MCTRL (TIOCM_RTS | TIOCM_DTR)
+
+static void serialsim_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	struct serialsim_intf *intf = serialsim_port_to_intf(port);
+
+	spin_lock(&intf->mctrl_lock);
+	intf->mctrl &= ~SETTABLE_MCTRL;
+	intf->mctrl |= mctrl & SETTABLE_MCTRL;
+	spin_unlock(&intf->mctrl_lock);
+
+	/*
+	 * We are called holding port->lock, but we must be able to claim
+	 * intf->ointf->port.lock, and that can result in deadlock.  So
+	 * we have to run this elsewhere.  Note that we run the other
+	 * end's tasklet.
+	 */
+	tasklet_schedule(&intf->ointf->mctrl_tasklet);
+}
+
+static unsigned int serialsim_get_mctrl(struct uart_port *port)
+{
+	struct serialsim_intf *intf = serialsim_port_to_intf(port);
+	unsigned int rv;
+
+	spin_lock(&intf->mctrl_lock);
+	rv = intf->mctrl;
+	spin_unlock(&intf->mctrl_lock);
+
+	return rv;
+}
+
+static void serialsim_stop_tx(struct uart_port *port)
+{
+	struct serialsim_intf *intf = serialsim_port_to_intf(port);
+
+	intf->tx_enabled = false;
+}
+
+static void serialsim_set_baud_rate(struct serialsim_intf *intf,
+				     unsigned int baud, unsigned int cflag)
+{
+	unsigned int bits_per_char;
+
+	switch (cflag & CSIZE) {
+	case CS5:
+		bits_per_char = 7;
+		break;
+	case CS6:
+		bits_per_char = 8;
+		break;
+	case CS7:
+		bits_per_char = 9;
+		break;
+	default:
+		bits_per_char = 10;
+		break; /* CS8 and others. */
+	}
+	if (cflag & CSTOPB)
+		bits_per_char++;
+
+	intf->div = SERIALSIM_WAKES_PER_SEC * bits_per_char;
+	intf->bytes_per_interval = baud / intf->div;
+	intf->per_interval_residual = baud % intf->div;
+}
+
+static void serialsim_transfer_data(struct uart_port *port,
+				    struct circ_buf *tbuf)
+{
+	struct circ_buf *cbuf = &port->state->xmit;
+
+	while (!uart_circ_empty(cbuf) && circ_sbuf_space(tbuf)) {
+		unsigned char c = cbuf->buf[cbuf->tail];
+
+		cbuf->tail = (cbuf->tail + 1) % UART_XMIT_SIZE;
+		tbuf->buf[tbuf->head] = c;
+		tbuf->head = circ_sbuf_next(tbuf->head);
+		port->icount.tx++;
+	}
+	if (uart_circ_chars_pending(cbuf) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+}
+
+static unsigned int serialsim_get_flag(struct serialsim_intf *intf,
+					unsigned int *status)
+{
+	unsigned int flags = intf->flags;
+
+	*status = flags;
+
+	/* Overrun is always reported through a different way. */
+	if (flags & DO_OVERRUN_ERR) {
+		intf->port.icount.overrun++;
+		intf->flags &= ~DO_OVERRUN_ERR;
+	}
+
+	if (flags & DO_BREAK && !intf->break_reported) {
+		intf->port.icount.brk++;
+		intf->break_reported = true;
+		return TTY_BREAK;
+	}
+	if (flags & DO_FRAME_ERR) {
+		intf->port.icount.frame++;
+		intf->flags &= ~DO_FRAME_ERR;
+		return TTY_FRAME;
+	}
+	if (flags & DO_PARITY_ERR) {
+		intf->port.icount.parity++;
+		intf->flags &= ~DO_PARITY_ERR;
+		return TTY_PARITY;
+	}
+
+	return TTY_NORMAL;
+}
+
+static void serialsim_set_flags(struct serialsim_intf *intf,
+				 unsigned int status)
+{
+	spin_lock_irq(&intf->port.lock);
+	intf->flags |= status;
+	spin_unlock_irq(&intf->port.lock);
+}
+
+static void serialsim_thread_delay(void)
+{
+#ifdef CONFIG_HIGH_RES_TIMERS
+	ktime_t timeout;
+
+	timeout = ns_to_ktime(1000000000 / SERIALSIM_WAKES_PER_SEC);
+	set_current_state(TASK_INTERRUPTIBLE);
+	schedule_hrtimeout(&timeout, HRTIMER_MODE_REL);
+#else
+	schedule_timeout_interruptible(1);
+#endif
+}
+
+static int serialsim_thread(void *data)
+{
+	struct serialsim_intf *intf = data;
+	struct serialsim_intf *ointf = intf->ointf;
+	struct uart_port *port = &intf->port;
+	struct uart_port *oport = &ointf->port;
+	struct circ_buf *tbuf = &intf->buf;
+	unsigned int residual = 0;
+
+	while (!kthread_should_stop()) {
+		unsigned int to_send;
+		unsigned int div;
+		unsigned char buf[SERIALSIM_XBUFSIZE];
+		unsigned int pos = 0;
+		unsigned int flag;
+		unsigned int status = 0;
+
+		spin_lock_irq(&oport->lock);
+		if (ointf->tx_enabled)
+			/*
+			 * Move bytes from the other port's transmit buffer to
+			 * the interface buffer.
+			 */
+			serialsim_transfer_data(oport, tbuf);
+		spin_unlock_irq(&oport->lock);
+
+		/*
+		 *  Move from the interface buffer into the local
+		 *  buffer based on the simulated serial speed.
+		 */
+		to_send = intf->bytes_per_interval;
+		residual += intf->per_interval_residual;
+		div = intf->div;
+		while (!circ_sbuf_empty(tbuf) && to_send) {
+			buf[pos++] = tbuf->buf[tbuf->tail];
+			tbuf->tail = circ_sbuf_next(tbuf->tail);
+			to_send--;
+		}
+		if (residual >= div) {
+			residual -= div;
+			if (!circ_sbuf_empty(tbuf)) {
+				buf[pos++] = tbuf->buf[tbuf->tail];
+				tbuf->tail = circ_sbuf_next(tbuf->tail);
+			}
+		}
+
+		/*
+		 * Move from the internal buffer into my receive
+		 * buffer.
+		 */
+		spin_lock_irq(&port->lock);
+		flag = serialsim_get_flag(intf, &status);
+		if (intf->rx_enabled) {
+			for (to_send = 0; to_send < pos; to_send++) {
+				port->icount.rx++;
+				uart_insert_char(port, status,
+						 DO_OVERRUN_ERR,
+						 buf[to_send], flag);
+				flag = 0;
+				status = 0;
+			}
+		}
+		spin_unlock_irq(&port->lock);
+
+		if (pos)
+			tty_flip_buffer_push(&port->state->port);
+
+		serialsim_thread_delay();
+	}
+
+	return 0;
+}
+
+static void serialsim_start_tx(struct uart_port *port)
+{
+	struct serialsim_intf *intf = serialsim_port_to_intf(port);
+
+	intf->tx_enabled = true;
+}
+
+static void serialsim_stop_rx(struct uart_port *port)
+{
+	struct serialsim_intf *intf = serialsim_port_to_intf(port);
+
+	intf->rx_enabled = false;
+}
+
+static void serialsim_break_ctl(struct uart_port *port, int break_state)
+{
+	struct serialsim_intf *intf = serialsim_port_to_intf(port);
+	struct serialsim_intf *ointf = intf->ointf;
+
+	spin_lock_irq(&ointf->port.lock);
+	if (!break_state && ointf->flags & DO_BREAK) {
+		/* Turning break off. */
+		ointf->break_reported = false;
+		ointf->flags &= ~DO_BREAK;
+	} else if (break_state) {
+		ointf->flags |= DO_BREAK;
+	}
+	spin_unlock_irq(&ointf->port.lock);
+}
+
+static int serialsim_startup(struct uart_port *port)
+{
+	struct serialsim_intf *intf = serialsim_port_to_intf(port);
+	int rv = 0;
+	struct circ_buf *cbuf = &port->state->xmit;
+	unsigned long flags;
+
+	/*
+	 * This is technically wrong, but otherwise tests using it
+	 * can get stale data.
+	 */
+	spin_lock_irqsave(&port->lock, flags);
+	cbuf->head = cbuf->tail = 0;
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	intf->buf.head = intf->buf.tail = 0;
+	intf->thread = kthread_run(serialsim_thread, intf,
+				   "%s%d", intf->threadname, port->line);
+	if (IS_ERR(intf->thread)) {
+		rv = PTR_ERR(intf->thread);
+		intf->thread = NULL;
+		pr_err("serialsim: Could not start thread: %d", rv);
+	} else {
+		spin_lock_irqsave(&port->lock, flags);
+		intf->tx_enabled = true;
+		intf->rx_enabled = true;
+
+		serialsim_set_baud_rate(intf, 9600, CS8);
+		spin_unlock_irqrestore(&port->lock, flags);
+	}
+
+	return rv;
+}
+
+static void serialsim_shutdown(struct uart_port *port)
+{
+	struct serialsim_intf *intf = serialsim_port_to_intf(port);
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	spin_unlock_irqrestore(&port->lock, flags);
+	kthread_stop(intf->thread);
+}
+
+static void serialsim_release_port(struct uart_port *port)
+{
+}
+
+static void
+serialsim_set_termios(struct uart_port *port, struct ktermios *termios,
+		      struct ktermios *old)
+{
+	struct serialsim_intf *intf = serialsim_port_to_intf(port);
+	unsigned int baud = uart_get_baud_rate(port, termios, old,
+					       10, 100000000);
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	serialsim_set_baud_rate(intf, baud, termios->c_cflag);
+	intf->termios = *termios;
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static int serialsim_rs485(struct uart_port *port,
+			   struct serial_rs485 *newrs485)
+{
+	struct serialsim_intf *intf = serialsim_port_to_intf(port);
+
+	intf->rs485 = *newrs485;
+	return 0;
+}
+
+static const char *serialecho_type(struct uart_port *port)
+{
+	return "SerialEcho";
+}
+
+static const char *serialpipea_type(struct uart_port *port)
+{
+	return "SerialPipeA";
+}
+
+static const char *serialpipeb_type(struct uart_port *port)
+{
+	return "SerialPipeB";
+}
+
+static void serialecho_config_port(struct uart_port *port, int type)
+{
+	port->type = PORT_SERIALECHO;
+}
+
+static void serialpipea_config_port(struct uart_port *port, int type)
+{
+	port->type = PORT_SERIALPIPEA;
+}
+
+static void serialpipeb_config_port(struct uart_port *port, int type)
+{
+	port->type = PORT_SERIALPIPEB;
+}
+
+static int serialpipe_ioctl(struct uart_port *port, unsigned int cmd,
+			    unsigned long arg)
+{
+	int rv = 0;
+	struct serialsim_intf *intf = serialsim_port_to_intf(port);
+	unsigned int mask;
+	int val;
+
+	switch (cmd) {
+	case TIOCSERSREMNULLMODEM:
+		serialsim_set_null_modem(intf->ointf, !!arg);
+		break;
+
+	case TIOCSERGREMNULLMODEM:
+		val = intf->ointf->do_null_modem;
+		if (copy_to_user((int __user *) arg, &val, sizeof(int)))
+			rv = -EFAULT;
+		break;
+
+	case TIOCSERSREMMCTRL:
+		mask = (arg >> 16) & 0xffff;
+		arg &= 0xffff;
+		if (mask & ~LOCAL_MCTRL || arg & ~LOCAL_MCTRL)
+			rv = -EINVAL;
+		else
+			serialsim_set_modem_lines(intf->ointf, mask, arg);
+		break;
+
+	case TIOCSERGREMMCTRL:
+		if (copy_to_user((unsigned int __user *) arg,
+				 &intf->ointf->mctrl,
+				 sizeof(unsigned int)))
+			rv = -EFAULT;
+		break;
+
+	case TIOCSERSREMERR:
+		if (arg & ~FLAGS_MASK)
+			rv = -EINVAL;
+		else
+			serialsim_set_flags(intf, arg);
+		break;
+
+	case TIOCSERGREMERR:
+		if (copy_to_user((unsigned int __user *) arg, &intf->flags,
+				 sizeof(unsigned int)))
+			rv = -EFAULT;
+		break;
+
+	case TIOCSERGREMTERMIOS:
+	{
+		struct ktermios otermios;
+
+		spin_lock_irq(&intf->ointf->port.lock);
+		otermios = intf->ointf->termios;
+		spin_unlock_irq(&intf->ointf->port.lock);
+#ifdef TCGETS2
+		rv = kernel_termios_to_user_termios((struct termios2 __user *)
+						    arg,
+						    &otermios);
+#else
+		rv = kernel_termios_to_user_termios((struct termios __user *)
+						    arg,
+						    &otermios);
+#endif
+		if (rv)
+			rv = -EFAULT;
+		break;
+	}
+
+	case TIOCSERGREMRS485:
+	{
+		struct serial_rs485 ors485;
+
+		spin_lock_irq(&intf->ointf->port.lock);
+		ors485 = intf->ointf->rs485;
+		spin_unlock_irq(&intf->ointf->port.lock);
+
+		if (copy_to_user((struct serial_rs485 __user *) arg,
+				 &ors485, sizeof(ors485)))
+			rv = -EFAULT;
+		break;
+	}
+
+	default:
+		rv = -ENOIOCTLCMD;
+	}
+
+	return rv;
+}
+
+static struct serialsim_intf *serialecho_ports;
+static struct serialsim_intf *serialpipe_ports;
+
+static unsigned int nr_echo_ports = 4;
+module_param(nr_echo_ports, uint, 0444);
+MODULE_PARM_DESC(nr_echo_ports,
+		 "The number of echo ports to create.  Defaults to 4");
+
+static unsigned int nr_pipe_ports = 4;
+module_param(nr_pipe_ports, uint, 0444);
+MODULE_PARM_DESC(nr_pipe_ports,
+		 "The number of pipe ports to create.  Defaults to 4");
+
+static char *gettok(char **s)
+{
+	char *t = skip_spaces(*s);
+	char *p = t;
+
+	while (*p && !isspace(*p))
+		p++;
+	if (*p)
+		*p++ = '\0';
+	*s = p;
+
+	return t;
+}
+
+static bool tokeq(const char *t, const char *m)
+{
+	return strcmp(t, m) == 0;
+}
+
+static unsigned int parse_modem_line(char op, unsigned int flag,
+				     unsigned int *mctrl)
+{
+	if (op == '+')
+		*mctrl |= flag;
+	else
+		*mctrl &= ~flag;
+	return flag;
+}
+
+static void serialsim_ctrl_append(char **val, int *left, char *n, bool enabled)
+{
+	int count;
+
+	count = snprintf(*val, *left, " %c%s", enabled ? '+' : '-', n);
+	*left -= count;
+	*val += count;
+}
+
+static ssize_t serialsim_ctrl_read(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct tty_port *tport = dev_get_drvdata(dev);
+	struct uart_state *state = container_of(tport, struct uart_state, port);
+	struct uart_port *port = state->uart_port;
+	struct serialsim_intf *intf = serialsim_port_to_intf(port);
+	unsigned int mctrl = intf->mctrl;
+	char *val = buf;
+	int left = PAGE_SIZE;
+	int count;
+
+	count = snprintf(val, left, "%s:", dev->kobj.name);
+	val += count;
+	left -= count;
+	serialsim_ctrl_append(&val, &left, "nullmodem", intf->do_null_modem);
+	serialsim_ctrl_append(&val, &left, "cd", mctrl & TIOCM_CAR);
+	serialsim_ctrl_append(&val, &left, "dsr", mctrl & TIOCM_DSR);
+	serialsim_ctrl_append(&val, &left, "cts", mctrl & TIOCM_CTS);
+	serialsim_ctrl_append(&val, &left, "ring", mctrl & TIOCM_RNG);
+	serialsim_ctrl_append(&val, &left, "dtr", mctrl & TIOCM_DTR);
+	serialsim_ctrl_append(&val, &left, "rts", mctrl & TIOCM_RTS);
+	*val++ = '\n';
+
+	return val - buf;
+}
+
+static ssize_t serialsim_ctrl_write(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *val, size_t count)
+{
+	struct tty_port *tport = dev_get_drvdata(dev);
+	struct uart_state *state = container_of(tport, struct uart_state, port);
+	struct uart_port *port = state->uart_port;
+	struct serialsim_intf *intf = serialsim_port_to_intf(port);
+	char *str = kstrndup(val, count, GFP_KERNEL);
+	char *p, *s = str;
+	int rv = count;
+	unsigned int flags = 0;
+	unsigned int nullmodem = 0;
+	unsigned int mctrl_mask = 0, mctrl = 0;
+
+	if (!str)
+		return -ENOMEM;
+
+	p = gettok(&s);
+	while (*p) {
+		char op = '\0';
+		int err = 0;
+
+		switch (*p) {
+		case '+':
+		case '-':
+			op = *p++;
+			break;
+		default:
+			break;
+		}
+
+		if (tokeq(p, "frame"))
+			flags |= DO_FRAME_ERR;
+		else if (tokeq(p, "parity"))
+			flags |= DO_PARITY_ERR;
+		else if (tokeq(p, "overrun"))
+			flags |= DO_OVERRUN_ERR;
+		else if (tokeq(p, "nullmodem"))
+			nullmodem = op;
+		else if (tokeq(p, "dsr"))
+			mctrl_mask |= parse_modem_line(op, TIOCM_DSR, &mctrl);
+		else if (tokeq(p, "cts"))
+			mctrl_mask |= parse_modem_line(op, TIOCM_CTS, &mctrl);
+		else if (tokeq(p, "cd"))
+			mctrl_mask |= parse_modem_line(op, TIOCM_CAR, &mctrl);
+		else if (tokeq(p, "ring"))
+			mctrl_mask |= parse_modem_line(op, TIOCM_RNG, &mctrl);
+		else
+			err = -EINVAL;
+
+		if (err) {
+			rv = err;
+			goto out;
+		}
+		p = gettok(&s);
+	}
+
+	if (flags)
+		serialsim_set_flags(intf, flags);
+	if (nullmodem)
+		serialsim_set_null_modem(intf, nullmodem == '+');
+	if (mctrl_mask)
+		serialsim_set_modem_lines(intf, mctrl_mask, mctrl);
+
+out:
+	kfree(str);
+
+	return rv;
+}
+
+static DEVICE_ATTR(ctrl, 0660, serialsim_ctrl_read, serialsim_ctrl_write);
+
+static struct attribute *serialsim_dev_attrs[] = {
+	&dev_attr_ctrl.attr,
+	NULL,
+};
+
+static struct attribute_group serialsim_dev_attr_group = {
+	.attrs = serialsim_dev_attrs,
+};
+
+static const struct uart_ops serialecho_ops = {
+	.tx_empty =		serialsim_tx_empty,
+	.set_mctrl =		serialsim_set_mctrl,
+	.get_mctrl =		serialsim_get_mctrl,
+	.stop_tx =		serialsim_stop_tx,
+	.start_tx =		serialsim_start_tx,
+	.stop_rx =		serialsim_stop_rx,
+	.break_ctl =		serialsim_break_ctl,
+	.startup =		serialsim_startup,
+	.shutdown =		serialsim_shutdown,
+	.release_port =		serialsim_release_port,
+	.set_termios =		serialsim_set_termios,
+	.type =			serialecho_type,
+	.config_port =		serialecho_config_port
+};
+
+static const struct uart_ops serialpipea_ops = {
+	.tx_empty =		serialsim_tx_empty,
+	.set_mctrl =		serialsim_set_mctrl,
+	.get_mctrl =		serialsim_get_mctrl,
+	.stop_tx =		serialsim_stop_tx,
+	.start_tx =		serialsim_start_tx,
+	.stop_rx =		serialsim_stop_rx,
+	.break_ctl =		serialsim_break_ctl,
+	.startup =		serialsim_startup,
+	.shutdown =		serialsim_shutdown,
+	.release_port =		serialsim_release_port,
+	.set_termios =		serialsim_set_termios,
+	.type =			serialpipea_type,
+	.config_port =		serialpipea_config_port,
+	.ioctl =		serialpipe_ioctl
+};
+
+static const struct uart_ops serialpipeb_ops = {
+	.tx_empty =		serialsim_tx_empty,
+	.set_mctrl =		serialsim_set_mctrl,
+	.get_mctrl =		serialsim_get_mctrl,
+	.stop_tx =		serialsim_stop_tx,
+	.start_tx =		serialsim_start_tx,
+	.stop_rx =		serialsim_stop_rx,
+	.break_ctl =		serialsim_break_ctl,
+	.startup =		serialsim_startup,
+	.shutdown =		serialsim_shutdown,
+	.release_port =		serialsim_release_port,
+	.set_termios =		serialsim_set_termios,
+	.type =			serialpipeb_type,
+	.config_port =		serialpipeb_config_port,
+	.ioctl =		serialpipe_ioctl
+};
+
+static struct uart_driver serialecho_driver = {
+	.owner = THIS_MODULE,
+	.driver_name = "ttyEcho",
+	.dev_name = "ttyEcho"
+};
+
+static struct uart_driver serialpipea_driver = {
+	.owner = THIS_MODULE,
+	.driver_name = "ttyPipeA",
+	.dev_name = "ttyPipeA"
+};
+
+static struct uart_driver serialpipeb_driver = {
+	.owner = THIS_MODULE,
+	.driver_name = "ttyPipeB",
+	.dev_name = "ttyPipeB"
+};
+
+
+static int __init serialsim_init(void)
+{
+	unsigned int i;
+	int rv;
+
+	serialecho_ports = kcalloc(nr_echo_ports,
+				   sizeof(*serialecho_ports),
+				   GFP_KERNEL);
+	if (!serialecho_ports) {
+		pr_err("serialsim: Unable to allocate echo ports.\n");
+		rv = ENOMEM;
+		goto out;
+	}
+
+	serialpipe_ports = kcalloc(nr_pipe_ports * 2,
+				   sizeof(*serialpipe_ports),
+				   GFP_KERNEL);
+	if (!serialpipe_ports) {
+		kfree(serialecho_ports);
+		pr_err("serialsim: Unable to allocate pipe ports.\n");
+		rv = ENOMEM;
+		goto out;
+	}
+
+	serialecho_driver.nr = nr_echo_ports;
+	rv = uart_register_driver(&serialecho_driver);
+	if (rv) {
+		kfree(serialecho_ports);
+		kfree(serialpipe_ports);
+		pr_err("serialsim: Unable to register driver.\n");
+		goto out;
+	}
+
+	serialpipea_driver.nr = nr_pipe_ports;
+	rv = uart_register_driver(&serialpipea_driver);
+	if (rv) {
+		uart_unregister_driver(&serialecho_driver);
+		kfree(serialecho_ports);
+		kfree(serialpipe_ports);
+		pr_err("serialsim: Unable to register driver.\n");
+		goto out;
+	}
+
+	serialpipeb_driver.nr = nr_pipe_ports;
+	rv = uart_register_driver(&serialpipeb_driver);
+	if (rv) {
+		uart_unregister_driver(&serialpipea_driver);
+		uart_unregister_driver(&serialecho_driver);
+		kfree(serialecho_ports);
+		kfree(serialpipe_ports);
+		pr_err("serialsim: Unable to register driver.\n");
+		goto out;
+	}
+
+	for (i = 0; i < nr_echo_ports; i++) {
+		struct serialsim_intf *intf = &serialecho_ports[i];
+		struct uart_port *port = &intf->port;
+
+		intf->buf.buf = intf->xmitbuf;
+		intf->ointf = intf;
+		intf->threadname = "serialecho";
+		intf->do_null_modem = true;
+		spin_lock_init(&intf->mctrl_lock);
+		tasklet_init(&intf->mctrl_tasklet, mctrl_tasklet, (long) intf);
+		/* Won't configure without some I/O or mem address set. */
+		port->iobase = 1;
+		port->line = i;
+		port->flags = UPF_BOOT_AUTOCONF;
+		port->ops = &serialecho_ops;
+		spin_lock_init(&port->lock);
+		port->attr_group = &serialsim_dev_attr_group;
+		rv = uart_add_one_port(&serialecho_driver, port);
+		if (rv)
+			pr_err("serialsim: Unable to add uart port %d: %d\n",
+			       i, rv);
+		else
+			intf->registered = true;
+	}
+
+	for (i = 0; i < nr_pipe_ports * 2; i += 2) {
+		struct serialsim_intf *intfa = &serialpipe_ports[i];
+		struct serialsim_intf *intfb = &serialpipe_ports[i + 1];
+		struct uart_port *porta = &intfa->port;
+		struct uart_port *portb = &intfb->port;
+
+		intfa->buf.buf = intfa->xmitbuf;
+		intfb->buf.buf = intfb->xmitbuf;
+		intfa->ointf = intfb;
+		intfb->ointf = intfa;
+		intfa->threadname = "serialpipea";
+		intfb->threadname = "serialpipeb";
+		intfa->do_null_modem = true;
+		intfb->do_null_modem = true;
+		spin_lock_init(&intfa->mctrl_lock);
+		spin_lock_init(&intfb->mctrl_lock);
+		tasklet_init(&intfa->mctrl_tasklet, mctrl_tasklet,
+			     (long) intfa);
+		tasklet_init(&intfb->mctrl_tasklet, mctrl_tasklet,
+			     (long) intfb);
+
+		/* Won't configure without some I/O or mem address set. */
+		porta->iobase = 1;
+		porta->line = i / 2;
+		porta->flags = UPF_BOOT_AUTOCONF;
+		porta->ops = &serialpipea_ops;
+		spin_lock_init(&porta->lock);
+		porta->attr_group = &serialsim_dev_attr_group;
+		porta->rs485_config = serialsim_rs485;
+		rv = uart_add_one_port(&serialpipea_driver, porta);
+		if (rv) {
+			pr_err("serialsim: Unable to add uart pipe aport %d: %d\n",
+			       i, rv);
+			continue;
+		} else {
+			intfa->registered = true;
+		}
+
+		portb->iobase = 1;
+		portb->line = i / 2;
+		portb->flags = UPF_BOOT_AUTOCONF;
+		portb->ops = &serialpipeb_ops;
+		portb->attr_group = &serialsim_dev_attr_group;
+		spin_lock_init(&portb->lock);
+		portb->rs485_config = serialsim_rs485;
+		rv = uart_add_one_port(&serialpipeb_driver, portb);
+		if (rv) {
+			pr_err("serialsim: Unable to add uart pipe b port %d: %d\n",
+			       i, rv);
+			intfa->registered = false;
+			uart_remove_one_port(&serialpipea_driver, porta);
+		} else {
+			intfb->registered = true;
+		}
+	}
+	rv = 0;
+
+	pr_info("serialsim ready\n");
+out:
+	return rv;
+}
+
+static void __exit serialsim_exit(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < nr_echo_ports; i++) {
+		struct serialsim_intf *intf = &serialecho_ports[i];
+		struct uart_port *port = &intf->port;
+
+		if (intf->registered)
+			uart_remove_one_port(&serialecho_driver, port);
+		tasklet_kill(&intf->mctrl_tasklet);
+	}
+
+	for (i = 0; i < nr_pipe_ports * 2; i += 2) {
+		struct serialsim_intf *intfa = &serialpipe_ports[i];
+		struct serialsim_intf *intfb = &serialpipe_ports[i + 1];
+		struct uart_port *porta = &intfa->port;
+		struct uart_port *portb = &intfb->port;
+
+		if (intfa->registered)
+			uart_remove_one_port(&serialpipea_driver, porta);
+		if (intfb->registered)
+			uart_remove_one_port(&serialpipeb_driver, portb);
+		tasklet_kill(&intfa->mctrl_tasklet);
+		tasklet_kill(&intfb->mctrl_tasklet);
+	}
+	uart_unregister_driver(&serialecho_driver);
+	uart_unregister_driver(&serialpipea_driver);
+	uart_unregister_driver(&serialpipeb_driver);
+
+	kfree(serialecho_ports);
+	kfree(serialpipe_ports);
+
+	pr_info("serialsim unloaded\n");
+}
+
+module_init(serialsim_init);
+module_exit(serialsim_exit);
+
+MODULE_AUTHOR("Corey Minyard");
+MODULE_DESCRIPTION("Serial simulation device");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/serialsim.h b/include/uapi/linux/serialsim.h
new file mode 100644
index 000000000000..7c62c7d148d1
--- /dev/null
+++ b/include/uapi/linux/serialsim.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+
+/*
+ * serialsim - Emulate a serial device in a loopback and/or pipe
+ */
+
+/*
+ * TTY IOCTLs for controlling the modem control and for error injection.
+ * See drivers/tty/serial/serialsim.c and Documentation/serial/serialsim.rst
+ * for details.
+ */
+
+#ifndef LINUX_SERIALSIM_H
+#define LINUX_SERIALSIM_H
+
+#include <linux/ioctl.h>
+#include <asm/termbits.h>
+
+#define TIOCSERSREMNULLMODEM	0x54e4
+#define TIOCSERSREMMCTRL	0x54e5
+#define TIOCSERSREMERR		0x54e6
+#define TIOCSERGREMTERMIOS	_IOR('T', 0xe7, struct termios2)
+#define TIOCSERGREMNULLMODEM	_IOR('T', 0xe8, int)
+#define TIOCSERGREMMCTRL	_IOR('T', 0xe9, unsigned int)
+#define TIOCSERGREMERR		_IOR('T', 0xea, unsigned int)
+#define TIOCSERGREMRS485	_IOR('T', 0xeb, struct serial_rs485)
+
+#endif
-- 
2.17.1

