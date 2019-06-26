Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C525C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3A1216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TWguFFAX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfFZNgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:36:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45626 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfFZNgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:36:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id f9so2748161wre.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 06:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T7ZRClmFeqyZ4D18CQN6W27UJDdTkTXzm4pfq532FJg=;
        b=TWguFFAXrPN64W+X4eBYlZPZH2QrZ3RtaEk2RtjrznN+tIo2MHrKBmJuHOYO0Uxo82
         CFP2HHb8vbibDiKipegaJwcQALrm2NrxCXayWfVXmKAcXmPvc89FzlJn27GwnE9dp9Jn
         TOmD7Y531MOUW4bMYKxXAlil3CTluuV2QY2Ocwu8EhCb9Ddn60MQ4rZjV5KStJJJZEny
         g1ynMXpyyM6tb5symDm+PSC0EgIq5hVwtlbTPNM1Yc333p5mIi/fL9jVfe4gbsAqYZDn
         xi7Sho9UEBe6Y+B41ZD6Fh4xckuLJjEvfvy8pec2lLenRMJaJVqr9uOUMwAgWUFtQMv5
         uFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T7ZRClmFeqyZ4D18CQN6W27UJDdTkTXzm4pfq532FJg=;
        b=mYsxp0gRAp9VRGqzPuGf9o7cphw5Ol40WY9oJJsGqAgLO181BYhwui2+EVVuoOkALD
         lvu6zSiTIWSa05o6ZtFelOfkS89meA2AKOYbSdFI3j2IckA8iTFaHXzzi8kmWw9dbCDi
         wiI0z//IIXqlQxnih0WBaKtBMoVT3xeIntvYDJ9B+RZPFeMwWo71x0MTVI4ci8/xl2V+
         a72kRVa+eW68Irq2+QamBq6iWM75Gea99vnirb6nF7xhpQp/WJKtjvTWB8uolqBC7CBd
         1j/s+GqTuLHVO+HdMW820qV16I8dBF7PHHKC71PLcJcKQxidVgBfDtvicoUwDT8irmxj
         5U4g==
X-Gm-Message-State: APjAAAU/Loag1GtlSFmVS+OLuZ1I2iXyJWucV3kiENE0Tgb4W7RxHe4h
        NvifZPZolw2uyI2be81JaLDWNQ==
X-Google-Smtp-Source: APXvYqyQoNCoBKyM9obg5usRFdzjH1ex5bqDtX67GdFzjV+14hTLDxL2tfEZx8cpYrkZQuJiZNlvnw==
X-Received: by 2002:a5d:4949:: with SMTP id r9mr3595411wrs.289.1561556196920;
        Wed, 26 Jun 2019 06:36:36 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id w185sm2877880wma.39.2019.06.26.06.36.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 06:36:36 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 2/2] ASoC: soc-core: support dai_link with platforms_num != 1
Date:   Wed, 26 Jun 2019 15:36:17 +0200
Message-Id: <20190626133617.25959-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626133617.25959-1-jbrunet@baylibre.com>
References: <20190626133617.25959-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support platforms_num != 1 in dai_link. Initially, the main purpose of
this change was to make the platform optional in the dai_link, instead of
inserting the dummy platform driver.

This particular case had just been solved by Kuninori Morimoto with
commit 1d7689892878 ("ASoC: soc-core: allow no Platform on dai_link").

However, this change may still be useful for those who need multiple
platform components on a single dai_link (it solves one of the FIXME
note in soc-core)

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 include/sound/soc.h  |  6 ++++
 sound/soc/soc-core.c | 66 +++++++++++++++++++-------------------------
 2 files changed, 34 insertions(+), 38 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 64405cdab8bb..4e8071269639 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -997,6 +997,12 @@ struct snd_soc_dai_link {
 	     ((i) < link->num_codecs) && ((codec) = &link->codecs[i]);	\
 	     (i)++)
 
+#define for_each_link_platforms(link, i, platform)			\
+	for ((i) = 0;							\
+	     ((i) < link->num_platforms) &&				\
+	     ((platform) = &link->platforms[i]);			\
+	     (i)++)
+
 /*
  * Sample 1 : Single CPU/Codec/Platform
  *
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 002ddbf4e5a3..3053a4a461b3 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -887,7 +887,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 	struct snd_soc_dai_link *dai_link)
 {
 	struct snd_soc_pcm_runtime *rtd;
-	struct snd_soc_dai_link_component *codecs;
+	struct snd_soc_dai_link_component *dlc;
 	struct snd_soc_component *component;
 	int i;
 
@@ -917,13 +917,14 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 
 	/* Find CODEC from registered CODECs */
 	rtd->num_codecs = dai_link->num_codecs;
-	for_each_link_codecs(dai_link, i, codecs) {
-		rtd->codec_dais[i] = snd_soc_find_dai(codecs);
+	for_each_link_codecs(dai_link, i, dlc) {
+		rtd->codec_dais[i] = snd_soc_find_dai(dlc);
 		if (!rtd->codec_dais[i]) {
 			dev_info(card->dev, "ASoC: CODEC DAI %s not registered\n",
-				 codecs->dai_name);
+				 dlc->dai_name);
 			goto _err_defer;
 		}
+
 		snd_soc_rtdcom_add(rtd, rtd->codec_dais[i]->component);
 	}
 
@@ -931,12 +932,13 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 	rtd->codec_dai = rtd->codec_dais[0];
 
 	/* Find PLATFORM from registered PLATFORMs */
-	for_each_component(component) {
-		if (!snd_soc_is_matching_component(dai_link->platforms,
-						   component))
-			continue;
+	for_each_link_platforms(dai_link, i, dlc) {
+		for_each_component(component) {
+			if (!snd_soc_is_matching_component(dlc, component))
+				continue;
 
-		snd_soc_rtdcom_add(rtd, component);
+			snd_soc_rtdcom_add(rtd, component);
+		}
 	}
 
 	soc_add_pcm_runtime(card, rtd);
@@ -1051,22 +1053,22 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 			     struct snd_soc_dai_link *link)
 {
 	int i;
-	struct snd_soc_dai_link_component *codec;
+	struct snd_soc_dai_link_component *dlc;
 
-	for_each_link_codecs(link, i, codec) {
+	for_each_link_codecs(link, i, dlc) {
 		/*
 		 * Codec must be specified by 1 of name or OF node,
 		 * not both or neither.
 		 */
-		if (!!codec->name ==
-		    !!codec->of_node) {
+		if (!!dlc->name ==
+		    !!dlc->of_node) {
 			dev_err(card->dev, "ASoC: Neither/both codec name/of_node are set for %s\n",
 				link->name);
 			return -EINVAL;
 		}
 
 		/* Codec DAI name must be specified */
-		if (!codec->dai_name) {
+		if (!dlc->dai_name) {
 			dev_err(card->dev, "ASoC: codec_dai_name not set for %s\n",
 				link->name);
 			return -EINVAL;
@@ -1076,40 +1078,28 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 		 * Defer card registartion if codec component is not added to
 		 * component list.
 		 */
-		if (!soc_find_component(codec))
+		if (!soc_find_component(dlc))
 			return -EPROBE_DEFER;
 	}
 
-	/*
-	 * Platform may be specified by either name or OF node,
-	 * or no Platform.
-	 *
-	 * FIXME
-	 *
-	 * We need multi-platform support
-	 */
-	if (link->num_platforms > 0) {
-
-		if (link->num_platforms > 1) {
-			dev_err(card->dev,
-				"ASoC: multi platform is not yet supported %s\n",
-				link->name);
-			return -EINVAL;
-		}
-
-		if (link->platforms->name && link->platforms->of_node) {
+	for_each_link_platforms(link, i, dlc) {
+		/*
+		 * Platform may be specified by either name or OF node, but it
+		 * can be left unspecified, then no components will be inserted
+		 * in the rtdcom list
+		 */
+		if (!!dlc->name == !!dlc->of_node) {
 			dev_err(card->dev,
-				"ASoC: Both platform name/of_node are set for %s\n",
+				"ASoC: Neither/both platform name/of_node are set for %s\n",
 				link->name);
 			return -EINVAL;
 		}
 
 		/*
-		 * Defer card registartion if platform dai component is not
-		 * added to component list.
+		 * Defer card registartion if platform component is not added to
+		 * component list.
 		 */
-		if ((link->platforms->of_node || link->platforms->name) &&
-		    !soc_find_component(link->platforms))
+		if (!soc_find_component(dlc))
 			return -EPROBE_DEFER;
 	}
 
-- 
2.21.0

