Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0580C76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A837E21901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ENmhN0C6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbfGVQGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 12:06:37 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:62586 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729549AbfGVQGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 12:06:37 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6MG65b1016173;
        Mon, 22 Jul 2019 18:06:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=sRoYw+gjO4V6WYQIFcpRmA6lrUT15ghe8XN5XQ6WRiw=;
 b=ENmhN0C6R269ohYvCIwqgaPJaskoRN8XZL4LQkM79yJFsTwQpADo53fEnn+29fWz3J1g
 oKUilDC980iSXubGcBcUWfiWTPHWZ8DZ7d8LPJKY4/BxPv5X3YmzvHg6OMwtW4WGJT/f
 GTKVt/PU0FJwwZA3f75q4/1ZN49iErJ3kxI5gHkZp0tzqCYmeWFVp8qRDXwJUbOje/6D
 czNkGuUOPtKyvcgzlGfWp/REkArNZsbY4R+bBwB3Uw2LStsvsxK1uj2RnNzC9yUPHmnS
 DZeebg5mmVTLxHEv6wUaDSvBm583PwId0Iq4vhI2ugIyBQNgobrl3ErxIz6Hnbx3nexg MQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ture1chdr-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 22 Jul 2019 18:06:05 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EDCE134;
        Mon, 22 Jul 2019 16:06:03 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BD08A52BD;
        Mon, 22 Jul 2019 16:06:03 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 22 Jul
 2019 18:06:03 +0200
Received: from localhost (10.201.23.16) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 22 Jul 2019 18:06:03
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
Subject: [PATCH v2 1/3] drm/bridge: sii902x: fix missing reference to mclk clock
Date:   Mon, 22 Jul 2019 18:05:58 +0200
Message-ID: <1563811560-29589-2-git-send-email-olivier.moysan@st.com>
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

Add devm_clk_get call to retrieve reference to master clock.

Fixes: ff5781634c41 ("drm/bridge: sii902x: Implement HDMI audio support")

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Reviewed-by: Jyri Sarha <jsarha@ti.com>
Acked-by: Andrzej Hajda <a.hajda@samsung.com
---
 drivers/gpu/drm/bridge/sii902x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index c2f97e5997a1..962931c20efe 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -751,6 +751,7 @@ static int sii902x_audio_codec_init(struct sii902x *sii902x,
 		sii902x->audio.i2s_fifo_sequence[i] |= audio_fifo_id[i] |
 			i2s_lane_id[lanes[i]] |	SII902X_TPI_I2S_FIFO_ENABLE;
 
+	sii902x->audio.mclk = devm_clk_get(dev, "mclk");
 	if (IS_ERR(sii902x->audio.mclk)) {
 		dev_err(dev, "%s: No clock (audio mclk) found: %ld\n",
 			__func__, PTR_ERR(sii902x->audio.mclk));
-- 
2.7.4

