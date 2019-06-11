Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0184DC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D772089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Qw8uP+ee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbfFKM3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 08:29:33 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48058 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbfFKM3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 08:29:22 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5BCTHZt128314;
        Tue, 11 Jun 2019 07:29:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560256157;
        bh=11RvASRP5mCGKkGEtizEUSkyQYW8HPiSCQc8womaJwQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Qw8uP+eeB5XQO8+ZJcESs3JvHddmzqRRxipKHMid590PezUsOBkJM6Rh/28lqkatz
         px7Jnq3Ke2zNneVOYdVOiUi5LrknjdxotjDLcuoEYPIH3IMTHeTOZRdadjZwUXrdlF
         WxLwvqOMdfTthzD6iUsJ37H5ejLgzoFn7u56HnzE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5BCTHwK054673
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Jun 2019 07:29:17 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 11
 Jun 2019 07:29:16 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 11 Jun 2019 07:29:16 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5BCT9s8010308;
        Tue, 11 Jun 2019 07:29:14 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>
CC:     <alsa-devel@alsa-project.org>, <misael.lopez@ti.com>,
        <jsarha@ti.com>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] ASoC: ti: davinci-mcasp: Support for auxclk-fs-ratio
Date:   Tue, 11 Jun 2019 15:29:41 +0300
Message-ID: <20190611122941.10708-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190611122941.10708-1-peter.ujfalusi@ti.com>
References: <20190611122941.10708-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When McASP is bus master and it's AUXCLK clock is not static, but it is
a multiple of the frame sync the constraint rules should take it account
when validating possible stream formats.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/ti/davinci-mcasp.c | 52 ++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 8 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index 9fbc759fdefe..a8378d223a9e 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -100,6 +100,7 @@ struct davinci_mcasp {
 
 	int	sysclk_freq;
 	bool	bclk_master;
+	u32	auxclk_fs_ratio;
 
 	unsigned long pdir; /* Pin direction bitfield */
 
@@ -1064,13 +1065,13 @@ static int mcasp_dit_hw_param(struct davinci_mcasp *mcasp,
 }
 
 static int davinci_mcasp_calc_clk_div(struct davinci_mcasp *mcasp,
+				      unsigned int sysclk_freq,
 				      unsigned int bclk_freq, bool set)
 {
-	int error_ppm;
-	unsigned int sysclk_freq = mcasp->sysclk_freq;
 	u32 reg = mcasp_get_reg(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG);
 	int div = sysclk_freq / bclk_freq;
 	int rem = sysclk_freq % bclk_freq;
+	int error_ppm;
 	int aux_div = 1;
 
 	if (div > (ACLKXDIV_MASK + 1)) {
@@ -1175,7 +1176,8 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 		if (mcasp->slot_width)
 			sbits = mcasp->slot_width;
 
-		davinci_mcasp_calc_clk_div(mcasp, rate * sbits * slots, true);
+		davinci_mcasp_calc_clk_div(mcasp, mcasp->sysclk_freq,
+					   rate * sbits * slots, true);
 	}
 
 	ret = mcasp_common_hw_param(mcasp, substream->stream,
@@ -1282,12 +1284,19 @@ static int davinci_mcasp_hw_rule_rate(struct snd_pcm_hw_params *params,
 
 	for (i = 0; i < ARRAY_SIZE(davinci_mcasp_dai_rates); i++) {
 		if (snd_interval_test(ri, davinci_mcasp_dai_rates[i])) {
-			uint bclk_freq = sbits*slots*
-				davinci_mcasp_dai_rates[i];
+			uint bclk_freq = sbits * slots *
+					 davinci_mcasp_dai_rates[i];
+			unsigned int sysclk_freq;
 			int ppm;
 
-			ppm = davinci_mcasp_calc_clk_div(rd->mcasp, bclk_freq,
-							 false);
+			if (rd->mcasp->auxclk_fs_ratio)
+				sysclk_freq =  davinci_mcasp_dai_rates[i] *
+					       rd->mcasp->auxclk_fs_ratio;
+			else
+				sysclk_freq = rd->mcasp->sysclk_freq;
+
+			ppm = davinci_mcasp_calc_clk_div(rd->mcasp, sysclk_freq,
+							 bclk_freq, false);
 			if (abs(ppm) < DAVINCI_MAX_RATE_ERROR_PPM) {
 				if (range.empty) {
 					range.min = davinci_mcasp_dai_rates[i];
@@ -1321,12 +1330,19 @@ static int davinci_mcasp_hw_rule_format(struct snd_pcm_hw_params *params,
 	for (i = 0; i <= SNDRV_PCM_FORMAT_LAST; i++) {
 		if (snd_mask_test(fmt, i)) {
 			uint sbits = snd_pcm_format_width(i);
+			unsigned int sysclk_freq;
 			int ppm;
 
+			if (rd->mcasp->auxclk_fs_ratio)
+				sysclk_freq =  rate *
+					       rd->mcasp->auxclk_fs_ratio;
+			else
+				sysclk_freq = rd->mcasp->sysclk_freq;
+
 			if (rd->mcasp->slot_width)
 				sbits = rd->mcasp->slot_width;
 
-			ppm = davinci_mcasp_calc_clk_div(rd->mcasp,
+			ppm = davinci_mcasp_calc_clk_div(rd->mcasp, sysclk_freq,
 							 sbits * slots * rate,
 							 false);
 			if (abs(ppm) < DAVINCI_MAX_RATE_ERROR_PPM) {
@@ -1991,6 +2007,22 @@ static inline int davinci_mcasp_init_gpiochip(struct davinci_mcasp *mcasp)
 }
 #endif /* CONFIG_GPIOLIB */
 
+static int davinci_mcasp_get_dt_params(struct davinci_mcasp *mcasp)
+{
+	struct device_node *np = mcasp->dev->of_node;
+	int ret;
+	u32 val;
+
+	if (!np)
+		return 0;
+
+	ret = of_property_read_u32(np, "auxclk-fs-ratio", &val);
+	if (ret >= 0)
+		mcasp->auxclk_fs_ratio = val;
+
+	return 0;
+}
+
 static int davinci_mcasp_probe(struct platform_device *pdev)
 {
 	struct snd_dmaengine_dai_dma_data *dma_data;
@@ -2224,6 +2256,10 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
+	ret = davinci_mcasp_get_dt_params(mcasp);
+	if (ret)
+		return -EINVAL;
+
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					&davinci_mcasp_component,
 					&davinci_mcasp_dai[pdata->op_mode], 1);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

