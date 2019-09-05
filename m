Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90C3C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B174822CEC
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DzwniM7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388971AbfIEMBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:01:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36129 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388932AbfIEMBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:01:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id y19so2468462wrd.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 05:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xyfe6twDn91vPCbiXX1zqgwt25Jhxxgzdbixh4MbER0=;
        b=DzwniM7S9e2dHldU3F+1DNyQh1GbrFBvALKFQRdXceZd7xAI6n3jUPUCOzCJ39+RDi
         J/h6MRpzGNtTE/lw14UHMVnmNAGdOEzU7cyD99NofWKpkbPsQOTE1+MDFwj25NmQc3aO
         W9KH3c2WRcRShGvbDNapGZ8QQDL4sFg+qd7j7Nzc514rBwmGbz2zA1L8LG/nLsogy/fA
         gbsccH4/iSxF0MbRsw1lImO1xy42xcxgf1z3Y5NcIUrEEWHcKDNlznQroP7+78TwZyWg
         d0nS6Jm0A0bQ3uda/ZmbM2ajPTylIKrRF9tkaXSX06wgn/nRJlzvISC8J8q1DNDX01Wb
         8kfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xyfe6twDn91vPCbiXX1zqgwt25Jhxxgzdbixh4MbER0=;
        b=LWUJUYSY78yidKBaWN0f1Dbct7PdRIG/FTZSGzh9u3JDPFlopkgBOu8YNJ3xDgMAmA
         2MO41PygUG7NScJMXEZ4T+VWFKuK1BETOkHYEacqkTFDZ7FJjWN8yXGiKCrkK5OCFFgU
         zuG5KVwOSlQ9bg22meBsKzGXzrQJRUHcBerFwJmObpbgpRn9lgLDQXmK53TqNDL2FoJc
         cdyWVCt+uo6bNMRPoyKKL7hrj5GWEKcATDZfBGaogJQpAPDahd937hPXV3X1Dw4t7PkS
         KIQx99DAaTPD7/X7hVtPyjPAKxuB8STbhlnJ3lRm6IHebKavtbhVizvIaD9yuhRG0jCg
         TQ1Q==
X-Gm-Message-State: APjAAAX5HKvxfEGfaQcvOa9lyuerF0i0FxdbZ8uYBlbArIXt5bwbI2BV
        hPScirdpbYbq1n1sejlj9secxA==
X-Google-Smtp-Source: APXvYqwctgVu4tqOBuDPlYOZXUwUpykru62hEl6KkwzhkUaceLyj2F4nPnNTNrghrllnO/9ig8jY8A==
X-Received: by 2002:a5d:4b41:: with SMTP id w1mr2142326wrs.23.1567684892350;
        Thu, 05 Sep 2019 05:01:32 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a18sm3436311wrh.25.2019.09.05.05.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 05:01:31 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 4/8] ASoC: meson: axg-toddr: expose all 8 inputs
Date:   Thu,  5 Sep 2019 14:01:16 +0200
Message-Id: <20190905120120.31752-5-jbrunet@baylibre.com>
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

The TODDR component, as it, has a maximum of 8 input. Depending on
the SoC, these may not all be connected or some input components may
not be supported

Instead of decribing only the connected inputs, describe them all
and let ASoC routing do the rest.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-toddr.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/meson/axg-toddr.c b/sound/soc/meson/axg-toddr.c
index 4f63e434fad4..2e9a2e5862ce 100644
--- a/sound/soc/meson/axg-toddr.c
+++ b/sound/soc/meson/axg-toddr.c
@@ -142,16 +142,11 @@ static struct snd_soc_dai_driver axg_toddr_dai_drv = {
 };
 
 static const char * const axg_toddr_sel_texts[] = {
-	"IN 0", "IN 1", "IN 2", "IN 3", "IN 4", "IN 6"
+	"IN 0", "IN 1", "IN 2", "IN 3", "IN 4", "IN 5", "IN 6", "IN 7"
 };
 
-static const unsigned int axg_toddr_sel_values[] = {
-	0, 1, 2, 3, 4, 6
-};
-
-static SOC_VALUE_ENUM_SINGLE_DECL(axg_toddr_sel_enum, FIFO_CTRL0,
-				  CTRL0_SEL_SHIFT, CTRL0_SEL_MASK,
-				  axg_toddr_sel_texts, axg_toddr_sel_values);
+static SOC_ENUM_SINGLE_DECL(axg_toddr_sel_enum, FIFO_CTRL0, CTRL0_SEL_SHIFT,
+			    axg_toddr_sel_texts);
 
 static const struct snd_kcontrol_new axg_toddr_in_mux =
 	SOC_DAPM_ENUM("Input Source", axg_toddr_sel_enum);
@@ -163,7 +158,9 @@ static const struct snd_soc_dapm_widget axg_toddr_dapm_widgets[] = {
 	SND_SOC_DAPM_AIF_IN("IN 2", NULL, 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("IN 3", NULL, 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("IN 4", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 5", NULL, 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("IN 6", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("IN 7", NULL, 0, SND_SOC_NOPM, 0, 0),
 };
 
 static const struct snd_soc_dapm_route axg_toddr_dapm_routes[] = {
@@ -173,7 +170,9 @@ static const struct snd_soc_dapm_route axg_toddr_dapm_routes[] = {
 	{ "SRC SEL", "IN 2", "IN 2" },
 	{ "SRC SEL", "IN 3", "IN 3" },
 	{ "SRC SEL", "IN 4", "IN 4" },
+	{ "SRC SEL", "IN 5", "IN 5" },
 	{ "SRC SEL", "IN 6", "IN 6" },
+	{ "SRC SEL", "IN 7", "IN 7" },
 };
 
 static const struct snd_soc_component_driver axg_toddr_component_drv = {
-- 
2.21.0

