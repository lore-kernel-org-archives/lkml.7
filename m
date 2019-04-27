Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF53C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076B42087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfD0M4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:56:10 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:52457 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbfD0MxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:10 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MdeSn-1glaAQ1CHx-00ZjUI; Sat, 27 Apr 2019 14:52:47 +0200
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
Subject: [PATCH 16/41] drivers: tty: serial: uartlite: fix overlong lines
Date:   Sat, 27 Apr 2019 14:51:57 +0200
Message-Id: <1556369542-13247-17-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:Ck93dTfp9+M+xebhyVSLDIJuo4MjSGOjDhbkWBRUIflN7U9qSCe
 pUde8jE0w5A43JR5NuYza+AsYcjHeRQdVwFH5DfzOGQOqRZzgRch+fJcKukuNGfeEOytvZR
 5/10Xwz0fpHNGToPKDV3mQbY+HwaGvDTud8ym7VEBca8ousV2I6zja+sNCKPIsmKUiAW4+V
 hJqAZT0gvkBV1/kztVb2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lFLVA5ANqXA=:+nwoqH7LETA5l4ZD6Cy0by
 9QQxF9w7JwL9dfUQLkTSklNQAm9TDaWBKAb/AK8KrfiMTcGzLt9Ee5RiujQGuJAuFYCa25OaW
 PsRCxkE462T85gSy8Pd/1exhcYQsoX46KyLQ4ZKSeHvVV8tbKS/OwkFfGrRHmBQ8UlBeXLZK5
 ebF4s0a/Z8QgHeSqLp8Mld3p8Su8UoV9Y8qvT6GUpcFbwp930569alSTM8wqnyrp9aFJ3bviY
 wC6Tzx19GZ9/leyIqE3JEmv02FWM4Ec4A6QWgiqsopsuDAzIuR2eWi4DxrYaPHzxccOjVXhW2
 RfH12CPwxeEkAGqjze7Djw/S5IYL86ng+BscK9UV3x0uudrqH2DvL3151YkbTo13FkHwqeNnW
 DIe1MAVVKDPOOe4QN7noYVLhRj71YKuN4gMT/LJ+u880TUoLEHCWMILbm5ZFZyvlzBG6K47hU
 9N57YDdSPilc+UdCPlSqXcQ4hJByXjZkI6wRREnTfmyit5sfL61G8Cy9lTvJngnoKEflZ/q/D
 +VkFl7qZhum7WEPeks7u2yKFDTGflXCZYn2mA1tQq+cnqN0OJ85RJZpWS9w6/wqjPbVQmeHnX
 K1uOze3TXyWYC56Tqwpenyo+uVz9fCc59R4P6VjWRvoYFvUN2alVsNGhQFk7qhdBWZ+GW9efn
 J+EJarUbpowxoppGXDdCKd50A08hfJxVUT6cLO8NZbGm/sKEm6hc8cXIke/czqdZS6Z34iUaH
 iiO7jtF61oWxoOCw5a6wqJbKewrFO8VHKUZg/A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warnings:

    WARNING: line over 80 characters
    #283: FILE: drivers/tty/serial/uartlite.c:283:
    +	ret = request_irq(port->irq, ulite_isr, IRQF_SHARED | IRQF_TRIGGER_RISING,

    WARNING: Missing a blank line after declarations
    #577: FILE: drivers/tty/serial/uartlite.c:577:
    +	struct earlycon_device *device = console->data;
    +	uart_console_write(&device->port, s, n, early_uartlite_putc);

    WARNING: line over 80 characters
    #590: FILE: drivers/tty/serial/uartlite.c:590:
    +OF_EARLYCON_DECLARE(uartlite_b, "xlnx,opb-uartlite-1.00.b", early_uartlite_setup);

    WARNING: line over 80 characters
    #591: FILE: drivers/tty/serial/uartlite.c:591:
    +OF_EARLYCON_DECLARE(uartlite_a, "xlnx,xps-uartlite-1.00.a", early_uartlite_setup);

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/uartlite.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 6f79353..0140cec 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -280,7 +280,8 @@ static int ulite_startup(struct uart_port *port)
 		return ret;
 	}
 
-	ret = request_irq(port->irq, ulite_isr, IRQF_SHARED | IRQF_TRIGGER_RISING,
+	ret = request_irq(port->irq, ulite_isr,
+			  IRQF_SHARED | IRQF_TRIGGER_RISING,
 			  "uartlite", port);
 	if (ret)
 		return ret;
@@ -574,6 +575,7 @@ static void early_uartlite_write(struct console *console,
 				 const char *s, unsigned int n)
 {
 	struct earlycon_device *device = console->data;
+
 	uart_console_write(&device->port, s, n, early_uartlite_putc);
 }
 
@@ -587,8 +589,10 @@ static int __init early_uartlite_setup(struct earlycon_device *device,
 	return 0;
 }
 EARLYCON_DECLARE(uartlite, early_uartlite_setup);
-OF_EARLYCON_DECLARE(uartlite_b, "xlnx,opb-uartlite-1.00.b", early_uartlite_setup);
-OF_EARLYCON_DECLARE(uartlite_a, "xlnx,xps-uartlite-1.00.a", early_uartlite_setup);
+OF_EARLYCON_DECLARE(uartlite_b, "xlnx,opb-uartlite-1.00.b",
+		    early_uartlite_setup);
+OF_EARLYCON_DECLARE(uartlite_a, "xlnx,xps-uartlite-1.00.a",
+		    early_uartlite_setup);
 
 #endif /* CONFIG_SERIAL_UARTLITE_CONSOLE */
 
-- 
1.9.1

