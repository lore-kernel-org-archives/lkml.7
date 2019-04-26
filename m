Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4A2C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DCA20652
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="dZyXt6OU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfDZIkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:40:46 -0400
Received: from first.geanix.com ([116.203.34.67]:36026 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfDZIkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:40:45 -0400
Received: from localhost (unknown [193.163.1.7])
        by first.geanix.com (Postfix) with ESMTPSA id 809A4308E75;
        Fri, 26 Apr 2019 08:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1556267974; bh=oxppZ/JJ4iNHirr/Iz21WP0fRvHABjsHo/+K9PQrsFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dZyXt6OUmlY7V9H6PFJi8B3TZQS4qYDh7tlJzgJoLqRnOWNXo8lvxmkcKlPIuvagk
         fj4dokqDmemlKJsr2lXPNEzZ2fwdYAKT3FIWszgcK8fwJMLtFQ3vY31qICe9PmYWDQ
         dFysnVJgkM7r2j+Sbw/FLEMT7z5iozDbZdooWpFpmK76zfdhTLyH8r/Ushbkxz1djk
         mmBgJTL2Tdie2aPLx3glAzbGR15I/PVT7frmAa1/u3YAKzFEqu3BDExFQ5dP59u0iV
         2YueY94Cf7klZAXY1Z4M+UlihOpV5dOsbYEhhu4lk6b7yEepS3LYJrv+iBmzgPfnPW
         vSme1GzjK9eHQ==
From:   Esben Haabendal <esben@geanix.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        He Zhe <zhe.he@windriver.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] serial: 8250: Allow port registration without UPF_BOOT_AUTOCONF
Date:   Fri, 26 Apr 2019 10:40:37 +0200
Message-Id: <20190426084038.6377-2-esben@geanix.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190426084038.6377-1-esben@geanix.com>
References: <20190426084038.6377-1-esben@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With serial8250_register_8250_port() forcing UPF_BOOT_AUTOCONF bit on, it
is not possible to register a port without having
serial8250_request_std_resource() called.

For adding a 8250 port to an MFD device, this is problematic, as the
request_mem_region() call will fail, as the MFD device (and rightly  so)
has requested the region.  For this case, the 8250 port should accept
having passed mapbase and membase, and just use that.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/tty/serial/8250/8250_core.c | 36 +++++++++++++++++++++---------------
 include/linux/serial_8250.h         |  2 ++
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index e441221..ddbb0a0 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -957,20 +957,8 @@ static void serial_8250_overrun_backoff_work(struct work_struct *work)
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
-/**
- *	serial8250_register_8250_port - register a serial port
- *	@up: serial port template
- *
- *	Configure the serial port specified by the request. If the
- *	port exists and is in use, it is hung up and unregistered
- *	first.
- *
- *	The port is then probed and if necessary the IRQ is autodetected
- *	If this fails an error is returned.
- *
- *	On success the port is ready to use and the line number is returned.
- */
-int serial8250_register_8250_port(struct uart_8250_port *up)
+int __serial8250_register_8250_port(struct uart_8250_port *up,
+				    unsigned int extra_flags)
 {
 	struct uart_8250_port *uart;
 	int ret = -ENOSPC;
@@ -993,7 +981,7 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 		uart->port.fifosize     = up->port.fifosize;
 		uart->port.regshift     = up->port.regshift;
 		uart->port.iotype       = up->port.iotype;
-		uart->port.flags        = up->port.flags | UPF_BOOT_AUTOCONF;
+		uart->port.flags        = up->port.flags | extra_flags;
 		uart->bugs		= up->bugs;
 		uart->port.mapbase      = up->port.mapbase;
 		uart->port.mapsize      = up->port.mapsize;
@@ -1086,6 +1074,24 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 
 	return ret;
 }
+
+/**
+ *	serial8250_register_8250_port - register a serial port
+ *	@up: serial port template
+ *
+ *	Configure the serial port specified by the request. If the
+ *	port exists and is in use, it is hung up and unregistered
+ *	first.
+ *
+ *	The port is then probed and if necessary the IRQ is autodetected
+ *	If this fails an error is returned.
+ *
+ *	On success the port is ready to use and the line number is returned.
+ */
+int serial8250_register_8250_port(struct uart_8250_port *up)
+{
+	return __serial8250_register_8250_port(up, UPF_BOOT_AUTOCONF);
+}
 EXPORT_SYMBOL(serial8250_register_8250_port);
 
 /**
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 5a655ba..9d1fe2e 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -145,6 +145,8 @@ static inline struct uart_8250_port *up_to_u8250p(struct uart_port *up)
 	return container_of(up, struct uart_8250_port, port);
 }
 
+extern int __serial8250_register_8250_port(struct uart_8250_port *,
+					   unsigned int);
 int serial8250_register_8250_port(struct uart_8250_port *);
 void serial8250_unregister_port(int line);
 void serial8250_suspend_port(int line);
-- 
2.4.11

