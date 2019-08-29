Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF3DC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DB121874
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 17:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfH2Rci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 13:32:38 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:48892 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbfH2Rch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 13:32:37 -0400
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x7THWCGr023722;
        Fri, 30 Aug 2019 02:32:12 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp);
 Fri, 30 Aug 2019 02:32:12 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp)
Received: from localhost.localdomain (118.153.231.153.ap.dti.ne.jp [153.231.153.118])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x7THW6NN023682
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 30 Aug 2019 02:32:11 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Mark Brown <broonie@kernel.org>,
        David Yang <yangxiaohua@everest-semi.com>,
        Daniel Drake <drake@endlessm.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH 2/3] ASoC: es8316: Add clock control of MCLK
Date:   Fri, 30 Aug 2019 02:32:04 +0900
Message-Id: <20190829173205.11805-2-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190829173205.11805-1-katsuhiro@katsuster.net>
References: <20190829173205.11805-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduce clock property for MCLK master freq control.
Driver will set rate of MCLK master if set_sysclk is called and
changing sysclk by board driver.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 sound/soc/codecs/es8316.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 229808fa627c..9ed564eac202 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -9,6 +9,7 @@
 
 #include <linux/module.h>
 #include <linux/acpi.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/mod_devicetable.h>
@@ -33,6 +34,7 @@ static const unsigned int supported_mclk_lrck_ratios[] = {
 
 struct es8316_priv {
 	struct mutex lock;
+	struct clk *mclk;
 	struct regmap *regmap;
 	struct snd_soc_component *component;
 	struct snd_soc_jack *jack;
@@ -363,12 +365,19 @@ static int es8316_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 {
 	struct snd_soc_component *component = codec_dai->component;
 	struct es8316_priv *es8316 = snd_soc_component_get_drvdata(component);
+	int ret;
 
 	es8316->sysclk = freq;
 
 	if (freq == 0)
 		return 0;
 
+	if (es8316->mclk) {
+		ret = clk_set_rate(es8316->mclk, freq);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -693,9 +702,20 @@ static int es8316_set_jack(struct snd_soc_component *component,
 static int es8316_probe(struct snd_soc_component *component)
 {
 	struct es8316_priv *es8316 = snd_soc_component_get_drvdata(component);
+	int ret;
 
 	es8316->component = component;
 
+	es8316->mclk = devm_clk_get(component->dev, "mclk");
+	if (PTR_ERR(es8316->mclk) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	if (es8316->mclk) {
+		ret = clk_prepare_enable(es8316->mclk);
+		if (ret)
+			return ret;
+	}
+
 	/* Reset codec and enable current state machine */
 	snd_soc_component_write(component, ES8316_RESET, 0x3f);
 	usleep_range(5000, 5500);
-- 
2.23.0.rc1

