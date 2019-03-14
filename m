Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01714C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91EB21874
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfCNWi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:38:29 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:46435 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbfCNWfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:35:03 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MAxLT-1hBTsK0L3R-00BNvB; Thu, 14 Mar 2019 23:34:37 +0100
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
Subject: [PATCH v2 05/45] drivers: tty: serial: sirfsoc_uart: use devm_ioremap_resource()
Date:   Thu, 14 Mar 2019 23:33:35 +0100
Message-Id: <1552602855-26086-6-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:TTR22l/LfD/B7GZc96+AJgfh+7Qs5IoI957gRIZ4mF/yPTuRPu5
 EiMbDwVBxaeOuOJwcguC8GXfum8gEjwrWkRdGLLwzrAHOwi2Y9q+RJrawRwCA5ZeIeywxsC
 psVLX+LTZkUWEdaidDBspsXZv+LrsXSxzlw7l/5SGFhDDP6Y3XDs951LC+0BvCOA6Wk10+X
 aVQuMhDL6P9kSFphW1UDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9H1r8UavsxA=:39U1UtWLYVNU6+1NJ7s/V0
 3GDfWTbVwMS1u1IGn697TSf92lpFEp301Ic+r36v3txW4v1mrVHIj9xS0gEbySdO1Ju3/7el9
 fuKV3RIlMUvGVkx7/IvAx2u8FCxRTWwfmWh7lihUVFlHfFoIIV0nWdaKtdqlxYu+lX784Cpw/
 CHhKNWeqtygHhlxhcmlaDjaiWUTqGnd0SX/edVoeDd0dkDSoSucEuKvwBuQqgeo1MEh/hbcWZ
 OXuksi1CW/iQwTU10ow1t8LYvvs3wp+oQkDEf63lxOqqYwz86lMfOrODYdiFPvxViUsEDLmhx
 WI0TX4xO3fZ67i+ZoG5qhBisLtOx4CWFqQ08a+uI8yaQrZ3iTPeVCudP52412UG0tApvN55ED
 QXIhx/vUDvggWm0RGPAvK8cOb4uohlmmpiTJufdHmplqS2DPdlnnKLvO8XzWVvaKJzztHNHKE
 uYX7T0/EgIDHoCbnx5nwDAvX7lGN9QwwF+qRTFzpg7BKpBze9jrEVL437cUcW98SVcTf/t49F
 k4K9h3iQ+1GoT7+PijDsktMrHe+Ehrc19Rj5T/EJMEyjJDS59AdMnpzVv/bIohqRWlEChICYT
 esBnpO6tBrx/j53b0ewQebbhxF1NQYhg4uhSkX7yjrWK/QTwZh3nSBEGjZ1oPJBqejxu2yRTf
 v8u51ZJQqOaWcMtTaErLu0UPtR05OMReMA8+pyTcBOccOZkfRCGH5M9pQCLDCRvAVzvDZHrfx
 GDq4kHG6KVWCRotQFnn7m43EKd6bjtciduStKA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of fetching out data from a struct resource for passing
it to devm_ioremap(), directly use devm_ioremap_resource()

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/sirfsoc_uart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

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

