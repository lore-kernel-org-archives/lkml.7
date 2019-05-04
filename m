Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CDCC43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 15:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577E920862
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 15:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwJyMbzz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfEDPRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 11:17:17 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46417 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfEDPRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 11:17:06 -0400
Received: by mail-ed1-f65.google.com with SMTP id f37so9672024edb.13
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 08:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZC78VHdO6R2zEO3o/rcoTftfUPrHjiCeWK1pVxkdMMg=;
        b=LwJyMbzzX1u8RDXAZ524BLTNc2ijQDCaiBiHO9lxonLu9KJMzeO8e5uJNcDBd1uhBb
         cnqkcPxHcTekqi0hIkPb/6xNLcOFI1ujyyRlAT8lGbi3jFx0jUgM0PcxWLqMi5XH6pYJ
         S2OFX4X1QpuhzaXEhIA9ECINxxkRf/zvC5Naxsk1LubgOqSOgBl5AWdHxTmiigRsWH+/
         BpZM/HO+KBUK0fKFWyiuW+MCXPnqkLpiqTb/YicH7FiKBi3mcMnAt93bmQT/S/5hB/sa
         ryY4qWsGsQqFW3rLAPxdvrlrpMZtceTFYYxuP/I6AfGRnWO9k+Ritd/vqj+NNL+3rPYg
         qG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZC78VHdO6R2zEO3o/rcoTftfUPrHjiCeWK1pVxkdMMg=;
        b=Pbk0JNhdHct1uMW4y35lmgkl9zYWYBdhHsGdm57dvAcXWPZ8Ta6B+lHi+ZPnuWRm3h
         EqV2VZ0JRgbdOrgkCmkm1KsbnxiOpzZqJJTiI/GL3etPo6mh7EyDCrvKL++ewcbdoCl4
         RzDvStJAZVvkFe5tS69gQTydngMy4QBYeoGUtMhlTtqsIf4QCmc/zzIQzVjVwnUnkSHu
         QZEEzvs9GtW8K3AmR4SmagpsAXG7+F7kl0JyNuWyCvfjR2HnuC804DMCXMHFJYO+ka+w
         Ti1j5qv4URxKfaY4e/3P3pZYqqXvF+aqy8Ehl6vboaernJuf0+JbUiulq/KG3z6SjLi9
         d6Vw==
X-Gm-Message-State: APjAAAUlA1bTrsV9KmixVgC3o+9VTMV33lBh6kN4Nr9uweJXU92YopN4
        rNq/dGVxKRplIBZn4h3mi7c=
X-Google-Smtp-Source: APXvYqxMtvwrVp1GD0rjfQE/veMHoC13fIU9jop9kWaleO4RZrH0aPYM0rSdYFFRZLdj73vHAbrGyw==
X-Received: by 2002:a50:b6cf:: with SMTP id f15mr15390529ede.192.1556983024555;
        Sat, 04 May 2019 08:17:04 -0700 (PDT)
Received: from elitebook-localhost (84-106-70-146.cable.dynamic.v4.ziggo.nl. [84.106.70.146])
        by smtp.gmail.com with ESMTPSA id j55sm1468433ede.27.2019.05.04.08.17.03
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 04 May 2019 08:17:03 -0700 (PDT)
From:   Nariman <narimantos@gmail.com>
X-Google-Original-From: Nariman <root>
To:     linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, Jordy Ubink <jordyubink@hotmail.nl>
Subject: [PATCH] ASoC: Intel: bytcr_rt5651.c: remove string buffers 'byt_rt5651_cpu_dai_name' and 'byt_rt5651_cpu_dai_name'
Date:   Sat,  4 May 2019 17:16:52 +0200
Message-Id: <20190504151652.5213-4-user@elitebook-localhost>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190504151652.5213-1-user@elitebook-localhost>
References: <20190504151652.5213-1-user@elitebook-localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jordy Ubink <jordyubink@hotmail.nl>

The snprintf calls filling byt_rt5651_cpu_dai_name / byt_rt5651_cpu_dai_name always fill them with the same string (ssp0-port" resp "rt5651-aif2"). So instead of keeping these buffers around and making the cpu_dai_name / codec_dai_name point to this, simply update the foo_dai_name pointers to directly point to a string constant containing the desired string.

Signed-off-by: Jordy Ubink <jordyubink@hotmail.nl>
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

