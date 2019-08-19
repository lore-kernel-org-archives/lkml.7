Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEFFC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C754D22CEC
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566242771;
	bh=ZcwqNyfFoQkpLOtyAx1vkzpHL07l3AQIIP2/dU2W0Js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FbGy2+IBOdiXz6t0oz+Ktx+XpuaDMPrZDWD3ChL+JUkdAfeFJqiNKMGBXtq+LHnAV
	 uppHIo8rXAVhHdolAvtqh1XF1k5sSiz1skJw3uT6rF4n7bJhS3YmbqJuaRflRO8uxs
	 UY8Qtfowv3EvAxyEjrQX89yrFSjNnanPN8Z8s71c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbfHST0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:26:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728636AbfHST0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:26:04 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E697C22CEC;
        Mon, 19 Aug 2019 19:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566242763;
        bh=ZcwqNyfFoQkpLOtyAx1vkzpHL07l3AQIIP2/dU2W0Js=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ro3TjRL988ozIKOXKkjU8yUL5lQAUbfUycGSTVVTf6h5MBF8TsYAQpFBx0UMDzR2y
         YyDwjxBoXzoBstxyYuvd/KBRyMTqwEtO9eXMp6hKEuuVwXLcZ0tp8E/34FcsM39wfM
         GEqz6ItuxnPTl7j5UngkpL24XANC1cNkP6ifHI2s=
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        codekipper@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH 10/21] ASoC: sun4i-i2s: RX and TX counter registers are swapped
Date:   Mon, 19 Aug 2019 21:25:17 +0200
Message-Id: <8b26477560ad5fd8f69e037b167c5e61de5c26a3.1566242458.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.e08aa7e33afe117e1fa8f017119d465d47c98016.1566242458.git-series.maxime.ripard@bootlin.com>
References: <cover.e08aa7e33afe117e1fa8f017119d465d47c98016.1566242458.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

The RX and TX counters registers offset have been swapped, fix that.

Fixes: fa7c0d13cb26 ("ASoC: sunxi: Add Allwinner A10 Digital Audio driver")
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 8d49ee7d2a95..08fc04ad3585 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -76,8 +76,8 @@
 #define SUN4I_I2S_CLK_DIV_MCLK_MASK		GENMASK(3, 0)
 #define SUN4I_I2S_CLK_DIV_MCLK(mclk)			((mclk) << 0)
 
-#define SUN4I_I2S_RX_CNT_REG		0x28
-#define SUN4I_I2S_TX_CNT_REG		0x2c
+#define SUN4I_I2S_TX_CNT_REG		0x28
+#define SUN4I_I2S_RX_CNT_REG		0x2c
 
 #define SUN4I_I2S_TX_CHAN_SEL_REG	0x30
 #define SUN4I_I2S_CHAN_SEL_MASK			GENMASK(2, 0)
-- 
git-series 0.9.1
