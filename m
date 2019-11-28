Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D18C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A452070B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574947115;
	bh=L0EdJPwiaZhI+M8LewE+42ivOhZqn0oaQ2oO9FBLvPw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=XGAyWNxmVFy1LCbFfxCem/BwEKmonDGHUOncKqqmv+Hx5yxusDGKepcFQkL5UB8Oa
	 Y9Y5KcMT4+NjJu3uvnXMMfqmC2L1jdj8/QySCybXAemI8guAI86a0SohWmcC2WbrbD
	 +OYE1+eNF1FpoB3U1XLdQUP8d6N1PEBp+WdQelJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfK1NSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:18:34 -0500
Received: from foss.arm.com ([217.140.110.172]:35206 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfK1NSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:18:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F34201042;
        Thu, 28 Nov 2019 05:18:32 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72BCC3F52E;
        Thu, 28 Nov 2019 05:18:32 -0800 (PST)
Date:   Thu, 28 Nov 2019 13:18:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, bardliao@realtek.com,
        benzh@chromium.org, broonie@kernel.org, cujomalainey@chromium.org,
        Hulk Robot <hulkci@huawei.com>, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: rt5677: Fix build error without CONFIG_SPI" to the asoc tree
In-Reply-To: <20191127082145.6100-1-yuehaibing@huawei.com>
Message-Id: <applied-20191127082145.6100-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: rt5677: Fix build error without CONFIG_SPI

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From fb3194413d1ef79732931a40f54da21a16505a76 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 27 Nov 2019 16:21:45 +0800
Subject: [PATCH] ASoC: rt5677: Fix build error without CONFIG_SPI

If CONFIG_SPI is n, SND_SOC_RT5677_SPI also is n, building fails:

sound/soc/codecs/rt5677.o: In function `rt5677_irq':
rt5677.c:(.text+0x2dbf): undefined reference to `rt5677_spi_hotword_detected'
sound/soc/codecs/rt5677.o: In function `rt5677_dsp_work':
rt5677.c:(.text+0x3709): undefined reference to `rt5677_spi_write'

This adds stub helpers to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 461c623270e4 ("ASoC: rt5677: Load firmware via SPI using delayed work")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20191127082145.6100-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5677-spi.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/codecs/rt5677-spi.h b/sound/soc/codecs/rt5677-spi.h
index 3af36ec928e9..088b77931727 100644
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
2.20.1

