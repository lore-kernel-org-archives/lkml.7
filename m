Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE500C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 08:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A211227182
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 08:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfFAIwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 04:52:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18067 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726058AbfFAIwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 04:52:16 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AB1817E6A55325AF0A27;
        Sat,  1 Jun 2019 16:52:11 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Sat, 1 Jun 2019
 16:52:04 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <matthias.bgg@gmail.com>,
        <shunli.wang@mediatek.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <alsa-devel@alsa-project.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] ASoC: da7219: Fix build error without CONFIG_I2C
Date:   Sat, 1 Jun 2019 16:51:44 +0800
Message-ID: <20190601085144.13832-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix gcc build error while CONFIG_I2C is not set

sound/soc/codecs/da7219.c:2640:1: warning: data definition has no type or storage class
 module_i2c_driver(da7219_i2c_driver);
 ^~~~~~~~~~~~~~~~~
sound/soc/codecs/da7219.c:2640:1: error: type defaults to int in declaration of module_i2c_driver [-Werror=implicit-int]
sound/soc/codecs/da7219.c:2640:1: warning: parameter names (without types) in function declaration
sound/soc/codecs/da7219.c:2629:26: warning: da7219_i2c_driver defined but not used [-Wunused-variable]

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 6d817c0e9fd7 ("ASoC: codecs: Add da7219 codec driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/mediatek/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 933ab51..111e44b 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -133,7 +133,7 @@ config SND_SOC_MT8183_MT6358_TS3A227E_MAX98357A
 
 config SND_SOC_MT8183_DA7219_MAX98357A
 	tristate "ASoC Audio driver for MT8183 with DA7219 MAX98357A codec"
-	depends on SND_SOC_MT8183
+	depends on SND_SOC_MT8183 && I2C
 	select SND_SOC_MT6358
 	select SND_SOC_MAX98357A
 	select SND_SOC_DA7219
-- 
2.7.4


