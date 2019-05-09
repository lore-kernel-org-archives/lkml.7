Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD50C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9058C20656
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557428534;
	bh=uZaDk2MwG1pjJ1LTJ9lj/yeRBUt9aHHPE2OQWP7w6zY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IRf5lJ5fYm4dhmcX9FSTjZtDCbq7o38PS3zL9QoV1I9dQ5onO6+P+5e2CmPgFQUmp
	 Hu+d8Jys7Vm7MnwOqBrp2iu6L/rhzS6QbqpkrvbthnsPNV2LM9mbXGmfk7til+ZLlc
	 je5/z1MS84pjT4FmiUZln24ZheX/HE5s9vu5vJgI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfEITCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 15:02:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728054AbfEISuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:50:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AA4321873;
        Thu,  9 May 2019 18:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427823;
        bh=uZaDk2MwG1pjJ1LTJ9lj/yeRBUt9aHHPE2OQWP7w6zY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z8cE1FksusGAbP2n/N5ERCIj5Wb7dO/w3VQcBWRK4xGlBI1Uy+OiFgC6mof8HjcYG
         s523ZDvZMq5nvy7BUK1kWYSYN27m1DJJA7XPsy9d5BiBu9K9DD0VqBb9jWnSG5QpA0
         7amR2uJQT1lvtFdDPmD/LY0/dhou7oqySGHrJuKw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Hsu <KCHSU0@nuvoton.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 18/95] ASoC: nau8810: fix the issue of widget with prefixed name
Date:   Thu,  9 May 2019 20:41:35 +0200
Message-Id: <20190509181310.616483558@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181309.180685671@linuxfoundation.org>
References: <20190509181309.180685671@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 54d1cf78b0f4ba348a7c7fb8b7d0708d71b6cc8a ]

The driver changes the stream name of DAC and ADC to avoid the issue of
widget with prefixed name. When the machine adds prefixed name for codec,
the stream name of DAI may not find the widgets.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/nau8810.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/nau8810.c b/sound/soc/codecs/nau8810.c
index bfd74b86c9d2f..645aa07941237 100644
--- a/sound/soc/codecs/nau8810.c
+++ b/sound/soc/codecs/nau8810.c
@@ -411,9 +411,9 @@ static const struct snd_soc_dapm_widget nau8810_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER("Mono Mixer", NAU8810_REG_POWER3,
 		NAU8810_MOUTMX_EN_SFT, 0, &nau8810_mono_mixer_controls[0],
 		ARRAY_SIZE(nau8810_mono_mixer_controls)),
-	SND_SOC_DAPM_DAC("DAC", "HiFi Playback", NAU8810_REG_POWER3,
+	SND_SOC_DAPM_DAC("DAC", "Playback", NAU8810_REG_POWER3,
 		NAU8810_DAC_EN_SFT, 0),
-	SND_SOC_DAPM_ADC("ADC", "HiFi Capture", NAU8810_REG_POWER2,
+	SND_SOC_DAPM_ADC("ADC", "Capture", NAU8810_REG_POWER2,
 		NAU8810_ADC_EN_SFT, 0),
 	SND_SOC_DAPM_PGA("SpkN Out", NAU8810_REG_POWER3,
 		NAU8810_NSPK_EN_SFT, 0, NULL, 0),
-- 
2.20.1



