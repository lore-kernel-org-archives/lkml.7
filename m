Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60641C04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3515720675
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAtLPg50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbfESR5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:57:40 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43162 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbfESR50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:57:26 -0400
Received: by mail-ed1-f67.google.com with SMTP id w33so19916938edb.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 10:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YXXH5t9TTRLBW2BHaBe8u0lhH1b3Av66zK7Fxpl6yxw=;
        b=GAtLPg50hmCYoeXb6A/edx2LgTxQ/v0NLySw+fcbnq+PngK+PEo/XaGqJYs4qySqwO
         DkqVvZ4VXWp6RIt4YxpfT1rlxQkpfHr73Nl9cmLBOqYwNNkSupAoWeHqdhBJLboFwtRh
         bbaGetGNiFIgYyNZf03+hXl+rS7tAhj4a/XgwWwuUvBEeXDqNMVgRta7TCKqTeTrQhxI
         3X7PwVuHResA4PsbKM5I9K5e7DLEoWE/KwQ3k18ujyCVmbuBYUcgKH92RiiadDLDH8Wj
         +DRM8JFA3rkKxcdoBIQCbNNYSptSOnXyoAZNKTCdAAKtYZOU7BIeJsmUmygdICbbosp8
         YfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YXXH5t9TTRLBW2BHaBe8u0lhH1b3Av66zK7Fxpl6yxw=;
        b=j9BLKDnIsXZojvFiWDubCBT1RXkaAwhxNXx54bTfiipW+3ggnb4OlXwD/IOILLN5UB
         Yrcc18FNO2Cb/eYGhb/e7rDmGoTXDQ2fsrg8RQas4YB11rN/VaSziqcd4BU8SIzR2GpV
         CKJyuJPmmkmhTLlNFy3PkT54MiF78y0ypy4wiWnFOM/u6ACh+D5A0SaBXY5cjehBv7Xw
         Kb56n6Tawc8p7EgTVvWgys1F1eCaK8JeVF2mbZCCB1UjSc7nOslw/WkbPIGLYBaKfSjh
         g5Pk/xVzb1rxSu9VEuZhmr1NRaRMen2V6WYfzR1/ccvnX5yQ0C69E76uCVHw/ycxUAJE
         1o3w==
X-Gm-Message-State: APjAAAWXGrL7f3Oe5mlnwc6tVjCb8ugr+yWFuZ2Pb1NwOfjveBEXhvTv
        Oy/Y/Wdx1B5YMYUigxksVwc=
X-Google-Smtp-Source: APXvYqxWrIwrCTIPqJP+H56HIVs5ZNIE4+Jcq5Aw1EY+qIZZroKHkaH3M4jxWm5IplbffUqLP9WElg==
X-Received: by 2002:a17:906:5d12:: with SMTP id g18mr42455993ejt.286.1558288644893;
        Sun, 19 May 2019 10:57:24 -0700 (PDT)
Received: from elitebook-localhost (84-106-70-146.cable.dynamic.v4.ziggo.nl. [84.106.70.146])
        by smtp.gmail.com with ESMTPSA id o47sm4959975edc.37.2019.05.19.10.57.24
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 May 2019 10:57:24 -0700 (PDT)
From:   nariman <narimantos@gmail.com>
To:     broonie@kernel.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Jordy Ubink <jordyubink@hotmail.nl>,
        Nariman Etemadi <narimantos@gmail.com>
Subject: [PATCH] ASoC: Intel: bytcr_rt5651.c: remove string buffers 'byt_rt5651_cpu_dai_name' and 'byt_rt5651_cpu_dai_name'
Date:   Sun, 19 May 2019 19:57:06 +0200
Message-Id: <20190519175706.3998-4-narimantos@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190519175706.3998-1-narimantos@gmail.com>
References: <20190519175706.3998-1-narimantos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jordy Ubink <jordyubink@hotmail.nl>

The snprintf calls filling byt_rt5651_cpu_dai_name / byt_rt5651_cpu_dai_name always fill them with the same string (ssp0-port" resp "rt5651-aif2"). So instead of keeping these buffers around and making the cpu_dai_name / codec_dai_name point to this, simply update the foo_dai_name pointers to directly point to a string constant containing the desired string.

Signed-off-by: Jordy Ubink <jordyubink@hotmail.nl>
Signed-off-by: Nariman Etemadi <narimantos@gmail.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index e528995668b7..2e1bf43820d8 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -730,8 +730,6 @@ static struct snd_soc_dai_link byt_rt5651_dais[] = {
 
 /* SoC card */
 static char byt_rt5651_codec_name[SND_ACPI_I2C_ID_LEN];
-static char byt_rt5651_codec_aif_name[12]; /*  = "rt5651-aif[1|2]" */
-static char byt_rt5651_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
 static char byt_rt5651_long_name[50]; /* = "bytcr-rt5651-*-spk-*-mic[-swapped-hp]" */
 
 static int byt_rt5651_suspend(struct snd_soc_card *card)
@@ -1009,26 +1007,12 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	log_quirks(&pdev->dev);
 
 	if ((byt_rt5651_quirk & BYT_RT5651_SSP2_AIF2) ||
-	    (byt_rt5651_quirk & BYT_RT5651_SSP0_AIF2)) {
-		/* fixup codec aif name */
-		snprintf(byt_rt5651_codec_aif_name,
-			sizeof(byt_rt5651_codec_aif_name),
-			"%s", "rt5651-aif2");
-
-		byt_rt5651_dais[dai_index].codec_dai_name =
-			byt_rt5651_codec_aif_name;
-	}
+	    (byt_rt5651_quirk & BYT_RT5651_SSP0_AIF2))
+		byt_rt5651_dais[dai_index].codec_dai_name = "rt5651-aif2";
 
 	if ((byt_rt5651_quirk & BYT_RT5651_SSP0_AIF1) ||
-	    (byt_rt5651_quirk & BYT_RT5651_SSP0_AIF2)) {
-		/* fixup cpu dai name name */
-		snprintf(byt_rt5651_cpu_dai_name,
-			sizeof(byt_rt5651_cpu_dai_name),
-			"%s", "ssp0-port");
-
-		byt_rt5651_dais[dai_index].cpu_dai_name =
-			byt_rt5651_cpu_dai_name;
-	}
+	    (byt_rt5651_quirk & BYT_RT5651_SSP0_AIF2))
+		byt_rt5651_dais[dai_index].cpu_dai_name = "ssp0-port";
 
 	if (byt_rt5651_quirk & BYT_RT5651_MCLK_EN) {
 		priv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
-- 
2.20.1

