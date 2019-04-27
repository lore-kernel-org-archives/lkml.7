Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC1AC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C52206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329712;
	bh=U7BiP04lB3YcN5B2Tokm4IXyjaL4m+4Sj+4dUOI+R0w=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hYrIciiq5++1tUN+zBuuR/q6cFjK5Q5angU/vcGUBKE7bicylBwvORelc97Fngy/R
	 6rwK2HfbwVkxcsO5xtgyRHuAilqbtehtI2JmpC1l+G7MPHmdw29SnKSKGesHyruDzj
	 jQFX2uTCBvuSJLXi4LWXEUy+fPkUbz1nloCKd7W4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbfD0Bsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:48:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbfD0Bm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:42:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD5E82053B;
        Sat, 27 Apr 2019 01:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329346;
        bh=U7BiP04lB3YcN5B2Tokm4IXyjaL4m+4Sj+4dUOI+R0w=;
        h=From:To:Cc:Subject:Date:From;
        b=nY6ag4OhEKjf/7+r0JgUxq/IXQhJBzpZPbRInODmPuAgLaJWJDKoP2+tLoJVyrZaL
         O5fS+KmgUiCuSR2PPY/WG0bLYDakcb5xxo02Md7zwAunPlhPvJXcYBjcQMix43H8/W
         7KRCOh8NradT982GJkU9+CJxYtHQKo9wga5oU/EY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 01/32] ASoC: hdmi-codec: fix S/PDIF DAI
Date:   Fri, 26 Apr 2019 21:41:52 -0400
Message-Id: <20190427014224.8274-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit 2e95f984aae4cf0608d0ba2189c756f2bd50b44a ]

When using the S/PDIF DAI, there is no requirement to call
snd_soc_dai_set_fmt() as there is no DAI format definition that defines
S/PDIF.  In any case, S/PDIF does not have separate clocks, this is
embedded into the data stream.

Consequently, when attempting to use TDA998x in S/PDIF mode, the attempt
to configure TDA998x via the hw_params callback fails as the
hdmi_codec_daifmt is left initialised to zero.

Since the S/PDIF DAI will only be used by S/PDIF, prepare the
hdmi_codec_daifmt structure for this format.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Reviewed-by: Jyri Sarha <jsarha@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/hdmi-codec.c | 118 +++++++++++++++++-----------------
 1 file changed, 59 insertions(+), 59 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index cf3b905b4ead..7406695ee5dc 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -536,73 +536,71 @@ static int hdmi_codec_set_fmt(struct snd_soc_dai *dai,
 {
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
 	struct hdmi_codec_daifmt cf = { 0 };
-	int ret = 0;
 
 	dev_dbg(dai->dev, "%s()\n", __func__);
 
-	if (dai->id == DAI_ID_SPDIF) {
-		cf.fmt = HDMI_SPDIF;
-	} else {
-		switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-		case SND_SOC_DAIFMT_CBM_CFM:
-			cf.bit_clk_master = 1;
-			cf.frame_clk_master = 1;
-			break;
-		case SND_SOC_DAIFMT_CBS_CFM:
-			cf.frame_clk_master = 1;
-			break;
-		case SND_SOC_DAIFMT_CBM_CFS:
-			cf.bit_clk_master = 1;
-			break;
-		case SND_SOC_DAIFMT_CBS_CFS:
-			break;
-		default:
-			return -EINVAL;
-		}
+	if (dai->id == DAI_ID_SPDIF)
+		return 0;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		cf.bit_clk_master = 1;
+		cf.frame_clk_master = 1;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFM:
+		cf.frame_clk_master = 1;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFS:
+		cf.bit_clk_master = 1;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
+	default:
+		return -EINVAL;
+	}
 
-		switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
-		case SND_SOC_DAIFMT_NB_NF:
-			break;
-		case SND_SOC_DAIFMT_NB_IF:
-			cf.frame_clk_inv = 1;
-			break;
-		case SND_SOC_DAIFMT_IB_NF:
-			cf.bit_clk_inv = 1;
-			break;
-		case SND_SOC_DAIFMT_IB_IF:
-			cf.frame_clk_inv = 1;
-			cf.bit_clk_inv = 1;
-			break;
-		}
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		cf.frame_clk_inv = 1;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		cf.bit_clk_inv = 1;
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		cf.frame_clk_inv = 1;
+		cf.bit_clk_inv = 1;
+		break;
+	}
 
-		switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
-		case SND_SOC_DAIFMT_I2S:
-			cf.fmt = HDMI_I2S;
-			break;
-		case SND_SOC_DAIFMT_DSP_A:
-			cf.fmt = HDMI_DSP_A;
-			break;
-		case SND_SOC_DAIFMT_DSP_B:
-			cf.fmt = HDMI_DSP_B;
-			break;
-		case SND_SOC_DAIFMT_RIGHT_J:
-			cf.fmt = HDMI_RIGHT_J;
-			break;
-		case SND_SOC_DAIFMT_LEFT_J:
-			cf.fmt = HDMI_LEFT_J;
-			break;
-		case SND_SOC_DAIFMT_AC97:
-			cf.fmt = HDMI_AC97;
-			break;
-		default:
-			dev_err(dai->dev, "Invalid DAI interface format\n");
-			return -EINVAL;
-		}
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		cf.fmt = HDMI_I2S;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		cf.fmt = HDMI_DSP_A;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		cf.fmt = HDMI_DSP_B;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		cf.fmt = HDMI_RIGHT_J;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		cf.fmt = HDMI_LEFT_J;
+		break;
+	case SND_SOC_DAIFMT_AC97:
+		cf.fmt = HDMI_AC97;
+		break;
+	default:
+		dev_err(dai->dev, "Invalid DAI interface format\n");
+		return -EINVAL;
 	}
 
 	hcp->daifmt[dai->id] = cf;
 
-	return ret;
+	return 0;
 }
 
 static int hdmi_codec_digital_mute(struct snd_soc_dai *dai, int mute)
@@ -784,8 +782,10 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 		i++;
 	}
 
-	if (hcd->spdif)
+	if (hcd->spdif) {
 		hcp->daidrv[i] = hdmi_spdif_dai;
+		hcp->daifmt[DAI_ID_SPDIF].fmt = HDMI_SPDIF;
+	}
 
 	ret = snd_soc_register_codec(dev, &hdmi_codec, hcp->daidrv,
 				     dai_count);
-- 
2.19.1

