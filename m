Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561B4C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292DA205F4
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556330185;
	bh=o+KMaZFGCimfQyk7lMKqWpuKUx5OsoIu52T/ZheX1GM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NuZwLNAGLmFtvT/mJ2bY0nfr1CIIHNjPd1q5/5d8wqPTAnZI8dvJJuvJ7UvIEujDj
	 Sumoy9bmi9uV2aMKY38h1naXeFgY3YUsGVM88grm6zw1pLVK6Vyko/KBp6G0Wt4R+b
	 77tW77HkWMx5VXo5gbF+bCVqUFzzLxNg5cYdfOiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfD0BjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:39:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727426AbfD0Bi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:38:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F123F208CB;
        Sat, 27 Apr 2019 01:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329135;
        bh=o+KMaZFGCimfQyk7lMKqWpuKUx5OsoIu52T/ZheX1GM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zDnIt+Go+BuFXgAjTzBBFPDklJfbHoBhzxYqYK6SXMjkvWszUZWUXG6Ifk97f8Xn9
         qgx0uRnHsIgrKrp4qCPzvMrlyWF/EKsu4aN3edZZsn0pSMe3Ip5mDbgxwZJ0mDI6FQ
         Idb4tHpW7d4JKgKO61XWIs9Cdd+pao1yJs4UUiiI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shuming Fan <shumingf@realtek.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 16/79] ASoC: rt5682: recording has no sound after booting
Date:   Fri, 26 Apr 2019 21:37:35 -0400
Message-Id: <20190427013838.6596-16-sashal@kernel.org>
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

[ Upstream commit 1c5b6a27e432e4fe170a924c8b41012271496a4c ]

If ASRC turns on, HW will use clk_dac as the reference clock
whether recording or playback.
Both of clk_dac and clk_adc should set proper clock while using ASRC.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5682.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 9331c13d2017..72ef2a0f6387 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -1202,7 +1202,7 @@ static int set_filter_clk(struct snd_soc_dapm_widget *w,
 	struct snd_soc_component *component =
 		snd_soc_dapm_to_component(w->dapm);
 	struct rt5682_priv *rt5682 = snd_soc_component_get_drvdata(component);
-	int ref, val, reg, sft, mask, idx = -EINVAL;
+	int ref, val, reg, idx = -EINVAL;
 	static const int div_f[] = {1, 2, 3, 4, 6, 8, 12, 16, 24, 32, 48};
 	static const int div_o[] = {1, 2, 4, 6, 8, 12, 16, 24, 32, 48};
 
@@ -1216,15 +1216,10 @@ static int set_filter_clk(struct snd_soc_dapm_widget *w,
 
 	idx = rt5682_div_sel(rt5682, ref, div_f, ARRAY_SIZE(div_f));
 
-	if (w->shift == RT5682_PWR_ADC_S1F_BIT) {
+	if (w->shift == RT5682_PWR_ADC_S1F_BIT)
 		reg = RT5682_PLL_TRACK_3;
-		sft = RT5682_ADC_OSR_SFT;
-		mask = RT5682_ADC_OSR_MASK;
-	} else {
+	else
 		reg = RT5682_PLL_TRACK_2;
-		sft = RT5682_DAC_OSR_SFT;
-		mask = RT5682_DAC_OSR_MASK;
-	}
 
 	snd_soc_component_update_bits(component, reg,
 		RT5682_FILTER_CLK_DIV_MASK, idx << RT5682_FILTER_CLK_DIV_SFT);
@@ -1236,7 +1231,8 @@ static int set_filter_clk(struct snd_soc_dapm_widget *w,
 	}
 
 	snd_soc_component_update_bits(component, RT5682_ADDA_CLK_1,
-		mask, idx << sft);
+		RT5682_ADC_OSR_MASK | RT5682_DAC_OSR_MASK,
+		(idx << RT5682_ADC_OSR_SFT) | (idx << RT5682_DAC_OSR_SFT));
 
 	return 0;
 }
-- 
2.19.1

