Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E15BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4523D218A3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfCNWfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:35:30 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:33925 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbfCNWfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:35:20 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1McYP5-1gUPEz1VCn-00cyuf; Thu, 14 Mar 2019 23:35:04 +0100
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
Subject: [PATCH v2 34/45] drivers: tty: serial: sb1250-duart: use devm_* functions
Date:   Thu, 14 Mar 2019 23:34:04 +0100
Message-Id: <1552602855-26086-35-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:GivYaYpI5CFgJ/Y6XyM0cFoodaogwjyFq9nJQTf5KB4miOPPElm
 TG7RnYiBDHHcGmQFX1YrCsFTVufVxUO2YXer2tyeeaFh1RQG/tiGlTQMuXcK926eQPH9QfT
 3bwHlNMp71kzHH3byvVqe08VFHmfl+1E2yRQY0rVg87iUp3J1p2cFhTfKh6Uaz5iQrssU6Z
 UWLr47C8sq0+M/4O7eceQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IG7rlAKrUkw=:OCafeg8PsmhaowzMNjMiRF
 cAk0TchRX0GICaLGSFjivMk0z9ja+1cepd8jRjMX3eckPCB4zHI862JkcnuJ/hsq8VLTlP+mc
 khvslUxRYU0kQtCP/+Gbe6B4PDyqD/QA1zAYaz0jFy5ruHtyuyljbf2S/RxigB16bRR1CX6dE
 qXm9vOF0h4dwpAAWywVo/GmSlGbE5/Yd5fL2kRUWfg0IcdOohXK5CrfNtNZcqH+thQhOXY7yU
 /lNuvWCLmcfIxCWVcKp0uw2HjUrpS36H2FwF9yuqd3qLNeLK8bSdvHXW1vXGMKmn9DPIk/DlQ
 KNPOR7hNDLVHXkyCPSLaaTWUEAdVgFKsQNnvoua/5UeK67zPZcct6ezghT7UEV+P7TPcGlTaC
 IKVmWG60kIPrYOA6pfHXxNOnBuxIGrle+WPtHfaQYaayYZjRTTxttecrEsMPnA3nflydA60Gq
 5fuTr8vBxWgq/oT4CDF7qdirTwiWRNFPw9vTz6KVpqbSaChVapCmQuslnhsyPCQhC25Q0gtkn
 70MWUF5EpKfLsFh8O4CxEZfkiF3vYPiBTL+VtKrJMZB4b+rpXaXVCXQBTOYsPpJDnSA884aC9
 pWHN8hQoW1VKvOvmAp+4HuEG2Tn8cJe7+KDjPaL7Z7YtT8znkuAtswxltJJ4WbZ/FTfMu5AY7
 TnkoQ+icRvdZFkHRhKYhoJvIG9QfF7SmkaG9aG9kju9eaNTddpFiokMAieT6xGQgiNTiKBfPR
 ST0FMWysfEHtCHRi7vEgJpMVHxfe8+NqHLw4KQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the safer devm versions of memory mapping functions.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/sb1250-duart.c | 42 +++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1250-duart.c
index 655961c..e77eef6 100644
--- a/drivers/tty/serial/sb1250-duart.c
+++ b/drivers/tty/serial/sb1250-duart.c
@@ -651,14 +651,18 @@ static void sbd_release_port(struct uart_port *uport)
 	struct sbd_port *sport = to_sport(uport);
 	struct sbd_duart *duart = sport->duart;
 
-	iounmap(sport->memctrl);
+	devm_iounmap(uport->dev, sport->memctrl);
 	sport->memctrl = NULL;
-	iounmap(uport->membase);
+	devm_iounmap(uport->dev, uport->membase);
 	uport->membase = NULL;
 
 	if(refcount_dec_and_test(&duart->map_guard))
-		release_mem_region(duart->mapctrl, DUART_CHANREG_SPACING);
-	release_mem_region(uport->mapbase, DUART_CHANREG_SPACING);
+		devm_release_mem_region(uport->dev,
+					duart->mapctrl,
+					DUART_CHANREG_SPACING);
+	devm_release_mem_region(uport->dev,
+				uport->mapbase,
+				DUART_CHANREG_SPACING);
 }
 
 static int sbd_map_port(struct uart_port *uport)
@@ -667,19 +671,21 @@ static int sbd_map_port(struct uart_port *uport)
 	struct sbd_duart *duart = sport->duart;
 
 	if (!uport->membase)
-		uport->membase = ioremap_nocache(uport->mapbase,
-						 DUART_CHANREG_SPACING);
+		uport->membase = devm_ioremap_nocache(uport->dev,
+						      uport->mapbase,
+						      DUART_CHANREG_SPACING);
 	if (!uport->membase) {
 		dev_err(uport->dev, "Cannot map MMIO (base)\n");
 		return -ENOMEM;
 	}
 
 	if (!sport->memctrl)
-		sport->memctrl = ioremap_nocache(duart->mapctrl,
-						 DUART_CHANREG_SPACING);
+		sport->memctrl = devm_ioremap_nocache(uport->dev,
+						      duart->mapctrl,
+						      DUART_CHANREG_SPACING);
 	if (!sport->memctrl) {
 		dev_err(uport->dev, "Cannot map MMIO (ctrl)\n");
-		iounmap(uport->membase);
+		devm_iounmap(uport->dev, uport->membase);
 		uport->membase = NULL;
 		return -ENOMEM;
 	}
@@ -693,15 +699,18 @@ static int sbd_request_port(struct uart_port *uport)
 	struct sbd_duart *duart = to_sport(uport)->duart;
 	int ret = 0;
 
-	if (!request_mem_region(uport->mapbase, DUART_CHANREG_SPACING,
+	if (!devm_request_mem_region(uport->dev,
+				uport->mapbase, DUART_CHANREG_SPACING,
 				"sb1250-duart")) {
 		printk(err);
 		return -EBUSY;
 	}
 	refcount_inc(&duart->map_guard);
 	if (refcount_read(&duart->map_guard) == 1) {
-		if (!request_mem_region(duart->mapctrl, DUART_CHANREG_SPACING,
-					"sb1250-duart")) {
+		if (!devm_request_mem_region(uport->dev,
+					     duart->mapctrl,
+					     DUART_CHANREG_SPACING,
+					     "sb1250-duart")) {
 			refcount_dec(&duart->map_guard);
 			printk(err);
 			ret = -EBUSY;
@@ -711,12 +720,15 @@ static int sbd_request_port(struct uart_port *uport)
 		ret = sbd_map_port(uport);
 		if (ret) {
 			if (refcount_dec_and_test(&duart->map_guard))
-				release_mem_region(duart->mapctrl,
-						   DUART_CHANREG_SPACING);
+				devm_release_mem_region(uport->dev,
+							duart->mapctrl,
+							DUART_CHANREG_SPACING);
 		}
 	}
 	if (ret) {
-		release_mem_region(uport->mapbase, DUART_CHANREG_SPACING);
+		devm_release_mem_region(uport->dev,
+					uport->mapbase,
+					DUART_CHANREG_SPACING);
 		return ret;
 	}
 	return 0;
-- 
1.9.1

