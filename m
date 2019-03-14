Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681EAC10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33DE021874
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfCNWfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:35:01 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:47591 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbfCNWe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:34:59 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MGQzj-1hGxW80hpt-00Gth3; Thu, 14 Mar 2019 23:34:33 +0100
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
Subject: [PATCH v2 01/45] drivers: tty: serial: 8250_bcm2835aux: use devm_platform_ioremap_resource()
Date:   Thu, 14 Mar 2019 23:33:31 +0100
Message-Id: <1552602855-26086-2-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:DWomIpNJmnbGMJQk8l3rsTOlr4+4BvTNMZUwMVWlUlx4l1A2znd
 FZ06j4Nm/7i1n6knMrNlmcS8b2UGcpWLaGAOLu2exNCVqqaAR69sM6VL9oRfxiDIETnSEr6
 vG67ameVMqEVG4Ep54DONR4viwdf1xr2IZ9/zClZAWUmVEkKlOkns5kWFmUwhFU3tvBEsJT
 Nvp1SrUnsQFsF7xpM+LsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UVdoO/YHweE=:DzgY/PEP0n/Au7FaBcOVtB
 9mIFLSFBAwG1hm8RdL79Epk+/FrvTjBTMoJxmIDTeyE6qQrsoxsxWfDiQRaP8vz9Vs3R9Tn+Z
 BcEueiXdTQ8SBKCIXPN2ICcQC926VzgJIamKPNyCmuKnR2L4vNQlv7BBbOlCK6hyfofmg5KSh
 Brm78xihl3WwM17H71ymPyt8jL//pUoY/KJO5QK9Nb36Mx4SY8N0v2hlsMeLSM8cPecBPafFU
 YyCIbIqaZFWbMTrkmMyG3Iwm25infwQKu1r3iUALCnu9XRPpd2oUqCIk/PL0JjRKSxidTcnsZ
 erIrmcUKsc1eY9vain4zUXIQ8J2cEqOIvMYm62XgCGJSjAtLttfB9Q7AlD7OS/9EqlOrCESrl
 gvHG3t3Va4SPAQC6AMlTzgsgLYCJIPDklCpyvI0Vq1kvxtZAlTPLjwGGRp2GONqvxQpQb49wz
 /p1+ycVmQ2HW/qPHZ/rY0do4ijrYh9qlH0U2+g47Lhog6ZRvZ59zVkEyVbyhu4ByQGqblcSle
 C5gBLyo8x6vZPiUimpJ17hUpheR7y7BeNm64hOZ50G3kJeM0k19s/RmATJMeRzqBBhl5hXeMq
 EfLBQRTyeULuMtGJKGowLpAPnhZA+lM8zB7Jj/oAUOm4n6zc8H1xQVKO/vxVrVF1PfmTFZO+a
 D1LtFweyrVVyWNm32R2QeKj2a0VEVArvwsYAdk+04GFqLeVXQfrplse1vhrFm0UbK1r2olAYa
 w/WLMvG8vVGYMLqeUvtSScKx3QNkWUixPOWVrA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the common platform_get_resource()+devm_platform_ioremap() combination,
there is a helper, so use it and make the code a bit more compact.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/8250/8250_bcm2835aux.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index bd53661..0738d14 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -25,7 +25,6 @@ struct bcm2835aux_data {
 static int bcm2835aux_serial_probe(struct platform_device *pdev)
 {
 	struct bcm2835aux_data *data;
-	struct resource *res;
 	int ret;
 
 	/* allocate the custom structure */
@@ -63,15 +62,12 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 	data->uart.port.irq = ret;
 
 	/* map the main registers */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "memory resource not found");
-		return -EINVAL;
-	}
-	data->uart.port.membase = devm_ioremap_resource(&pdev->dev, res);
+	data->uart.port.membase = devm_platform_ioremap_resource(pdev, 0);
 	ret = PTR_ERR_OR_ZERO(data->uart.port.membase);
-	if (ret)
+	if (ret) {
+		dev_err(&pdev->dev, "could not map memory resource");
 		return ret;
+	}
 
 	/* Check for a fixed line number */
 	ret = of_alias_get_id(pdev->dev.of_node, "serial");
-- 
1.9.1

