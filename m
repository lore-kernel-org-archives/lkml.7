Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D90FA372B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 06:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C03214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 06:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392595AbfJQGX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 02:23:57 -0400
Received: from inva021.nxp.com ([92.121.34.21]:54160 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727653AbfJQGX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 02:23:57 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CF242200031;
        Thu, 17 Oct 2019 08:23:54 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8322220004C;
        Thu, 17 Oct 2019 08:23:49 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 11186402B4;
        Thu, 17 Oct 2019 14:23:42 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_asrc: refine the setting of internal clock divider
Date:   Thu, 17 Oct 2019 14:21:08 +0800
Message-Id: <1571293268-5146-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For P2P output, the output divider should align with the output sample
rate, if use ideal sample rate, there will be a lot of overload, which
would cause underrun.

The maximum divider of asrc clock is 1024, but there is no judgement
for this limitaion in driver, which may cause the divider setting not
correct.

For non-ideal ratio mode, the clock rate should divide the sample rate
with no remainder, and the quotient should be less than 1024.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_asrc.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 0bf91a6f54b9..44d05ec28bd3 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -260,7 +260,7 @@ static int fsl_asrc_set_ideal_ratio(struct fsl_asrc_pair *pair,
  * of struct asrc_config which includes in/output sample rate, width, channel
  * and clock settings.
  */
-static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
+static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair, bool p2p)
 {
 	struct asrc_config *config = pair->config;
 	struct fsl_asrc *asrc_priv = pair->asrc_priv;
@@ -268,7 +268,8 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
 	enum asrc_word_width input_word_width;
 	enum asrc_word_width output_word_width;
 	u32 inrate, outrate, indiv, outdiv;
-	u32 clk_index[2], div[2];
+	u32 clk_index[2], div[2], rem[2];
+	u64 clk_rate;
 	int in, out, channels;
 	int pre_proc, post_proc;
 	struct clk *clk;
@@ -351,7 +352,9 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
 	/* We only have output clock for ideal ratio mode */
 	clk = asrc_priv->asrck_clk[clk_index[ideal ? OUT : IN]];
 
-	div[IN] = clk_get_rate(clk) / inrate;
+	clk_rate = clk_get_rate(clk);
+	rem[IN] = do_div(clk_rate, inrate);
+	div[IN] = (u32)clk_rate;
 	if (div[IN] == 0) {
 		pair_err("failed to support input sample rate %dHz by asrck_%x\n",
 				inrate, clk_index[ideal ? OUT : IN]);
@@ -360,11 +363,20 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
 
 	clk = asrc_priv->asrck_clk[clk_index[OUT]];
 
-	/* Use fixed output rate for Ideal Ratio mode (INCLK_NONE) */
-	if (ideal)
-		div[OUT] = clk_get_rate(clk) / IDEAL_RATIO_RATE;
-	else
-		div[OUT] = clk_get_rate(clk) / outrate;
+	/*
+	 * When P2P mode, output rate should align with the out samplerate.
+	 * if set too high output rate, there will be lots of Overload.
+	 * When M2M mode, output rate should also need to align with the out
+	 * samplerate, but M2M must use less time to achieve good performance.
+	 */
+	clk_rate = clk_get_rate(clk);
+	if (p2p || !ideal) {
+		rem[OUT] = do_div(clk_rate, outrate);
+		div[OUT] = clk_rate;
+	} else {
+		rem[OUT] = do_div(clk_rate, IDEAL_RATIO_RATE);
+		div[OUT] = clk_rate;
+	}
 
 	if (div[OUT] == 0) {
 		pair_err("failed to support output sample rate %dHz by asrck_%x\n",
@@ -372,6 +384,16 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
 		return -EINVAL;
 	}
 
+	if (!ideal && (div[IN] > 1024 || div[OUT] > 1024 ||
+		       rem[IN] != 0 || rem[OUT] != 0)) {
+		pair_err("The divider can't be used for non ideal mode\n");
+		return -EINVAL;
+	}
+
+	/* Divider range is [1, 1024] */
+	div[IN] = min_t(u32, 1024, div[IN]);
+	div[OUT] = min_t(u32, 1024, div[OUT]);
+
 	/* Set the channel number */
 	channels = config->channel_num;
 
@@ -560,7 +582,7 @@ static int fsl_asrc_dai_hw_params(struct snd_pcm_substream *substream,
 		config.output_sample_rate = rate;
 	}
 
-	ret = fsl_asrc_config_pair(pair);
+	ret = fsl_asrc_config_pair(pair, true);
 	if (ret) {
 		dev_err(dai->dev, "fail to config asrc pair\n");
 		return ret;
-- 
2.21.0

