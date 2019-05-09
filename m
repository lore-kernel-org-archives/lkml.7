Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E88CC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E6D2177B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557428500;
	bh=mrCCDWM23VSfbpq4cOeRulv0rY0o3uBxCNGWwpjI4rY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nUN9zF1Zgbcnu0TTv9gIkGosgjanWDAisUtGpME80HhVAgbFQgvfUoqJvdbreNw1i
	 jZrCfyhv5iW7eh8MNOWJh9UqnF7ZGvBBTPGeDg0xBYj9tUsTtDzO96UFDsq99U+Uqa
	 q1Bqzoy62w7yBlyzPNz0OYClvR0FuPDmV/asxQyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbfEITBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 15:01:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728456AbfEISuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:50:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 526A820578;
        Thu,  9 May 2019 18:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427836;
        bh=mrCCDWM23VSfbpq4cOeRulv0rY0o3uBxCNGWwpjI4rY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pRTCyQNRfCMkc2ynaK66iZpu3cgMABlTBff55vHQFS2dTy3NGODTggGHLqF5EaHgJ
         3w5ENiKp0tdijNMyWQvFon3hbED98JVCIi3jTDnrLk9hP2LTyq5Srg+vyPwqJFZ9sp
         TSxW0bwHEq3Osh6UEZVFmX3NUiXvU2rqtXcjLZzA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shuming Fan <shumingf@realtek.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 22/95] ASoC: rt5682: recording has no sound after booting
Date:   Thu,  9 May 2019 20:41:39 +0200
Message-Id: <20190509181310.884855118@linuxfoundation.org>
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
index 9331c13d2017a..72ef2a0f6387d 100644
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
2.20.1



