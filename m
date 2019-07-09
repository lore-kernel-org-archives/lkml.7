Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42DFC73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88A92080C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sU5195Zy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbfGIShW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:37:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45479 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbfGIShW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:37:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id r1so9688549pfq.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 11:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=St7FhH/B2+2QgaaqOEQBdmC5rnxH6VjFL6gJzmS5t78=;
        b=sU5195Zy+46v8fdhHcGm6ZEuoHLruB9abDWcULfRtfkiyh6Rel3d/I0zTH7cHEv4wP
         8KARyhwvnDuxfsOPRDv1iq7YPCSVMm5bleuSwiaGyrcOf8IykUYsEHPZV5VhtEhhJopY
         RgMkap+TkVQHIKcy1R151Wvp1E0d0pilsZGHKdUoDNtxAAtg75gJq7rx5TcKkQl3leNP
         Kc+09sfa5b6WvMUfCi2GAPKFw/Znlxxu1x/CdMc9iDRJVLyZnVb9vSW5WftFnVGDNQiY
         arS1e16fRgVrukTkmjWwS52WqO3E8CJQCL2RrkZlx7RfVVDL4unn7I0eIqEEnj/mH9Cu
         gWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=St7FhH/B2+2QgaaqOEQBdmC5rnxH6VjFL6gJzmS5t78=;
        b=o3FSAnL0aGfOnzSNI18JQhIkSpDl+gALqhji6kYgkmqUeyZMquHBfof8PPqWxOlS/T
         aubPr37GhI0KTdE1uEC1NGpZn61Cn8+nNv1GJs0axXBXB3goRi+ovweb++VilMgjfjrW
         xDBCoPK1rRRVkc05jGjVScfrXxMxd7O6UndB9rKs0k4fX300xP+rVapbw6QnArOvE+NV
         YaPTPPu27NONDw7Cwc4d0dhEBIuA7X37mOyIH7IK5uO9BRvk1BBoLdsYJBTQJpNvA0pB
         67RGGPyLJaBsTka4F/1cgT24dEIXVkC6lr0WDVnC5x7d2tFhCN2Uy14DXkpUlpiawUNu
         XijQ==
X-Gm-Message-State: APjAAAVLwRyGv8I1qcDnWQXEM8RjDcjjSOCtDFN9pYwlX2kwbY4MGC+R
        NW1yHBmcly+fnBBCVO4hRto=
X-Google-Smtp-Source: APXvYqxNt5E/YYKAgEW1nfeuimILQx8tP1AR9k9ETZtDKUi2QI1/Dvs6glXpRmhRP9RSTge0M1Hqlg==
X-Received: by 2002:a17:90a:29c5:: with SMTP id h63mr1551874pjd.83.1562697441789;
        Tue, 09 Jul 2019 11:37:21 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id 65sm23755427pgf.30.2019.07.09.11.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 11:37:21 -0700 (PDT)
Date:   Wed, 10 Jul 2019 00:07:15 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Gen Zhang <blackgod016574@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sound: soc: codecs: wcd9335: fix Unneeded variable: "ret"
Message-ID: <20190709183715.GA7634@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this fixes below issues reported  by coccicheck
sound/soc/codecs/wcd9335.c:3611:5-8: Unneeded variable: "ret". Return
"0" on line 3625
sound/soc/codecs/wcd9335.c:3941:5-8: Unneeded variable: "ret". Return
"0" on line 3971
sound/soc/codecs/wcd9335.c:3745:5-8: Unneeded variable: "ret". Return
"0" on line 3784
sound/soc/codecs/wcd9335.c:3896:5-8: Unneeded variable: "ret". Return
"0" on line 3934
sound/soc/codecs/wcd9335.c:3026:5-8: Unneeded variable: "ret". Return
"0" on line 3038

We cannot change return of these functions as they are callback
functions.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 sound/soc/codecs/wcd9335.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 1bbbe42..e13af36 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -3018,7 +3018,6 @@ static int wcd9335_codec_enable_slim(struct snd_soc_dapm_widget *w,
 	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
 	struct wcd9335_codec *wcd = snd_soc_component_get_drvdata(comp);
 	struct wcd_slim_codec_dai_data *dai = &wcd->dai[w->shift];
-	int ret = 0;
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
@@ -3030,7 +3029,7 @@ static int wcd9335_codec_enable_slim(struct snd_soc_dapm_widget *w,
 		break;
 	}
 
-	return ret;
+	return 0;
 }
 
 static int wcd9335_codec_enable_mix_path(struct snd_soc_dapm_widget *w,
@@ -3603,7 +3602,6 @@ static int wcd9335_codec_ear_dac_event(struct snd_soc_dapm_widget *w,
 {
 	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
 	struct wcd9335_codec *wcd = dev_get_drvdata(comp->dev);
-	int ret = 0;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -3617,7 +3615,7 @@ static int wcd9335_codec_ear_dac_event(struct snd_soc_dapm_widget *w,
 		break;
 	};
 
-	return ret;
+	return 0;
 }
 
 static void wcd9335_codec_hph_post_pa_config(struct wcd9335_codec *wcd,
@@ -3737,7 +3735,6 @@ static int wcd9335_codec_enable_hphl_pa(struct snd_soc_dapm_widget *w,
 	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
 	struct wcd9335_codec *wcd = dev_get_drvdata(comp->dev);
 	int hph_mode = wcd->hph_mode;
-	int ret = 0;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -3776,7 +3773,7 @@ static int wcd9335_codec_enable_hphl_pa(struct snd_soc_dapm_widget *w,
 		break;
 	};
 
-	return ret;
+	return 0;
 }
 
 static int wcd9335_codec_enable_lineout_pa(struct snd_soc_dapm_widget *w,
@@ -3888,7 +3885,6 @@ static int wcd9335_codec_enable_hphr_pa(struct snd_soc_dapm_widget *w,
 	struct snd_soc_component *comp = snd_soc_dapm_to_component(w->dapm);
 	struct wcd9335_codec *wcd = dev_get_drvdata(comp->dev);
 	int hph_mode = wcd->hph_mode;
-	int ret = 0;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -3926,14 +3922,13 @@ static int wcd9335_codec_enable_hphr_pa(struct snd_soc_dapm_widget *w,
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
@@ -3963,7 +3958,7 @@ static int wcd9335_codec_enable_ear_pa(struct snd_soc_dapm_widget *w,
 		break;
 	};
 
-	return ret;
+	return 0;
 }
 
 static irqreturn_t wcd9335_slimbus_irq(int irq, void *data)
-- 
2.7.4

