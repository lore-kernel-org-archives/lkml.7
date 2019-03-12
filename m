Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6817AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FC62075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfCLO6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:58:47 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:57901 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfCLO6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:58:45 -0400
Received: from orion.localdomain ([77.4.190.91]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MeTD8-1gTI6V1vJE-00aTDI; Tue, 12 Mar 2019 15:57:59 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] drivers: tty: serial: 8250_bcm2835aux: use devm_platform_ioremap_resource()
Date:   Tue, 12 Mar 2019 15:57:33 +0100
Message-Id: <1552402660-31730-2-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552402660-31730-1-git-send-email-info@metux.net>
References: <1552402660-31730-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:FN04X2Ub3xRXIzlxlh17glX9Iw/H9eqelV2UVvQPJoruw3dDK1j
 XB1O90+jCvGfoYykUWHVpjmWm09DqlGoj9HzxKE0WI0ehY6P7doAJrTwJPjWkUIyKRVB06H
 pqz07ujIsyvkGP6Tv2kou6JvXcLXxy8bfxkk1pIg4GE7V4RoBSjPJ0rOQNT0nk1vmlxkbzN
 68e5nAU3vVz7NEFFFS1vg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:msGOz4avu/A=:MVBLetZzFMjT7JusAGoEhz
 +9WQMyjk4a6FvA2zWOLZ5u/tWbW8pjqOa4VHC3ioPa804R75SRqKpef+0yUf1DIydbkXvp+Ue
 zMLok4JVXeSntaLHDb5xLC4UdSMsQr9cthu0OAtJPf2ZYdt93q7RTPWO+u0NMIpkbOQ9SMtyu
 Mths4UlLqLCgkzAH8b82FO88dzRPuHC/tdWmzjU/2XLTp/5J49RsBJ0RAZSxFcOEQWGBA5gHE
 XdUGEbJJfgZCH8WIj3qlSq8XKoIQ+/HlaKCSgINBjMCzC27kxjR+VWQxxv10YpDl50qsraB2X
 OIoO8lOKGjsg2MXKSXmlGxnGLRhnR2u2wScax2oWoEZds5ORtdIgSqRYtjn2PCycp0zxUjoJY
 BPouIM8bi7knU6VxXDmwFLwE5t5RUVrxuGBq3FK6Wpeh57p7kCFiAMkGJxwAze+dDVAeRUvAw
 VwE8xM2F5/a1KBkX1GaGYsW8KwdGkXyFRGwri+gWHkMsB83VIrqjX9RoEl5S/6awlhmUlIpv/
 LppTnE1aQjEUDfEpl9c4rRUnnc9KntkYPheGD1gIGEFQ0I+0TX/GDYUj+IIyE8sFe94MNrgx1
 QrbJrIiHWlpv5dIyj7rJl2/fnPH5XpWBS2+jaFA3jfn3W08tg6QIF6g7uYcodwbBCVJUXEYtS
 iUYDmnCI3hhuz/dEgDK1VQYQOU/tJuSCU1KhgNPsw0L19TsFmXOWDdA3OH6z2/HHT1y4ZxPUP
 5bN6x2Npl+9uEDZFS9je7bJY6OIPPuNGZNxrAw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

