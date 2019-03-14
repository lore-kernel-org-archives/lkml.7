Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09B8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87422184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbfCNWiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:38:52 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:46973 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbfCNWfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:35:02 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MvrRB-1gnZmO0vzT-00srrv; Thu, 14 Mar 2019 23:34:35 +0100
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
Subject: [PATCH v2 03/45] drivers: tty: serial: 8250_ingenic: use devm_ioremap_resource()
Date:   Thu, 14 Mar 2019 23:33:33 +0100
Message-Id: <1552602855-26086-4-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:5GzyXryUCmPhaqsbZOtkTmtvvnO+gg6pzLTYxW3RxRcEjAoNXdO
 +lAE/VWhVRPlbPQJCB+g3Ld9/FEIODdn6m7Cs25TEXWnoYX6TFnNW91Jd7l1w3c72fyw/ai
 ExQlqgaL0xZNA62P2gp27c5eWykMCBCgqyoIR3Sx2+7eCabx/b/kivarJvErvg4qBMjp+G8
 B4Jvc4PvLWY88dnQ8uAdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rrNl+h4uyJ8=:xNJaxU04GcMIeah+XGsjkE
 zA5wE6b0m+5hBvespKtjA70HcK4xtqzHl/p4mucVkxmNwiE+AoJm3drv2oPJOJkIwyZxQFgPe
 aueRfd1uo65hCABbaVQmuOO9P8mlmtu1G1/+ekN1W77eFx7/dG6wYA95huRX91Kz3OjdmktvO
 JjCq3xm0SmQiH9z6hpWmvqtiP9PswDuf9jTGMfpQoeVeoOc0gJQG3SE1+0Prc+bQpCuuy8zkR
 XBk8XKJJOrECHiKDzM0Kzs+IRr3rT6lM1aDyVha0C68/SNh/gEQOk7sBvX+EPbnXwpaj9OroD
 PWOBKpVF1k5dRkvt3ZQlQssb5oNtCfRMlGKIyyocVDozl4eolo47qzJC2fUYuyGwiNUQOuvup
 YSO3b83i8KtOLLIVT4pijgOG2YlGg3topK67lzJviVYdodTPN4PNZ8LLyhPFVh+3c8Ce4oegM
 lFDabZJktPMaM6TceNfg+EN8GDvPTbjXFQY//ELZ/wmpxs/YADIDb05SIO/VmP/XXAo1rMS7w
 lAqjb3H2zyOUEI2JxY4p6XAHRmKZbiSYbMVgOj+40r0fQcHvpvpbgKpFpfeDxZqahjUjmrksY
 YvrhC9cWULSUb4BUyePaoDWjuamLhISnk4iP2zIo0hAukPjhGGBX1lmpLOtmEQ3U6rYFCV/4c
 EK18nYm3BPI6GfhFcDxAYlTu0Lw2taR1+a4TLCEQo0Ub7WUYP05820kdG9LKFT9yHM8QChyYT
 lWnWjIritbelwlb25P9dfMP860oykPYW1JbMjw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of fetching out data from a struct resource for passing
it to devm_ioremap(), directly use devm_ioremap_resource()

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/8250/8250_ingenic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index 424c07c..90ae3e2 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -249,8 +249,7 @@ static int ingenic_uart_probe(struct platform_device *pdev)
 	if (line >= 0)
 		uart.port.line = line;
 
-	uart.port.membase = devm_ioremap(&pdev->dev, regs->start,
-					 resource_size(regs));
+	uart.port.membase = devm_ioremap_resource(&pdev->dev, regs);
 	if (!uart.port.membase)
 		return -ENOMEM;
 
-- 
1.9.1

