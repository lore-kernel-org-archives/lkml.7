Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7063AC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 17:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49618218AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 17:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9XjvkCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391435AbfIIRpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 13:45:55 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32791 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbfIIRpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 13:45:55 -0400
Received: by mail-pl1-f193.google.com with SMTP id t11so6856288plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 10:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=NyVhJPPTs6wJnDV91iq2gfn2ADsla6hIU5GumREy3IU=;
        b=M9XjvkCU8U0uc2A2HXkCDBumTsIS6nsgiD4PpQon98qdueFJ/bxdz8ON6SfMx3hgFN
         aOOL0CBopLJ0Bdf6qem737wLy+F7G7ZNTprUazDp/KwTQXuO04EMFI8PggDeqxj/7b+B
         oA7mU5eRAqRtD5NpqHTuV3kgdTPWRR1E2SlG8z8CuD29EFxUo6Pyh3Te+pg6HqWIgKPD
         WhPaF6JmubDLd+fHXvT1S16wM6vcI9DTrMhs62+65QZ0Lk08dyWqwGKQKY13p6LwrYiJ
         EA38F/qILGOCkDmfsnWUYehYUYIdbErBOUD/AP8VOevLr6+lCc6/ARFwKkqMAiWdQTG3
         miYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=NyVhJPPTs6wJnDV91iq2gfn2ADsla6hIU5GumREy3IU=;
        b=MMh8k8e6OTcB9NsBQSRfOMJ79km3rHopH7DzHLnbf6EQKfhL7ZARTaykDn2+m/iLco
         TDi6r2Ou67LgvSnCTepZZN3BE5ddnoByyySs2br3JhowRqOOd7ZUWmvh65x3CJsp9KWP
         f7tLNuV0l/QgulkpheTBTFdC564P7nTnXTIu27PEUtfANEF9lZdy9bAT1ISGyB/T8Oh4
         WKzmW3kuVpdw8bSKfQzci0HbxsF9v8lrN5XLU/rrgc89a7vgJ0+QrqUTHxjqNlMwqJwM
         jtEfzZfdN1zTMKwK1Zr1gGhbQIg8g3qP624OyXjyJMpk5gvh2ln30a9KlfoUP/T+gwAI
         8kGA==
X-Gm-Message-State: APjAAAUXng5B4iTM14gKXq7UjW4gaU8T9Ew4O0X2OWVhEMX+7HOis7N6
        CDOnPKHmQZS07uKeud7H74Y=
X-Google-Smtp-Source: APXvYqxneiElM9L6z2oc9GIFmEdOmZXAESGHesiUPjLlmzl0qWX+82SU80jLw2IpeN/5P0XxDrUsqw==
X-Received: by 2002:a17:902:b201:: with SMTP id t1mr25927892plr.144.1568051153805;
        Mon, 09 Sep 2019 10:45:53 -0700 (PDT)
Received: from SD ([2405:204:810e:f33:a5a3:6372:2e94:6aea])
        by smtp.gmail.com with ESMTPSA id u9sm162507pjb.4.2019.09.09.10.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 10:45:53 -0700 (PDT)
Date:   Mon, 9 Sep 2019 23:15:41 +0530
From:   Saiyam Doshi <saiyamdoshi.in@gmail.com>
To:     broonie@kernel.org, srinivas.kandagatla@linaro.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: wcd9335: remove redundant use of ret variable
Message-ID: <20190909174541.GA22718@SD>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All these functions declares and initializes variable ret with
'0' and without modifying 'ret' variable, it is returned.

This patch removes this redundancy and returns '0' directly.

Signed-off-by: Saiyam Doshi <saiyamdoshi.in@gmail.com>
---
 sound/soc/codecs/wcd9335.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 03f8a94bba2f..f318403133e9 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -3022,7 +3022,6 @@ static int wcd9335_codec_enable_slim(struct snd_soc_dapm_widget *w,
 	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
 	struct wcd9335_codec *wcd = snd_soc_component_get_drvdata(comp);
 	struct wcd_slim_codec_dai_data *dai = &wcd->dai[w->shift];
-	int ret = 0;
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
@@ -3034,7 +3033,7 @@ static int wcd9335_codec_enable_slim(struct snd_soc_dapm_widget *w,
 		break;
 	}
 
-	return ret;
+	return 0;
 }
 
 static int wcd9335_codec_enable_mix_path(struct snd_soc_dapm_widget *w,
@@ -3539,7 +3538,6 @@ static int wcd9335_codec_hphl_dac_event(struct snd_soc_dapm_widget *w,
 	struct wcd9335_codec *wcd = dev_get_drvdata(comp->dev);
 	int hph_mode = wcd->hph_mode;
 	u8 dem_inp;
-	int ret = 0;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -3579,7 +3577,7 @@ static int wcd9335_codec_hphl_dac_event(struct snd_soc_dapm_widget *w,
 		break;
 	};
 
-	return ret;
+	return 0;
 }
 
 static int wcd9335_codec_lineout_dac_event(struct snd_soc_dapm_widget *w,
@@ -3607,7 +3605,6 @@ static int wcd9335_codec_ear_dac_event(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
 	struct wcd9335_codec *wcd = dev_get_drvdata(comp->dev);
-	int ret = 0;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -3621,7 +3618,7 @@ static int wcd9335_codec_ear_dac_event(struct snd_soc_dapm_widget *w,
 		break;
 	};
 
-	return ret;
+	return 0;
 }
 
 static void wcd9335_codec_hph_post_pa_config(struct wcd9335_codec *wcd,
@@ -3692,7 +3689,6 @@ static int wcd9335_codec_hphr_dac_event(struct snd_soc_dapm_widget *w,
 	struct wcd9335_codec *wcd = dev_get_drvdata(comp->dev);
 	int hph_mode = wcd->hph_mode;
 	u8 dem_inp;
-	int ret = 0;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -3731,7 +3727,7 @@ static int wcd9335_codec_hphr_dac_event(struct snd_soc_dapm_widget *w,
 		break;
 	};
 
-	return ret;
+	return 0;
 }
 
 static int wcd9335_codec_enable_hphl_pa(struct snd_soc_dapm_widget *w,
@@ -3741,7 +3737,6 @@ static int wcd9335_codec_enable_hphl_pa(struct snd_soc_dapm_widget *w,
 	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
 	struct wcd9335_codec *wcd = dev_get_drvdata(comp->dev);
 	int hph_mode = wcd->hph_mode;
-	int ret = 0;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -3780,7 +3775,7 @@ static int wcd9335_codec_enable_hphl_pa(struct snd_soc_dapm_widget *w,
 		break;
 	};
 
-	return ret;
+	return 0;
 }
 
 static int wcd9335_codec_enable_lineout_pa(struct snd_soc_dapm_widget *w,
@@ -3789,7 +3784,6 @@ static int wcd9335_codec_enable_lineout_pa(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
 	int vol_reg = 0, mix_vol_reg = 0;
-	int ret = 0;
 
 	if (w->reg == WCD9335_ANA_LO_1_2) {
 		if (w->shift == 7) {
@@ -3837,7 +3831,7 @@ static int wcd9335_codec_enable_lineout_pa(struct snd_soc_dapm_widget *w,
 		break;
 	};
 
-	return ret;
+	return 0;
 }
 
 static void wcd9335_codec_init_flyback(struct snd_soc_component *component)
@@ -3892,7 +3886,6 @@ static int wcd9335_codec_enable_hphr_pa(struct snd_soc_dapm_widget *w,
 	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
 	struct wcd9335_codec *wcd = dev_get_drvdata(comp->dev);
 	int hph_mode = wcd->hph_mode;
-	int ret = 0;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -3930,14 +3923,13 @@ static int wcd9335_codec_enable_hphr_pa(struct snd_soc_dapm_widget *w,
 		break;
 	};
 
-	return ret;
+	return 0;
 }
 
 static int wcd9335_codec_enable_ear_pa(struct snd_soc_dapm_widget *w,
 				       struct snd_kcontrol *kc, int event)
 {
 	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
-	int ret = 0;
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
@@ -3967,7 +3959,7 @@ static int wcd9335_codec_enable_ear_pa(struct snd_soc_dapm_widget *w,
 		break;
 	};
 
-	return ret;
+	return 0;
 }
 
 static irqreturn_t wcd9335_slimbus_irq(int irq, void *data)
-- 
2.20.1

