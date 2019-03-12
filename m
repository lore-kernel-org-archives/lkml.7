Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179AEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E37002075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfCLO6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:58:24 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:43241 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfCLO6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:58:16 -0400
Received: from orion.localdomain ([77.4.190.91]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MgwBv-1gZcpB0RLR-00hMyD; Tue, 12 Mar 2019 15:58:00 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] drivers: tty: serial: use devm_ioremap_resource()
Date:   Tue, 12 Mar 2019 15:57:36 +0100
Message-Id: <1552402660-31730-5-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552402660-31730-1-git-send-email-info@metux.net>
References: <1552402660-31730-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:Njyk1peVeKpZh4vSxceQpkHgLq9jcXdzVOTOS0UuPfrUhhl6+fn
 6QtNEwBEod+T5xZ5MykrUnyMmspck1fo43ygFyjB0odzBvAEB1xxkjuJKSTgh1HSjrCvHqK
 Ln6Wa/5SIW4rUdkNf3xRhurbkbhjxsKwoQgMmtDS5+IKOX2SrByWkPH9HWZQXuQ/tnc1HM5
 N8/M2zZs7FsErud5FhK4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BEqDTb6ueWI=:BnIuvtWKr29qrffhAw4oT1
 gVikglP+ix/LE8HACRqX1D96M0OCzme4T4P1na6JJuZuFjPjQ5cqRKPTR+KkQ9vuYNM6rwKFE
 kbirg5OfgRTPOg2ofRANzbt3MTzWIeXLntW3WjBRbfjmX1oJ88Dp7mzEOoaHinEklA+/53b53
 7tS/gZa7sPD91epUrHwgcpFJ6nshqhzjz2F2O0uYMA62LpL6xk97j3GSXB1QzNlmzjiloc0tp
 F5bzIj5TecJVumg4ks/M/vMuglOnVoHoiZq+A8MrdiNklb01plfkK0rXAnNRCG69rL2tQl7eN
 qzfe6EYz9iOyT7tnM8bKcdLfJxQV+obcfTDKjNt529z7APPHc23jUJyvOc9ytzqqvmBKGAnXw
 rssLn0miKA/PGQZt3Xn6fFAegnm+CxWJDbPCHF+FJ3I8556P79hqbVjQ9nWUf32wyzpgkOnUv
 KrbGRBc8svrCUQUADm5HFqsriEJklh4vSPxCwLlSf8qtnp+yaen0/P6SLnZSroaxcQHSt0Q8y
 GkrkhSdzKjbaRNlqRJY00Sa0ypDukblt2LdrHOp5rIYdrrA4B+XmAXCT8xLNkbWsWlvjHn1O2
 uS0OVWf+LFIGiGPzFqYeE4Cso5ahJ67KVSsSBrR7Kw+n8Dk48UVYzEPGJIYD+R/W0hQBZc1v3
 +gJ5GXSrviiusahpTobKzaL/PUCE4et8tvGy0tNWQ8cw3bwvFlbTtSTDVFouSX+OeFvOUmhfR
 lOSWIUjs5ZY8l1+3VHWJCxrW35hBBr2y+JpWKw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

instead of fetching out start and len from a struct resource for
passing it to devm_ioremap(), directly use devm_ioremap_resource()

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/8250/8250_lpc18xx.c  | 3 +--
 drivers/tty/serial/8250/8250_mtk.c      | 3 +--
 drivers/tty/serial/8250/8250_uniphier.c | 2 +-
 drivers/tty/serial/amba-pl010.c         | 3 +--
 drivers/tty/serial/samsung.c            | 2 +-
 drivers/tty/serial/sirfsoc_uart.c       | 3 +--
 6 files changed, 6 insertions(+), 10 deletions(-)

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
 
diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index c1fdbc0..bf6eb8d 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -383,8 +383,7 @@ static int mtk8250_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	uart.port.membase = devm_ioremap(&pdev->dev, regs->start,
-					 resource_size(regs));
+	uart.port.membase = devm_ioremap_resource(&pdev->dev, regs);
 	if (!uart.port.membase)
 		return -ENOMEM;
 
diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index 164ba13..9c1244e 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -171,7 +171,7 @@ static int uniphier_uart_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	membase = devm_ioremap(dev, regs->start, resource_size(regs));
+	membase = devm_ioremap_resource(dev, regs);
 	if (!membase)
 		return -ENOMEM;
 
diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index 2c37d11..109b8df 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -713,8 +713,7 @@ static int pl010_probe(struct amba_device *dev, const struct amba_id *id)
 	if (!uap)
 		return -ENOMEM;
 
-	base = devm_ioremap(&dev->dev, dev->res.start,
-			    resource_size(&dev->res));
+	base = devm_ioremap_resource(&dev->dev, &dev->res);
 	if (!base)
 		return -ENOMEM;
 
diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 83fd516..a49cf15 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1775,7 +1775,7 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 
 	dbg("resource %pR)\n", res);
 
-	port->membase = devm_ioremap(port->dev, res->start, resource_size(res));
+	port->membase = devm_ioremap_resource(port->dev, res);
 	if (!port->membase) {
 		dev_err(port->dev, "failed to remap controller address\n");
 		return -EBUSY;
diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 38622f2..db2e08d 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -1359,8 +1359,7 @@ static int sirfsoc_uart_probe(struct platform_device *pdev)
 		goto err;
 	}
 	port->mapbase = res->start;
-	port->membase = devm_ioremap(&pdev->dev,
-			res->start, resource_size(res));
+	port->membase = devm_ioremap_resource(&pdev->dev, res);
 	if (!port->membase) {
 		dev_err(&pdev->dev, "Cannot remap resource.\n");
 		ret = -ENOMEM;
-- 
1.9.1

