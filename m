Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90630C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5436C206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qjim+RSV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbfDDLuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:50:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39623 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfDDLux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 07:50:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id n25so3026363wmk.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 04:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z2/CoXo7oHFZHaZjncloW8yt4NzKpCTULQGuHVPCIyM=;
        b=qjim+RSVmqV5zUgypYEY7qNbq+oLvx7h4jcPi5wvE/GGgUB+drTFQPZ4JQ0UdTLmeH
         6h/fyqnpoBexavZChAiNicMCan8y8QTaeRY2snkCGtzfoEgt/jMYx+I199VTO+IPpJTP
         tDRDNNzuUMKVNVt5Vkk2swprOOJY0lF2cV4K2UCQesTYtR9geEDMmmCAZt5GFaA5sPkI
         MoymKp0ML/HQ7/zznEwDLN9dUn4RulaGyv/rXO9o8OCXexLLVGHCDtoUUY7Miz3k72tZ
         1uyjmZ2iYNeifXtCvaSSwaFrRyxK7MH4HJC4nRvb0k/KXxakn2WZpCBAElPbjbX1McMO
         oKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z2/CoXo7oHFZHaZjncloW8yt4NzKpCTULQGuHVPCIyM=;
        b=VARiNSwSKoAamPob+Twzs6z1rRBolcILrMD+M6zXNFCAequ0fC7crsQhIGIVvNTbpz
         fYlxSOFkHEvq53mIlqj2RK9R4oNT3qyoD/XyxUL1VGMq+RjjEHh0UuXSDnOpz6flyTUn
         I7gX2suTLOnN52y15CMXJP2eX35sEnfMW96ugR7SbkFpLXURrvFRK1Eqnwn3dZ0tOfbk
         z4S0cQXLRXX6woLxiAofTlEqh/j4slC+JK+1TWuUWGl43NDzzWZB67JFBV0DkFoZAHGK
         GLzOuOcBIHMbvyT//UrcDOwSaX4Yec/Z79MmPpCvT6yq6ckW7m3c66Vc9gowhAWOEzfE
         hB+g==
X-Gm-Message-State: APjAAAXnjJ6+TWeDV/ClTXjQ3RNt9mxx7M3TawZqfN1rns3jt+AbTt8w
        2U1BGx1A4A1ROZAd2Tg6buPjIA==
X-Google-Smtp-Source: APXvYqx4CP7iaLosKmM8Z7K4BgDFLDgizhg9DVAVaak5YOJR7MwLbsfyHRZzhiIWY8xGQ3+FqEkugg==
X-Received: by 2002:a7b:c353:: with SMTP id l19mr3944897wmj.12.1554378652040;
        Thu, 04 Apr 2019 04:50:52 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id z18sm32039468wrr.90.2019.04.04.04.50.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 04:50:51 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: max98357a: add missing supported rates
Date:   Thu,  4 Apr 2019 13:50:15 +0200
Message-Id: <20190404115015.32208-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According the publicly available datasheet (and some test) the max98357a
also supports 32, 44.1 and 88.2 kHz sample rate.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

 Datasheet is available here:
 https://datasheets.maximintegrated.com/en/ds/MAX98357A-MAX98357B.pdf

 sound/soc/codecs/max98357a.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index d469576b5a7b..d037a3e4d323 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -97,7 +97,10 @@ static struct snd_soc_dai_driver max98357a_dai_driver = {
 					SNDRV_PCM_FMTBIT_S32,
 		.rates		= SNDRV_PCM_RATE_8000 |
 					SNDRV_PCM_RATE_16000 |
+					SNDRV_PCM_RATE_32000 |
+					SNDRV_PCM_RATE_44100 |
 					SNDRV_PCM_RATE_48000 |
+					SNDRV_PCM_RATE_88200 |
 					SNDRV_PCM_RATE_96000,
 		.rate_min	= 8000,
 		.rate_max	= 96000,
-- 
2.20.1

