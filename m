Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40613C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 11:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C342184E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 11:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbfGVLrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 07:47:31 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:51719 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfGVLrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 07:47:31 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MHWzP-1hc2P93KOf-00DX7g; Mon, 22 Jul 2019 13:47:26 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Sekhar Nori <nsekhar@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] mfd: davinci_voicecodec: remove pointless #include
Date:   Mon, 22 Jul 2019 13:47:13 +0200
Message-Id: <20190722114725.3398694-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/16xgt8i29BbhJxdyDZduqZVqgprV72HOGHV/wBP1tKP4jlYRTc
 M9xASYFnLmx0JchXqh1NffsL09FPc4hehAQ4YH13Zs5rMR7lTWvDqe8bhJ8WmgE33DbivhH
 q+HDiifjhjYZAFAYX2vfIw8s8Js7XEUQX/r+oa4uXIWD6AQVFFqG2pLYcqZToDoHi64y/bk
 QR6RF/KcLTfyViQoxMNzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BWqPk7k3CEs=:PncGTVIO0Pea+WtDV2/Nb6
 +Z4mR8C1Nwz1nZfmOEXIl8q5erwG1oDGHSvhbFBt6qD+sW5CoqDrQWtmQqhuFAvEfeFehU6Pv
 XFr/x0sLEq4DOngW+v7am/iGI8waafbqlqEnS4Ji24bsy/jLT9XzmBgTfnTJLnZIOSyxI2riy
 f4X9OG9tkC59lF5w5IWCNX2JHE0G9BWP9HXXtvOrEGPO/BirdtlnLQxPzfESDqtxE9ox96UOQ
 YGKbtILYlZ0EjPE7GgvHYiJDJonuUYdTIMekm/+utpXZBJBjNHIS5/uc7htVa7FRPNLWCs5Wk
 2Owcd+1XHa662tJSNbymzEzxQEYiFznABxogozqR+Dp64pMO2ReEHpvyi+rpdOgNey8Lm1VcV
 dHvgNPiMlKyFlLg4RkPSDxKiczlCvYv37SlUowHetefi6Telp/PhhmQ3GOZVqhW/Zkt9tOn1Z
 pW21HK3KoZgzs9DWXhaQ11zai4yKAsN1/dThzG/uZorz92WpxS3UyvULv4BwtECnHTdJIhOMG
 wlMHdqpHkiDh8uHHOfAbdJfTFPF8v1mizUHz9xZRGedDJYne6VWFfsKTSF3hzxrGcBZQ2ayFP
 +mVA+rxHbmwNvDRYEBNTSG4OhRTec9wd2DdPVmuTmZk6THpnwiyDUY71UP0hyFyaA3c9lTW/X
 aeoPikr3kvT2uz44zNsQSmZSVfVSQkVwAB4rVGJAjvcdLn6o0NLQRBZIndm8fD5kcP5XMeZmH
 IElc95cTmSqQ8N35GG6gO+KzD+IMIfZ8GmWNaA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building davinci as multiplatform, we get a build error
in this file:

drivers/mfd/davinci_voicecodec.c:22:10: fatal error: 'mach/hardware.h' file not found

The header is only used to access the io_v2p() macro, but the
result is already known because that comes from the resource
a little bit earlier.

Acked-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I sent this in June, but it did not get picked up into the mfd
tree. Sending the same one again in case it got lost.
---
 drivers/mfd/davinci_voicecodec.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/davinci_voicecodec.c b/drivers/mfd/davinci_voicecodec.c
index 13ca7203e193..e5c8bc998eb4 100644
--- a/drivers/mfd/davinci_voicecodec.c
+++ b/drivers/mfd/davinci_voicecodec.c
@@ -19,7 +19,6 @@
 #include <sound/pcm.h>
 
 #include <linux/mfd/davinci_voicecodec.h>
-#include <mach/hardware.h>
 
 static const struct regmap_config davinci_vc_regmap = {
 	.reg_bits = 32,
@@ -31,6 +30,7 @@ static int __init davinci_vc_probe(struct platform_device *pdev)
 	struct davinci_vc *davinci_vc;
 	struct resource *res;
 	struct mfd_cell *cell = NULL;
+	dma_addr_t fifo_base;
 	int ret;
 
 	davinci_vc = devm_kzalloc(&pdev->dev,
@@ -48,6 +48,7 @@ static int __init davinci_vc_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
+	fifo_base = (dma_addr_t)res->start;
 	davinci_vc->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(davinci_vc->base)) {
 		ret = PTR_ERR(davinci_vc->base);
@@ -70,8 +71,7 @@ static int __init davinci_vc_probe(struct platform_device *pdev)
 	}
 
 	davinci_vc->davinci_vcif.dma_tx_channel = res->start;
-	davinci_vc->davinci_vcif.dma_tx_addr =
-		(dma_addr_t)(io_v2p(davinci_vc->base) + DAVINCI_VC_WFIFO);
+	davinci_vc->davinci_vcif.dma_tx_addr = fifo_base + DAVINCI_VC_WFIFO;
 
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
 	if (!res) {
@@ -81,8 +81,7 @@ static int __init davinci_vc_probe(struct platform_device *pdev)
 	}
 
 	davinci_vc->davinci_vcif.dma_rx_channel = res->start;
-	davinci_vc->davinci_vcif.dma_rx_addr =
-		(dma_addr_t)(io_v2p(davinci_vc->base) + DAVINCI_VC_RFIFO);
+	davinci_vc->davinci_vcif.dma_rx_addr = fifo_base + DAVINCI_VC_RFIFO;
 
 	davinci_vc->dev = &pdev->dev;
 	davinci_vc->pdev = pdev;
-- 
2.20.0

