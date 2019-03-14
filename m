Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480AFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A0821874
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbfCNWhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:37:10 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:59871 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbfCNWfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:35:19 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MZk1p-1ha7vI0XKR-00WmeJ; Thu, 14 Mar 2019 23:35:07 +0100
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
Subject: [PATCH v2 37/45] drivers: tty: serial: apbuart: use devm_* functions
Date:   Thu, 14 Mar 2019 23:34:07 +0100
Message-Id: <1552602855-26086-38-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:2dk2jESpJv/HEfcNhm6LprNXtUCqzVx1Rvdfnjmt87/bGDbVsf/
 n6IJXGpfOh+ytlsw3dFBHYudgyuS1XDPdOT3eQYpN7QrEUJ5zFh4jnOO9OqQ2oHIhZfyLL4
 qnqLTDRTXuIfKvf0gzGuMPkPi3Z4BrPcuHcKwYjrIS+IbAxFB1cehvHku5NKfqbqPZdYaSb
 GBkxJfegQWU/hAuuGRPaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2rOfErufcPA=:2/hDprE9Ghh6MvquzUy22u
 mN8+IDIauukhHoPPk+W+k9L4oLy46DK0ThHqo2W8BH+HtmEg0eqrLIcBKJf+XGrkOhthWLSfA
 NB0SSVGgzssGmqKehw/S7FoiD6W3RyQMvnZ5TCLZVfwhUwaxsbZuVIoVIlJAiXomhHd74u76N
 p562cJZNfqJE6r2W5OuqsUUr9yGFGvwdsQ1uCRZnbrxfBAviyrMQGTRxOn4rxektMrIrMOq9m
 exBeGNyGCWAiOft1vosaIKYsTpLu7zXvEHV80Dt615vJNnn7RZuIukLmd5f7OY2MXsSVhR+nr
 oZKl/Jvox98y+G6mtnL+E0FrX0i0+7WzaMToWRcBJT3NQaxAKSAuFK10kQ6rOgujPWosxnPGR
 V9ydwETF5HrKtlLnR421q0vvmAxr/FU7QOsiv5poqJw9gC8MOutsi/9AQ8KMTINqCTB8cuh9i
 RZyCrDuQ9jShqj62DNCoFeEjUbGmlwoYRYCdR19l9PpLvIdIo0dG+ElfprOQCkk7HNy3oaFZL
 O/3u0A/5d2FcTU1TMaIA46lAONoCRR8UPszBvNndJ9qaR8qDKx4MQXDMV7fqoUCLu6ptEEMbj
 iXHB0SRsovoPKH+j0tU259t8AQFYabf53z6lYaQoMpfSMbiWKKHR5ZgpMsxjxQTD974kL3xSP
 8ckMHatFoGN6iB08Z2HVzEa+PsjbhlTbxaLwG9U6xThjvSc/MVn/ir45gFrytl8QzGUl1+LUq
 hObTVSpfZFgbS7/SoooABz615U7N0uG+0rwq9A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the safer devm versions of memory mapping functions.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/apbuart.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.c
index 60cd133..5eaaee9 100644
--- a/drivers/tty/serial/apbuart.c
+++ b/drivers/tty/serial/apbuart.c
@@ -293,12 +293,15 @@ static const char *apbuart_type(struct uart_port *port)
 
 static void apbuart_release_port(struct uart_port *port)
 {
-	release_mem_region(port->mapbase, 0x100);
+	devm_release_mem_region(port->dev, port->mapbase, 0x100);
 }
 
 static int apbuart_request_port(struct uart_port *port)
 {
-	return request_mem_region(port->mapbase, 0x100, "grlib-apbuart")
+	return devm_request_mem_region(port->dev,
+				       port->mapbase,
+				       0x100,
+				       "grlib-apbuart")
 	    != NULL ? 0 : -EBUSY;
 	return 0;
 }
@@ -622,7 +625,9 @@ static int __init grlib_apbuart_configure(void)
 		port = &grlib_apbuart_ports[line];
 
 		port->mapbase = addr;
-		port->membase = ioremap(addr, sizeof(struct grlib_apbuart_regs_map));
+		port->membase = devm_ioremap(port->dev,
+					     addr,
+					     sizeof(struct grlib_apbuart_regs_map));
 		port->irq = 0;
 		port->iotype = UPIO_MEM;
 		port->ops = &grlib_apbuart_ops;
-- 
1.9.1

