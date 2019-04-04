Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64FBC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A672147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OrjhkX68";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Lorf4Y27"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfDDHSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:18:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34190 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfDDHSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:18:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7473061528; Thu,  4 Apr 2019 07:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554362313;
        bh=slSFrSlYoHAmsXtoqq6LMfCj4JYQqHpuoI/eWuHfQrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OrjhkX68T5OTaM6/lXcSJZLGZe4V5nowar1Nqs/WZgGB700wrYe4c+DAZ2hzg+gHN
         m9ItZgslsmatyDRj5X9mvFwblaBTZ5U6LN3m2uaL3LMMowxicqq3H65C+ba1BLdT3X
         PRUbXIyeoVnf1s/0WiOilzQwN6oIPKMvFgMaoGZY=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 346E5614B5;
        Thu,  4 Apr 2019 07:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554362297;
        bh=slSFrSlYoHAmsXtoqq6LMfCj4JYQqHpuoI/eWuHfQrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lorf4Y27b6t3iR8KLz586dENDjbOlnK7mjUk6At4Vkssxx/Pg6ruicQfOvtcXposi
         Zj3JFpLOHquLvysT8h01rKjsJXZ0FCEzYUrGF7NCKQSyBfgsp31AT9BYybX4BNX9lF
         4gAhanLKavHqf7kjF0F8oAEU3hbdVHKwh5EM8N7o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 346E5614B5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     dmitry.torokhov@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linux-imx@nxp.com,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH 3/5] Input: s3c2410_ts: Use devm_platform_ioremap_resource()
Date:   Thu,  4 Apr 2019 12:47:21 +0530
Message-Id: <1554362243-2888-4-git-send-email-mojha@codeaurora.org>
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
 drivers/input/touchscreen/s3c2410_ts.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
index 1173890..e11cdae 100644
--- a/drivers/input/touchscreen/s3c2410_ts.c
+++ b/drivers/input/touchscreen/s3c2410_ts.c
@@ -242,7 +242,6 @@ static int s3c2410ts_probe(struct platform_device *pdev)
 	struct s3c2410_ts_mach_info *info;
 	struct device *dev = &pdev->dev;
 	struct input_dev *input_dev;
-	struct resource *res;
 	int ret = -EINVAL;
 
 	/* Initialise input stuff */
@@ -277,14 +276,7 @@ static int s3c2410ts_probe(struct platform_device *pdev)
 		goto err_clk;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(dev, "no resource for registers\n");
-		ret = -ENOENT;
-		goto err_clk;
-	}
-
-	ts.io = ioremap(res->start, resource_size(res));
+	ts.io = devm_platform_ioremap_resource(pdev, 0);
 	if (ts.io == NULL) {
 		dev_err(dev, "cannot map registers\n");
 		ret = -ENOMEM;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

