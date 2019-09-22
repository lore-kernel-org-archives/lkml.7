Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6343CC3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33DE021D7B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569178332;
	bh=gzyP2iDTSZJkcDxjXtyZpYtn6CrWpPanXtKAD1JQ+j4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wu6iD8HsjwtHBNQqdawTFq/mlgvontCYWUK6iu2dT64OnZGWypurS7GK1LXUNQ1OL
	 mSE12uX6IQGEX2JXYNVqlQsieyfFsk8iYNO1dhmAtsc2QoVwRHk/IGbOt+/5pyv5iF
	 xLV8G+SoYh0UTA2Aw2m9cMaqThofByV7CcE89zhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407301AbfIVSwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:52:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407086AbfIVSwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:52:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1DDD21479;
        Sun, 22 Sep 2019 18:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178327;
        bh=gzyP2iDTSZJkcDxjXtyZpYtn6CrWpPanXtKAD1JQ+j4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sGUDWizTkxvsuxV6yiL/OfXUfF9jvmtY+TvW9RoxemWfIuZKssxhtl188lYJzwsaI
         WpLegE5/MWb47MRV08L1zBpRwB8spcLTPjgcDjZnXa4MK0oH4WFJc/volhXx82sJfu
         P3KQMZ8OpaG5nshJ8Qqzcx7+54zdmc0jpxxjc+4Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 092/185] ASoC: mchp-i2s-mcc: Fix unprepare of GCLK
Date:   Sun, 22 Sep 2019 14:47:50 -0400
Message-Id: <20190922184924.32534-92-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184924.32534-1-sashal@kernel.org>
References: <20190922184924.32534-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

[ Upstream commit 988b59467b2b14523a266957affbe9eca3e99fc9 ]

If hw_free() gets called after hw_params(), GCLK remains prepared,
preventing further use of it. This patch fixes this by unpreparing the
clock in hw_free() or if hw_params() gets an error.

Fixes: 7e0cdf545a55 ("ASoC: mchp-i2s-mcc: add driver for I2SC Multi-Channel Controller")
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Link: https://lore.kernel.org/r/20190820162411.24836-2-codrin.ciubotariu@microchip.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/atmel/mchp-i2s-mcc.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/atmel/mchp-i2s-mcc.c b/sound/soc/atmel/mchp-i2s-mcc.c
index 8272915fa09b9..ab7d5f98e759e 100644
--- a/sound/soc/atmel/mchp-i2s-mcc.c
+++ b/sound/soc/atmel/mchp-i2s-mcc.c
@@ -670,8 +670,13 @@ static int mchp_i2s_mcc_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	ret = regmap_write(dev->regmap, MCHP_I2SMCC_MRA, mra);
-	if (ret < 0)
+	if (ret < 0) {
+		if (dev->gclk_use) {
+			clk_unprepare(dev->gclk);
+			dev->gclk_use = 0;
+		}
 		return ret;
+	}
 	return regmap_write(dev->regmap, MCHP_I2SMCC_MRB, mrb);
 }
 
@@ -710,9 +715,13 @@ static int mchp_i2s_mcc_hw_free(struct snd_pcm_substream *substream,
 		regmap_write(dev->regmap, MCHP_I2SMCC_CR, MCHP_I2SMCC_CR_CKDIS);
 
 		if (dev->gclk_running) {
-			clk_disable_unprepare(dev->gclk);
+			clk_disable(dev->gclk);
 			dev->gclk_running = 0;
 		}
+		if (dev->gclk_use) {
+			clk_unprepare(dev->gclk);
+			dev->gclk_use = 0;
+		}
 	}
 
 	return 0;
-- 
2.20.1

