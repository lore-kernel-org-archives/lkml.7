Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1FDC433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 15:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2565B208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 15:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbfG0PK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 11:10:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41476 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729069AbfG0PKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 11:10:24 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A46AD9911FF182FFAE54;
        Sat, 27 Jul 2019 23:10:19 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Sat, 27 Jul 2019
 23:10:13 +0800
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
Subject: [PATCH -next 17/34] ASoC: codecs: jz4725b: use devm_platform_ioremap_resource() to simplify code
Date:   Sat, 27 Jul 2019 23:07:21 +0800
Message-ID: <20190727150738.54764-18-yuehaibing@huawei.com>
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
 sound/soc/codecs/jz4725b.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
index 766354c..2567a5d 100644
--- a/sound/soc/codecs/jz4725b.c
+++ b/sound/soc/codecs/jz4725b.c
@@ -545,15 +545,13 @@ static int jz4725b_codec_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct jz_icdc *icdc;
-	struct resource *mem;
 	int ret;
 
 	icdc = devm_kzalloc(dev, sizeof(*icdc), GFP_KERNEL);
 	if (!icdc)
 		return -ENOMEM;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	icdc->base = devm_ioremap_resource(dev, mem);
+	icdc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(icdc->base))
 		return PTR_ERR(icdc->base);
 
-- 
2.7.4


