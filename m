Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9C5C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525552071E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="kOfanqpR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfK0KXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 05:23:31 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:8796 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726149AbfK0KXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 05:23:30 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARAI6oZ024345;
        Wed, 27 Nov 2019 11:23:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=nRnCfDOyz8UKlH1ej2bd+91eyXIv7FWz+tcHNpHp4WI=;
 b=kOfanqpRLE2X5OrdBPfGaTDLlOFrumNPxqc7RurAe1I3jLcFvaNiJU//PE/Lnujs8qoC
 DsqtMYOd44gy77KydQ/V2SH0hgd9srdp3Ji0zhw7yWqc7pxP+x849gQoEL3dCxmbVBYV
 XWVMbrdmBtzVa/x3S9eQ+hQWf+qLbasdhd8bO2B8bSzWMiSFjmirfvG96cALT2Mhaqcv
 ZX94+A54k/LwzQ9gbVtbmvDX29sg2enBMz5m+pFP+c4ajsxvOvNSXA5Yhce1k8phO9hw
 Y5s2EJNu/YquovOlayUOjL/HcK0PQ+EyOFvKEtEM/WJN8fyupT6nXjpgClf607+N8i7z 6w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2whcxkjxr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Nov 2019 11:23:21 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3552B100039;
        Wed, 27 Nov 2019 11:23:16 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 87F9B2B1213;
        Wed, 27 Nov 2019 11:23:16 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Nov 2019 11:23:15
 +0100
From:   Yannick Fertre <yannick.fertre@st.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/bridge/synopsys: dsi: read status error during transfer
Date:   Wed, 27 Nov 2019 11:23:13 +0100
Message-ID: <1574850193-13197-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_02:2019-11-27,2019-11-27 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yannick Fertré <yannick.fertre@st.com>

Read the DSI_INT_ST1 status register to check if
errors occur while reading/writing a command to panel.
In case of error, the transfer is retried 3 times.

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 99 +++++++++++++++++++++++----
 1 file changed, 85 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index b6e793b..cc806ba 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -212,6 +212,20 @@
 
 #define DSI_INT_ST0			0xbc
 #define DSI_INT_ST1			0xc0
+#define GPRXE				BIT(12)
+#define GPRDE				BIT(11)
+#define GPTXE				BIT(10)
+#define GPWRE				BIT(9)
+#define GCWRE				BIT(8)
+#define DPIPLDWE			BIT(7)
+#define EOTPE				BIT(6)
+#define PSE				BIT(5)
+#define CRCE				BIT(4)
+#define ECCME				BIT(3)
+#define ECCSE				BIT(2)
+#define TOLPRX				BIT(1)
+#define TOHSTX				BIT(0)
+
 #define DSI_INT_MSK0			0xc4
 #define DSI_INT_MSK1			0xc8
 
@@ -397,6 +411,42 @@ static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 hdr_val)
 	return 0;
 }
 
+static int dw_mipi_dsi_read_status(struct dw_mipi_dsi *dsi)
+{
+	u32 val;
+
+	val = dsi_read(dsi, DSI_INT_ST1);
+
+	if (val & GPRXE)
+		DRM_DEBUG_DRIVER("DSI Generic payload receive error\n");
+	if (val & GPRDE)
+		DRM_DEBUG_DRIVER("DSI Generic payload read error\n");
+	if (val & GPTXE)
+		DRM_DEBUG_DRIVER("DSI Generic payload transmit error\n");
+	if (val & GPWRE)
+		DRM_DEBUG_DRIVER("DSI Generic payload write error\n");
+	if (val & GCWRE)
+		DRM_DEBUG_DRIVER("DSI Generic command write error\n");
+	if (val & DPIPLDWE)
+		DRM_DEBUG_DRIVER("DSI DPI payload write error\n");
+	if (val & EOTPE)
+		DRM_DEBUG_DRIVER("DSI EoTp error\n");
+	if (val & PSE)
+		DRM_DEBUG_DRIVER("DSI Packet size error\n");
+	if (val & CRCE)
+		DRM_DEBUG_DRIVER("DSI CRC error\n");
+	if (val & ECCME)
+		DRM_DEBUG_DRIVER("DSI ECC multi-bit error\n");
+	if (val & ECCSE)
+		DRM_DEBUG_DRIVER("DSI ECC single-bit error\n");
+	if (val & TOLPRX)
+		DRM_DEBUG_DRIVER("DSI Timeout low-power reception\n");
+	if (val & TOHSTX)
+		DRM_DEBUG_DRIVER("DSI Timeout high-speed transmission\n");
+
+	return val;
+}
+
 static int dw_mipi_dsi_write(struct dw_mipi_dsi *dsi,
 			     const struct mipi_dsi_packet *packet)
 {
@@ -426,6 +476,12 @@ static int dw_mipi_dsi_write(struct dw_mipi_dsi *dsi,
 				"failed to get available write payload FIFO\n");
 			return ret;
 		}
+
+		val = dw_mipi_dsi_read_status(dsi);
+		if (val) {
+			dev_err(dsi->dev, "dsi status error 0x%0x\n", val);
+			return -EINVAL;
+		}
 	}
 
 	word = 0;
@@ -459,6 +515,12 @@ static int dw_mipi_dsi_read(struct dw_mipi_dsi *dsi,
 			return ret;
 		}
 
+		val = dw_mipi_dsi_read_status(dsi);
+		if (val) {
+			dev_err(dsi->dev, "dsi status error 0x%0x\n", val);
+			return -EINVAL;
+		}
+
 		val = dsi_read(dsi, DSI_GEN_PLD_DATA);
 		for (j = 0; j < 4 && j + i < len; j++)
 			buf[i + j] = val >> (8 * j);
@@ -473,6 +535,7 @@ static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
 	struct dw_mipi_dsi *dsi = host_to_dsi(host);
 	struct mipi_dsi_packet packet;
 	int ret, nb_bytes;
+	int retry = 3;
 
 	ret = mipi_dsi_create_packet(&packet, msg);
 	if (ret) {
@@ -484,24 +547,32 @@ static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
 	if (dsi->slave)
 		dw_mipi_message_config(dsi->slave, msg);
 
-	ret = dw_mipi_dsi_write(dsi, &packet);
-	if (ret)
-		return ret;
-	if (dsi->slave) {
-		ret = dw_mipi_dsi_write(dsi->slave, &packet);
+	while (retry--) {
+		ret = dw_mipi_dsi_write(dsi, &packet);
 		if (ret)
-			return ret;
-	}
+			continue;
 
-	if (msg->rx_buf && msg->rx_len) {
-		ret = dw_mipi_dsi_read(dsi, msg);
-		if (ret)
-			return ret;
-		nb_bytes = msg->rx_len;
-	} else {
-		nb_bytes = packet.size;
+		if (dsi->slave) {
+			ret = dw_mipi_dsi_write(dsi->slave, &packet);
+			if (ret)
+				continue;
+		}
+
+		if (msg->rx_buf && msg->rx_len) {
+			ret = dw_mipi_dsi_read(dsi, msg);
+			if (ret)
+				continue;
+			nb_bytes = msg->rx_len;
+
+		} else {
+			nb_bytes = packet.size;
+		}
+		break;
 	}
 
+	if (ret)
+		return ret;
+
 	return nb_bytes;
 }
 
-- 
2.7.4

