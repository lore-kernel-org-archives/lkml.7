Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47092C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 03:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0317A2067C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 03:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfE2D2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 23:28:31 -0400
Received: from inva021.nxp.com ([92.121.34.21]:45194 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfE2D2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 23:28:30 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9F1DA200379;
        Wed, 29 May 2019 05:28:28 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DEB9F200009;
        Wed, 29 May 2019 05:28:24 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id F07D4402AE;
        Wed, 29 May 2019 11:28:19 +0800 (SGT)
From:   shengjiu.wang@nxp.com
To:     brian.austin@cirrus.com, Paul.Handrigan@cirrus.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: cs42xx8: Fix build error with CONFIG_GPIOLIB is not set
Date:   Wed, 29 May 2019 11:30:02 +0800
Message-Id: <20190529033002.16606-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shengjiu Wang <shengjiu.wang@nxp.com>

config: x86_64-randconfig-x000201921-201921
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        make ARCH=x86_64

sound/soc/codecs/cs42xx8.c: In function ‘cs42xx8_probe’:
sound/soc/codecs/cs42xx8.c:472:25: error: implicit declaration of function ‘devm_gpiod_get_optional’; did you mean ‘devm_clk_get_optional’? [-Werror=implicit-function-declaration]
  cs42xx8->gpiod_reset = devm_gpiod_get_optional(dev, "reset",
                         ^~~~~~~~~~~~~~~~~~~~~~~
                         devm_clk_get_optional
sound/soc/codecs/cs42xx8.c:473:8: error: ‘GPIOD_OUT_HIGH’ undeclared (first use in this function); did you mean ‘GPIOF_INIT_HIGH’?
        GPIOD_OUT_HIGH);
        ^~~~~~~~~~~~~~
        GPIOF_INIT_HIGH
sound/soc/codecs/cs42xx8.c:473:8: note: each undeclared identifier is reported only once for each function it appears in
sound/soc/codecs/cs42xx8.c:477:2: error: implicit declaration of function ‘gpiod_set_value_cansleep’; did you mean ‘gpio_set_value_cansleep’? [-Werror=implicit-function-declaration]
  gpiod_set_value_cansleep(cs42xx8->gpiod_reset, 0);
  ^~~~~~~~~~~~~~~~~~~~~~~~
  gpio_set_value_cansleep

Fixes: bfe95dfa4dac ("ASoC: cs42xx8: Add reset gpio handling")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/codecs/cs42xx8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42xx8.c b/sound/soc/codecs/cs42xx8.c
index 3e8dbf63adbe..3bbc62322dfe 100644
--- a/sound/soc/codecs/cs42xx8.c
+++ b/sound/soc/codecs/cs42xx8.c
@@ -14,7 +14,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <sound/pcm_params.h>
-- 
2.21.0

