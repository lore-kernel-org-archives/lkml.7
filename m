Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F698C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A8F2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfCNWfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:35:04 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:60913 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbfCNWfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:35:02 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MxmJs-1gpUW13UAI-00zCSQ; Thu, 14 Mar 2019 23:34:40 +0100
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
Subject: [PATCH v2 08/45] drivers: tty: serial: 8250_lpc18xx: use devm_ioremap_resource()
Date:   Thu, 14 Mar 2019 23:33:38 +0100
Message-Id: <1552602855-26086-9-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:VNFqRitCVhR/QvfRU71bdEi19RCYMosXsVa+dbZIUtqM0/So7w6
 WsUpKH3AYerVvwkhIbGqqwssVBUZ1NZ3s5t68seo/luOTCBgG0i1KwSbptAvCwU09DcApt9
 UU0yty9FBEPWwB0RsesG7Y8gtvj28G5/H2Yrmz3j2803BHISpfIOUVucZuoHsTtTy8PyrGS
 GrPWUf/H3vNdjdzCusdHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f6ZtSgSp/XQ=:zIdbqjzF39xfFLvmTXRF8s
 yjSFGGorDuE2/cXjPX0ouaFMG58I+9bXgOgfZaViJx2ESbif03k6pmbhBPuq/9dmyyve3lVsc
 g4s86OOQrG53x7rnstWITKZz8BCeQJc8V8VqX7n9rWcCFunRNcjO1MR3eP2PQ/CiJrYacPt3Z
 nRzG4p9vTERiptHq5DPvf21IAgTY6AjNSp7gx8i6Dyj5dKcXKt7PV4IjJUMjn9BlrOsxpwseb
 uhN72nIIm8ybHFuYwD1k5biruZbiSQvA0kkMYGqTz+SAi0g4duTlbir1FCFtfQsjns+Y8+niT
 JnKX18yjT/iCR3Uc6WiLJKteT76dtdTJN50s9q14EUuGXFtd8hNUldq6JYHmIGyUi9w7Q8pVA
 uloO/zZ9M0RCuAQof6qR68oDtUv0iPciQm0cP8FMtGRrZpjCXI1LnMIJJAaae74iMvaq0zHzo
 o0ElnWwPXHgvz29m9zpYB7DiogSwgd+34Cst/GulKyVAnCglIQnkJ73pPEhoA+ne4TdqXI3zd
 S4IrCj5w2pWC38zaVrBKTwDqvL/Z9aSuRkcCZZK5FjZGkaUOq3yEe87sVOJUMVZvNgXFnQENt
 NiFmg/7MKZ5irghuOJd3gUuupB2I+5N0xZLTgWDTtAPkveRlo8alxLTOQMhHbFM0XtiG0l1j7
 Y+eNqCi1ymdupVmGE9U3nOHkkEjzRisPZfX7EmcuMds2qfCR8TlGrX+k8b1XcTEuGV3sEsre5
 lZ85s0X74ibilZ07uyzHjsPV1Cych7n3Twrn0Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of fetching out data from a struct resource for passing
it to devm_ioremap(), directly use devm_ioremap_resource()

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/8250/8250_lpc18xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_lpc18xx.c b/drivers/tty/serial/8250/8250_lpc18xx.c
index eddf119..f36902b 100644
--- a/drivers/tty/serial/8250/8250_lpc18xx.c
+++ b/drivers/tty/serial/8250/8250_lpc18xx.c
@@ -119,8 +119,7 @@ static int lpc18xx_serial_probe(struct platform_device *pdev)
 
 	memset(&uart, 0, sizeof(uart));
 
-	uart.port.membase = devm_ioremap(&pdev->dev, res->start,
-					 resource_size(res));
+	uart.port.membase = devm_ioremap_resource(&pdev->dev, res);
 	if (!uart.port.membase)
 		return -ENOMEM;
 
-- 
1.9.1

