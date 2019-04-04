Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA1BC10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB89A2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IfhgYUXT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cJl6dD64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfDDHWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:22:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43682 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfDDHWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:22:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B360861B1E; Thu,  4 Apr 2019 07:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554362520;
        bh=jXeJfK8T3G1dyUObfVmDCBse7KFqyMZPb9m9hJMUNUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IfhgYUXToDqEctEohNVCXuYRoVyABQ39a26GNHwtzm5/D7bMX2BKSUDqW6rzd2mHO
         vji7uUMmYKL3EQ0UEPREcdmfjp14q7F05z+3DAyuNv63GMagvJzgv6LVAVswJIcArB
         qhjAyw+8wQpicl6Hu8YubQjys6CDfJPEIeNSQzb4=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 17CDE61AE8;
        Thu,  4 Apr 2019 07:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554362509;
        bh=jXeJfK8T3G1dyUObfVmDCBse7KFqyMZPb9m9hJMUNUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cJl6dD64ghwfMgWaEGUwl5+j8zAC4WfQfgUM6DM0PysdRIrrvqE7AMDTBUr0OsGQ0
         WxlTeZ5RpfXB8Jj4w4IGRuFAWRgYdVYW4p52gCeoK4e4T4nJyr7Rd42PAZ5+S4ZtH2
         Bs15NdSvusGAW9vV/f5fW967vMxnm7knpYNJSvfs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 17CDE61AE8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH 6/7] irqchip/irq-mvebu-pic: Use devm_platform_ioremap_resource()
Date:   Thu,  4 Apr 2019 12:50:12 +0530
Message-Id: <1554362413-3305-7-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1554362413-3305-1-git-send-email-mojha@codeaurora.org>
References: <1554362413-3305-1-git-send-email-mojha@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_platform_ioremap_resource() internally have platform_get_resource()
and devm_ioremap_resource() in it. So instead of calling them separately
use devm_platform_ioremap_resource() directly.

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
---
 drivers/irqchip/irq-mvebu-pic.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-pic.c b/drivers/irqchip/irq-mvebu-pic.c
index eec6395..d6ade62 100644
--- a/drivers/irqchip/irq-mvebu-pic.c
+++ b/drivers/irqchip/irq-mvebu-pic.c
@@ -124,14 +124,12 @@ static int mvebu_pic_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	struct mvebu_pic *pic;
 	struct irq_chip *irq_chip;
-	struct resource *res;
 
 	pic = devm_kzalloc(&pdev->dev, sizeof(struct mvebu_pic), GFP_KERNEL);
 	if (!pic)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pic->base = devm_ioremap_resource(&pdev->dev, res);
+	pic->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pic->base))
 		return PTR_ERR(pic->base);
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

