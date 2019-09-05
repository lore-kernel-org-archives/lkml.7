Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C1CC3A5AB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 04:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1019F20674
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 04:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UlWHaWw3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfIEEDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 00:03:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41228 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfIEEDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 00:03:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so615252pgg.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 21:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gzTkO0Rbhbc6qGDT4uIsvz+/20vaG5J88mBFRCtZ1I0=;
        b=UlWHaWw3ysvzZNAgX+b35OI9+m0ei8mMYZmwfZkhVK967RNE5uj2MIBkIHRATZ5esw
         qb2hPWTAVy6dFfKt9um30IWo4TxlIZ53AIWY/28YO0JO4StEDkqmHg80vf+RH6jcQLEz
         ZWb0ozANSR8EuLNR2PzNS6phOTLdfV9S/Q/P/YNrtoXg45wfaFcNPw+0BI/TIMwWp3WN
         kbyD3hUtDym4qEsogP3jw/HeyECxPiimveggDTcLyrotnFzwHZ7I9jVvypxJyOSQsYAS
         vX2rANBi1fBc+TFWVqqG5PhXk53W73VDFlESbnWLTqIV3+vpAm33Y01DXzE4l1o+yOkh
         G2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gzTkO0Rbhbc6qGDT4uIsvz+/20vaG5J88mBFRCtZ1I0=;
        b=Eo42yCIlBmCEqaEvoaM5bpWnpMs4WS8lod63pFcEFwVIFAmwLB2ajVYoLp+7/6v1g1
         ZfBtbGPncs0YnO5ewZURysv8cruxEFOat1Co+pDuZj62XZ69U1lJ0SDWHiCQIfaa/fhz
         jjU9qbkn7eIvaeRe7JgtSrPe1bbS1TUzqh+5Ao1Meg/iGzg/4Xdjp5rtSO0O4gFIuGCJ
         khzVFJge6CqHs1qMDl4PSEMJPoqvolInzwTfYxIuUX9468dLM3CyANrY2w1/NLMNUgF4
         PvngE9MtvAf6yhOgUQTRu0HhIMUjORhSi6LqoIUzEcOqH0GEkVh75LnEnpk1FXHG4FDC
         dfaQ==
X-Gm-Message-State: APjAAAVziQ+vmH2k31wFBsD7Udg6hCLKbbfOqPSukeXC6NHbP5pklSb/
        LLvR5QgS0wFnFXFl1mKbLTPDyQ==
X-Google-Smtp-Source: APXvYqyzIkvz0yA2lrEI0RaVsZGYFyE3s0khoYRmNK/psHtkaYkobCO80VWq1O/SIMOTnPn49zIaiQ==
X-Received: by 2002:aa7:8a13:: with SMTP id m19mr1324958pfa.228.1567656190065;
        Wed, 04 Sep 2019 21:03:10 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u9sm498058pjb.4.2019.09.04.21.03.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 21:03:09 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] ASoC: qcom: common: Include link-name in error messages
Date:   Wed,  4 Sep 2019 21:03:06 -0700
Message-Id: <20190905040306.21399-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading out the link-name earlier and including it in the various error
messages makes it much more convenient to figure out what links have
unmet dependencies.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 sound/soc/qcom/common.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index 2c7348ddbbb3..6c20bdd850f3 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -53,12 +53,18 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 		link->num_cpus		= 1;
 		link->num_platforms	= 1;
 
+		ret = of_property_read_string(np, "link-name", &link->name);
+		if (ret) {
+			dev_err(card->dev, "error getting codec dai_link name\n");
+			goto err;
+		}
+
 		cpu = of_get_child_by_name(np, "cpu");
 		platform = of_get_child_by_name(np, "platform");
 		codec = of_get_child_by_name(np, "codec");
 
 		if (!cpu) {
-			dev_err(dev, "Can't find cpu DT node\n");
+			dev_err(dev, "%s: Can't find cpu DT node\n", link->name);
 			ret = -EINVAL;
 			goto err;
 		}
@@ -66,7 +72,7 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 		ret = of_parse_phandle_with_args(cpu, "sound-dai",
 					"#sound-dai-cells", 0, &args);
 		if (ret) {
-			dev_err(card->dev, "error getting cpu phandle\n");
+			dev_err(card->dev, "%s: error getting cpu phandle\n", link->name);
 			goto err;
 		}
 		link->cpus->of_node = args.np;
@@ -74,7 +80,7 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 
 		ret = snd_soc_of_get_dai_name(cpu, &link->cpus->dai_name);
 		if (ret) {
-			dev_err(card->dev, "error getting cpu dai name\n");
+			dev_err(card->dev, "%s: error getting cpu dai name\n", link->name);
 			goto err;
 		}
 
@@ -83,14 +89,14 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 					"sound-dai",
 					0);
 			if (!link->platforms->of_node) {
-				dev_err(card->dev, "platform dai not found\n");
+				dev_err(card->dev, "%s: platform dai not found\n", link->name);
 				ret = -EINVAL;
 				goto err;
 			}
 
 			ret = snd_soc_of_get_dai_link_codecs(dev, codec, link);
 			if (ret < 0) {
-				dev_err(card->dev, "codec dai not found\n");
+				dev_err(card->dev, "%s: codec dai not found\n", link->name);
 				goto err;
 			}
 			link->no_pcm = 1;
@@ -110,12 +116,6 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 		}
 
 		link->ignore_suspend = 1;
-		ret = of_property_read_string(np, "link-name", &link->name);
-		if (ret) {
-			dev_err(card->dev, "error getting codec dai_link name\n");
-			goto err;
-		}
-
 		link->nonatomic = 1;
 		link->dpcm_playback = 1;
 		link->dpcm_capture = 1;
-- 
2.18.0

