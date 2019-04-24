Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E75BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD05B20656
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="luX2JALB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfDXJWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:22:00 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41248 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726451AbfDXJWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:22:00 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3O9HQaJ030753;
        Wed, 24 Apr 2019 11:21:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=YUB6Zr4mQO1vo7mjsN1l9v+q+hPoYBype2WkI1xrxao=;
 b=luX2JALB3WHOeeP5YCpHnvsVvg4WlmXv1n8RpabTse8TQHjNSX5hV72EZ4eMKOyGQfGt
 BUyA8J6xq2++b/AdW54fFoM/ZL49MEALoyaTlXbxF1vZJj6SSw42GgM0Kib8Xl00v/X4
 jOYsSiGb3yg4OL9KKiwARQKz1Lr8eMTDBs+erxIsyWyChqEbMxmqTkO3LmnhbvqT+sVr
 hhRw0/an189QX7EFvZ7Kp0DyWZ1CtD5rHtpyXnELojyO6zoq8GOBo1O72mVniuTgtqPP
 oM1sjH/q/V9Z3q9dHLyDZTH+THJPlnUjwlnYGjEuOqjoBgrSaFyLZ/x6tofRXp/i43yi vg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rytad5hba-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Apr 2019 11:21:45 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AA73234;
        Wed, 24 Apr 2019 09:21:44 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 839981559;
        Wed, 24 Apr 2019 09:21:44 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 24 Apr
 2019 11:21:44 +0200
Received: from localhost (10.201.23.25) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 24 Apr 2019 11:21:43
 +0200
From:   Fabien Dessenne <fabien.dessenne@st.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fabien Dessenne <fabien.dessenne@st.com>
Subject: [PATCH] dmaengine: stm32-dma: dmaengine: stm32-dma: use platform_get_irq()
Date:   Wed, 24 Apr 2019 11:21:25 +0200
Message-ID: <1556097685-7236-1-git-send-email-fabien.dessenne@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.25]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource(pdev, IORESOURCE_IRQ) is not recommended for
requesting IRQ's resources, as they can be not ready yet. Using
platform_get_irq() instead is preferred for getting IRQ even if it was
not retrieved earlier.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 drivers/dma/stm32-dma.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index ba239b5..3306818 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -1302,13 +1302,14 @@ static int stm32_dma_probe(struct platform_device *pdev)
 
 	for (i = 0; i < STM32_DMA_MAX_CHANNELS; i++) {
 		chan = &dmadev->chan[i];
-		res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
-		if (!res) {
-			ret = -EINVAL;
-			dev_err(&pdev->dev, "No irq resource for chan %d\n", i);
+		chan->irq = platform_get_irq(pdev, i);
+		if (chan->irq < 0)  {
+			ret = chan->irq;
+			if (ret != -EPROBE_DEFER)
+				dev_err(&pdev->dev,
+					"No irq resource for chan %d\n", i);
 			goto err_unregister;
 		}
-		chan->irq = res->start;
 		ret = devm_request_irq(&pdev->dev, chan->irq,
 				       stm32_dma_chan_irq, 0,
 				       dev_name(chan2dev(chan)), chan);
-- 
2.7.4

