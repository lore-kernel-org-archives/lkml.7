Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08D8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735D32184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfCNWf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:35:27 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:59435 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbfCNWfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:35:19 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MMWcT-1hMuVR0qhD-00JX7L; Thu, 14 Mar 2019 23:35:06 +0100
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
Subject: [PATCH v2 36/45] drivers: tty: serial: pic32_uart: use devm_* functions
Date:   Thu, 14 Mar 2019 23:34:06 +0100
Message-Id: <1552602855-26086-37-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:470VhaLpNC6lKxsvkwsuYrMW/TNf5OEECXD1f0Sbftri6x8ZrSB
 /Kps+C6NL9+/F2nl9xWr+/6JWiQsAGwxrb3GEj2aqNfH/38CZFmS4flrktATiwUi4M/rjev
 qSVUDYZCFAQj9Bvzey7VKBOwFhkD/hTiCCJcXorivOizFH8JN0RIHFGQSFhrKlNgvkQv5ii
 Q+GrPPjQjta3ydAQ+blNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D9c0qOR8ong=:juCLVtgDScU3i+htrRvVfW
 QeEgKi/DbwtBxOExSsZAXM+NjfGByaBXZIifSyOoiXRDncdTlGuiBnrYLloy2PBfJfK8xh/hy
 +p8Kx0KmLNfnS+cXkiaJrnDvMxPour0HREFaz1Dd/HrmXJG9wej1NPO1TfM1vRhdZf11pQJy1
 CGDCI1QbmzMK8F9ZJQmWSd1I9xu/W+SClRNYLbzVl//6ZMrxmE72ZXHVlITUXuVQQpalQDtBH
 VrHs+aDhYOgBo4W/8hzl3+7HNGH2WOzvEQgk9XezGNM4X/jbCfOH1toswng+9sOFLDHNZayng
 1a7A7uJtvTELw/hYFrbAuRD1Uzrwok2TfkSI4K0d3ICsA+2x8x935rkilJ/fABlUEganBd8xL
 09isMTlCwm8OQqc3ejl5D3RfpgorTbYvGlW6smSGNCu2qew3xCV+H//M62A9yWh0oxZE4vHRB
 fOEYwm2xVQvGJ9PDJLck3rvWKmGEYGi/gG8aS+fSGjZXJ4LMtXKY6OYtCMcq/w1KMi3fejy8v
 6swY+x1CrSGZeLvsww2Ffc6Lx904IuYMgjDTtQcH2UNT2I/MhTau1hbZHkwFo3m408dTbD0Aa
 QUs6f04ot3yaPfGpEvmfyKUXYGSX2GqkAHcwvTR3P2z4OPWv843M8g5TWPk38sVC+cblcdrWC
 vvqcfBgEFAKmd/+cblnsE353y/FiFV9XBCJmijoaJt3sUzkkjJIbnyWg/9DI8wphMzAGbifFO
 8F+2d1KTJPIRaJrCDAjLGHs6g+CpGFjqEMLU+g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the safer devm versions of memory mapping functions.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/pic32_uart.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index 0bdf168..b4f0b29 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -614,15 +614,19 @@ static int pic32_uart_request_port(struct uart_port *port)
 	if (unlikely(!res_mem))
 		return -EINVAL;
 
-	if (!request_mem_region(port->mapbase, resource_size(res_mem),
-				"pic32_uart_mem"))
+	if (!devm_request_mem_region(port->dev,
+				     port->mapbase,
+				     resource_size(res_mem),
+				     "pic32_uart_mem"))
 		return -EBUSY;
 
 	port->membase = devm_ioremap_nocache(port->dev, port->mapbase,
 						resource_size(res_mem));
 	if (!port->membase) {
 		dev_err(port->dev, "Unable to map registers\n");
-		release_mem_region(port->mapbase, resource_size(res_mem));
+		devm_release_mem_region(port->dev,
+					port->mapbase,
+					resource_size(res_mem));
 		return -ENOMEM;
 	}
 
@@ -641,7 +645,7 @@ static void pic32_uart_release_port(struct uart_port *port)
 		return;
 	res_size = resource_size(res_mem);
 
-	release_mem_region(port->mapbase, res_size);
+	devm_release_mem_region(port->dev, port->mapbase, res_size);
 }
 
 /* serial core request to do any port required auto-configuration */
-- 
1.9.1

