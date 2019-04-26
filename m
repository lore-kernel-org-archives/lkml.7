Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD60C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73293206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="SjHD1InQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfDZIhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:37:02 -0400
Received: from first.geanix.com ([116.203.34.67]:35870 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbfDZIhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:37:01 -0400
Received: from localhost (unknown [193.163.1.7])
        by first.geanix.com (Postfix) with ESMTPSA id 8FA2B308E71;
        Fri, 26 Apr 2019 08:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1556267750; bh=oxppZ/JJ4iNHirr/Iz21WP0fRvHABjsHo/+K9PQrsFk=;
        h=From:To:Cc:Subject:Date;
        b=SjHD1InQ1Le7c1g8Px5tGi/eqHHcKrdWVyWRhhxEOzVt9l+CPLt50JJUn4KD5ysbW
         aiqIWsQdyl4NwlbAvntdAe+3kWp3xgBFahpJntIFDlW5RlzZV10rGTVdBvbxhSGv1V
         hb+/4WEPK1qiXN/g88HkJpIIE20bgEbp4q2vdxJKb1POae2FcUe3RQEswsHvtWIc6E
         R5dbueH5B37zNbcv2IrsIGQN7l5gONrfLhpmWws0YHMA9a9medCzHqq7M7eSXqZDV5
         Iw72zV92GFX/hHD0B4pEaYsIqFg9eBT0K5Vi4LF/obUoiOjY7k0t39vNzHeqpWeIir
         9ViBcqggrQ5xw==
From:   Esben Haabendal <esben@geanix.com>
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        He Zhe <zhe.he@windriver.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] serial: 8250: Allow port registration without UPF_BOOT_AUTOCONF
Date:   Fri, 26 Apr 2019 10:36:56 +0200
Message-Id: <20190426083657.5544-1-esben@geanix.com>
X-Mailer: git-send-email 2.21.0
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

