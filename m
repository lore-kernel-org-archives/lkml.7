Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD3EC5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D2421897
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="xszA75fY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfGCIEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 04:04:46 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:26448 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726670AbfGCIEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:04:46 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x637rQ6P011005;
        Wed, 3 Jul 2019 10:04:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=Me2aIVtHkOwy84/SxLI2Xnts7qdQwbxVRhp1y4JNm4U=;
 b=xszA75fYJmgBnFtufF/fyMNT8ZY1A4LbSlEKstxr/xjye2iA6Hm+/HSoVN5izM6WFILS
 Fl690awtgTlr3w7LOAlH0Nt6/VDHHIZhyJQ3ICqlhhRjhnttP0dRV+OxNYmu+1avUHRY
 yHxolqUTOGod5kvDpxoYE6qrMnTwGYnk1jnypkgP1bFOiJqW8gxZADRSwSRBNStFteup
 QQPNg0N9J7J1DmGe4sITKKibHagNPzfX0n/E7y9c/iyPLMQNiogQ1QEhS24XPidLgE/X
 b7wPl7nKOj2vjB0g3kKUXOURArS5DX4OXQMu5xQTulab/e6J76r+MElhnp6rbKagEQTW nQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2tdw4a28d7-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 03 Jul 2019 10:04:19 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0858641;
        Wed,  3 Jul 2019 08:04:15 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AA7E0169F;
        Wed,  3 Jul 2019 08:04:15 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 3 Jul 2019
 10:04:15 +0200
Received: from localhost (10.201.23.16) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 3 Jul 2019 10:04:14
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <a.hajda@samsung.com>, <narmstrong@baylibre.com>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@siol.net>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <benjamin.gaignard@st.com>, <alexandre.torgue@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <olivier.moysan@st.com>, <jsarha@ti.com>
Subject: [PATCH] drm/bridge: sii902x: add audio graph card support
Date:   Wed, 3 Jul 2019 10:04:12 +0200
Message-ID: <1562141052-26221-1-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-03_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement get_dai_id callback of audio HDMI codec
to support ASoC audio graph card.
HDMI audio output has to be connected to sii902x port 3.
get_dai_id callback maps this port to ASoC DAI index 0.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 drivers/gpu/drm/bridge/sii902x.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index dd7aa466b280..daf9ef3cd817 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -158,6 +158,8 @@
 
 #define SII902X_I2C_BUS_ACQUISITION_TIMEOUT_MS	500
 
+#define SII902X_AUDIO_PORT_INDEX		3
+
 struct sii902x {
 	struct i2c_client *i2c;
 	struct regmap *regmap;
@@ -690,11 +692,32 @@ static int sii902x_audio_get_eld(struct device *dev, void *data,
 	return 0;
 }
 
+static int sii902x_audio_get_dai_id(struct snd_soc_component *component,
+				    struct device_node *endpoint)
+{
+	struct of_endpoint of_ep;
+	int ret;
+
+	ret = of_graph_parse_endpoint(endpoint, &of_ep);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * HDMI sound should be located at reg = <3>
+	 * Return expected DAI index 0.
+	 */
+	if (of_ep.port == SII902X_AUDIO_PORT_INDEX)
+		return 0;
+
+	return -EINVAL;
+}
+
 static const struct hdmi_codec_ops sii902x_audio_codec_ops = {
 	.hw_params = sii902x_audio_hw_params,
 	.audio_shutdown = sii902x_audio_shutdown,
 	.digital_mute = sii902x_audio_digital_mute,
 	.get_eld = sii902x_audio_get_eld,
+	.get_dai_id = sii902x_audio_get_dai_id,
 };
 
 static int sii902x_audio_codec_init(struct sii902x *sii902x,
-- 
2.7.4

