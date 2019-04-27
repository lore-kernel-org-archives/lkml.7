Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D16CC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE7A20679
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556330217;
	bh=YoEhNjoWZOm6r6wDwUuPvc4qJ6jHzYtOkY3Q25Ml4GQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2BCD2p7UV8GU/FDff+5JIVXEcN//qThQXWQDE599GPaV/QsIn6G2OZXmKa9SDLcRk
	 FnZxlgXxhIf/rWm6GHQ1U7Y7eH08HU+TM2qUKDig+7F12n/j4pA5coZvCs0/18E5gs
	 d4J5lr1edmWlAlAOuNeA/1TSOgHJWO6TDZmsoYL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfD0Biw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:38:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbfD0Bir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:38:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08FFE214AE;
        Sat, 27 Apr 2019 01:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329126;
        bh=YoEhNjoWZOm6r6wDwUuPvc4qJ6jHzYtOkY3Q25Ml4GQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f1u0LtC5EMGz9mW+gx9/v+Zu5nCCMZo7J5BLrd7Q/I/VseXxv/JAQsxjlOyp35w9K
         BS4xMh8UwNCkQbDlStnWcw9hQUvEjTN+3bnqVcQrU8WHcd0ruDINFMxxrw77h5/HFI
         W38FgBMm2UMwdxlD+ZyAVucoqS4BSiDPw8VV0PAE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rander Wang <rander.wang@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 07/79] ASoC:soc-pcm:fix a codec fixup issue in TDM case
Date:   Fri, 26 Apr 2019 21:37:26 -0400
Message-Id: <20190427013838.6596-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
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
index 03f36e534050..0b6ade426516 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -954,10 +954,13 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
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

