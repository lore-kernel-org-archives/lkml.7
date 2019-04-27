Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98297C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE51206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329698;
	bh=nYFPDUGUZbdom8f4jCG8V0pg/9Vn8dGeYnUfa31FxW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fnk4DMPU7pY1vCxgpqEw+Pjt+DEslTkaSBFAFlyJ2Dt7PqXPLVkF67GzXb/dvI4k5
	 aV8I7Aj4O+9Z/yXYUhvtNO45WG5M3o8WMKYv+ggjtFyJ9lMjiFtvubc2WBEXGnA3Mq
	 LpELHJ1gcPnmQV3s24hVlDefEe02qvcHkHY3yHRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbfD0BsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:48:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727652AbfD0Bme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:42:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6213F2053B;
        Sat, 27 Apr 2019 01:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329354;
        bh=nYFPDUGUZbdom8f4jCG8V0pg/9Vn8dGeYnUfa31FxW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k91NSP9towI2xA90rrqW5SENpGZIyzHZNhQXM6EFCgPM9Nu0tkQV5ZYd4XLEsJHpr
         oET6JaSJdSnfXubeQLl6jQU8G+IaBQbBZ3JpPDZr2Zu1mkUBQ/4J1VeBYrwReh3X7Z
         JcjjECTj4XXQk8X51YQ/uRRXlmldE1ICcD/ojE+Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Hsu <KCHSU0@nuvoton.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 05/32] ASoC: nau8810: fix the issue of widget with prefixed name
Date:   Fri, 26 Apr 2019 21:41:56 -0400
Message-Id: <20190427014224.8274-5-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014224.8274-1-sashal@kernel.org>
References: <20190427014224.8274-1-sashal@kernel.org>
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
index c8e2451ae0a3..193588eb9835 100644
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

