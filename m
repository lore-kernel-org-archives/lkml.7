Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC9DC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB0520656
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557428681;
	bh=inT9FER4sSnpeDgeUcIZ2sHTDbPIDTss4puXlMKfU9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rYR/YBy6yGc2KepxOlzbci5rjum2TdRqmOIq6CwpVQBBuhO3VSsPQ3qYsDN/5b2qF
	 /+cYo/D3tgU//l2Qf+COGNQPT1BhTVH3hRgCIJDxliFiRcRvUoyHLPVc5GoJBANvvQ
	 t+HuPJIDH6BCyctxhMNSHb12sPnuMMiY8TpUwG7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfEITEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 15:04:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbfEISsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:48:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3408D217F9;
        Thu,  9 May 2019 18:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427703;
        bh=inT9FER4sSnpeDgeUcIZ2sHTDbPIDTss4puXlMKfU9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BawazgV1jQw9KBE+JTxXCk0w+RmRcw8nFHs5G/de78vFQtqJxIUNaPggYVohsXfU+
         a/JG6M65J+e0ngTRPaz13KLXMWNM34lF0abDeDQL/zFzGtw11aLrER4/VZMBz4pjLR
         5rWEny0xMLiIBTfG47kuJDL8vgok7DkJ8PEyw7CA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rander Wang <rander.wang@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 11/66] ASoC:soc-pcm:fix a codec fixup issue in TDM case
Date:   Thu,  9 May 2019 20:41:46 +0200
Message-Id: <20190509181303.095144130@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181301.719249738@linuxfoundation.org>
References: <20190509181301.719249738@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index e8b98bfd4cf13..33060af18b5a4 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -957,10 +957,13 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
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
2.20.1



