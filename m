Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5776C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB086208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329585;
	bh=EM+7b7k3Em94HPk5gsuzbQhZkPb3gER7uQiHpAIAcd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Icn6pjdw25H0GPw/c1fLSiqj1FEeBRULoglVb1MTNFoxop6zjFPnNgr7Ask1fO2Ek
	 sB9Ql86+/QokjfzUtYQwcFnOlcSpk9FhL1tfJHRI9uQCYzNJs9Hp36C0zC5G/+Gu5l
	 pCpIDLIIrtXbK+b5ZOoJshB1X1vXnWDILogNCTCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbfD0BqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:46:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727998AbfD0Bna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:43:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6F42216C4;
        Sat, 27 Apr 2019 01:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329410;
        bh=EM+7b7k3Em94HPk5gsuzbQhZkPb3gER7uQiHpAIAcd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O68IQJIYaYWVJzV7prnNfts4LdQp6WHdnG7tKJ8DHH+fn1VW/VU8XBDFx4PmYioUq
         VkVRkJuhftbZ+3Q+pHi8ik+9vOhtL1joQxwCWFbOJ9aRTtTs6AcNFqnzcGuwXCqqIY
         qRskMZ/peYXlvV55MkyhtYI20T+pT0mop7ujy9Wk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Hsu <KCHSU0@nuvoton.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 03/16] ASoC: nau8810: fix the issue of widget with prefixed name
Date:   Fri, 26 Apr 2019 21:43:11 -0400
Message-Id: <20190427014325.8704-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014325.8704-1-sashal@kernel.org>
References: <20190427014325.8704-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hsu <KCHSU0@nuvoton.com>

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
index e45518629968..2234d0c04165 100644
--- a/sound/soc/codecs/nau8810.c
+++ b/sound/soc/codecs/nau8810.c
@@ -414,9 +414,9 @@ static const struct snd_soc_dapm_widget nau8810_dapm_widgets[] = {
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
2.19.1

