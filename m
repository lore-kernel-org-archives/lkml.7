Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291D5C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE8C20863
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482967;
	bh=wPSD5GVuIeOKSj3ezSPdIhvdyMAG0R9gBfHweupUel8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xq9gJuW1C6hQYtvMREprx7YHF9ljmBiB6bNvvCdz1x26WLrFDIr/IehkoHo8TH4qu
	 Ea5h4E6EQ2HxNJJ4fL3KrBKSz4Nupx4YBWmXvcNpQGhrV0pjzrCccqfDH3UE7RZx3V
	 Pg9JMmIe2LtXmLqoOCF0wiBlTg945T5/kQJd1kxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731056AbfLDSJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:09:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730389AbfLDSJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:09:19 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB54220674;
        Wed,  4 Dec 2019 18:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482958;
        bh=wPSD5GVuIeOKSj3ezSPdIhvdyMAG0R9gBfHweupUel8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wznyW87U1JepXuOGjT0Pd149D8IjTMhZi0hruV/yaR1M3B55YDZrS/16TR0q4HInC
         rRVTKmOyO8mqHr+goh+SkVXJas16xXJtNoDA0FyRqtiIsfy3jWPoc7XlloN6PsyGLs
         ftCHMarcWdsyiTPGkyihy3kNiZcd7VhvU/zSmkfY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olivier Moysan <olivier.moysan@st.com>,
        Mark Brown <broonie@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 4.14 204/209] ASoC: stm32: i2s: fix dma configuration
Date:   Wed,  4 Dec 2019 18:56:56 +0100
Message-Id: <20191204175337.531874896@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olivier Moysan <olivier.moysan@st.com>

commit 1ac2bd16448997d9ec01922423486e1e85535eda upstream.

DMA configuration is not balanced on start/stop.
Move DMA configuration to trigger callback.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/stm/stm32_i2s.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -488,7 +488,7 @@ static int stm32_i2s_configure(struct sn
 {
 	struct stm32_i2s_data *i2s = snd_soc_dai_get_drvdata(cpu_dai);
 	int format = params_width(params);
-	u32 cfgr, cfgr_mask, cfg1, cfg1_mask;
+	u32 cfgr, cfgr_mask, cfg1;
 	unsigned int fthlv;
 	int ret;
 
@@ -529,15 +529,11 @@ static int stm32_i2s_configure(struct sn
 	if (ret < 0)
 		return ret;
 
-	cfg1 = I2S_CFG1_RXDMAEN | I2S_CFG1_TXDMAEN;
-	cfg1_mask = cfg1;
-
 	fthlv = STM32_I2S_FIFO_SIZE * I2S_FIFO_TH_ONE_QUARTER / 4;
-	cfg1 |= I2S_CFG1_FTHVL_SET(fthlv - 1);
-	cfg1_mask |= I2S_CFG1_FTHVL_MASK;
+	cfg1 = I2S_CFG1_FTHVL_SET(fthlv - 1);
 
 	return regmap_update_bits(i2s->regmap, STM32_I2S_CFG1_REG,
-				  cfg1_mask, cfg1);
+				  I2S_CFG1_FTHVL_MASK, cfg1);
 }
 
 static int stm32_i2s_startup(struct snd_pcm_substream *substream,
@@ -589,6 +585,10 @@ static int stm32_i2s_trigger(struct snd_
 		/* Enable i2s */
 		dev_dbg(cpu_dai->dev, "start I2S\n");
 
+		cfg1_mask = I2S_CFG1_RXDMAEN | I2S_CFG1_TXDMAEN;
+		regmap_update_bits(i2s->regmap, STM32_I2S_CFG1_REG,
+				   cfg1_mask, cfg1_mask);
+
 		ret = regmap_update_bits(i2s->regmap, STM32_I2S_CR1_REG,
 					 I2S_CR1_SPE, I2S_CR1_SPE);
 		if (ret < 0) {


