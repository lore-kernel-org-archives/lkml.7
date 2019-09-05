Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89419C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5981822CF5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hEH6ZzUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388950AbfIEMBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:01:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37150 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388920AbfIEMBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:01:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id i1so1872695wro.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 05:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cj+xRSKwyNiG3WxbYk3EzxKZy6mBMzhtFu6vqSlSsIE=;
        b=hEH6ZzULAcBUkR1Q6yIgBkAgn6572zSGLcHJzNX9o8GjeGom1qFmNHgIUE+FCVzH6m
         elgPgQsnkhGo7fWdGYHoiHnZtTDhBEVKxW722L5mrvmRjc73MzbyGD9yxrlHw7um4D0w
         WQqZ3yZk2Y0t8lg3+G1WHbyiXLfkYvCI5LMVHIuYQkIIojDtzaQML0pvjI+xGoe01mXg
         WgXNYc6VkUeNuo7wsCPWuH0wlvt1OZfepRl3qLGy1TO2nEkkumLhYUqr+NIHmiBRoZAV
         bINPVS81H26mFy0xV/bkolv4SWJdI7dbTkf5d1xOqwojLzDUdNDSH+NSvE3Oq5uF3Zxl
         KMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cj+xRSKwyNiG3WxbYk3EzxKZy6mBMzhtFu6vqSlSsIE=;
        b=qMg5SmMKlC0v9E9zHiHP4cPd/XITL8dd8P1HNcMbFoLnNEk/QnMruMUs/iggsbWk/J
         YQ45tURGfnP0gU4W1ZD97/F3yVSjtgfKBcV+uo8owqA92vU59cYodvPI8Ae8eV9N7dN0
         1eye6LGLDoPh+iigIiti4Vz7YJV8KTzDe9lknkPJ85YkRSCHx/GSFIoUafRSQQADm4a4
         SykNVKFX242D+AKcW/U4RC6Pw2nzW8qz/ne2RxLMkywIZok+OZnzAz4HPwFFwDnCJEQm
         F1j78qne0ufsEUZQIxiULAkg5ETJaTzT3/EdPMXwQQWbGCUjQ70QcnZ/eT7liIHKCqpP
         k6ug==
X-Gm-Message-State: APjAAAXf36hLKp8lOj4VY+XjUNN7KHR6UgQpIMYMTFM0qUn8gY5qQUFC
        44Sk/K98cHyMZQ9eza1oHE8DUg==
X-Google-Smtp-Source: APXvYqziOr8Gaxr0aNjdG/0c+A5ueIJxf7uLcnCfDDYrzhPawEingY+F6Xn70XqHUHjwCEKumyPZiA==
X-Received: by 2002:adf:f7c7:: with SMTP id a7mr2255564wrq.273.1567684891412;
        Thu, 05 Sep 2019 05:01:31 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a18sm3436311wrh.25.2019.09.05.05.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 05:01:30 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 3/8] ASoC: meson: axg-frddr: expose all 8 outputs
Date:   Thu,  5 Sep 2019 14:01:15 +0200
Message-Id: <20190905120120.31752-4-jbrunet@baylibre.com>
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

The FRDDR component, as it, has a maximum of 8 outputs. Depending on
the SoC, these may not all be connected.

Instead of decribing only the connected outputs of each SoC, describe
them all and let ASoC routing do the rest.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-frddr.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/sound/soc/meson/axg-frddr.c b/sound/soc/meson/axg-frddr.c
index 2b8807737b2b..0968e8375000 100644
--- a/sound/soc/meson/axg-frddr.c
+++ b/sound/soc/meson/axg-frddr.c
@@ -104,7 +104,7 @@ static struct snd_soc_dai_driver axg_frddr_dai_drv = {
 };
 
 static const char * const axg_frddr_sel_texts[] = {
-	"OUT 0", "OUT 1", "OUT 2", "OUT 3"
+	"OUT 0", "OUT 1", "OUT 2", "OUT 3", "OUT 4", "OUT 5", "OUT 6", "OUT 7",
 };
 
 static SOC_ENUM_SINGLE_DECL(axg_frddr_sel_enum, FIFO_CTRL0, CTRL0_SEL_SHIFT,
@@ -120,6 +120,10 @@ static const struct snd_soc_dapm_widget axg_frddr_dapm_widgets[] = {
 	SND_SOC_DAPM_AIF_OUT("OUT 1", NULL, 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("OUT 2", NULL, 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("OUT 3", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("OUT 4", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("OUT 5", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("OUT 6", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("OUT 7", NULL, 0, SND_SOC_NOPM, 0, 0),
 };
 
 static const struct snd_soc_dapm_route axg_frddr_dapm_routes[] = {
@@ -128,6 +132,10 @@ static const struct snd_soc_dapm_route axg_frddr_dapm_routes[] = {
 	{ "OUT 1", "OUT 1",  "SINK SEL" },
 	{ "OUT 2", "OUT 2",  "SINK SEL" },
 	{ "OUT 3", "OUT 3",  "SINK SEL" },
+	{ "OUT 4", "OUT 4",  "SINK SEL" },
+	{ "OUT 5", "OUT 5",  "SINK SEL" },
+	{ "OUT 6", "OUT 6",  "SINK SEL" },
+	{ "OUT 7", "OUT 7",  "SINK SEL" },
 };
 
 static const struct snd_soc_component_driver axg_frddr_component_drv = {
@@ -162,16 +170,12 @@ static struct snd_soc_dai_driver g12a_frddr_dai_drv = {
 	.pcm_new	= axg_frddr_pcm_new,
 };
 
-static const char * const g12a_frddr_sel_texts[] = {
-	"OUT 0", "OUT 1", "OUT 2", "OUT 3", "OUT 4",
-};
-
 static SOC_ENUM_SINGLE_DECL(g12a_frddr_sel1_enum, FIFO_CTRL0, CTRL0_SEL_SHIFT,
-			    g12a_frddr_sel_texts);
+			    axg_frddr_sel_texts);
 static SOC_ENUM_SINGLE_DECL(g12a_frddr_sel2_enum, FIFO_CTRL0, CTRL0_SEL2_SHIFT,
-			    g12a_frddr_sel_texts);
+			    axg_frddr_sel_texts);
 static SOC_ENUM_SINGLE_DECL(g12a_frddr_sel3_enum, FIFO_CTRL0, CTRL0_SEL3_SHIFT,
-			    g12a_frddr_sel_texts);
+			    axg_frddr_sel_texts);
 
 static const struct snd_kcontrol_new g12a_frddr_out1_demux =
 	SOC_DAPM_ENUM("Output Src 1", g12a_frddr_sel1_enum);
@@ -211,6 +215,9 @@ static const struct snd_soc_dapm_widget g12a_frddr_dapm_widgets[] = {
 	SND_SOC_DAPM_AIF_OUT("OUT 2", NULL, 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("OUT 3", NULL, 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_OUT("OUT 4", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("OUT 5", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("OUT 6", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("OUT 7", NULL, 0, SND_SOC_NOPM, 0, 0),
 };
 
 static const struct snd_soc_dapm_route g12a_frddr_dapm_routes[] = {
@@ -228,16 +235,25 @@ static const struct snd_soc_dapm_route g12a_frddr_dapm_routes[] = {
 	{ "OUT 2", "OUT 2", "SINK 1 SEL" },
 	{ "OUT 3", "OUT 3", "SINK 1 SEL" },
 	{ "OUT 4", "OUT 4", "SINK 1 SEL" },
+	{ "OUT 5", "OUT 5", "SINK 1 SEL" },
+	{ "OUT 6", "OUT 6", "SINK 1 SEL" },
+	{ "OUT 7", "OUT 7", "SINK 1 SEL" },
 	{ "OUT 0", "OUT 0", "SINK 2 SEL" },
 	{ "OUT 1", "OUT 1", "SINK 2 SEL" },
 	{ "OUT 2", "OUT 2", "SINK 2 SEL" },
 	{ "OUT 3", "OUT 3", "SINK 2 SEL" },
 	{ "OUT 4", "OUT 4", "SINK 2 SEL" },
+	{ "OUT 5", "OUT 5", "SINK 2 SEL" },
+	{ "OUT 6", "OUT 6", "SINK 2 SEL" },
+	{ "OUT 7", "OUT 7", "SINK 2 SEL" },
 	{ "OUT 0", "OUT 0", "SINK 3 SEL" },
 	{ "OUT 1", "OUT 1", "SINK 3 SEL" },
 	{ "OUT 2", "OUT 2", "SINK 3 SEL" },
 	{ "OUT 3", "OUT 3", "SINK 3 SEL" },
 	{ "OUT 4", "OUT 4", "SINK 3 SEL" },
+	{ "OUT 5", "OUT 5", "SINK 3 SEL" },
+	{ "OUT 6", "OUT 6", "SINK 3 SEL" },
+	{ "OUT 7", "OUT 7", "SINK 3 SEL" },
 };
 
 static const struct snd_soc_component_driver g12a_frddr_component_drv = {
-- 
2.21.0

