Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C272C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A122087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfD0MyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:54:07 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:36297 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfD0Mxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:34 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N1fei-1gegIM1SdE-011xhz; Sat, 27 Apr 2019 14:53:06 +0200
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
Subject: [PATCH 38/41] drivers: tty: serial: xilinx_uartps: fill mapsize and use it
Date:   Sat, 27 Apr 2019 14:52:19 +0200
Message-Id: <1556369542-13247-39-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:VtPNlXzPCRVCI3k6aUN/2RTDRVtNySvUetW2m1i45Od16fYdx6y
 LS0k0V6K9tTbj9vRmp5ZCjL/mOHH5UpOiIqa//lNidg8lexGQDtGIijbeiQYs9a5ONTZ41P
 /QJB/7RWi0uO5xDMBNsrF+ru49A7jV2roH/XamiBQrb9q1XduKueamQiuyXwbKmDF6vMy65
 SexEhyAOG2uVr2I4z3nnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vdDn587xvd4=:4RpbDZcbrZSWSyIEGlsv8U
 0K/I8sTnMUV5V0+BjvOPaxxEwIozbULnFUa3IkYA47OU1n2ZzOGt7QzRwMPMuqMALSKhvyuAl
 t6yxt1msPA6kyUDppcf5bgSpylyoQ+W3C3CEite19ArJ0t2AwR6wilppKV3Jh+KUD0mfjD37s
 puKb7aoMCoZdZ9cOEaWpB8YfmHh2SeNm3SKcsAkE7vcrHhkRch80ahpP21xLnNLrzWFwCiTuU
 WSN3vp3JWGFtDHw/p2jQySYFGI9Vvh91eVlMxXKQnLF8yiehURKGk5Y9GEuaj9RXP5HmHyXjL
 lkZ4wlyKfUEpxD3Tl6j6hawA4nl7XcPNysl3Seys3+VcrP/aydSp4ueltBl6mcp8g5r8Iu5uk
 FkL08ODMZnsQE8pOye6cuMetb4LkUBCKcprXMYP3ryPqZt7eZBS2lqFiNuPM8xsH9a6WEgJYl
 I8UzUK30NOx46sp+1PsMg6yTempKzXES5ap5lEgIV0nJrAM21L0mN5/+t0oEjzTtfatOFX5uk
 M8KVoYNe+W+PKDYsTRSESAgizrPxXk4EkwtRVnV0jmEmUaN3alDd8SqnV0Gu3ROymNZhrZzjz
 UqyzBRlfWbCGoVNw2LXOb1DGrDLQx+dvJriCIMgZ17xzGKlGAboXpbywthlWS4UNNov0IADCk
 lffkQK22QhbX1XOmZDBYc2dE7NUMWkmiM2KbFwEs43p6iiUf7jDM/pMtGNBfUfwU5YV9haj7W
 AFEnEYlgHisqoTzmsKB1b9VQMJVErA9QCIapeg==
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
 drivers/tty/serial/xilinx_uartps.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 74089f5..cf8ca66 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -953,15 +953,15 @@ static int cdns_uart_verify_port(struct uart_port *port,
  */
 static int cdns_uart_request_port(struct uart_port *port)
 {
-	if (!request_mem_region(port->mapbase, CDNS_UART_REGISTER_SPACE,
+	if (!request_mem_region(port->mapbase, port->mapsize,
 					 CDNS_UART_NAME)) {
 		return -ENOMEM;
 	}
 
-	port->membase = ioremap(port->mapbase, CDNS_UART_REGISTER_SPACE);
+	port->membase = ioremap(port->mapbase, port->mapsize);
 	if (!port->membase) {
 		dev_err(port->dev, "Unable to map registers\n");
-		release_mem_region(port->mapbase, CDNS_UART_REGISTER_SPACE);
+		release_mem_region(port->mapbase, port->mapsize);
 		return -ENOMEM;
 	}
 	return 0;
@@ -976,7 +976,7 @@ static int cdns_uart_request_port(struct uart_port *port)
  */
 static void cdns_uart_release_port(struct uart_port *port)
 {
-	release_mem_region(port->mapbase, CDNS_UART_REGISTER_SPACE);
+	release_mem_region(port->mapbase, port->mapsize);
 	iounmap(port->membase);
 	port->membase = NULL;
 }
@@ -1627,6 +1627,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	 * and triggers invocation of the config_port() entry point.
 	 */
 	port->mapbase = res->start;
+	port->mapsize = CDNS_UART_REGISTER_SPACE;
 	port->irq = irq;
 	port->dev = &pdev->dev;
 	port->uartclk = clk_get_rate(cdns_uart_data->uartclk);
-- 
1.9.1

