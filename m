Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21ADCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D720F2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbfCNWfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:35:15 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:59425 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbfCNWfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:35:07 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M8xwu-1h9ULI3npG-0068zi; Thu, 14 Mar 2019 23:34:39 +0100
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
Subject: [PATCH v2 07/45] drivers: tty: serial: 8250_uniphier: use devm_ioremap_resource()
Date:   Thu, 14 Mar 2019 23:33:37 +0100
Message-Id: <1552602855-26086-8-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:HcULVpvjlPvPuUEkGombDx6Lq0TzXgQINZcbt9v0F4IVw3gvfDU
 ue5jWD4gA8wP1LsZ1ucMXRfehaO85dVyZr4F+33vEb/+OE8H5eHMGwes+HogG5qug9JrO8J
 7oabaolb7Wozqlw9bGe/y7tClhrPNMmFUx/bGTknMrKxLOQyDBqevKo6OkgNPmcIwooD2n9
 pp/LAHbGltK7rNTIffR5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4uPRC96/ixw=:MVIF+epBtx1bRwzaXem0UT
 ZjVpUy+qBWEVewbWf6tEZyqn8SuuO3a+V/jPrPOu/iQS0nuZ0509ATVN+iIBW3U3kCanvh8av
 Quo4grx9tQzJ3G0g3tgWvM5k0XnvlkZnRNJNY7T20C/l9ICnhM9FXYnNs+bKNefKxQ4Amlzqm
 NqFKewDr71+dbTBm8YtoSjAHfepFA8gn8bQvlo7pYeHz5glc8GdPIgyT2S5CfGnoAV3ZtLcKB
 YzCBA9v/AdXGcNpoUgIApdqb2Np8GOIz051SjR7raVwPWLpPnF9WXcoGcUXHMdvZ9EqULthsq
 HadKjLE+6KJ4PymgsJYSK1kDXBZnhQmDx7Ugm12lDXaehNQyq3abOwDUAyRsmsiSmLXNWA1z4
 YY5v1QZ/tyBxJEko8MCjbeteZMzHCzryHzfjWH/6+X932muk3bfGFejAIWcUZpYy/rIDPOWVo
 Gv+snZCm+zNSlLEk61q+xVFIQnTAvNoxHCGsC02+JcAjF6cIsvRwGdqsYgaeSf1us0uXHyZmE
 lQTTUCjdhuv0zreVE/Xak6OdKMZ7r4BF2stYLwH+BEuVwpc+3+cQKJToo8nGAF4RF94QrSOa1
 OIRV/e0vybyVH+ToU9oNm2lE/njB2kcCusqeCy2ybJmdXBGZyBi5N0mXJ1cRAZX3va5V+e80W
 Ap+F3nrbULbPZ2uI1OoQpSz4mDHvzpb1Stbw7mvxNW5W9rSE9OeFSSJTgSnDzsBIJPtWdaeu6
 8uDDvt+uabZO6SKvQpcU+te6p4hwJRe/JhTbNg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of fetching out data from a struct resource for passing
it to devm_ioremap(), directly use devm_ioremap_resource()

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/8250/8250_uniphier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
 
-- 
1.9.1

