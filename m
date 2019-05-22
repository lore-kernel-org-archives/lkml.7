Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE25C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D2621841
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558553347;
	bh=HYtcnejSjdCJsw5o0rxcwSJiFUIB6WG1tHilFWol0jM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F8fzSxu2GEl5chzhscdf3RyQhSTpqVwkrD2zOMWiySwU8h5pA3G5pgpj1hEx9UA7X
	 d9ppcyiYswSf4xvagVovdPVCtm+qd7p6saglPLg3qPJyOh3pWhqFEXitFVa/cJ8Ynr
	 APr5PbagnPxJ4pHd7tuUrL0Pjry6eeI5YR22sGFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732746AbfEVT3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:29:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730041AbfEVT3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:29:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B47B720675;
        Wed, 22 May 2019 19:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553340;
        bh=HYtcnejSjdCJsw5o0rxcwSJiFUIB6WG1tHilFWol0jM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OD1ZIpUAm7d1cSqN27Rf1C4mIIOT0R+fDCznhCAh9v7m54ixcuv3n7PXlsfD1lGai
         IxP1salwN7bmg2zIrgW7x2RNciyTt0VpF8OiTviU3BtehzeFMwXBNY4polzY8Gz2J2
         33vTijho47VjNEaZNopnjKW8y/8noHl89NkrXlZA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 012/167] ASoC: hdmi-codec: unlock the device on startup errors
Date:   Wed, 22 May 2019 15:26:07 -0400
Message-Id: <20190522192842.25858-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192842.25858-1-sashal@kernel.org>
References: <20190522192842.25858-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit 30180e8436046344b12813dc954b2e01dfdcd22d ]

If the hdmi codec startup fails, it should clear the current_substream
pointer to free the device. This is properly done for the audio_startup()
callback but for snd_pcm_hw_constraint_eld().

Make sure the pointer cleared if an error is reported.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/hdmi-codec.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 7406695ee5dc2..e00f5f49f21d1 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -446,8 +446,12 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 		if (!ret) {
 			ret = snd_pcm_hw_constraint_eld(substream->runtime,
 							hcp->eld);
-			if (ret)
+			if (ret) {
+				mutex_lock(&hcp->current_stream_lock);
+				hcp->current_stream = NULL;
+				mutex_unlock(&hcp->current_stream_lock);
 				return ret;
+			}
 		}
 		/* Select chmap supported */
 		hdmi_codec_eld_chmap(hcp);
-- 
2.20.1

