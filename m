Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6A9C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4390215EA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329461;
	bh=4suxKOebdBCrv1QJH7vHAcVR4kZcO6lhmAODBKiQcD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0WRTwwLzsDpw6fynNMUMH88sVG381YOAuRtg+cKyXaQAxpiMDZjpen+lDiHtZp7dS
	 eN1h2ySmlUM+Cqb50AxkHH06aQDe9uXRr2wGoDFhD6yTWRblH/AGX6pKEUL0ZM93C/
	 dJqwtSpifPfXCqYTu9QOJZPI/Zv80OKaV4FnMWXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfD0BoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:44:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727501AbfD0BoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:44:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75017215EA;
        Sat, 27 Apr 2019 01:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329455;
        bh=4suxKOebdBCrv1QJH7vHAcVR4kZcO6lhmAODBKiQcD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y32SqkoGAxzKxt52IvMsBxZieUww7epgsoXT2ZghmZU3ji3Iwd9xllAseQAnRhzVJ
         /fTktmNZMSEJiSYL15I/AYW+p259n112+b95aX++Tl8m7EA7saiCFG1b56Dy0XGTFI
         LM93B0IFi8kcnpcb5HGH9QiaUKLYyPvXZt3jBdZY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rander Wang <rander.wang@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 2/8] ASoC:soc-pcm:fix a codec fixup issue in TDM case
Date:   Fri, 26 Apr 2019 21:44:05 -0400
Message-Id: <20190427014412.9091-2-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014412.9091-1-sashal@kernel.org>
References: <20190427014412.9091-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rander Wang <rander.wang@linux.intel.com>

[ Upstream commit 570f18b6a8d1f0e60e8caf30e66161b6438dcc91 ]

On HDaudio platforms, if playback is started when capture is working,
there is no audible output.

This can be root-caused to the use of the rx|tx_mask to store an HDaudio
stream tag.

If capture is stared before playback, rx_mask would be non-zero on HDaudio
platform, then the channel number of playback, which is in the same codec
dai with the capture, would be changed by soc_pcm_codec_params_fixup based
on the tx_mask at first, then overwritten by this function based on rx_mask
at last.

According to the author of tx|rx_mask, tx_mask is for playback and rx_mask
is for capture. And stream direction is checked at all other references of
tx|rx_mask in ASoC, so here should be an error. This patch checks stream
direction for tx|rx_mask for fixup function.

This issue would affect not only HDaudio+ASoC, but also I2S codecs if the
channel number based on rx_mask is not equal to the one for tx_mask. It could
be rarely reproduecd because most drivers in kernel set the same channel number
to tx|rx_mask or rx_mask is zero.

Tested on all platforms using stream_tag & HDaudio and intel I2S platforms.

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-pcm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index e2fb859fbbaa..4323002c67db 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -847,10 +847,13 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 		codec_params = *params;
 
 		/* fixup params based on TDM slot masks */
-		if (codec_dai->tx_mask)
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
+		    codec_dai->tx_mask)
 			soc_pcm_codec_params_fixup(&codec_params,
 						   codec_dai->tx_mask);
-		if (codec_dai->rx_mask)
+
+		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE &&
+		    codec_dai->rx_mask)
 			soc_pcm_codec_params_fixup(&codec_params,
 						   codec_dai->rx_mask);
 
-- 
2.19.1

