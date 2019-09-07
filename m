Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95510C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 16:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B0921871
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 16:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395001AbfIGQhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 12:37:24 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:16955 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392062AbfIGQhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 12:37:23 -0400
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x87GawEt091896;
        Sun, 8 Sep 2019 01:36:58 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp);
 Sun, 08 Sep 2019 01:36:58 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp)
Received: from localhost.localdomain (118.153.231.153.ap.dti.ne.jp [153.231.153.118])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x87GatL2091872
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 8 Sep 2019 01:36:57 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Mark Brown <broonie@kernel.org>,
        David Yang <yangxiaohua@everest-semi.com>,
        Daniel Drake <drake@endlessm.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH 1/2] ASoC: es8316: fix redundant codes of clock
Date:   Sun,  8 Sep 2019 01:36:52 +0900
Message-Id: <20190907163653.9382-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes redundant null checks for optional MCLK clock.
And fix DT binding document for changing clock property to optional
from required.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 .../bindings/sound/everest,es8316.txt         |  3 ++
 sound/soc/codecs/es8316.c                     | 31 ++++++++-----------
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/everest,es8316.txt b/Documentation/devicetree/bindings/sound/everest,es8316.txt
index aefcff9c48a2..1bf03c5f2af4 100644
--- a/Documentation/devicetree/bindings/sound/everest,es8316.txt
+++ b/Documentation/devicetree/bindings/sound/everest,es8316.txt
@@ -6,6 +6,9 @@ Required properties:
 
   - compatible  : should be "everest,es8316"
   - reg : the I2C address of the device for I2C
+
+Optional properties:
+
   - clocks : a list of phandle, should contain entries for clock-names
   - clock-names : should include as follows:
          "mclk" : master clock (MCLK) of the device
diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index d07d50f51b28..1424ecd6952c 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -373,11 +373,9 @@ static int es8316_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	if (freq == 0)
 		return 0;
 
-	if (es8316->mclk) {
-		ret = clk_set_rate(es8316->mclk, freq);
-		if (ret)
-			return ret;
-	}
+	ret = clk_set_rate(es8316->mclk, freq);
+	if (ret)
+		return ret;
 
 	/* Limit supported sample rates to ones that can be autodetected
 	 * by the codec running in slave mode.
@@ -712,20 +710,18 @@ static int es8316_probe(struct snd_soc_component *component)
 
 	es8316->component = component;
 
-	es8316->mclk = devm_clk_get(component->dev, "mclk");
-	if (PTR_ERR(es8316->mclk) == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
+	es8316->mclk = devm_clk_get_optional(component->dev, "mclk");
 	if (IS_ERR(es8316->mclk)) {
-		dev_err(component->dev, "clock is invalid, ignored\n");
-		es8316->mclk = NULL;
+		dev_err(component->dev, "unable to get mclk\n");
+		return PTR_ERR(es8316->mclk);
 	}
+	if (!es8316->mclk)
+		dev_warn(component->dev, "assuming static mclk\n");
 
-	if (es8316->mclk) {
-		ret = clk_prepare_enable(es8316->mclk);
-		if (ret) {
-			dev_err(component->dev, "unable to enable clock\n");
-			return ret;
-		}
+	ret = clk_prepare_enable(es8316->mclk);
+	if (ret) {
+		dev_err(component->dev, "unable to enable mclk\n");
+		return ret;
 	}
 
 	/* Reset codec and enable current state machine */
@@ -754,8 +750,7 @@ static void es8316_remove(struct snd_soc_component *component)
 {
 	struct es8316_priv *es8316 = snd_soc_component_get_drvdata(component);
 
-	if (es8316->mclk)
-		clk_disable_unprepare(es8316->mclk);
+	clk_disable_unprepare(es8316->mclk);
 }
 
 static const struct snd_soc_component_driver soc_component_dev_es8316 = {
-- 
2.23.0.rc1

