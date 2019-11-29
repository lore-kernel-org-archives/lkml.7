Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A87C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 13:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2727920869
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 13:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="s9zfE0mZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfK2N13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 08:27:29 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45457 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfK2N12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 08:27:28 -0500
Received: by mail-wr1-f68.google.com with SMTP id j42so9344941wrj.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 05:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wLfDQ5ajtCtjsZut+MHDTVTGUfN92CA1VMVGdXe6/IY=;
        b=s9zfE0mZ46H/YCCF6SFMx+5kauV6ZRd5G/mkAxn2WUQ9jTi5/ICJ5UsjoHoaGzf0yt
         jICztwFjkmnOnPqaCM1Bofcnub9d9gBi8feCQ89IzLhHwezzaZrvWll2Kg3eZbKh3L2G
         QJo3cTnzarF65Hl+DfAIe41Doid3kjkXJULFBmzUcOW1juGWi7iPS1GG/PUovb4enixL
         uCELOoWEKc0QOjkHvHYvVj2GQrtAF1DiTAsxRShpfgDKDxV2LpEH4TQ2/vh7Ln5Oxcom
         U50W/UEB2WFlnp+fmicacfnyTc1ht0zbXtSu/wbQAJEdpjoey5NM0VM9DWbBGNOJF4/o
         suSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wLfDQ5ajtCtjsZut+MHDTVTGUfN92CA1VMVGdXe6/IY=;
        b=XIIA3ZOxQbJmzGaERcewdCgnQNsNscUvugQuvILvn6XV9EAD/WuTtRJuzcnEiu2lv/
         mnC9BW7Qz+xOgUm0Yxnt2EXgE4KD04r4OAaRu8kuNR9fCZ2fhZb7rlUer2+ApQcZ7e+Z
         ZEQu1DT6hvIi35mPGifVCDfDd0ly36/+MgAVzL/QxLZk5tlp3IP6YLF260UuaIFgtuZ8
         576q/lPyOmPtff+ZWSYHPdA19jkAXS0UssoRRSkKOXuwIxzmmv7UtHQ9Y7z7Kqjhiwi/
         itmyvRwbNPrzuM71ZvVUZcRdXsPphLkEOd3AcsyB8rekUbh2qnSlIgvTz14Eznh4ShYK
         4o8w==
X-Gm-Message-State: APjAAAX+YGyruCNmKEltS8SN7f2JSbck5xj+GAF9YzQnqxebFGJ+vDZr
        qD/mt0X3a5R3/iEd5TDq4tHn1w==
X-Google-Smtp-Source: APXvYqxFoXoj+7jxE3KhBSeo0GazT3SDB/RaZL6lwkxuZVlBQzZBqVBDBtYN+Vri/IDnNCJ4KoCg5w==
X-Received: by 2002:a5d:4602:: with SMTP id t2mr8447343wrq.37.1575034045218;
        Fri, 29 Nov 2019 05:27:25 -0800 (PST)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id x8sm27151530wrm.7.2019.11.29.05.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 05:27:24 -0800 (PST)
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
Subject: [PATCH] ASoC: tlv320aic31xx: Add Volume Soft Stepping control
Date:   Fri, 29 Nov 2019 16:27:19 +0300
Message-Id: <20191129132719.11603-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chip supports soft stepping of volume changes and it is enabled by
default.

This patch adds a control for it, so it could be either made slower
(two sample periods per step instead of one), or disabled.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 8 ++++++++
 sound/soc/codecs/tlv320aic31xx.h | 3 ---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index d6c462f21370..31daa60695bd 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -275,6 +275,12 @@ static const char * const hp_rampup_step_text[] = {
 static SOC_ENUM_SINGLE_DECL(hp_rampup_step_enum, AIC31XX_HPPOP, 1,
 	hp_rampup_step_text);
 
+static const char * const vol_soft_step_mode_text[] = {
+	"fast", "slow", "disabled" };
+
+static SOC_ENUM_SINGLE_DECL(vol_soft_step_mode_enum, AIC31XX_DACSETUP, 0,
+	vol_soft_step_mode_text);
+
 static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -6350, 50, 0);
 static const DECLARE_TLV_DB_SCALE(adc_fgain_tlv, 0, 10, 0);
 static const DECLARE_TLV_DB_SCALE(adc_cgain_tlv, -2000, 50, 0);
@@ -306,6 +312,8 @@ static const struct snd_kcontrol_new common31xx_snd_controls[] = {
 	 */
 	SOC_ENUM("HP Output Driver Power-On time", hp_poweron_time_enum),
 	SOC_ENUM("HP Output Driver Ramp-up step", hp_rampup_step_enum),
+
+	SOC_ENUM("Volume Soft Stepping", vol_soft_step_mode_enum),
 };
 
 static const struct snd_kcontrol_new aic31xx_snd_controls[] = {
diff --git a/sound/soc/codecs/tlv320aic31xx.h b/sound/soc/codecs/tlv320aic31xx.h
index 83a8c7604cc3..0523884cee74 100644
--- a/sound/soc/codecs/tlv320aic31xx.h
+++ b/sound/soc/codecs/tlv320aic31xx.h
@@ -218,9 +218,6 @@ struct aic31xx_pdata {
 #define AIC31XX_GPIO1_ADC_MOD_CLK	0x10
 #define AIC31XX_GPIO1_SDOUT		0x11
 
-/* AIC31XX_DACSETUP */
-#define AIC31XX_SOFTSTEP_MASK		GENMASK(1, 0)
-
 /* AIC31XX_DACMUTE */
 #define AIC31XX_DACMUTE_MASK		GENMASK(3, 2)
 
-- 
2.20.1

