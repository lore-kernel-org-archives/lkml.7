Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A01BC33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8182072E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 10:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HuDbXpFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbgAIKcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 05:32:10 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53618 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728614AbgAIKcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 05:32:07 -0500
Received: by mail-wm1-f66.google.com with SMTP id m24so2299794wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 02:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0b+aMIWgaqOGNLhH5jThwdZY8oNLzZ6JoyOvUDXTde8=;
        b=HuDbXpFBD3WuhbTSxy2ZahTGpjjyL2g284NrIyhv0FmCNx2NqyjpMn0GOIsxlEZkg4
         KWOnKfnCWiCqK7978KPycWLJ1f9oCfHJXi3629C2ognUFMA9tyYV5k5qpM2GP8mpM5L0
         wI+RcZmjgCezlD6aGL03X43fkDKd/SbPYHXgKDuYa+9Gbv0NH06eomko8XY5ISmIRMld
         aN8pEuVuQgHb/VMS6d93dY7rK9KaM0ZbCq1az5O+FX4sktWAX/CSB2cpAORKY1SVWT3g
         p2OgK8VCA2DoDfUl/ZLS/m4P37/5L90ImzaOs0zgfyKpU/BG/+nXF5mSazeqpOxuo3Oe
         2Rfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0b+aMIWgaqOGNLhH5jThwdZY8oNLzZ6JoyOvUDXTde8=;
        b=UOC/1PnnOpsPhckDHv4aUYViCBwLipN//+mZxXvjQB6F44s/6iUTxsz9eOKzKPvJV/
         Yiw7jwqUj+Jg1PuqNM/eOmwNpjLWdInmwKN4NadWYN8+ZUDMGpEvaQ5y5gFAK6jK4Tv1
         JD6hzQbej5MRCbPoTn+Y6vNbiQ0J7i/c9b3DQFanry/5CeuHX5ExC6FlxeKdt30PTZNg
         FQ8LIav90ANnRxDcclJ2wjI1DUISNWQp5MPlIePgIf1TzpXBb9CyFA+UjWs2Lgapa8OT
         sVoWTBRyg64Yr9d+leAVOlGa6SqIdi05Z+fcIES+37UwtPL2KSv44PL63QgSjnpaNsLk
         02LA==
X-Gm-Message-State: APjAAAUONsFzW8sSmxcXb+prXawzGhU9E3Azz1bz4aDFTs1OYdNAgzc9
        X2zXNli1JgYLgBdbc8xovs/yNw==
X-Google-Smtp-Source: APXvYqyz/wYHZpdMR1qsoovmpqHI+yfop5dqpsJS2BFGsCABoFISXSZTtsAcI+fAvwuhcEvqr+6pyg==
X-Received: by 2002:a1c:2355:: with SMTP id j82mr4073740wmj.135.1578565925414;
        Thu, 09 Jan 2020 02:32:05 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id z83sm2473830wmg.2.2020.01.09.02.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 02:32:04 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/4] slimbus: qcom-ngd-ctrl: Use dma_request_chan() instead dma_request_slave_channel()
Date:   Thu,  9 Jan 2020 10:31:46 +0000
Message-Id: <20200109103148.5612-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200109103148.5612-1-srinivas.kandagatla@linaro.org>
References: <20200109103148.5612-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

dma_request_slave_channel() is a wrapper on top of dma_request_chan()
eating up the error code.

By using dma_request_chan() directly the driver can support deferred
probing against DMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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
2.21.0

