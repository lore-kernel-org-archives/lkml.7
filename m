Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CF0C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142112070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfK0IWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 03:22:09 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6722 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726125AbfK0IWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 03:22:08 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D27E9A28826B1B02A339;
        Wed, 27 Nov 2019 16:22:06 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 27 Nov 2019
 16:21:57 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <bardliao@realtek.com>, <oder_chiou@realtek.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <benzh@chromium.org>, <cujomalainey@chromium.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: rt5677: Fix build error without CONFIG_SPI
Date:   Wed, 27 Nov 2019 16:21:45 +0800
Message-ID: <20191127082145.6100-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_SPI is n, SND_SOC_RT5677_SPI also is n, building fails:

sound/soc/codecs/rt5677.o: In function `rt5677_irq':
rt5677.c:(.text+0x2dbf): undefined reference to `rt5677_spi_hotword_detected'
sound/soc/codecs/rt5677.o: In function `rt5677_dsp_work':
rt5677.c:(.text+0x3709): undefined reference to `rt5677_spi_write'

This adds stub helpers to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 461c623270e4 ("ASoC: rt5677: Load firmware via SPI using delayed work")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/rt5677-spi.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/codecs/rt5677-spi.h b/sound/soc/codecs/rt5677-spi.h
index 3af36ec..088b779 100644
--- a/sound/soc/codecs/rt5677-spi.h
+++ b/sound/soc/codecs/rt5677-spi.h
@@ -9,9 +9,25 @@
 #ifndef __RT5677_SPI_H__
 #define __RT5677_SPI_H__
 
+#if IS_ENABLED(CONFIG_SND_SOC_RT5677_SPI)
 int rt5677_spi_read(u32 addr, void *rxbuf, size_t len);
 int rt5677_spi_write(u32 addr, const void *txbuf, size_t len);
 int rt5677_spi_write_firmware(u32 addr, const struct firmware *fw);
 void rt5677_spi_hotword_detected(void);
+#else
+static inline int rt5677_spi_read(u32 addr, void *rxbuf, size_t len)
+{
+	return -EINVAL;
+}
+static inline int rt5677_spi_write(u32 addr, const void *txbuf, size_t len)
+{
+	return -EINVAL;
+}
+static inline int rt5677_spi_write_firmware(u32 addr, const struct firmware *fw)
+{
+	return -EINVAL;
+}
+static inline void rt5677_spi_hotword_detected(void){}
+#endif
 
 #endif /* __RT5677_SPI_H__ */
-- 
2.7.4


