Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57A9C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA42218EA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="LYkqkqea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbfGVQGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 12:06:41 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:22594 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729753AbfGVQGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 12:06:37 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6MG64sW016167;
        Mon, 22 Jul 2019 18:06:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=lMBXVdaWkpNK3eb/f1Th8IHqOU36gvkUYQ/xuGtXNQw=;
 b=LYkqkqea4BV4nkzQeT228vwRbHjFV7f7OhZhrHLXcGZtjQBUSO1GhqJWLzIVq9deWRh6
 e6b/FOCAu+HXpEBNsu4fU/Uxm8vmHwOSbqqlVY9WxcmOYaOAAIr/cNrkbi5c4iXL56UG
 gggeeJO4mxPS+kLnuKhJHiw6RpHtUyUvfasNUSZXTUf0K10bE5M5iIck+TGekRyZkWrK
 dJ3ACuS/2RfXP53EgcretzJ+9/PWgoGBkVkhCzDUpXOmgxnVD6CNbZvOUJyquRAYF7tp
 hcKTeBYuA6L3tWPpISLXPDiQvONw7p3zICdlD1/uqUsNvkPKMF8D4fOVmE/Uq8icBd6D iA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ture1chdv-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 22 Jul 2019 18:06:06 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F053831;
        Mon, 22 Jul 2019 16:06:05 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D3D6F52BB;
        Mon, 22 Jul 2019 16:06:05 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 22 Jul
 2019 18:06:05 +0200
Received: from localhost (10.201.23.16) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 22 Jul 2019 18:06:05
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <a.hajda@samsung.com>, <narmstrong@baylibre.com>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@siol.net>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <benjamin.gaignard@st.com>, <alexandre.torgue@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <olivier.moysan@st.com>, <jsarha@ti.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 3/3] drm/bridge: sii902x: make audio mclk optional
Date:   Mon, 22 Jul 2019 18:06:00 +0200
Message-ID: <1563811560-29589-4-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563811560-29589-1-git-send-email-olivier.moysan@st.com>
References: <1563811560-29589-1-git-send-email-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-22_12:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The master clock on i2s bus is not mandatory,
as sii902X internal PLL can be used instead.
Make use of mclk optional.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Reviewed-by: Jyri Sarha <jsarha@ti.com>
Acked-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/gpu/drm/bridge/sii902x.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 962931c20efe..a323815aa9b6 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -568,13 +568,14 @@ static int sii902x_audio_hw_params(struct device *dev, void *data,
 		return ret;
 	}
 
-	mclk_rate = clk_get_rate(sii902x->audio.mclk);
-
-	ret = sii902x_select_mclk_div(&i2s_config_reg, params->sample_rate,
-				      mclk_rate);
-	if (mclk_rate != ret * params->sample_rate)
-		dev_dbg(dev, "Inaccurate reference clock (%ld/%d != %u)\n",
-			mclk_rate, ret, params->sample_rate);
+	if (sii902x->audio.mclk) {
+		mclk_rate = clk_get_rate(sii902x->audio.mclk);
+		ret = sii902x_select_mclk_div(&i2s_config_reg,
+					      params->sample_rate, mclk_rate);
+		if (mclk_rate != ret * params->sample_rate)
+			dev_dbg(dev, "Inaccurate reference clock (%ld/%d != %u)\n",
+				mclk_rate, ret, params->sample_rate);
+	}
 
 	mutex_lock(&sii902x->mutex);
 
@@ -751,11 +752,11 @@ static int sii902x_audio_codec_init(struct sii902x *sii902x,
 		sii902x->audio.i2s_fifo_sequence[i] |= audio_fifo_id[i] |
 			i2s_lane_id[lanes[i]] |	SII902X_TPI_I2S_FIFO_ENABLE;
 
-	sii902x->audio.mclk = devm_clk_get(dev, "mclk");
+	sii902x->audio.mclk = devm_clk_get_optional(dev, "mclk");
 	if (IS_ERR(sii902x->audio.mclk)) {
 		dev_err(dev, "%s: No clock (audio mclk) found: %ld\n",
 			__func__, PTR_ERR(sii902x->audio.mclk));
-		return 0;
+		return PTR_ERR(sii902x->audio.mclk);
 	}
 
 	sii902x->audio.pdev = platform_device_register_data(
-- 
2.7.4

