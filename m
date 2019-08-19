Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8781C3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88B122D6D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566242738;
	bh=NeI4/RHFsIzYkus2CwMCSmRgL3wBBxOm4tj3ljYKR2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VNFlTV6/PlBLi/o38bqMlwluDGsiVcOuambZaiQtpFPL6sEx5oWmJGmepYSC5UwIE
	 Tp3zzBsckHh3xFhh+zlkcTCia2MpOL5z7lIDX1pK6pk4iYVprMFeSlxqaAC3MI9GR6
	 TUDYuynvV6/MbJ16Lt1KACxW2K/bwk+J2j2ldlaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfHSTZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:25:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728337AbfHSTZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:25:36 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF48022CF6;
        Mon, 19 Aug 2019 19:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566242735;
        bh=NeI4/RHFsIzYkus2CwMCSmRgL3wBBxOm4tj3ljYKR2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ISzRRBYYdB0cVdsQnh/XhBoQXSMRKlu6C6hDmUvJ28BTFuiM0eM0UHdYkLc0LCFbK
         XURn5Hsu3MnzgRxvX+FI95aBdHu8jI0M5Sfh49aYCxXQCdGGHZeQNN98U0Radlr8+F
         sECplnVAcpRiCh0cUnC+FKg/TmF/j8ipa6+adIZE=
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        codekipper@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH 01/21] ASoC: sun4i-i2s: Register regmap and PCM before our component
Date:   Mon, 19 Aug 2019 21:25:08 +0200
Message-Id: <67e303f37f141ef73ce9ed47d7f831b63c694424.1566242458.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.e08aa7e33afe117e1fa8f017119d465d47c98016.1566242458.git-series.maxime.ripard@bootlin.com>
References: <cover.e08aa7e33afe117e1fa8f017119d465d47c98016.1566242458.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

So far the regmap and the dmaengine PCM are registered after our component
has been, which means that our driver isn't properly initialised by then.

Let's fix that.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 7fa5c61169db..85c3b2c8cd77 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1148,11 +1148,9 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 			goto err_pm_disable;
 	}
 
-	ret = devm_snd_soc_register_component(&pdev->dev,
-					      &sun4i_i2s_component,
-					      &sun4i_i2s_dai, 1);
+	ret = sun4i_i2s_init_regmap_fields(&pdev->dev, i2s);
 	if (ret) {
-		dev_err(&pdev->dev, "Could not register DAI\n");
+		dev_err(&pdev->dev, "Could not initialise regmap fields\n");
 		goto err_suspend;
 	}
 
@@ -1162,9 +1160,11 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 		goto err_suspend;
 	}
 
-	ret = sun4i_i2s_init_regmap_fields(&pdev->dev, i2s);
+	ret = devm_snd_soc_register_component(&pdev->dev,
+					      &sun4i_i2s_component,
+					      &sun4i_i2s_dai, 1);
 	if (ret) {
-		dev_err(&pdev->dev, "Could not initialise regmap fields\n");
+		dev_err(&pdev->dev, "Could not register DAI\n");
 		goto err_suspend;
 	}
 
-- 
git-series 0.9.1
