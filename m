Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16066C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 06:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70C120C01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 06:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbfHTGQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 02:16:20 -0400
Received: from mx.socionext.com ([202.248.49.38]:58469 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728960AbfHTGQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 02:16:20 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 20 Aug 2019 15:16:18 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id CFEDF605F8;
        Tue, 20 Aug 2019 15:16:18 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 20 Aug 2019 15:16:18 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 4DF4B1A04FC;
        Tue, 20 Aug 2019 15:16:18 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] ASoC: uniphier: Fix double reset assersion when transitioning to suspend state
Date:   Tue, 20 Aug 2019 15:16:04 +0900
Message-Id: <1566281764-14059-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When transitioning to supend state, uniphier_aio_dai_suspend() is called
and asserts reset lines and disables clocks.

However, if there are two or more DAIs, uniphier_aio_dai_suspend() are
called multiple times, and double reset assersion will cause.

This patch defines the counter that has the number of DAIs at first, and
whenever uniphier_aio_dai_suspend() are called, it decrements the
counter. And only if the counter is zero, it asserts reset lines and
disables clocks.

In the same way, uniphier_aio_dai_resume() are called, it increments the
counter after deasserting reset lines and enabling clocks.

Fixes: 139a34200233 ("ASoC: uniphier: add support for UniPhier AIO CPU DAI driver")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 sound/soc/uniphier/aio-cpu.c | 31 +++++++++++++++++++++----------
 sound/soc/uniphier/aio.h     |  1 +
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/sound/soc/uniphier/aio-cpu.c b/sound/soc/uniphier/aio-cpu.c
index ee90e6c..2ae582a 100644
--- a/sound/soc/uniphier/aio-cpu.c
+++ b/sound/soc/uniphier/aio-cpu.c
@@ -424,8 +424,11 @@ int uniphier_aio_dai_suspend(struct snd_soc_dai *dai)
 {
 	struct uniphier_aio *aio = uniphier_priv(dai);
 
-	reset_control_assert(aio->chip->rst);
-	clk_disable_unprepare(aio->chip->clk);
+	aio->chip->num_wup_aios--;
+	if (!aio->chip->num_wup_aios) {
+		reset_control_assert(aio->chip->rst);
+		clk_disable_unprepare(aio->chip->clk);
+	}
 
 	return 0;
 }
@@ -439,13 +442,15 @@ int uniphier_aio_dai_resume(struct snd_soc_dai *dai)
 	if (!aio->chip->active)
 		return 0;
 
-	ret = clk_prepare_enable(aio->chip->clk);
-	if (ret)
-		return ret;
+	if (!aio->chip->num_wup_aios) {
+		ret = clk_prepare_enable(aio->chip->clk);
+		if (ret)
+			return ret;
 
-	ret = reset_control_deassert(aio->chip->rst);
-	if (ret)
-		goto err_out_clock;
+		ret = reset_control_deassert(aio->chip->rst);
+		if (ret)
+			goto err_out_clock;
+	}
 
 	aio_iecout_set_enable(aio->chip, true);
 	aio_chip_init(aio->chip);
@@ -458,7 +463,7 @@ int uniphier_aio_dai_resume(struct snd_soc_dai *dai)
 
 		ret = aio_init(sub);
 		if (ret)
-			goto err_out_clock;
+			goto err_out_reset;
 
 		if (!sub->setting)
 			continue;
@@ -466,11 +471,16 @@ int uniphier_aio_dai_resume(struct snd_soc_dai *dai)
 		aio_port_reset(sub);
 		aio_src_reset(sub);
 	}
+	aio->chip->num_wup_aios++;
 
 	return 0;
 
+err_out_reset:
+	if (!aio->chip->num_wup_aios)
+		reset_control_assert(aio->chip->rst);
 err_out_clock:
-	clk_disable_unprepare(aio->chip->clk);
+	if (!aio->chip->num_wup_aios)
+		clk_disable_unprepare(aio->chip->clk);
 
 	return ret;
 }
@@ -619,6 +629,7 @@ int uniphier_aio_probe(struct platform_device *pdev)
 		return PTR_ERR(chip->rst);
 
 	chip->num_aios = chip->chip_spec->num_dais;
+	chip->num_wup_aios = chip->num_aios;
 	chip->aios = devm_kcalloc(dev,
 				  chip->num_aios, sizeof(struct uniphier_aio),
 				  GFP_KERNEL);
diff --git a/sound/soc/uniphier/aio.h b/sound/soc/uniphier/aio.h
index ca6ccba..a7ff7e5 100644
--- a/sound/soc/uniphier/aio.h
+++ b/sound/soc/uniphier/aio.h
@@ -285,6 +285,7 @@ struct uniphier_aio_chip {
 
 	struct uniphier_aio *aios;
 	int num_aios;
+	int num_wup_aios;
 	struct uniphier_aio_pll *plls;
 	int num_plls;
 
-- 
2.7.4

