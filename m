Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9173C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F88208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfD0MyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:54:17 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:36535 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfD0Mxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:33 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MS3r9-1hEZPX2dSN-00TRpw; Sat, 27 Apr 2019 14:53:04 +0200
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
Subject: [PATCH 36/41] drivers: tty: serial: 8250: store mmio resource size in port struct
Date:   Sat, 27 Apr 2019 14:52:17 +0200
Message-Id: <1556369542-13247-37-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:5xh4xCURPmXUvaYJVhWOOLAQMBFKolTB1CtYzDRsCmMQTGj9Kze
 7Fbh3rf2q+OnFvF6rluf5naHkTWp2AKMpX/8qWmYyA8oK2d2GVmdCXs4872KOgx/atiTp7G
 d+ALZSGvhXvKgBZpXx6a8p8ION7NAMwQ3bOjpLN0lyMQnletfe+ZuAytTgD3Wq6yfeTr+s+
 ZII786NCtXHLUZuyeofOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GZhL/NKGMsU=:pnMO/pRCh4WLDmq1DpqqkI
 p740YhoZo3KQxvlsgHWL9Sn+LIr06u69K2ghV8d9qHNzoyiPomaqNU5cnYgdozqeDh29Rsgjv
 ffKYhEy8LP/dM3+eJZyPqJby5XBIeyw+t/Yz/Gqu5DJyCCZ0qGn+obhaZrEAC1hn0dehex8LH
 Y29Pludjbv/FLBcUH2QZ5aierVn9/bY69FTIeRIdUACuTWi6mi7zK5YHunkvSlaQzgvdXxNyL
 dCjmGgw2Amr8S6h7ta+8i/sCpp8B7+3p+92RuIDy5BKINKaXuN3bN9MOGLjDGFwRqgRlti/Dj
 LliFdWVz1UBHO2VJwClV0KGGWcYUjvjijY7zPH0IEBJB+EhJwtyrQ/KudHTCa33UAXq0+TUAT
 EpoR7jQNlBnEiT/SFmsOgpGN8b7lsalx7rdGaNRvV+zYtMll9I9Ms1lsgy3xcw4VKqy4dxZuO
 x+9uYESni8vxxkNVHa0vkDraGm51hKm5cxfVSh9b7Wrq8UfujbcasWoSCOB6Du0TKnFF9opiu
 cjKF9J4+ZiXNe+dqu7B06scO0AubXzFYOUxDQSf7E44puHzDnYbEZJL1hnVUo1+0uhLdYXcfC
 fPqwL7DvijxNj/uuYVU5ONNp5roM2diftSzOsvSbGpAzFmDa2YYt9ALX/fURAdlGRPFYSyGIs
 gMntrnhErYZl3d/3yiz61Pbsjf9nvg9eaN8p31MgENeQofS70cF9FMmSpx7UxWsdjShkic4oX
 n1nhOD1d3Z+rEp/YJb0U6rAZJ+vN4ZqBpXkcfw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The io resource size is currently recomputed when it's needed but this
actually needs to be done once (or drivers could specify fixed values)

Simplify that by doing this computation only once and storing the result
into the mapsize field. serial8250_register_8250_port() is now called
only once on driver init, the previous call sites now just fetch the
value from the mapsize field.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/8250/8250.h      |  2 ++
 drivers/tty/serial/8250/8250_core.c |  3 +++
 drivers/tty/serial/8250/8250_port.c | 33 +++++++++++++++------------------
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index ebfb0bd..89e3f09 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -255,3 +255,5 @@ static inline int serial_index(struct uart_port *port)
 {
 	return port->minor - 64;
 }
+
+unsigned int serial8250_port_size(struct uart_8250_port *pt);
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 71a398b..a9d4ba1 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -979,6 +979,9 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 	if (up->port.uartclk == 0)
 		return -EINVAL;
 
+	/* compute the mapsize in case the driver didn't specify one */
+	up->mapsize = serial8250_port_size(up);
+
 	mutex_lock(&serial_mutex);
 
 	uart = serial8250_find_match_or_unused(&up->port);
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index d2f3310..d09af4c 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2829,7 +2829,7 @@ void serial8250_do_pm(struct uart_port *port, unsigned int state,
 		serial8250_do_pm(port, state, oldstate);
 }
 
-static unsigned int serial8250_port_size(struct uart_8250_port *pt)
+unsigned int serial8250_port_size(struct uart_8250_port *pt)
 {
 	if (pt->port.mapsize)
 		return pt->port.mapsize;
@@ -2849,9 +2849,7 @@ static unsigned int serial8250_port_size(struct uart_8250_port *pt)
  */
 static int serial8250_request_std_resource(struct uart_8250_port *up)
 {
-	unsigned int size = serial8250_port_size(up);
 	struct uart_port *port = &up->port;
-	int ret = 0;
 
 	switch (port->iotype) {
 	case UPIO_AU:
@@ -2863,32 +2861,31 @@ static int serial8250_request_std_resource(struct uart_8250_port *up)
 		if (!port->mapbase)
 			break;
 
-		if (!request_mem_region(port->mapbase, size, "serial")) {
-			ret = -EBUSY;
-			break;
-		}
+		if (!request_mem_region(port->mapbase,
+					port->mapsize, "serial"))
+			return -EBUSY;
 
 		if (port->flags & UPF_IOREMAP) {
-			port->membase = ioremap_nocache(port->mapbase, size);
-			if (!port->membase) {
-				release_mem_region(port->mapbase, size);
-				ret = -ENOMEM;
-			}
+			port->membase = ioremap_nocache(port->mapbase,
+							port->mapsize);
+			if (!port->membase)
+				release_mem_region(port->mapbase,
+						   port->mapsize);
+				return -ENOMEM;
 		}
 		break;
 
 	case UPIO_HUB6:
 	case UPIO_PORT:
-		if (!request_region(port->iobase, size, "serial"))
-			ret = -EBUSY;
+		if (!request_region(port->iobase, port->mapsize, "serial"))
+			return -EBUSY;
 		break;
 	}
-	return ret;
+	return 0;
 }
 
 static void serial8250_release_std_resource(struct uart_8250_port *up)
 {
-	unsigned int size = serial8250_port_size(up);
 	struct uart_port *port = &up->port;
 
 	switch (port->iotype) {
@@ -2906,12 +2903,12 @@ static void serial8250_release_std_resource(struct uart_8250_port *up)
 			port->membase = NULL;
 		}
 
-		release_mem_region(port->mapbase, size);
+		release_mem_region(port->mapbase, port->mapsize);
 		break;
 
 	case UPIO_HUB6:
 	case UPIO_PORT:
-		release_region(port->iobase, size);
+		release_region(port->iobase, port->mapsize);
 		break;
 	}
 }
-- 
1.9.1

