Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88F0C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED142147C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfDCN0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:26:17 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:7214 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726624AbfDCN0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:26:07 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x33DLSS7019129;
        Wed, 3 Apr 2019 15:23:47 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rmgev46js-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 03 Apr 2019 15:23:47 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6656C31;
        Wed,  3 Apr 2019 13:23:46 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3A9B429C0;
        Wed,  3 Apr 2019 13:23:46 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 3 Apr 2019
 15:23:46 +0200
Received: from localhost (10.201.23.16) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.435.0; Wed, 3 Apr 2019 15:23:45
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <robh@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@st.com>,
        <apatard@mandriva.com>
Subject: [PATCH 4/7] ASoC: cs42l51: add support of master mode
Date:   Wed, 3 Apr 2019 15:23:34 +0200
Message-ID: <1554297817-14154-5-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554297817-14154-1-git-send-email-olivier.moysan@st.com>
References: <1554297817-14154-1-git-send-email-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support of master mode for cs42l51 cirrus audio codec.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/codecs/cs42l51.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 9b3ffa16b204..397b68901d1c 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -340,6 +340,19 @@ static struct cs42l51_ratios slave_auto_ratios[] = {
 	{  256, CS42L51_DSM_MODE, 1 }, {  384, CS42L51_DSM_MODE, 1 },
 };
 
+/*
+ * Master mode mclk/fs ratios.
+ * Recommended configurations are SSM for 4-50khz and DSM for 50-100kHz ranges
+ * The table below provides support of following ratios:
+ * 128: SSM (%128) with div2 disabled
+ * 256: SSM (%128) with div2 enabled
+ * In both cases, if sampling rate is above 50kHz, SSM is overridden
+ * with DSM (%128) configuration
+ */
+static struct cs42l51_ratios master_ratios[] = {
+	{ 128, CS42L51_SSM_MODE, 0 }, { 256, CS42L51_SSM_MODE, 1 },
+};
+
 static int cs42l51_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
@@ -362,11 +375,13 @@ static int cs42l51_hw_params(struct snd_pcm_substream *substream,
 	unsigned int ratio;
 	struct cs42l51_ratios *ratios = NULL;
 	int nr_ratios = 0;
-	int intf_ctl, power_ctl, fmt;
+	int intf_ctl, power_ctl, fmt, mode;
 
 	switch (cs42l51->func) {
 	case MODE_MASTER:
-		return -EINVAL;
+		ratios = master_ratios;
+		nr_ratios = ARRAY_SIZE(master_ratios);
+		break;
 	case MODE_SLAVE:
 		ratios = slave_ratios;
 		nr_ratios = ARRAY_SIZE(slave_ratios);
@@ -402,7 +417,16 @@ static int cs42l51_hw_params(struct snd_pcm_substream *substream,
 	switch (cs42l51->func) {
 	case MODE_MASTER:
 		intf_ctl |= CS42L51_INTF_CTL_MASTER;
-		power_ctl |= CS42L51_MIC_POWER_CTL_SPEED(ratios[i].speed_mode);
+		mode = ratios[i].speed_mode;
+		/* Force DSM mode if sampling rate is above 50kHz */
+		if (rate > 50000)
+			mode = CS42L51_DSM_MODE;
+		power_ctl |= CS42L51_MIC_POWER_CTL_SPEED(mode);
+		/*
+		 * Auto detect mode is not applicable for master mode and has to
+		 * be disabled. Otherwise SPEED[1:0] bits will be ignored.
+		 */
+		power_ctl &= ~CS42L51_MIC_POWER_CTL_AUTO;
 		break;
 	case MODE_SLAVE:
 		power_ctl |= CS42L51_MIC_POWER_CTL_SPEED(ratios[i].speed_mode);
-- 
2.7.4

