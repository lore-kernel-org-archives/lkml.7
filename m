Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9CAC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFAC205F4
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556330198;
	bh=AAEvVE7frmeHvOOmiQfnba+MqSBFIYXCB/fwuyLnTU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UtkjUz9N+9bZ7wv4GrO2Wiy3n7g6o4gjLnaMW7ItXhD+Qf+0wLKymMu3Q7wZT3nJK
	 mrOplUMWJ1xpiPfI9fy2AX1eOsp0fb94WPHpE5vY5WD0Y7CDuDvLg3Zn4750RdVt9r
	 sLOdTZjzUbJ5C2jQwZIjOCNFZT2KqtHO+AMJAYhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfD0B4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:56:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfD0Biy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:38:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC54B214C6;
        Sat, 27 Apr 2019 01:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329133;
        bh=AAEvVE7frmeHvOOmiQfnba+MqSBFIYXCB/fwuyLnTU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uyC5J7QNVSoO5t+lpGJg7UjqNpEO38dWuR5jzanjmnRQ/z8T+5bV1Snprry1kvcv4
         RoginKvFrh+A9nRfs99I15FJip+Eh0LVE9t/5YTaVoJu+EqvD6FrCbv554YpEeZNcN
         vVIaJXWWv9hhrY/rKU+85zSmNceqiFjQG4g6u0TI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shuming Fan <shumingf@realtek.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 14/79] ASoC: rt5682: Check JD status when system resume
Date:   Fri, 26 Apr 2019 21:37:33 -0400
Message-Id: <20190427013838.6596-14-sashal@kernel.org>
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

From: Shuming Fan <shumingf@realtek.com>

[ Upstream commit 4834d7070c85a5fb69637265dbbb05d13043280c ]

The IRQ function may not work when system suspend.
We remove snd_soc_dapm_force_enable_pin function call to
make sure the bias off when idle and run into suspend/resume function.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5682.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index a9b91bcfcc09..49ff5e52db58 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -904,13 +904,20 @@ static int rt5682_headset_detect(struct snd_soc_component *component,
 		int jack_insert)
 {
 	struct rt5682_priv *rt5682 = snd_soc_component_get_drvdata(component);
-	struct snd_soc_dapm_context *dapm =
-		snd_soc_component_get_dapm(component);
 	unsigned int val, count;
 
 	if (jack_insert) {
-		snd_soc_dapm_force_enable_pin(dapm, "CBJ Power");
-		snd_soc_dapm_sync(dapm);
+
+		snd_soc_component_update_bits(component, RT5682_PWR_ANLG_1,
+			RT5682_PWR_VREF2, RT5682_PWR_VREF2);
+		snd_soc_component_update_bits(component,
+				RT5682_PWR_ANLG_1, RT5682_PWR_FV2, 0);
+		usleep_range(15000, 20000);
+		snd_soc_component_update_bits(component,
+				RT5682_PWR_ANLG_1, RT5682_PWR_FV2, RT5682_PWR_FV2);
+		snd_soc_component_update_bits(component, RT5682_PWR_ANLG_3,
+			RT5682_PWR_CBJ, RT5682_PWR_CBJ);
+
 		snd_soc_component_update_bits(component, RT5682_CBJ_CTRL_1,
 			RT5682_TRIG_JD_MASK, RT5682_TRIG_JD_HIGH);
 
@@ -938,8 +945,10 @@ static int rt5682_headset_detect(struct snd_soc_component *component,
 		rt5682_enable_push_button_irq(component, false);
 		snd_soc_component_update_bits(component, RT5682_CBJ_CTRL_1,
 			RT5682_TRIG_JD_MASK, RT5682_TRIG_JD_LOW);
-		snd_soc_dapm_disable_pin(dapm, "CBJ Power");
-		snd_soc_dapm_sync(dapm);
+		snd_soc_component_update_bits(component, RT5682_PWR_ANLG_1,
+			RT5682_PWR_VREF2, 0);
+		snd_soc_component_update_bits(component, RT5682_PWR_ANLG_3,
+			RT5682_PWR_CBJ, 0);
 
 		rt5682->jack_type = 0;
 	}
@@ -1585,8 +1594,6 @@ static const struct snd_soc_dapm_widget rt5682_dapm_widgets[] = {
 		0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("Vref1", RT5682_PWR_ANLG_1, RT5682_PWR_VREF1_BIT, 0,
 		rt5655_set_verf, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
-	SND_SOC_DAPM_SUPPLY("Vref2", RT5682_PWR_ANLG_1, RT5682_PWR_VREF2_BIT, 0,
-		rt5655_set_verf, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
 
 	/* ASRC */
 	SND_SOC_DAPM_SUPPLY_S("DAC STO1 ASRC", 1, RT5682_PLL_TRACK_1,
@@ -1621,9 +1628,6 @@ static const struct snd_soc_dapm_widget rt5682_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA("BST1 CBJ", SND_SOC_NOPM,
 		0, 0, NULL, 0),
 
-	SND_SOC_DAPM_SUPPLY("CBJ Power", RT5682_PWR_ANLG_3,
-		RT5682_PWR_CBJ_BIT, 0, NULL, 0),
-
 	/* REC Mixer */
 	SND_SOC_DAPM_MIXER("RECMIX1L", SND_SOC_NOPM, 0, 0, rt5682_rec1_l_mix,
 		ARRAY_SIZE(rt5682_rec1_l_mix)),
@@ -1786,17 +1790,13 @@ static const struct snd_soc_dapm_route rt5682_dapm_routes[] = {
 
 	/*Vref*/
 	{"MICBIAS1", NULL, "Vref1"},
-	{"MICBIAS1", NULL, "Vref2"},
 	{"MICBIAS2", NULL, "Vref1"},
-	{"MICBIAS2", NULL, "Vref2"},
 
 	{"CLKDET SYS", NULL, "CLKDET"},
 
 	{"IN1P", NULL, "LDO2"},
 
 	{"BST1 CBJ", NULL, "IN1P"},
-	{"BST1 CBJ", NULL, "CBJ Power"},
-	{"CBJ Power", NULL, "Vref2"},
 
 	{"RECMIX1L", "CBJ Switch", "BST1 CBJ"},
 	{"RECMIX1L", NULL, "RECMIX1L Power"},
@@ -1906,9 +1906,7 @@ static const struct snd_soc_dapm_route rt5682_dapm_routes[] = {
 	{"HP Amp", NULL, "Capless"},
 	{"HP Amp", NULL, "Charge Pump"},
 	{"HP Amp", NULL, "CLKDET SYS"},
-	{"HP Amp", NULL, "CBJ Power"},
 	{"HP Amp", NULL, "Vref1"},
-	{"HP Amp", NULL, "Vref2"},
 	{"HPOL Playback", "Switch", "HP Amp"},
 	{"HPOR Playback", "Switch", "HP Amp"},
 	{"HPOL", NULL, "HPOL Playback"},
@@ -2357,6 +2355,8 @@ static int rt5682_resume(struct snd_soc_component *component)
 	regcache_cache_only(rt5682->regmap, false);
 	regcache_sync(rt5682->regmap);
 
+	rt5682_irq(0, rt5682);
+
 	return 0;
 }
 #else
-- 
2.19.1

