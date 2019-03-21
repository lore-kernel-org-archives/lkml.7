Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17938C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5780218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b="DiiRYMPG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfCUWQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:16:16 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34255 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbfCUWQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:16:07 -0400
Received: by mail-qt1-f196.google.com with SMTP id k2so474770qtm.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 15:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mu9vXisaQd7ghjQVLWfrL4876M7CDnfKlb87qdepNrs=;
        b=DiiRYMPGV8qwxWOzqeuHbFkr40TI6APbXrOH0/YUd0kUIN7wPTF88EUml1b2nXFEXs
         WE6sM1PisgoLCg3t6Wi+mkFYssmL2uMi0uLkCASmIDY5xrn87pz9sxZanfufW4G66iYk
         8NMrq4YPzukYbfuyefjqo7HAo7235nH7es0qroIWoFGuOoFEo0+5aie2qG1ebK84pjXe
         BHAIqen9tmssXDMvA11cCGW5okZWbS1vxPf0VMegdNDZRxbMlPaS9CkX7bZT3WFBj2v1
         HniDbMzhRKr4piOwksnT+gBsNMsuZhqj075GO3GhPe6eLd1Zymz8N03U/FKdmBa326mm
         Dcdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mu9vXisaQd7ghjQVLWfrL4876M7CDnfKlb87qdepNrs=;
        b=BnrE7Q6Xlc9GeqqUZsqaGVB7p1Y/mfO+RepnzkEnKepTEbZLymWmshOP73kW2osj10
         9P+Tlk6ZNsRY1W3ZKO1t0XHD0+zXCZ5Kh4ke8n/LK6sfHSgMZrKIrWd5xXGhouu8dpkl
         0qZUkkmVYAafBCj5UozhxRqWEbmKYTfV6QbmwyZuhXfezq7smw2bcfbWJM+AAzEvXtFN
         nvQA7HcQkWZCJgc9Fj5UAW3Ze4Cb0wn/mShGD0PcUX6BZhF64Vj8UzJJRtUGIH6quI6l
         ERwFUZaMr7k6dGooptBrBeuwCAk3W+7Cc3ErMXPJIAxByp1ghjYg/loDG/zPKZatQoN+
         hCRw==
X-Gm-Message-State: APjAAAUWnK9/SyGPhXfrBHQLnXUtlD96N+0GaRlIJCWLXTcKJgzuBhu3
        HXwXDYb1B5RS0AzjPlZ4GkbcgQ==
X-Google-Smtp-Source: APXvYqyrnQKlB8qmYvLMRwUg+4JuuE2obl6Jjc3atAOxJCBZzaYtjSNe4k+wYYgpdtOFjxSzru1jYA==
X-Received: by 2002:a0c:a3c1:: with SMTP id v59mr5177313qvv.159.1553206566766;
        Thu, 21 Mar 2019 15:16:06 -0700 (PDT)
Received: from jcormier-MS-7A93.syr.criticallink.com (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id w37sm3895968qtw.27.2019.03.21.15.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 15:16:05 -0700 (PDT)
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
Subject: [PATCH v2 7/7] ASoC: tlv320aic26: Change Capture Mute to Capture Switch to match alsa documentation.
Date:   Thu, 21 Mar 2019 18:15:49 -0400
Message-Id: <20190321221549.13765-8-jcormier@criticallink.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190321221549.13765-1-jcormier@criticallink.com>
References: <20190321221549.13765-1-jcormier@criticallink.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Control name needs to match Switch for alsa to use it as the channel mute

Signed-off-by: Cormier, Jonathan <jcormier@criticallink.com>
---
 sound/soc/codecs/tlv320aic26.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index c6ff4ca29d43..3935be79b091 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -269,7 +269,7 @@ static const struct snd_kcontrol_new aic26_snd_controls[] = {
 	SOC_DOUBLE("PCM Playback Volume", AIC26_REG_DAC_GAIN, 8, 0, 0x7f, 1),
 	SOC_DOUBLE("PCM Playback Switch", AIC26_REG_DAC_GAIN, 15, 7, 1, 1),
 	SOC_SINGLE("PCM Capture Volume", AIC26_REG_ADC_GAIN, 8, 0x7f, 0),
-	SOC_SINGLE("PCM Capture Mute", AIC26_REG_ADC_GAIN, 15, 1, 1),
+	SOC_SINGLE("PCM Capture Switch", AIC26_REG_ADC_GAIN, 15, 1, 1),
 	SOC_SINGLE("Keyclick activate", AIC26_REG_AUDIO_CTRL2, 15, 0x1, 0),
 	SOC_SINGLE("Keyclick amplitude", AIC26_REG_AUDIO_CTRL2, 12, 0x7, 0),
 	SOC_SINGLE("Keyclick frequency", AIC26_REG_AUDIO_CTRL2, 8, 0x7, 0),
-- 
2.21.0

