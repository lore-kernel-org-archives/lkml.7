Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506BFC7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 15:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5802084C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 15:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387759AbfG0PJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 11:09:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42706 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728989AbfG0PJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 11:09:55 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1057E7993F6C646F9051;
        Sat, 27 Jul 2019 23:09:52 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Sat, 27 Jul 2019
 23:09:43 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <eric@anholt.net>, <wahrenst@gmx.net>,
        <f.fainelli@gmail.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <paul@crapouillou.net>, <timur@kernel.org>,
        <nicoleotsuka@gmail.com>, <Xiubo.Lee@gmail.com>,
        <festevam@gmail.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <linux-imx@nxp.com>, <matthias.bgg@gmail.com>,
        <jbrunet@baylibre.com>, <khilman@baylibre.com>,
        <daniel@zonque.org>, <haojian.zhuang@gmail.com>,
        <robert.jarzmik@free.fr>, <baohua@kernel.org>,
        <olivier.moysan@st.com>, <arnaud.pouliquen@st.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <mripard@kernel.org>, <wens@csie.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <yamada.masahiro@socionext.com>,
        <michal.simek@xilinx.com>, <jcmvbkbc@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-tegra@vger.kernel.org>, <linux-xtensa@linux-xtensa.org>,
        <gregkh@linuxfoundation.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next 07/34] ASoC: imx-audmux: use devm_platform_ioremap_resource() to simplify code
Date:   Sat, 27 Jul 2019 23:07:11 +0800
Message-ID: <20190727150738.54764-8-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190727150738.54764-1-yuehaibing@huawei.com>
References: <20190727150738.54764-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/fsl/imx-audmux.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index b2351cd..7595f24 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -298,12 +298,10 @@ static int imx_audmux_parse_dt_defaults(struct platform_device *pdev,
 
 static int imx_audmux_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	const struct of_device_id *of_id =
 			of_match_device(imx_audmux_dt_ids, &pdev->dev);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	audmux_base = devm_ioremap_resource(&pdev->dev, res);
+	audmux_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(audmux_base))
 		return PTR_ERR(audmux_base);
 
-- 
2.7.4


