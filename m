Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0613BC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19FE217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="QMBwExph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfK1Nyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:54:55 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52445 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfK1Nyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:54:55 -0500
Received: by mail-wm1-f68.google.com with SMTP id l1so11070238wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 05:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CAcvbytV4i2a1AoQdWPTiNmNKQ9t7p9KSzPJ6vzgFPc=;
        b=QMBwExphVxemOgnNlthrCN7d7TjJUTnBj6TFZ01UYgrmsdtrFkVTgNQ/Zi2/3ACcIq
         MPCvzCrDCSKSbGAIlSiuzm/9IxULCIaUciW2rDKc5/GughrDE761PaCJzeJ3o4DFyIN1
         u6Dk+3Z+zoHFjRUWPPL+xJXI/HnB8Dp3709yTU0b7PGkUQkdQThZA5kdg8KJgrw6g09+
         HSFXkXZClgDL0w5p1KmmVGklJE7ss8pTa94TOnp5uMpMlYnISTq3F1uaCZyzZK0kRDx2
         IP03p7J5zu8P02+fmdHuhBcC/2luiuieGYBDtDqWJt22FwqfAyeq4HSJ0PN4GnBMRv6k
         Q+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CAcvbytV4i2a1AoQdWPTiNmNKQ9t7p9KSzPJ6vzgFPc=;
        b=pLWhfd+wrLwD8FV4csru0gmMCwzfMrfoMvqNDwA6TaJ3w4oyrUn5ZO8JgY97GZXTDH
         X1aXInVm1IOUtV88i04I5s38S+DhNq/TDV1NKtmNajtz2WInYWD/F+LUaW/f2SYKQM5g
         WS0P8Pcv6yA4iFtjuXLIBMi+WR0E8KAXpes837sVlwJNHMQqS4meX+w0jiWtV4rMvTCV
         LVWNZvStwpIxho2dh/tSRVzy6hj9QJfndEQnE9nyOsf7TzpCDL9NCJs2J0e5X/t+lXci
         5wJ4DL7rgg9bPhrIGuByb8bVmKwurTpzYEo3CfuRC4UL1I/zYlHf38aoux8dAe1eW0If
         JmmQ==
X-Gm-Message-State: APjAAAVlBUQ7wUZNWeTDMWTZVFDVV2y9t1fVni+oY9VwZ+e6m871H295
        vS1rdr5mw/6uO2XR3iUG1RXfbA==
X-Google-Smtp-Source: APXvYqztu2661hM/tDpwiKNjROy9HqloK/NHG6y+VNcJz+qgtBkEj0z6E7TTM4iuyyiQM/oIV5bVQw==
X-Received: by 2002:a1c:2846:: with SMTP id o67mr9868162wmo.7.1574949292213;
        Thu, 28 Nov 2019 05:54:52 -0800 (PST)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id r2sm10960599wma.44.2019.11.28.05.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 05:54:51 -0800 (PST)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "Andrew F. Davis" <afd@ti.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH v2] ASoC: tlv320aic31xx: Add HP output driver pop reduction controls
Date:   Thu, 28 Nov 2019 16:54:47 +0300
Message-Id: <20191128135447.26458-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191128122337.GC4210@sirena.org.uk>
References: <20191128122337.GC4210@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HP output driver has two parameters that can be configured to reduce
pop noise: power-on delay and ramp-up step time. Two new kcontrols
have been added to set these parameters.

Also have to alter timeout in aic31xx_dapm_power_event() because default
timeout does fire when higher supported power-on delay are configured.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index f6f19fdc72f5..d6c462f21370 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -262,6 +262,19 @@ static SOC_ENUM_SINGLE_DECL(mic1lm_p_enum, AIC31XX_MICPGAPI, 2,
 static SOC_ENUM_SINGLE_DECL(mic1lm_m_enum, AIC31XX_MICPGAMI, 4,
 	mic_select_text);
 
+static const char * const hp_poweron_time_text[] = {
+	"0us", "15.3us", "153us", "1.53ms", "15.3ms", "76.2ms",
+	"153ms", "304ms", "610ms", "1.22s", "3.04s", "6.1s" };
+
+static SOC_ENUM_SINGLE_DECL(hp_poweron_time_enum, AIC31XX_HPPOP, 3,
+	hp_poweron_time_text);
+
+static const char * const hp_rampup_step_text[] = {
+	"0ms", "0.98ms", "1.95ms", "3.9ms" };
+
+static SOC_ENUM_SINGLE_DECL(hp_rampup_step_enum, AIC31XX_HPPOP, 1,
+	hp_rampup_step_text);
+
 static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -6350, 50, 0);
 static const DECLARE_TLV_DB_SCALE(adc_fgain_tlv, 0, 10, 0);
 static const DECLARE_TLV_DB_SCALE(adc_cgain_tlv, -2000, 50, 0);
@@ -285,6 +298,14 @@ static const struct snd_kcontrol_new common31xx_snd_controls[] = {
 
 	SOC_DOUBLE_R_TLV("HP Analog Playback Volume", AIC31XX_LANALOGHPL,
 			 AIC31XX_RANALOGHPR, 0, 0x7F, 1, hp_vol_tlv),
+
+	/* HP de-pop control: apply power not immediately but via ramp
+	 * function with these psarameters. Note that power up sequence
+	 * has to wait for this to complete; this is implemented by
+	 * polling HP driver status in aic31xx_dapm_power_event()
+	 */
+	SOC_ENUM("HP Output Driver Power-On time", hp_poweron_time_enum),
+	SOC_ENUM("HP Output Driver Ramp-up step", hp_rampup_step_enum),
 };
 
 static const struct snd_kcontrol_new aic31xx_snd_controls[] = {
@@ -357,6 +378,7 @@ static int aic31xx_dapm_power_event(struct snd_soc_dapm_widget *w,
 	struct aic31xx_priv *aic31xx = snd_soc_component_get_drvdata(component);
 	unsigned int reg = AIC31XX_DACFLAG1;
 	unsigned int mask;
+	unsigned int timeout = 500 * USEC_PER_MSEC;
 
 	switch (WIDGET_BIT(w->reg, w->shift)) {
 	case WIDGET_BIT(AIC31XX_DACSETUP, 7):
@@ -367,9 +389,13 @@ static int aic31xx_dapm_power_event(struct snd_soc_dapm_widget *w,
 		break;
 	case WIDGET_BIT(AIC31XX_HPDRIVER, 7):
 		mask = AIC31XX_HPLDRVPWRSTATUS_MASK;
+		if (event == SND_SOC_DAPM_POST_PMU)
+			timeout = 7 * USEC_PER_SEC;
 		break;
 	case WIDGET_BIT(AIC31XX_HPDRIVER, 6):
 		mask = AIC31XX_HPRDRVPWRSTATUS_MASK;
+		if (event == SND_SOC_DAPM_POST_PMU)
+			timeout = 7 * USEC_PER_SEC;
 		break;
 	case WIDGET_BIT(AIC31XX_SPKAMP, 7):
 		mask = AIC31XX_SPLDRVPWRSTATUS_MASK;
@@ -389,9 +415,11 @@ static int aic31xx_dapm_power_event(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-		return aic31xx_wait_bits(aic31xx, reg, mask, mask, 5000, 100);
+		return aic31xx_wait_bits(aic31xx, reg, mask, mask,
+				5000, timeout / 5000);
 	case SND_SOC_DAPM_POST_PMD:
-		return aic31xx_wait_bits(aic31xx, reg, mask, 0, 5000, 100);
+		return aic31xx_wait_bits(aic31xx, reg, mask, 0,
+				5000, timeout / 5000);
 	default:
 		dev_dbg(component->dev,
 			"Unhandled dapm widget event %d from %s\n",
-- 
2.20.1

