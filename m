Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F12DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DD4218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfCNWfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:35:41 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:58649 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbfCNWfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:35:33 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M8hEd-1h9De70Imf-004mDV; Thu, 14 Mar 2019 23:35:14 +0100
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
Subject: [PATCH v2 44/45] drivers: tty: serial: pnx8xxx_uart: use devm_* functions
Date:   Thu, 14 Mar 2019 23:34:14 +0100
Message-Id: <1552602855-26086-45-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:F6spCLrnPk4yuFxqhl6fX+h+SLnr1wF1ZAV5scoTF7cyAy3wHqN
 Qq1DudA02ljbXR6u9JxOIqYan1EFOoCSjey9XlbB05Si21KBlSp40f1pSu6AOGLKF0i5IqQ
 lPay4c8yMzJTyi56IeCv1wZ+PZ22BgyXbsTDWvNPQVyOYET89/anwsX8AXt+2tVmdMd8zgb
 5ias72tJZkdphbbm/dAQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JmS/Ewatt7E=:+XPikidV2634JXwUSO4NoS
 TWcM0/9GdYEyG7JJwwlhzi7QMOWckRIttI/iQVBZzqOijsfU3hjgq9Tnk7D084B9/8bAJtG8z
 GDLB5+kkOn4goJFCoMV3Q4QNe2bC/nYQdLsD/CmsQg+txs8x7d+3lgliKUxzTaVjZoyRbUCZM
 NVQDSXsMI0vyVURRfGvwquBdXLnMu1rPJhz3WKc6AA68YNiUJxU1LsVD0L7RzbdbZRRKMbLpO
 /l+bkV2eJTAMTFnmk33sx6XFBmHivrzXvqN3ZX2xvGa2r5diH0oNv6Wmc5JWzUxQsqvg9EPdE
 f0Kr0hbOlB+L8icOIuGIcpoicqoWm84ctEGBmLJsA+nm1Hg3J/P3w0LIuQSJzS8WAUHMCzSB/
 PVPHTM0nftD3a3aIJ+ouKM4Yy+exseJigKFogOp1ZF2mcBSNOaUz6blNFta+IvVStcMVj4MIc
 fzPlPbbrSxCN5gV43Dg7ki10PpJq7S7JzwpsPpPMKE/k5jw9KjHPZycu2+Dm14Rj5apbSHQyx
 RA1983qKJdsgFcdfXssBIKciXzZQ3rocKmhsvKGm9Jr+RrO2Vz1yzVINlse7TG+Gg7DCscu3Y
 D2z+5a0y6a5vYYfT1vZltZrSKFXH2Dm518E/ovnvIRIyd3Sb7/b4qdX4k5v4iWNfAmidTXcHx
 q8dT4PUM1UPtHr9fuybrCHSTxyXS2cz8AG5YJ/dackc4mrY4SX+bQUwvtqkjAhnMLgGVicbT2
 2kmFZyDv/cftTOIrg7G0gu3377xOZiNmkkMK2w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the safer devm versions of memory mapping functions.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/pnx8xxx_uart.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/pnx8xxx_uart.c b/drivers/tty/serial/pnx8xxx_uart.c
index 223a949..3951226 100644
--- a/drivers/tty/serial/pnx8xxx_uart.c
+++ b/drivers/tty/serial/pnx8xxx_uart.c
@@ -568,10 +568,7 @@ static const char *pnx8xxx_type(struct uart_port *port)
  */
 static void pnx8xxx_release_port(struct uart_port *port)
 {
-	struct pnx8xxx_port *sport =
-		container_of(port, struct pnx8xxx_port, port);
-
-	release_mem_region(sport->port.mapbase, UART_PORT_SIZE);
+	devm_release_mem_region(port->dev, port->mapbase, UART_PORT_SIZE);
 }
 
 /*
@@ -579,9 +576,7 @@ static void pnx8xxx_release_port(struct uart_port *port)
  */
 static int pnx8xxx_request_port(struct uart_port *port)
 {
-	struct pnx8xxx_port *sport =
-		container_of(port, struct pnx8xxx_port, port);
-	return request_mem_region(sport->port.mapbase, UART_PORT_SIZE,
+	return devm_request_mem_region(port->dev, port->mapbase, UART_PORT_SIZE,
 			"pnx8xxx-uart") != NULL ? 0 : -EBUSY;
 }
 
-- 
1.9.1

