Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5C0C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3238206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329888;
	bh=2m9AUxm3e4svXdc9yihwc+IQCXRs3NTQh/4aH+3Clr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zJqr3fi/DZlV2I8YC/wSrQn82qxoC/M52zLMM70qriQYxTeyTjTiEx94Q6d0equz3
	 dyJpEqWMHwLhPl0jVSwE5WEiGf+RYWSrxgA8R2WH5W7ItvQbF06GpKWQoAU0WAP7Cz
	 13kBN4SUt+cc2IIOR1ZN9qVdzgAruihmpfd1qR2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbfD0Bv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:51:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728183AbfD0BlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:41:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0398621537;
        Sat, 27 Apr 2019 01:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329268;
        bh=2m9AUxm3e4svXdc9yihwc+IQCXRs3NTQh/4aH+3Clr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FmXZho3yok0OMbsaoZhQfEWXb51AGJWWltmgM8o7LxfSWwHJkMEXqhvoSlbWOPabm
         Wo+9POoAQDVpXQzbRuTZBGO0zJK/8XCXhw6dzHzlU9cmElzKGIzmBZagkeXvu4XZii
         51GVx9IZKGpMfSXyoO+UPpMXv8wY48V9wxfKFqJw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shuming Fan <shumingf@realtek.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 11/53] ASoC: rt5682: recording has no sound after booting
Date:   Fri, 26 Apr 2019 21:40:08 -0400
Message-Id: <20190427014051.7522-11-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014051.7522-1-sashal@kernel.org>
References: <20190427014051.7522-1-sashal@kernel.org>
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
index 79ebcc239786..6f5dac09cede 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -1196,7 +1196,7 @@ static int set_filter_clk(struct snd_soc_dapm_widget *w,
 	struct snd_soc_component *component =
 		snd_soc_dapm_to_component(w->dapm);
 	struct rt5682_priv *rt5682 = snd_soc_component_get_drvdata(component);
-	int ref, val, reg, sft, mask, idx = -EINVAL;
+	int ref, val, reg, idx = -EINVAL;
 	static const int div_f[] = {1, 2, 3, 4, 6, 8, 12, 16, 24, 32, 48};
 	static const int div_o[] = {1, 2, 4, 6, 8, 12, 16, 24, 32, 48};
 
@@ -1210,15 +1210,10 @@ static int set_filter_clk(struct snd_soc_dapm_widget *w,
 
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
@@ -1230,7 +1225,8 @@ static int set_filter_clk(struct snd_soc_dapm_widget *w,
 	}
 
 	snd_soc_component_update_bits(component, RT5682_ADDA_CLK_1,
-		mask, idx << sft);
+		RT5682_ADC_OSR_MASK | RT5682_DAC_OSR_MASK,
+		(idx << RT5682_ADC_OSR_SFT) | (idx << RT5682_DAC_OSR_SFT));
 
 	return 0;
 }
-- 
2.19.1

