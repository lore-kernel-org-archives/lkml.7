Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429F0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18392218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbfC2Pil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:38:41 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:28146 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728815AbfC2Pil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:38:41 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2TFao5K004311;
        Fri, 29 Mar 2019 16:37:41 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rhg9w22ex-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 29 Mar 2019 16:37:41 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3A51631;
        Fri, 29 Mar 2019 15:37:40 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0697D4E8C;
        Fri, 29 Mar 2019 15:37:40 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 29 Mar
 2019 16:37:39 +0100
Received: from localhost (10.201.23.16) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.435.0; Fri, 29 Mar 2019 16:37:39
 +0100
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>,
        <arnaud.pouliquen@st.com>
CC:     <benjamin.gaignard@st.com>, <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH] ASoC: cs42l51: add multi endpoint support
Date:   Fri, 29 Mar 2019 16:37:37 +0100
Message-ID: <1553873857-7423-1-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-29_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support multiple endpoints on cs42L51 codec port
when used in of_graph context.

This patch allows to share the codec port between two CPU DAIs.

Example:

STM32MP157C-DK2 board uses CS42L51 audio codec.
This codec is connected to two serial audio interfaces,
which are configured either as rx or tx.

From AsoC point of view the topolgy is the following:
// 2 CPU DAIs (SAI2A/B), 1 Codec (CS42L51)
Playback: CPU-A-DAI(slave) -> (master)CODEC-DAI/port0
Record:   CPU-B-DAI(slave) <- (master)CODEC-DAI/port0

In the DT two endpoints have to be associated to the codec port:
cs42l51_port: port {
	cs42l51_tx_endpoint: endpoint@0 {
		remote-endpoint = <&sai2a_endpoint>;
	};
	cs42l51_rx_endpoint: endpoint@1 {
		remote-endpoint = <&sai2b_endpoint>;
	};
};

However, when the audio graph card parses the codec nodes, it expects
to find DAI interface indexes matching the endpoints indexes.

The current patch forces the use of DAI id 0 for both endpoints,
which allows to share the codec DAI between the two CPU DAIs
for playback and capture streams respectively.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/codecs/cs42l51.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index fd2bd74024c1..80da3cd73e04 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -464,6 +464,13 @@ static int cs42l51_dai_mute(struct snd_soc_dai *dai, int mute)
 	return snd_soc_component_write(component, CS42L51_DAC_OUT_CTL, reg);
 }
 
+static int cs42l51_of_xlate_dai_id(struct snd_soc_component *component,
+				   struct device_node *endpoint)
+{
+	/* return dai id 0, whatever the endpoint index */
+	return 0;
+}
+
 static const struct snd_soc_dai_ops cs42l51_dai_ops = {
 	.hw_params      = cs42l51_hw_params,
 	.set_sysclk     = cs42l51_set_dai_sysclk,
@@ -526,6 +533,7 @@ static const struct snd_soc_component_driver soc_component_device_cs42l51 = {
 	.num_dapm_widgets	= ARRAY_SIZE(cs42l51_dapm_widgets),
 	.dapm_routes		= cs42l51_routes,
 	.num_dapm_routes	= ARRAY_SIZE(cs42l51_routes),
+	.of_xlate_dai_id	= cs42l51_of_xlate_dai_id,
 	.idle_bias_on		= 1,
 	.use_pmdown_time	= 1,
 	.endianness		= 1,
-- 
2.7.4

