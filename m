Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D2AC2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE0B2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="svc2K7Ls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfLQKqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 05:46:24 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60852 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfLQKqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 05:46:24 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBHAkH2o116257;
        Tue, 17 Dec 2019 04:46:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576579577;
        bh=lrWG52vZJWUbatvnVA4RbMRIojZou2X56dG4oPSNdq4=;
        h=From:To:CC:Subject:Date;
        b=svc2K7Ls2jHkrBMO5OIDGFMZV/G6C6mycJe44tRkxAc2wPm2Mo8d5lvvKfx++yMKH
         N8juaqVcv8RXUeOmcx4e8uep9TJuwn1x/HUawjw3qAQEc1iAA1ejeLcxg3hM2J7hyd
         kh0JTidg1DCndxyZFUFmZTaNkQZ3sso7NQN0y/hw=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBHAkHgL008715
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Dec 2019 04:46:17 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 17
 Dec 2019 04:46:16 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 17 Dec 2019 04:46:16 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBHAkEcg037743;
        Tue, 17 Dec 2019 04:46:15 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <srinivas.kandagatla@linaro.org>
CC:     <vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] slimbus: qcom-ngd-ctrl: Use dma_request_chan() instead dma_request_slave_channel()
Date:   Tue, 17 Dec 2019 12:46:29 +0200
Message-ID: <20191217104629.24590-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_request_slave_channel() is a wrapper on top of dma_request_chan()
eating up the error code.

By using dma_request_chan() directly the driver can support deferred
probing against DMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 29fbab55c3b3..e3f5ebc0c05e 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -666,10 +666,12 @@ static int qcom_slim_ngd_init_rx_msgq(struct qcom_slim_ngd_ctrl *ctrl)
 	struct device *dev = ctrl->dev;
 	int ret, size;
 
-	ctrl->dma_rx_channel = dma_request_slave_channel(dev, "rx");
-	if (!ctrl->dma_rx_channel) {
-		dev_err(dev, "Failed to request dma channels");
-		return -EINVAL;
+	ctrl->dma_rx_channel = dma_request_chan(dev, "rx");
+	if (IS_ERR(ctrl->dma_rx_channel)) {
+		dev_err(dev, "Failed to request RX dma channel");
+		ret = PTR_ERR(ctrl->dma_rx_channel);
+		ctrl->dma_rx_channel = NULL;
+		return ret;
 	}
 
 	size = QCOM_SLIM_NGD_DESC_NUM * SLIM_MSGQ_BUF_LEN;
@@ -703,10 +705,12 @@ static int qcom_slim_ngd_init_tx_msgq(struct qcom_slim_ngd_ctrl *ctrl)
 	int ret = 0;
 	int size;
 
-	ctrl->dma_tx_channel = dma_request_slave_channel(dev, "tx");
-	if (!ctrl->dma_tx_channel) {
-		dev_err(dev, "Failed to request dma channels");
-		return -EINVAL;
+	ctrl->dma_tx_channel = dma_request_chan(dev, "tx");
+	if (IS_ERR(ctrl->dma_tx_channel)) {
+		dev_err(dev, "Failed to request TX dma channel");
+		ret = PTR_ERR(ctrl->dma_tx_channel);
+		ctrl->dma_tx_channel = NULL;
+		return ret;
 	}
 
 	size = ((QCOM_SLIM_NGD_DESC_NUM + 1) * SLIM_MSGQ_BUF_LEN);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

