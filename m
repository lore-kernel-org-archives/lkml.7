Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEC9C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2CC20659
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563301106;
	bh=ibIzwDrMEg7O1tz0RohdZG9NDGmR8rHKZ4qhn4NsXww=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=MNO+YdZedqGxTbLSKXOymfQ3XBdcFooq7kuVLumJBdzcFlnBvV5pO32egszMUyR8k
	 p8AwNs1cXcQ4f8MjMYkl7MueG7JAkC+h7M9AnXLAE7xQqu84BXDFfOcy66QZB/Sav0
	 LkMnROBI5kNKwEPfLd8NCWO0/jADPCRBzmub8G48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388470AbfGPSSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 14:18:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58906 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388395AbfGPSSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 14:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=xOHLMbPHcvk/YRwlG+YY9Bb912WwVjs7eTKG7HprBsM=; b=doRmbBl4T5Vm
        XJF2E97u+PTQktb2V5HfOnEhZe7WzthGej+bwRvTUpFsioo/DdDLS86rgGySUJN0XR69jKzrcnvO2
        60DhCmz7e54fmD6pjx0TGgCWFcRWtVQTBUTcxrHG4SK5gEz5m75kdpKimTRGwwvCE5fq8VSsYoASQ
        1f8qg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hnS1i-0005yk-JC; Tue, 16 Jul 2019 18:18:10 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 324D02742BD4; Tue, 16 Jul 2019 19:18:08 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        cheng.shengyu@zte.com.cn, Jaroslav Kysela <perex@perex.cz>,
        krzk@kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        lgirdwood@gmail.com, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        perex@perex.cz, Sangbeom Kim <sbkim73@samsung.com>,
        sbkim73@samsung.com, s.nawrocki@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Takashi Iwai <tiwai@suse.com>, tiwai@suse.com,
        wang.yi59@zte.com.cn, xue.zhihong@zte.com.cn
Subject: Applied "ASoC: samsung: odroid: fix a double-free issue for cpu_dai" to the asoc tree
In-Reply-To: <1562989575-33785-3-git-send-email-wen.yang99@zte.com.cn>
X-Patchwork-Hint: ignore
Message-Id: <20190716181808.324D02742BD4@ypsilon.sirena.org.uk>
Date:   Tue, 16 Jul 2019 19:18:08 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: samsung: odroid: fix a double-free issue for cpu_dai

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 2abee12c0ab1924a69993d2c063a39a952e7d836 Mon Sep 17 00:00:00 2001
From: Wen Yang <wen.yang99@zte.com.cn>
Date: Sat, 13 Jul 2019 11:46:15 +0800
Subject: [PATCH] ASoC: samsung: odroid: fix a double-free issue for cpu_dai

The cpu_dai variable is still being used after the of_node_put() call,
which may result in double-free:

        of_node_put(cpu_dai);            ---> released here

        ret = devm_snd_soc_register_card(dev, card);
        if (ret < 0) {
...
                goto err_put_clk_i2s;    --> jump to err_put_clk_i2s
...

err_put_clk_i2s:
        clk_put(priv->clk_i2s_bus);
err_put_sclk:
        clk_put(priv->sclk_i2s);
err_put_cpu_dai:
        of_node_put(cpu_dai);            --> double-free here

Fixes: d832d2b246c5 ("ASoC: samsung: odroid: Fix of_node refcount unbalance")
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sangbeom Kim <sbkim73@samsung.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/r/1562989575-33785-3-git-send-email-wen.yang99@zte.com.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/odroid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/odroid.c b/sound/soc/samsung/odroid.c
index 64ebe895cdd7..f0f5fa9c27d3 100644
--- a/sound/soc/samsung/odroid.c
+++ b/sound/soc/samsung/odroid.c
@@ -308,7 +308,6 @@ static int odroid_audio_probe(struct platform_device *pdev)
 		ret = PTR_ERR(priv->clk_i2s_bus);
 		goto err_put_sclk;
 	}
-	of_node_put(cpu_dai);
 
 	ret = devm_snd_soc_register_card(dev, card);
 	if (ret < 0) {
@@ -316,6 +315,7 @@ static int odroid_audio_probe(struct platform_device *pdev)
 		goto err_put_clk_i2s;
 	}
 
+	of_node_put(cpu_dai);
 	of_node_put(codec);
 	return 0;
 
-- 
2.20.1

