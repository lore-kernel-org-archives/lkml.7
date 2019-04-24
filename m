Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35043C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043D42077C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="a8UMzjyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfDXN0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:26:06 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:49990 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726426AbfDXN0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:26:03 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3ODM02S031678;
        Wed, 24 Apr 2019 15:25:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=98vMUtCxCdnUW7IwxKx65w1DwVxQTVCA7WkVYQzRie4=;
 b=a8UMzjyyFr/SITLIln8eo3Xnh4LERk4nIYdrKpVzv8VjQOPi5oNL/wRzqJmE+tX/HTcr
 lYIuHUDdq7Jwe8YPzEsGwwO0vn68CWg5OAVrBD0qg1uYmSEFisOqUhQ4zX3LG4faa+/7
 qrpIwKWnokUrktMmZ1EL4o+S9W5EbjvG6s6nUdLiyamRUMU63zfH4IYPjCc91MQfRXvA
 vEM1/UUerWlrTdlPk9pQ8b9rrZt23YtrpWOxAFqaMHW5A/0/OuAsXrh95Q/ouBCgNx+V
 V1AbPT0i8daW7uf9o+DthV8ftBGKKVRNwrUVZQtV2xQS4+s3q+xBFd+ny3FAN2AzT927 fg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ryrvxdqq6-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Apr 2019 15:25:52 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F1AFF41;
        Wed, 24 Apr 2019 13:25:51 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C0BCB2649;
        Wed, 24 Apr 2019 13:25:51 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 24 Apr
 2019 15:25:51 +0200
Received: from localhost (10.201.23.25) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 24 Apr 2019 15:25:50
 +0200
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Hugues Fruchet <hugues.fruchet@st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@st.com>,
        <linux-media@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>
Subject: [PATCH] media: stm32-dcmi: return appropriate error codes during probe
Date:   Wed, 24 Apr 2019 15:25:44 +0200
Message-ID: <1556112344-15305-1-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During probe, return the provided errors value instead of -ENODEV.
This allows the driver to be deferred probed if needed.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 drivers/media/platform/stm32/stm32-dcmi.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index 906e71b..b9dad0a 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -1672,7 +1672,7 @@ static int dcmi_probe(struct platform_device *pdev)
 	dcmi->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(dcmi->rstc)) {
 		dev_err(&pdev->dev, "Could not get reset control\n");
-		return -ENODEV;
+		return PTR_ERR(dcmi->rstc);
 	}
 
 	/* Get bus characteristics from devicetree */
@@ -1687,7 +1687,7 @@ static int dcmi_probe(struct platform_device *pdev)
 	of_node_put(np);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not parse the endpoint\n");
-		return -ENODEV;
+		return ret;
 	}
 
 	if (ep.bus_type == V4L2_MBUS_CSI2_DPHY) {
@@ -1700,8 +1700,9 @@ static int dcmi_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		dev_err(&pdev->dev, "Could not get irq\n");
-		return -ENODEV;
+		if (irq != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Could not get irq\n");
+		return irq;
 	}
 
 	dcmi->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1721,12 +1722,13 @@ static int dcmi_probe(struct platform_device *pdev)
 					dev_name(&pdev->dev), dcmi);
 	if (ret) {
 		dev_err(&pdev->dev, "Unable to request irq %d\n", irq);
-		return -ENODEV;
+		return ret;
 	}
 
 	mclk = devm_clk_get(&pdev->dev, "mclk");
 	if (IS_ERR(mclk)) {
-		dev_err(&pdev->dev, "Unable to get mclk\n");
+		if (PTR_ERR(mclk) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Unable to get mclk\n");
 		return PTR_ERR(mclk);
 	}
 
-- 
2.7.4

