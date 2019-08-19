Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF43FC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B774122D37
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566242741;
	bh=KWvMAVh8158Vfot7bGOe/TZP6z7v55KtdLwvGs8+fyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RlKhgTEBKpBLwK91rCwIYDHlpyOm6cKiItYyj5vaHb9VBJmq/wXWm8ui4BFKfEWbM
	 uy3iQXo5FrwSiuZCwwmdXJY/9AHB3Li/PDweLVQdPBEG92MDlKY+sBhyzvC1GGRUUi
	 /DidL7dbwzhes95nU0r3MXSWOriXXDvJPNpxchTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbfHSTZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:25:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:41036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728337AbfHSTZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:25:39 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19D0C22CF4;
        Mon, 19 Aug 2019 19:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566242738;
        bh=KWvMAVh8158Vfot7bGOe/TZP6z7v55KtdLwvGs8+fyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rl8cyP+EOopS1H4rho1U/AiNRXHlyHm53mEiFLDzajk2B8TlmRoa1ogWcWL/12kro
         YOby6qvoM/VYXrXOe8an/y9R59mtvrUvlM5y9AfycmsJahHL7kWkYNeZnGmyt/6UW/
         RsWACt/0oxJL+R6W7/DSKGwDFhJKItIy4lgpLFdY=
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        codekipper@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH 02/21] ASoC: sun4i-i2s: Switch to devm for PCM register
Date:   Mon, 19 Aug 2019 21:25:09 +0200
Message-Id: <606d271187091e858e8c15e20555af0b79798fe1.1566242458.git-series.maxime.ripard@bootlin.com>
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

Since the introduction of the driver, a new managed helper for the
dmaengine PCM registration has been created. Let's use it to simplify a bit
our probe and remove functions.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 85c3b2c8cd77..1ed7670eae9c 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1154,7 +1154,7 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 		goto err_suspend;
 	}
 
-	ret = snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
+	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register PCM\n");
 		goto err_suspend;
@@ -1185,8 +1185,6 @@ static int sun4i_i2s_remove(struct platform_device *pdev)
 {
 	struct sun4i_i2s *i2s = dev_get_drvdata(&pdev->dev);
 
-	snd_dmaengine_pcm_unregister(&pdev->dev);
-
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		sun4i_i2s_runtime_suspend(&pdev->dev);
-- 
git-series 0.9.1
