Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D523FC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE15B207FC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbfIFQOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 12:14:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52063 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfIFQOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 12:14:30 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i6Gs8-0006ps-DW; Fri, 06 Sep 2019 16:14:04 +0000
From:   Colin King <colin.king@canonical.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: codecs: ad193x: make two arrays static const, makes object smaller
Date:   Fri,  6 Sep 2019 17:14:04 +0100
Message-Id: <20190906161404.1440-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the arrays on the stack but instead make them
static const. Makes the object code smaller by 37 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
  16253	   7200	      0	  23453	   5b9d	sound/soc/codecs/ad193x.o

After:
   text	   data	    bss	    dec	    hex	filename
  16056	   7360	      0	  23416	   5b78	sound/soc/codecs/ad193x.o

(gcc version 9.2.1, amd64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/ad193x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index fb04c9379b71..980e024a5720 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -416,7 +416,7 @@ static struct snd_soc_dai_driver ad193x_no_adc_dai = {
 /* codec register values to set after reset */
 static void ad193x_reg_default_init(struct ad193x_priv *ad193x)
 {
-	const struct reg_sequence reg_init[] = {
+	static const struct reg_sequence reg_init[] = {
 		{  0, 0x99 },	/* PLL_CLK_CTRL0: pll input: mclki/xi 12.288Mhz */
 		{  1, 0x04 },	/* PLL_CLK_CTRL1: no on-chip Vref */
 		{  2, 0x40 },	/* DAC_CTRL0: TDM mode */
@@ -432,7 +432,7 @@ static void ad193x_reg_default_init(struct ad193x_priv *ad193x)
 		{ 12, 0x00 },	/* DAC_L4_VOL: no attenuation */
 		{ 13, 0x00 },	/* DAC_R4_VOL: no attenuation */
 	};
-	const struct reg_sequence reg_adc_init[] = {
+	static const struct reg_sequence reg_adc_init[] = {
 		{ 14, 0x03 },	/* ADC_CTRL0: high-pass filter enable */
 		{ 15, 0x43 },	/* ADC_CTRL1: sata delay=1, adc aux mode */
 		{ 16, 0x00 },	/* ADC_CTRL2: reset */
-- 
2.20.1

