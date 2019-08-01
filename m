Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B75C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 08:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9107216C8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 08:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbfHAISO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 04:18:14 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:46986 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730229AbfHAISO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 04:18:14 -0400
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 1BCB46274CE;
        Thu,  1 Aug 2019 10:18:06 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 1 Aug 2019
 10:18:05 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Thu, 1 Aug 2019 10:18:05 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>
CC:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] serial: imx: Avoid probe failure in case of missing gpiolib
Thread-Topic: [PATCH] serial: imx: Avoid probe failure in case of missing
 gpiolib
Thread-Index: AQHVSEGkENWr6+HjfEGe5le+et6JcQ==
Date:   Thu, 1 Aug 2019 08:18:05 +0000
Message-ID: <20190801081524.22577-1-frieder.schrempf@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 1BCB46274CE.A071D
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: festevam@gmail.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

If CONFIG_GPIOLIB is not enabled, mctrl_gpio_init() will return
-ENOSYS and cause the probing of the imx UART to fail. As the
GPIOs are optional, we should continue probing in this case.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/tty/serial/imx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 10db3e54ac9e..51714498dacf 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2237,7 +2237,9 @@ static int imx_uart_probe(struct platform_device *pdev)
 	timer_setup(&sport->timer, imx_uart_timeout, 0);
 
 	sport->gpios = mctrl_gpio_init(&sport->port, 0);
-	if (IS_ERR(sport->gpios))
+	if (PTR_ERR(sport->gpios) == -ENOSYS)
+		sport->gpios = NULL;
+	else if (IS_ERR(sport->gpios))
 		return PTR_ERR(sport->gpios);
 
 	sport->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
-- 
2.17.1
