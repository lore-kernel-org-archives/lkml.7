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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9CEC04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811B920675
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6wB/8d7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbfESR5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:57:31 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46016 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbfESR53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:57:29 -0400
Received: by mail-ed1-f68.google.com with SMTP id g57so19904495edc.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 10:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eVaNiZEHc2WcLQetcZoCKC6E7inFmZ0Pm/1lAy3U6IQ=;
        b=K6wB/8d7dqCDlc21CCTdhmAzeRVyTKQRgt2+flXlaWoLItJMy8VTsJt++RLKl77n40
         ftEt8NJZPoqzl75TaNzxFJ1MI1I3rTMb2TYt6C7/5lejLoTDOcg4ieqKJsSu19kT1weS
         MMUAymGTkJKScCfuiSacIteezNzOzxWneXQXU8aU95rzYdCah4CyLbDcepmt9lypqY5B
         v21JKS1WZ08knDGuN9L9vr2CgfmleW7Dx9JRAcPnD6uAMwwKD4nafvuvFOWlZ06eT9B/
         vkWokLfdZRCrxp6OjqbDN2HyUOUMB//Yue0uHTCc5CJQV3I0WcFiQE3cqOsJ5ONGLnVZ
         Hw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eVaNiZEHc2WcLQetcZoCKC6E7inFmZ0Pm/1lAy3U6IQ=;
        b=Jnj3GKX6OIwwit0CHbRFwM0Yi7JuPOrBsft0xnIfFFiLsp+PgBAyAq6qa7RGq8i7IS
         AsYPuUb3cLlehT4vlFpA+bDuZaKKLVCwE7sDZyp+955P5r4sHR45ADqYKX4npF1v2MFB
         Kxd4e3ADSZo6DoHe+F/hwF/ipFy8HjlR+JC+yIBfFFnJWSAkhmo03usOeM440AipP6l7
         BSaA6v67QHbIfouc3tkuVAQAGrbq7QIZ4HlbNLWspr+nHpnYnII9BbT9bDHsZufsjcCX
         KIQ51KqeMzdZochZMEzgN2f0KAECVDWOcLHy5ibTkp15HOrbU/w+H45qZfNPQlSWjC36
         itfg==
X-Gm-Message-State: APjAAAX1pankM/fu6ogxid9vGTVLWlm/AhenAzg1HJ3fZDolyQtRLY70
        3vBPjp+i1SS4UK2UfW3XCcM=
X-Google-Smtp-Source: APXvYqzwILb9iU6xVGV23PJPw0nr3EUtl8te6kELaj8HZ7i6oFAwJbtvJrjvKY8xCkIvNFiumh4uSQ==
X-Received: by 2002:a17:906:3e8a:: with SMTP id a10mr52197862ejj.179.1558288647205;
        Sun, 19 May 2019 10:57:27 -0700 (PDT)
Received: from elitebook-localhost (84-106-70-146.cable.dynamic.v4.ziggo.nl. [84.106.70.146])
        by smtp.gmail.com with ESMTPSA id f25sm4936965ede.44.2019.05.19.10.57.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 May 2019 10:57:26 -0700 (PDT)
From:   nariman <narimantos@gmail.com>
To:     broonie@kernel.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Nariman Etemadi <narimantos@gmail.com>
Subject: [PATCH] ASoC: Intel: bytcr_5640.c:Refactored if statement and removed buffer
Date:   Sun, 19 May 2019 19:57:03 +0200
Message-Id: <20190519175706.3998-1-narimantos@gmail.com>
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

