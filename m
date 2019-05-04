Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F10C04AA9
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 15:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957B5206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 15:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lust9394"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfEDPRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 11:17:08 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35852 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfEDPRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 11:17:05 -0400
Received: by mail-ed1-f67.google.com with SMTP id a8so9718258edx.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 08:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eVaNiZEHc2WcLQetcZoCKC6E7inFmZ0Pm/1lAy3U6IQ=;
        b=lust9394uk9VsG0Af6ixeNW7Ob8Y4vrJJbdXC0+Iz6YUJM2pFZz5fdUE3ZUf/dUZRS
         258q1s8zOau8xZFmjfqsexI66BrPIQnJhr3KMpu6KjXwhU260OS08iBj8RVzzM/UmkVL
         KHnF7+YdzH8mMcxykyLrVlI00WT0ZMIjocPqbkAL12+JMv1O1XLx/guD5xeWUDWFi1aC
         tLYAU+cx5cOt1L4gGVkLrgdC54ecQW83nn90RIFMI8CddXjJSsVrdWuPRYxU2J0I8ai1
         NLwtKehhdv2w4k9SqtGVpKIhu3vBAY2sp7w6mZnweCDEb3wNSXmDK0F/9fl/sKPYCBJS
         hayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eVaNiZEHc2WcLQetcZoCKC6E7inFmZ0Pm/1lAy3U6IQ=;
        b=XR60Te8eMoaa1OEu8Pp7OSO5FzEG3M0P5JXY+shmbpY4jYCeRBRBjUAVzDFaaVrFEd
         sMPF3wCLrvyaS36H62CrgxonbRMUY9c/thobzapMBGCZ/c+C7iH2pNCr5Z2NhRyEBsa1
         hgCiguYZGAwnjQo16EwEpmsIv+D++/RNSlgGCRIqYfGF5DrdN8zEnqKidT+G0hYxW3Kp
         7uzZZmKBAaP4+UFkPfPCuX1K0dXoEcimCZ5Q3nIq3BMX80OsckR+ukBpwpJMWqaSQnXq
         wp9zL8zimJmmCb3+l0wxHxpqMeoq9L/0meeXY2hOLFWU4N0tznUGgUmh7Z0TSRFfDujK
         w7rA==
X-Gm-Message-State: APjAAAX70WIDfrhXv+H+UgcIRMQ8ClPC6dGY9gozS1GV2n1RBt6XRL9/
        bGGkHgs5rnK0kYHaSgjN8ZA=
X-Google-Smtp-Source: APXvYqyjUMC5lD1Ttz9DnqsIcJ7TsmGtzUtIugjLV+/qjipULhLu9wXCxDrKuT4+m1zJljEJdgNsyQ==
X-Received: by 2002:a17:906:c52:: with SMTP id t18mr11359001ejf.53.1556983023082;
        Sat, 04 May 2019 08:17:03 -0700 (PDT)
Received: from elitebook-localhost (84-106-70-146.cable.dynamic.v4.ziggo.nl. [84.106.70.146])
        by smtp.gmail.com with ESMTPSA id x44sm1438747edb.51.2019.05.04.08.17.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 04 May 2019 08:17:02 -0700 (PDT)
From:   Nariman <narimantos@gmail.com>
X-Google-Original-From: Nariman <root>
To:     linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, Nariman Etemadi <narimantos@gmail.com>
Subject: [PATCH] ASoC: Intel: bytcr_5640.c:Refactored if statement and removed buffer
Date:   Sat,  4 May 2019 17:16:49 +0200
Message-Id: <20190504151652.5213-1-user@elitebook-localhost>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nariman Etemadi <narimantos@gmail.com>

in function snd_byt_rt5640_mc_probe and removed buffer yt_rt5640_codec_aif_name & byt_rt5640_cpu_dai_name

Signed-off-by: Nariman Etemadi <narimantos@gmail.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 940eb27158da..0d91642ca287 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -1075,8 +1075,6 @@ static struct snd_soc_dai_link byt_rt5640_dais[] = {
 
 /* SoC card */
 static char byt_rt5640_codec_name[SND_ACPI_I2C_ID_LEN];
-static char byt_rt5640_codec_aif_name[12]; /*  = "rt5640-aif[1|2]" */
-static char byt_rt5640_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
 static char byt_rt5640_long_name[40]; /* = "bytcr-rt5640-*-spk-*-mic" */
 
 static int byt_rt5640_suspend(struct snd_soc_card *card)
@@ -1268,28 +1266,12 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	log_quirks(&pdev->dev);
 
 	if ((byt_rt5640_quirk & BYT_RT5640_SSP2_AIF2) ||
-	    (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2)) {
-
-		/* fixup codec aif name */
-		snprintf(byt_rt5640_codec_aif_name,
-			sizeof(byt_rt5640_codec_aif_name),
-			"%s", "rt5640-aif2");
-
-		byt_rt5640_dais[dai_index].codec_dai_name =
-			byt_rt5640_codec_aif_name;
-	}
+	    (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2))
+		byt_rt5640_dais[dai_index].codec_dai_name = "rt5640-aif2";
 
 	if ((byt_rt5640_quirk & BYT_RT5640_SSP0_AIF1) ||
-	    (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2)) {
-
-		/* fixup cpu dai name name */
-		snprintf(byt_rt5640_cpu_dai_name,
-			sizeof(byt_rt5640_cpu_dai_name),
-			"%s", "ssp0-port");
-
-		byt_rt5640_dais[dai_index].cpu_dai_name =
-			byt_rt5640_cpu_dai_name;
-	}
+	    (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF2))
+		byt_rt5640_dais[dai_index].cpu_dai_name = "ssp0-port";
 
 	if (byt_rt5640_quirk & BYT_RT5640_MCLK_EN) {
 		priv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
-- 
2.20.1

