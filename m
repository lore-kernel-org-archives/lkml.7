Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E043C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FBB21873
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbfCNWfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:35:02 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:38477 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbfCNWe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:34:59 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N3sRi-1gvalv2zSq-00zmY0; Thu, 14 Mar 2019 23:34:43 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, eric@anholt.net,
        stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        matthias.bgg@gmail.com, yamada.masahiro@socionext.com,
        tklauser@distanz.ch, richard.genoud@gmail.com,
        macro@linux-mips.org, u.kleine-koenig@pengutronix.de,
        kernel@pengutronix.de, slemieux.tyco@gmail.com,
        andy.gross@linaro.org, david.brown@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        baohua@kernel.org, jacmet@sunsite.dk, linux-serial@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 12/45] drivers: tty: serial: xilinx_uartps: use devm_* functions
Date:   Thu, 14 Mar 2019 23:33:42 +0100
Message-Id: <1552602855-26086-13-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:D6vqc6/SMpMwV3Mjm1p7xwRTR72HMVZBBVh1/FCbNDWkp8P3g2W
 TrOQ87bVPA7kZwpyl4ktqhFPS0EHPzrsjJIhjUlp5PE8BrbbZWJkU1r+OdPzwIb+4IuKGu8
 qTaAipHSCwQ95WbNCyDsmAXV+n3scqPBNNtGSqPBn9yAKY29csLqZoxzRV+w7cCK1CTqMJt
 srxJ7oLeNS4PEbiQgosVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dQYoeogF+gM=:+v5tmVFISov78Xbvh9iZWd
 +upmxph7jKFEYXmvk+036QcWGCaBMGC4wGaE3YoW8226iiUEqZCy0tCZE4//CTfsZlYfXBIGD
 jEGMIOXU4rvKB2NR0rJzpIpCH2Jlz9U4Ri8KL6Ae3Nd6n3D6E6l/rjfIZ+HdZVEGDWFvMLNNW
 hSD/aOk99A1r/xJb+clK1/e70LznqkzsFj3mfkp9Q0hbPnJ0ytnaiONyW0ZSPe3QhFOzSA+F1
 /vP4Wi9Ghxc5+teU3KNPolONOKVbwpzIYVk4CzZ18tbnxil8nosXH0PoMlbsRKA0p65myyigy
 qUQcN9E8jchRS08fDImRAWZEBlj1bcEuLq/wvzzE2w6stKJeo9LWDylJXF4/UA/Xv43rVauY7
 Jy/t1QiO2zSmF39CpPkDN+x761trSt3rU+zCZxc+vjH6DIURsynyMWONBkGumyLEW9MmyvkTw
 F9WRIcYiT3BUP3RmzycQb56UcT8yz3b2w6uUiKQKiW7Fj7kW607xGWGMxKeIwMfp1qPjUjSn1
 Y2MrNOOPKqIZ25Lj90rVDUboOBWh07kvUTnpK9zRTHgdrzSOL8C7IpTxCzGXIXubVb0NQYmPN
 9abhyKD7BY2nDDo5Va52UH2qhTmNv13ENTShkP60bQnP6Fi8FXWhPQPUvJd4/2oVLai2FFhbC
 hnOtc6GA2K0p+e90KmRseGL5sTZtwPyHnXAGmJWM2JutSjpd8hG0NGbwfHaAGEzqMkRA8O9l7
 9ccXjW99SDXU0FLLE9VvHYFZ/hdZ1wZXaHrbdw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the safer devm versions of memory mapping functions.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/xilinx_uartps.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 74089f5..6684ed7 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -953,15 +953,21 @@ static int cdns_uart_verify_port(struct uart_port *port,
  */
 static int cdns_uart_request_port(struct uart_port *port)
 {
-	if (!request_mem_region(port->mapbase, CDNS_UART_REGISTER_SPACE,
-					 CDNS_UART_NAME)) {
+	if (!devm_request_mem_region(port->dev,
+				     port->mapbase,
+				     CDNS_UART_REGISTER_SPACE,
+				     CDNS_UART_NAME)) {
 		return -ENOMEM;
 	}
 
-	port->membase = ioremap(port->mapbase, CDNS_UART_REGISTER_SPACE);
+	port->membase = devm_ioremap(port->dev,
+				     port->mapbase,
+				     CDNS_UART_REGISTER_SPACE);
 	if (!port->membase) {
 		dev_err(port->dev, "Unable to map registers\n");
-		release_mem_region(port->mapbase, CDNS_UART_REGISTER_SPACE);
+		devm_release_mem_region(port->dev,
+					port->mapbase,
+					CDNS_UART_REGISTER_SPACE);
 		return -ENOMEM;
 	}
 	return 0;
@@ -976,8 +982,10 @@ static int cdns_uart_request_port(struct uart_port *port)
  */
 static void cdns_uart_release_port(struct uart_port *port)
 {
-	release_mem_region(port->mapbase, CDNS_UART_REGISTER_SPACE);
-	iounmap(port->membase);
+	devm_release_mem_region(port->dev,
+				port->mapbase,
+				CDNS_UART_REGISTER_SPACE);
+	devm_iounmap(port->dev, port->membase);
 	port->membase = NULL;
 }
 
-- 
1.9.1

