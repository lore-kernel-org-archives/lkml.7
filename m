Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A9CC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 09:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C1021741
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 09:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="wFhcln6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfK1JkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 04:40:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41233 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfK1JkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 04:40:06 -0500
Received: by mail-wr1-f66.google.com with SMTP id b18so30240891wrj.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 01:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/JTPZnckyzjgJEzpIRleuMXljaM0DFNZiV1GxL/alt8=;
        b=wFhcln6M8qxf18N1O/bdB4MCLIw8mwWvsHlQJCgz+bkNzJ5TKu63c1aX109Yy0GTci
         Irrx9dzqltC3ArhPSav2bCyG0L+eTVr8lNvEhb7eNstKT1Zyj6Vc9n72zpeyKrJdsuS0
         6bYbohiwF0D4Vl946uBLeLqIgUKHQjlgG5kA6oD7Ei7DcjEJvpX9+Ay00ONY1aEShlSC
         KTTEmsZH71kbakbsWSd79pAft5+k/AYNVHNtgDoUV0e1awngaSdpRHINFE25dfQK3aLN
         5eYjABk8G7n617MEqZiStbaTxZqf77Q8SYETeUVVUFQv41pJIbTjQFqUi1jr13IUfzJ9
         rhug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/JTPZnckyzjgJEzpIRleuMXljaM0DFNZiV1GxL/alt8=;
        b=Z9goxiYMzH5sW+spAise0ymqUlXKiofQiAjPRPzXnB13gxl+tmODd8iJ6tCHAxjDsp
         WT37jvTf0y0TpVkKCZdz1ycfOYGUTv25Bht4JKnHlFZ4wi2fksmkwxSUe7JlWeNierQW
         00hTwg5y/tEgyTflqydDsGW+pZ0yV+HZWxpq4Qxy1TAJQZWDCSLheWss/uHmrWb2r6Fc
         nl+k+ozNeU1ODguRxLqU4l9lqG4g+QVstAySLwewkBzW62baFrBB8nWKmisHW9ha6HSN
         iOctGoQXWhkb3HqXnD9QzdW7hURH3SMUHcWjHDbvHRVRAgYIlo8SVIDvR433sM/70Ecx
         92+Q==
X-Gm-Message-State: APjAAAW9tJGvezOc9JUKeSjJ92ZaE6g79JmsfPXIqpkmsxLrki1S1yRZ
        r47Cgzp+1ywg8U514C+2X6YveQ==
X-Google-Smtp-Source: APXvYqwu1QjgKfwI4JCeQQx1SHzEZw7WIBYrq8BpklWehtaitBzDqcEh+OUYTfpGukVZw43XcCA6rw==
X-Received: by 2002:a05:6000:149:: with SMTP id r9mr7594495wrx.147.1574934004238;
        Thu, 28 Nov 2019 01:40:04 -0800 (PST)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id f6sm23073673wrr.15.2019.11.28.01.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 01:40:03 -0800 (PST)
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
Subject: [PATCH] ASoC: tlv320aic31xx: Add HP output driver pop reduction controls
Date:   Thu, 28 Nov 2019 12:39:55 +0300
Message-Id: <20191128093955.29567-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HP output driver has two parameters that can be configured to reduce
pop noise: power-on delay and ramp-up step time. Two new kcontrols
have been added to set these parameters.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 67323188afd2..740e75032f36 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -263,6 +263,19 @@ static SOC_ENUM_SINGLE_DECL(cm_m_enum, AIC31XX_MICPGAMI, 6, mic_select_text);
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
@@ -286,6 +299,9 @@ static const struct snd_kcontrol_new common31xx_snd_controls[] = {
 
 	SOC_DOUBLE_R_TLV("HP Analog Playback Volume", AIC31XX_LANALOGHPL,
 			 AIC31XX_RANALOGHPR, 0, 0x7F, 1, hp_vol_tlv),
+
+	SOC_ENUM("HP Output Driver Power-On time", hp_poweron_time_enum),
+	SOC_ENUM("HP Output Driver Ramp-up step", hp_rampup_step_enum),
 };
 
 static const struct snd_kcontrol_new aic31xx_snd_controls[] = {
-- 
2.20.1

