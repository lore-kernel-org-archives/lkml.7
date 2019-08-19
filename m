Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C889C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2158522DA7
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566242776;
	bh=9kEw9cHE+bCs68Xy5PuK1OYo4Sh8sJwkLQ3Okm4GVxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rx/HEAkd7fR96/UjWXUaYRi3ZFB5rtDRqWGwCUvhwCYe590Jz7A0cpFanwjOAGb8U
	 52tmoI6xL6JShQmXdZ6n27F0qiqumGqSAJ7aydju+XnYH8S1KzuB6Yn9Ydh7pz+dhw
	 sdTe+s677GgWjTdOhNfgk3rYsJh8dApkTrwbXgHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfHST0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:26:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728652AbfHST0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:26:07 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E66022CF4;
        Mon, 19 Aug 2019 19:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566242766;
        bh=9kEw9cHE+bCs68Xy5PuK1OYo4Sh8sJwkLQ3Okm4GVxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pIf3gPHHYMaY1X3Db+4FwyD5v4DkbTmTrTcaCASUnizc0O/PJZV9rMlwHntNAu7Pa
         xIN5Oyk1OW0q8zHwOMTnWxVi7VivC7Kv6J1OD4A/9AV3eVEke95aML5iPiTj8qmrZS
         f4cqst6iaO3dl0Py/rD4HX+bm0uUONFPDwTzx6Y0=
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        codekipper@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH 11/21] ASoC: sun4i-i2s: Use the actual format width instead of an hardcoded one
Date:   Mon, 19 Aug 2019 21:25:18 +0200
Message-Id: <fcf77b3bee47b54d81d1a3f4f107312f44388f5a.1566242458.git-series.maxime.ripard@bootlin.com>
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

The LRCK period field in the FMT0 register holds the number of LRCK period
for one channel in I2S mode.

This has been hardcoded to 32, while it really should be the physical width
of the format, which creates an improper clock when using a 16bit format,
with the i2s controller as LRCK master.

Fixes: 7d2993811a1e ("ASoC: sun4i-i2s: Add support for H3")
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 08fc04ad3585..2996beb4f092 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -357,7 +357,7 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 	if (i2s->variant->has_fmt_set_lrck_period)
 		regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
 				   SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
-				   SUN8I_I2S_FMT0_LRCK_PERIOD(32));
+				   SUN8I_I2S_FMT0_LRCK_PERIOD(params_physical_width(params)));
 
 	return 0;
 }
-- 
git-series 0.9.1
