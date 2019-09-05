Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,UPPERCASE_50_75,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33AAC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C198D23404
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bZvoaN8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388984AbfIEMBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:01:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42977 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388947AbfIEMBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:01:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id q14so2432319wrm.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 05:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cwIBL4UHh/W/g2VGAibAzry/ewI4tWE5Tv7d1Udm+yA=;
        b=bZvoaN8kfBlJr557WiU4RA17OFezviTWtWGEFddijqdVU2icYp6sMDiTVcTPidBX6c
         DIHAjpnJAcmHLrnFZ4SCWBMqfwSNPA1NnA8yl0ZoteP+Zw3TZFXQGtUBrwx/4WesE+ip
         K8l5xpQwNjyH09ZncYod4oeArbPlGvBNbiIXyi5cGMRqHo3u0Qd31ig+LcKga4Rzr7Pk
         mtgMJjp93GlGrUngM0v5BNPOMf2LjPL6qDKxbbHIJtr/esoKcy52bXW8876IpwjJTxqJ
         2BkskNQ5IFxJNz6/DDQ/AwsWzTzwYmMq/0HNCUujKTaVPdYEM0CUmRBMVYJGBRzPu0Ym
         hDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cwIBL4UHh/W/g2VGAibAzry/ewI4tWE5Tv7d1Udm+yA=;
        b=bbqXEWsDuqdbjDLbHgUTFfWQzbmw2pb1diqwrm8GlGf068qyjTPOGdpOAabg1elvg6
         sRPOsgUnuxLMM+eHkGc5/s5lxX5a1+SsO3iZRaYFwjhLwZIhZ5befZ9B5zpnVbURNNAR
         b+oyG5DByw7msM/7fIS8wvzLi9az7oXuiba1fhyHE1VYeddW37Cj6jp/lGlLmAb5Et/T
         OQYre4XjSX373JN5CbWx6JqajDCdrtafRsznitACo6pXiqkKlkaTBgOprxmHvrQt/N5C
         c7jjAdbZwugpJecXJAem9sIkUiZAcvQHtEOKMp/D43EtZo7Hu7FqbVRzKOjNT5kwZQb5
         kaew==
X-Gm-Message-State: APjAAAUNIbbhcMmd53wqSsIHHLKqQQ+Dxkcq4ZTl8LF2A2oBNcNFMGXR
        vn3hwyz+ZZP4EliOjdRlWJgkGg==
X-Google-Smtp-Source: APXvYqzwbqkVLLSjcIoOrfnAmDwBx+OFVpJhIzJAo2/JMbRNzWLPcZyCMfUZhDW8FQH66JXu0xVWRQ==
X-Received: by 2002:a05:6000:128d:: with SMTP id f13mr2430516wrx.241.1567684893278;
        Thu, 05 Sep 2019 05:01:33 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a18sm3436311wrh.25.2019.09.05.05.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 05:01:32 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 5/8] ASoC: meson: tdmin: expose all 16 inputs
Date:   Thu,  5 Sep 2019 14:01:17 +0200
Message-Id: <20190905120120.31752-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190905120120.31752-1-jbrunet@baylibre.com>
References: <20190905120120.31752-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TDMIN component, as it, has a maximum of 16 input. Depending on
the SoC, these may not all be connected.

Instead of decribing only the connected inputs of each SoC, describe
them all and let ASoC routing do the rest.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-tdmin.c | 47 +++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/sound/soc/meson/axg-tdmin.c b/sound/soc/meson/axg-tdmin.c
index cb87f17f3e95..973d4c02ef8d 100644
--- a/sound/soc/meson/axg-tdmin.c
+++ b/sound/soc/meson/axg-tdmin.c
@@ -43,7 +43,8 @@ static const struct regmap_config axg_tdmin_regmap_cfg = {
 };
 
 static const char * const axg_tdmin_sel_texts[] = {
-	"IN 0", "IN 1", "IN 2", "IN 3", "IN 4", "IN 5",
+	"IN 0", "IN 1", "IN 2",  "IN 3",  "IN 4",  "IN 5",  "IN 6",  "IN 7",
+	"IN 8", "IN 9", "IN 10", "IN 11", "IN 12", "IN 13", "IN 14", "IN 15",
 };
 
 /* Change to special mux control to reset dapm */
@@ -164,12 +165,22 @@ static int axg_tdmin_prepare(struct regmap *map,
 }
 
 static const struct snd_soc_dapm_widget axg_tdmin_dapm_widgets[] = {
-	SND_SOC_DAPM_AIF_IN("IN 0", NULL, 0, SND_SOC_NOPM, 0, 0),
-	SND_SOC_DAPM_AIF_IN("IN 1", NULL, 0, SND_SOC_NOPM, 0, 0),
-	SND_SOC_DAPM_AIF_IN("IN 2", NULL, 0, SND_SOC_NOPM, 0, 0),
-	SND_SOC_DAPM_AIF_IN("IN 3", NULL, 0, SND_SOC_NOPM, 0, 0),
-	SND_SOC_DAPM_AIF_IN("IN 4", NULL, 0, SND_SOC_NOPM, 0, 0),
-	SND_SOC_DAPM_AIF_IN("IN 5", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 0",  NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 1",  NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 2",  NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 3",  NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 4",  NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 5",  NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 6",  NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 7",  NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 8",  NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 9",  NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 10", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 11", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 12", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 13", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 14", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 15", NULL, 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_MUX("SRC SEL", SND_SOC_NOPM, 0, 0, &axg_tdmin_in_mux),
 	SND_SOC_DAPM_PGA_E("DEC", SND_SOC_NOPM, 0, 0, NULL, 0,
 			   axg_tdm_formatter_event,
@@ -178,12 +189,22 @@ static const struct snd_soc_dapm_widget axg_tdmin_dapm_widgets[] = {
 };
 
 static const struct snd_soc_dapm_route axg_tdmin_dapm_routes[] = {
-	{ "SRC SEL", "IN 0", "IN 0" },
-	{ "SRC SEL", "IN 1", "IN 1" },
-	{ "SRC SEL", "IN 2", "IN 2" },
-	{ "SRC SEL", "IN 3", "IN 3" },
-	{ "SRC SEL", "IN 4", "IN 4" },
-	{ "SRC SEL", "IN 5", "IN 5" },
+	{ "SRC SEL", "IN 0",  "IN 0" },
+	{ "SRC SEL", "IN 1",  "IN 1" },
+	{ "SRC SEL", "IN 2",  "IN 2" },
+	{ "SRC SEL", "IN 3",  "IN 3" },
+	{ "SRC SEL", "IN 4",  "IN 4" },
+	{ "SRC SEL", "IN 5",  "IN 5" },
+	{ "SRC SEL", "IN 6",  "IN 6" },
+	{ "SRC SEL", "IN 7",  "IN 7" },
+	{ "SRC SEL", "IN 8",  "IN 8" },
+	{ "SRC SEL", "IN 9",  "IN 9" },
+	{ "SRC SEL", "IN 10", "IN 10" },
+	{ "SRC SEL", "IN 11", "IN 11" },
+	{ "SRC SEL", "IN 12", "IN 12" },
+	{ "SRC SEL", "IN 13", "IN 13" },
+	{ "SRC SEL", "IN 14", "IN 14" },
+	{ "SRC SEL", "IN 15", "IN 15" },
 	{ "DEC", NULL, "SRC SEL" },
 	{ "OUT", NULL, "DEC" },
 };
-- 
2.21.0

