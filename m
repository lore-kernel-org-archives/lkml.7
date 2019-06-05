Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04C4C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944CE20870
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfFENmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 09:42:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:51941 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbfFENml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 09:42:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 06:42:41 -0700
X-ExtLoop1: 1
Received: from xxx.igk.intel.com ([10.237.93.170])
  by orsmga004.jf.intel.com with ESMTP; 05 Jun 2019 06:42:39 -0700
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH 09/14] ASoC: Intel: Skylake: Fix NULL ptr dereference when unloading clk dev
Date:   Wed,  5 Jun 2019 15:45:51 +0200
Message-Id: <20190605134556.10322-10-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605134556.10322-1-amadeuszx.slawinski@linux.intel.com>
References: <20190605134556.10322-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When driver is probed, we iterate over NHLT and check if clk entries are
present. For each such entry we call register_skl_clk and keep the
result in data->clk[].
Currently data->clk is sparsely indexed using NHLT table iterator, while
when freeing we use number of registered entries. Let's just use
data->avail_clk_cnt as index, so it can be reset back in
unregister_src_clk.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/intel/skylake/skl-ssp-clk.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-ssp-clk.c b/sound/soc/intel/skylake/skl-ssp-clk.c
index cda1b5fa7436..5bb6e40d4d3e 100644
--- a/sound/soc/intel/skylake/skl-ssp-clk.c
+++ b/sound/soc/intel/skylake/skl-ssp-clk.c
@@ -276,10 +276,8 @@ static void unregister_parent_src_clk(struct skl_clk_parent *pclk,
 
 static void unregister_src_clk(struct skl_clk_data *dclk)
 {
-	u8 cnt = dclk->avail_clk_cnt;
-
-	while (cnt--)
-		clkdev_drop(dclk->clk[cnt]->lookup);
+	while (dclk->avail_clk_cnt--)
+		clkdev_drop(dclk->clk[dclk->avail_clk_cnt]->lookup);
 }
 
 static int skl_register_parent_clks(struct device *dev,
@@ -381,13 +379,13 @@ static int skl_clk_dev_probe(struct platform_device *pdev)
 		if (clks[i].rate_cfg[0].rate == 0)
 			continue;
 
-		data->clk[i] = register_skl_clk(dev, &clks[i], clk_pdata, i);
-		if (IS_ERR(data->clk[i])) {
-			ret = PTR_ERR(data->clk[i]);
+		data->clk[data->avail_clk_cnt] = register_skl_clk(dev,
+				&clks[i], clk_pdata, i);
+
+		if (IS_ERR(data->clk[data->avail_clk_cnt])) {
+			ret = PTR_ERR(data->clk[data->avail_clk_cnt++]);
 			goto err_unreg_skl_clk;
 		}
-
-		data->avail_clk_cnt++;
 	}
 
 	platform_set_drvdata(pdev, data);
-- 
2.17.1

