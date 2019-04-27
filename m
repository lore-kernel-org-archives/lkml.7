Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E34C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E249208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfD0M4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:56:41 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:41983 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfD0MxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:09 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MPXpS-1h7dOA2vUw-00MaDR; Sat, 27 Apr 2019 14:52:44 +0200
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
Subject: [PATCH 13/41] drivers: tty: serial: uartlite: fill mapsize and use it
Date:   Sat, 27 Apr 2019 14:51:54 +0200
Message-Id: <1556369542-13247-14-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:HsinThJYSBbvZXPfm+0O6kKUO+qcziVpNnYsjWaEzEiMEg9DSuK
 dNf0rb/MCsWgo6VR685d/dBzsntfhucM9zdpec9KJhVPsvgZXFU+FHm2NA8+p9uNUoUt2t/
 97+mu3GZ0mzF7ACNEs/tQdl8KcWi9bu5JVWLna6RzeYMAWm9wnFG9XjorOOkAQTF4hi7dJB
 W8BggkCEpEPmgsUJa1QKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M2CupHkdprI=:t4eNWY5bS1vu92cW6qDWEU
 ADcR+6Kg7dcevcZPeO14Esbr4UB1TouOkNfW01O86yvYnijA1sc/wnjYLbAFIt0rwXMyPKNGU
 O/PioqNftTLrLR+ttFEWixd+2dV3vE30I4Ge56dkTfvUCXNuMnkxzEAZskQfusFSpau0qMp3m
 4B3eZ7QEbqsajYkwU+gX1wSdVckm7ohYMvPl92gqYlvK0WbrvXhR6X59BXzlQ+TeldpXpLkpt
 qxNlzP/6DsfSHkrfCntzbFaD4FkxHXnhDUDngfu6J8I1XCkKuDwY7JEfPQIoyLB7Ao7TKq3gj
 WIlU9tIg7jI/cufHOP/EkSmv0xP8qavjGQazjMDDC57vd+Jovtnwcp3n24xxplR6xxuT5tAwY
 Wp9TEeiF0rZwe1z9tF6QztbHm2UaaNo2wv6I1A+IN6pVUFBFul9CnwmxQG81GmFjrhxWSgUtJ
 IMMdF66BcOi48fIhcMfXtDWMpWDXC+uWdiPjeWhQk1RUYc6PrVeGQOYfhDHJelX7nkF9fOJvN
 yjiW401cuK4NbC6nHAjZULv7zT8Ckza4ID+/BlH0wUfNAkj6i28hgOSsg58c6b5fMCXjyhkJL
 5R5FYtY9cs3sxNW2/qp+GIWH0qY3L7sI0LyA/aC3gm70d0HNqsoPZD49KGFdJ75JCDJrwlJ+l
 +MfViqK0FaiihFHJPKgf95dVxASBqvUqvWXYZbU0XDUpXNVGBfQQpp5jxT6/y8t/byI8M1vTQ
 ll/ztjVh1UtTy87vhydhWCwlP4maAW5p4lwI3g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fill the struct uart_port->mapsize field and use it, insteaf of
hardcoded values in many places. This makes the code layout a bit
more consistent and easily allows using generic helpers for the
io memory handling.

Candidates for such helpers could be eg. the request+ioremap and
iounmap+release combinations.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/uartlite.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 44d65bd..c322ab6 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -342,7 +342,7 @@ static const char *ulite_type(struct uart_port *port)
 
 static void ulite_release_port(struct uart_port *port)
 {
-	release_mem_region(port->mapbase, ULITE_REGION);
+	release_mem_region(port->mapbase, port->mapsize);
 	iounmap(port->membase);
 	port->membase = NULL;
 }
@@ -356,15 +356,15 @@ static int ulite_request_port(struct uart_port *port)
 		"ulite console: port=%p; port->mapbase=%llx\n",
 		 port, (unsigned long long) port->mapbase);
 
-	if (!request_mem_region(port->mapbase, ULITE_REGION, "uartlite")) {
+	if (!request_mem_region(port->mapbase, port->mapsize, "uartlite")) {
 		dev_err(port->dev, "Memory region busy\n");
 		return -EBUSY;
 	}
 
-	port->membase = ioremap(port->mapbase, ULITE_REGION);
+	port->membase = ioremap(port->mapbase, port->mapsize);
 	if (!port->membase) {
 		dev_err(port->dev, "Unable to map registers\n");
-		release_mem_region(port->mapbase, ULITE_REGION);
+		release_mem_region(port->mapbase, port->mapsize);
 		return -EBUSY;
 	}
 
@@ -649,6 +649,7 @@ static int ulite_assign(struct device *dev, int id, u32 base, int irq,
 	port->iotype = UPIO_MEM;
 	port->iobase = 1; /* mark port in use */
 	port->mapbase = base;
+	port->mapsize = ULITE_REGION;
 	port->membase = NULL;
 	port->ops = &ulite_ops;
 	port->irq = irq;
-- 
1.9.1

