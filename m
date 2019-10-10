Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C101C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB33206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfJJUpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 16:45:00 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:38005 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfJJUpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:45:00 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M7NaW-1iAwan0z8u-007hQ6; Thu, 10 Oct 2019 22:44:45 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 20/36] ASoC: samsung: s3c2412-i2s: avoid hardcoded S3C2410_PA_IIS
Date:   Thu, 10 Oct 2019 22:30:04 +0200
Message-Id: <20191010203043.1241612-20-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191010203043.1241612-1-arnd@arndb.de>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TeWf9ZvWfvjnb3Ve9QrAtsPxCA5VGsKiYGYpNXLQpoD0HmWO+Ks
 UTtAeH609AIi4hlmzjVR5LB64CsPOtEnktY3gel+r0tddNDxlQdqdcdSy7KM564GUqFF59d
 ESmRXscKVtl/UO1tJrchwYHtuWECrpBQBzr4bq2YAz0W0o7jcB1AM2n78yMQG2wHh8BZ546
 +Jj6GGRLp22jZRUaAq+rA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G145m/aL1hs=:sr15MrldjKsqqqKcPPsAcS
 rx9bG0hsaqZArUGQfG4daIX6hCQIS5LxphGu6LBkwmvBP/30bRfC1CkUGvVmXegk/siDAqHRG
 Y501U6N2nMX+QJxLZti0i/pwI4yJCcjRgeGCOTqpGpRuvvGopQYM14i6YPu+gL/dt9Cs4iKwe
 kvEmlYqxyk7+tb7DarBuMVaA7g8otT5ruEldzk3qEafRpxU3asRCO6sSrMk3IC5nwcKUsG4gJ
 +8QqVDTzDRFpzUvZGIUvjH/C94yTZtcG5drJLND3QQhBAEmyoVMSmVt0g1GjyRr15YgTQ+3/k
 Jj3x9IsbZswRcNFfNbmN75+LJowP52l7vdBr5wAsDZIgHZDN4F92JK8mf8LTqH1E9ny4DQS6c
 EQoPXfVWQT03Fr9LAUOr8D74IcL9OBAv0Q/LVlT1+uxdH36djNjxQgaaKp8sWvuwJJeatc9ay
 aGJgZGBybo1H4gcoNYFnwTdy73BjFoJgMEORAdS5y5ykx+3z1SqRHM9nUv5wY5afMV/MR2Yvu
 6mB/feJh6PRTjGiK9zuSSwAK0amKACMBYIDLSz/hF5s02u9f4V+Hajg7XNwjO+Pauxqc5lOu6
 it/vvYGArso57IO1So7zdk7/AJ3rKdC5adQ/NIwZWoMwZe7Rz/JXLuMmwsdtST9zLWLhjoYGM
 2ZCfr/wEPA3FGGBMcqInS6Pn9eU3AOSLucH5tLtEy92m8UuInxw6NmabA3w4ez09+XtM34Ofm
 r/bsqjMw8wF24O+p+xW39i3gX9Ch01nynJxZ+Yg9yvwiqUID/LPO2e92M5d09j3Mb1AiNXKRE
 gXK+DMtndkWTpHz9FVFmCrLdKrd7HdihkyilJKK5fGN7NDtGUyq0SpmPYIcug/2gTiy0rNrp5
 HAxLeTVvprdB6tPmZfVQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The constant requires indirectly including a machine header file,
but it's not actually used any more since commit 87b132bc0315 ("ASoC:
samsung: s3c24{xx,12}-i2s: port to use generic dmaengine API"), so
remove it completely.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/samsung/s3c-i2s-v2.c  | 3 +--
 sound/soc/samsung/s3c-i2s-v2.h  | 3 +--
 sound/soc/samsung/s3c2412-i2s.c | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/samsung/s3c-i2s-v2.c b/sound/soc/samsung/s3c-i2s-v2.c
index 7e196b599be1..6a254fdaa6fb 100644
--- a/sound/soc/samsung/s3c-i2s-v2.c
+++ b/sound/soc/samsung/s3c-i2s-v2.c
@@ -616,8 +616,7 @@ int s3c_i2sv2_iis_calc_rate(struct s3c_i2sv2_rate_calc *info,
 EXPORT_SYMBOL_GPL(s3c_i2sv2_iis_calc_rate);
 
 int s3c_i2sv2_probe(struct snd_soc_dai *dai,
-		    struct s3c_i2sv2_info *i2s,
-		    unsigned long base)
+		    struct s3c_i2sv2_info *i2s)
 {
 	struct device *dev = dai->dev;
 	unsigned int iismod;
diff --git a/sound/soc/samsung/s3c-i2s-v2.h b/sound/soc/samsung/s3c-i2s-v2.h
index fe42b77999fd..8c6fc0d3d77e 100644
--- a/sound/soc/samsung/s3c-i2s-v2.h
+++ b/sound/soc/samsung/s3c-i2s-v2.h
@@ -83,8 +83,7 @@ extern int s3c_i2sv2_iis_calc_rate(struct s3c_i2sv2_rate_calc *info,
  * @base: The base address for the registers.
  */
 extern int s3c_i2sv2_probe(struct snd_soc_dai *dai,
-			   struct s3c_i2sv2_info *i2s,
-			   unsigned long base);
+			   struct s3c_i2sv2_info *i2s);
 
 /**
  * s3c_i2sv2_cleanup - cleanup resources allocated in s3c_i2sv2_probe
diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
index 787a3f6e9f24..5bf571762e89 100644
--- a/sound/soc/samsung/s3c2412-i2s.c
+++ b/sound/soc/samsung/s3c2412-i2s.c
@@ -49,7 +49,7 @@ static int s3c2412_i2s_probe(struct snd_soc_dai *dai)
 	snd_soc_dai_init_dma_data(dai, &s3c2412_i2s_pcm_stereo_out,
 					&s3c2412_i2s_pcm_stereo_in);
 
-	ret = s3c_i2sv2_probe(dai, &s3c2412_i2s, S3C2410_PA_IIS);
+	ret = s3c_i2sv2_probe(dai, &s3c2412_i2s);
 	if (ret)
 		return ret;
 
-- 
2.20.0

