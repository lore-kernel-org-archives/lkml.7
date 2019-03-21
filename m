Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE59C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AABDE218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b="Rd/NcxI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfCUWQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:16:08 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39336 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfCUWQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:16:06 -0400
Received: by mail-qt1-f194.google.com with SMTP id t28so437678qte.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 15:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PaAiK0DR2sIQWzoKy9Rm5Q9ewZFtpvbkDJA7a+dgNIQ=;
        b=Rd/NcxI3SiTqghKLtjSSi1Yv28GGZ5BOQx3mDk4NUx9AFttyl7VoBpY54e/v8KJMWA
         bk/e25I4k7LbksAsM5o95GzMKquXi14B860qYXdfuQK9Ggp6qR5vGIl0YwXTD6PIXgos
         WPP4soeT8fF/8qI+GWDRie/n8PRHERwT1ehRO85Zw3SAFx7jVquWlepCwtqF8qMXVa04
         yENVJHPLxfVAqv2Nq7rqEb36bg/phHF0SxrWRDCsJf09l2bYG0puJgWn5Ph+CWwC8z4P
         7imCkSkCTz+HQrVQDYND4Nsb6A+UZhiFgTK+ExloSKme8FOWbN7ERco0P5Ssi2xj9Sno
         RNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PaAiK0DR2sIQWzoKy9Rm5Q9ewZFtpvbkDJA7a+dgNIQ=;
        b=fmscPUGhRWB2x4RevgsRyNgomJTgr6Ln4hGTL2/1RLgGWiN4ZCPkLk54mzqtL9IqmW
         kWeeH7gWt1hi0Wc++9ZDmQi03ttZCDw+avsB19ZwGUb7qdxPEbBzytq11NwyfJVk/r0k
         bQqA/Z8WC1+Zjt/ujRj33TdAY+/6Evb3D1ssMZt2uMnzremYD5fco/2qyyDkPHSbztfO
         cwLxfFvyOLJZGTS/a9LlZIAKAh9OeXwjg09SpQJ4UcATRAIkdqWnjEP1i2bR4Gt/RD+r
         NBUfG2aa3QM2JgviLBjFLcBV9VDL+7KlE34bt82nDJ2JzaUrpvuIBYgLtcWb0BFQXpyB
         rZTQ==
X-Gm-Message-State: APjAAAX6XxSv8bFxuT/tO2uWDpTjQG345m3vtD4yTPUwaYvn43bnNaib
        21qzEJwTSxECrHqZVlPN5aW6xg==
X-Google-Smtp-Source: APXvYqxW8KY5acPBbd3l0z7nMTSHAl2jEQL/aIeaTfianJL+n6xtWTDQ5tXC94y66IRi+2VRm6PqsA==
X-Received: by 2002:ac8:3202:: with SMTP id x2mr5262310qta.56.1553206564811;
        Thu, 21 Mar 2019 15:16:04 -0700 (PDT)
Received: from jcormier-MS-7A93.syr.criticallink.com (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id w37sm3895968qtw.27.2019.03.21.15.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 15:16:03 -0700 (PDT)
From:   "Cormier, Jonathan" <jcormier@criticallink.com>
To:     Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
Cc:     Bob Duke <bduke@criticallink.com>,
        Mike Williamson <michael.williamson@criticallink.com>,
        Greg Gluszek <greg.gluszek@criticallink.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jyri Sarha <jsarha@ti.com>,
        Misael Lopez Cruz <misael.lopez@ti.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] ASoC: tlv320aic26: hw_params was unintentionally clearing AIC26 master mode
Date:   Thu, 21 Mar 2019 18:15:48 -0400
Message-Id: <20190321221549.13765-7-jcormier@criticallink.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190321221549.13765-1-jcormier@criticallink.com>
References: <20190321221549.13765-1-jcormier@criticallink.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5b0959d472c2 ("ASoC: tlv320aic26: Use snd_soc_update_bits()")
broke setting AIC26_REG_AUDIO_CTRL3 in master mode when fsref happens
to be 48000. The master mode bit was getting cleared.

Also fix setting AIC26_REG_DAC_GAIN and AIC26_REG_AUDIO_CTRL2 which
was broke by same commit.

Fixes 5b0959d472c2 ("ASoC: tlv320aic26: Use snd_soc_update_bits()")
Signed-off-by: Cormier, Jonathan <jcormier@criticallink.com>
---
 sound/soc/codecs/tlv320aic26.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index cd1bcb9cbfe1..c6ff4ca29d43 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -138,11 +138,12 @@ static int aic26_hw_params(struct snd_pcm_substream *substream,
 	snd_soc_component_write(component, AIC26_REG_PLL_PROG2, reg);
 
 	/* Audio Control 3 (master mode, fsref rate) */
+	reg = 0;
 	if (aic26->master)
-		reg = 0x0800;
+		reg |= 0x0800;
 	if (fsref == 48000)
-		reg = 0x2000;
-	snd_soc_component_update_bits(component, AIC26_REG_AUDIO_CTRL3, 0xf800, reg);
+		reg |= 0x2000;
+	snd_soc_component_update_bits(component, AIC26_REG_AUDIO_CTRL3, 0x2800, reg);
 
 	/* Audio Control 1 (FSref divisor) */
 	reg = wlen | aic26->datfm | (divisor << 3) | divisor;
@@ -167,7 +168,7 @@ static int aic26_mute(struct snd_soc_dai *dai, int mute)
 		reg = 0x8080;
 	else
 		reg = 0;
-	snd_soc_component_update_bits(component, AIC26_REG_DAC_GAIN, 0x8000, reg);
+	snd_soc_component_update_bits(component, AIC26_REG_DAC_GAIN, 0x8080, reg);
 
 	return 0;
 }
@@ -302,7 +303,7 @@ static ssize_t aic26_keyclick_set(struct device *dev,
 	struct aic26 *aic26 = dev_get_drvdata(dev);
 
 	snd_soc_component_update_bits(aic26->component, AIC26_REG_AUDIO_CTRL2,
-			    0x8000, 0x800);
+			    0x8000, 0x8000);
 
 	return count;
 }
-- 
2.21.0

