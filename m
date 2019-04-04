Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C579C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F4A2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="R1OnHkkY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OMeCFYIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfDDHSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:18:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59966 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfDDHSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:18:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0F422607C6; Thu,  4 Apr 2019 07:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554362288;
        bh=yKYPUn62ma6HL1VuWEXd+QduzyTtxeLAKCHyWFpD/sI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R1OnHkkY8zj492O2wFrer1Hywwu480F3whnVCHYnKYCeqzRTINzJqDGracAWw71gf
         PLZoVr1TsAfAULz3D/2PbYQTxISFO/5ep0Yxygp1opuYW4P0JLDazm4c/QafjF92p5
         7jDxu9R9QiTh+1SG/JVVo2mTI8K62cKe+Iqs4iLo=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E7C16607C6;
        Thu,  4 Apr 2019 07:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554362286;
        bh=yKYPUn62ma6HL1VuWEXd+QduzyTtxeLAKCHyWFpD/sI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OMeCFYInUzGbbeVJGd8qsoaXvk2Cb/F7+h8arhWjy4CfzaJDVJB4Xu12zKCwH85um
         e8Ap9DoaLrYJbYOJFevqUfEx9Ff3sXJIIGGCYtVtjEI8EsxxiPPZl0/34UV6OC8oFV
         6GM6BRn7MGR7ZeGW1x/waTvqEsPVxXty3Rm2peAk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E7C16607C6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     dmitry.torokhov@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linux-imx@nxp.com,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH 1/5] Input: fsl-imx25-tcq: Use devm_platform_ioremap_resource()
Date:   Thu,  4 Apr 2019 12:47:19 +0530
Message-Id: <1554362243-2888-2-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1554362243-2888-1-git-send-email-mojha@codeaurora.org>
References: <1554362243-2888-1-git-send-email-mojha@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_platform_ioremap_resource() internally have platform_get_resource()
and devm_ioremap_resource() in it. So instead of calling them separately
use devm_platform_ioremap_resource() directly.

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
---
 drivers/input/touchscreen/fsl-imx25-tcq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/fsl-imx25-tcq.c b/drivers/input/touchscreen/fsl-imx25-tcq.c
index 1d6c8f4..b66df8a 100644
--- a/drivers/input/touchscreen/fsl-imx25-tcq.c
+++ b/drivers/input/touchscreen/fsl-imx25-tcq.c
@@ -503,7 +503,6 @@ static int mx25_tcq_probe(struct platform_device *pdev)
 	struct input_dev *idev;
 	struct mx25_tcq_priv *priv;
 	struct mx25_tsadc *tsadc = dev_get_drvdata(dev->parent);
-	struct resource *res;
 	void __iomem *mem;
 	int error;
 
@@ -512,8 +511,7 @@ static int mx25_tcq_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	priv->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mem = devm_ioremap_resource(dev, res);
+	mem = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mem))
 		return PTR_ERR(mem);
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

