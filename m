Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7AFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D514A2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfCNWfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:35:25 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:33887 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbfCNWfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:35:18 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N5W4y-1gxEOp193a-016wDW; Thu, 14 Mar 2019 23:35:05 +0100
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
Subject: [PATCH v2 35/45] drivers: tty: serial: lpc32xx_hs: use devm_* functions
Date:   Thu, 14 Mar 2019 23:34:05 +0100
Message-Id: <1552602855-26086-36-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:te4TBOLd0AsObsYwaKbuq3GQUSFWyyoYsWbEecdVNIqZj5kp8kI
 QFrPLrflaxNteCN3YD3usBroa57u0rrRiGZp0ReH5gzoRB8gM15rA3a0NDzkIIP+k5/yDlh
 LvR36Mr04OkvDGUp31Kzuz5czxwmL6ukyf9lXFg76Y2owmPk2zC4xjAcl4EJPSkMPPRVY8d
 n4jk04eYTqRikCqVJesuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AX6cckKTnAg=:ICZlOILXa9RJlGaLMOdLrX
 COPAoGd0JasjPiu1Y71B/lNhZb7Be8bqw8kMB99yWM6jfXqQ7pnioaIpRKK6hj4uLdCR7QOwX
 Df7FOi1yUBKW1wRFtuJD94z8EhRL/tCsdQlFZE3CdL1dCg9Cq/AlXBuHYm8I6vs+X8g9BTurv
 e2vhSH1Op2irGi7MsVsWUXBEZ8QZdX3OVB8FJWcgzmk6a3WPF9NWvYX4usLaoUlAlzzIvFNkc
 9+h7XcC7vLtxsQU1D8xLfeF7yd1Wz6+sFnSaUbDLpvJ6TV0ziHhY8BGusjSk1ViNmhXqg0IkW
 ueHfNLuwzGc0ZiiAdW5YBZt58dxVubV9VR3ibEiJqyJYwauMGdUGlXqqtTLZ77sCZFnuS03Vq
 EbfYP1HsmI048YVxalqLTntJZSXZXmZCYqhAIopsSGu9FiUeGeQdiwBa3t35dFFXNpEpOO8lH
 DdXE0NP1vsCHDm+0/IRug+aVM97iTaa/krVAB8Whk+XZT541V47uuF4DqSgFPO7wvh1GLujqC
 NxSvS4ixdNEoFk79SmlU/agoAKeUWYNp+fstqhOH9yaBZvbMCx/v+q6WHifd21cOiWVGm0KqU
 gPUefBZtFuJGl9yppjVqykWPmQKJCsBcnjmtvrmHK0meZ4dPs2+gNwhwWFayLLZxzTEFI1Q8S
 9FE8c1olRhlmn4mbE+P/M8gCxph4b5nR1R/WIQ/ShFcoB2uubZl5um/y0XHo9I6GXKT3u3luX
 GbS3nwowSy/89EsnNQ07BoAKR+e/y+pvb7+EsQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the safer devm versions of memory mapping functions.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/lpc32xx_hs.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index f4e27d0..0bb86d7 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -575,11 +575,11 @@ static void serial_lpc32xx_release_port(struct uart_port *port)
 {
 	if ((port->iotype == UPIO_MEM32) && (port->mapbase)) {
 		if (port->flags & UPF_IOREMAP) {
-			iounmap(port->membase);
+			devm_iounmap(port->dev, port->membase);
 			port->membase = NULL;
 		}
 
-		release_mem_region(port->mapbase, SZ_4K);
+		devm_release_mem_region(port->dev, port->mapbase, SZ_4K);
 	}
 }
 
@@ -590,12 +590,19 @@ static int serial_lpc32xx_request_port(struct uart_port *port)
 	if ((port->iotype == UPIO_MEM32) && (port->mapbase)) {
 		ret = 0;
 
-		if (!request_mem_region(port->mapbase, SZ_4K, MODNAME))
+		if (!devm_request_mem_region(port->dev,
+					     port->mapbase,
+					     SZ_4K,
+					     MODNAME))
 			ret = -EBUSY;
 		else if (port->flags & UPF_IOREMAP) {
-			port->membase = ioremap(port->mapbase, SZ_4K);
+			port->membase = devm_ioremap(port->dev,
+						     port->mapbase,
+						     SZ_4K);
 			if (!port->membase) {
-				release_mem_region(port->mapbase, SZ_4K);
+				devm_release_mem_region(port->dev,
+							port->mapbase,
+							SZ_4K);
 				ret = -ENOMEM;
 			}
 		}
-- 
1.9.1

