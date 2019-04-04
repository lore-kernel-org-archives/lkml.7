Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCC0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A9F20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eiA+cTx5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VaXKwEGj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfDDHVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:21:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41732 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfDDHVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:21:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8934261AB3; Thu,  4 Apr 2019 07:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554362500;
        bh=UwZDme7oLJ4lQ0xS/HZjRyKSI9Hl05BPZanKyxCd0+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eiA+cTx51NgZUrbOQmAEG7Oznbk0ViR8BiC/6IEzhR3xujDSJGdaYkAt3kFPZULPK
         ekpBBby3h6KbKMcoMG8cN9XM6kNFL/d6Yhks8SN01b2NnRhODQpV7QodC92qPZrFO6
         ioCR1RyWfgaOMnIvFrvx/BtUM+B83BfypA3VAVmc=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4F41061573;
        Thu,  4 Apr 2019 07:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554362497;
        bh=UwZDme7oLJ4lQ0xS/HZjRyKSI9Hl05BPZanKyxCd0+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VaXKwEGjqjegWv/GYZedJdHb6nXV5RwP8azpL6atj32TWzgaMnE+DlgOPrNkXnbJ4
         Q62VqE20Hw06Bk57bzHG3dy/H5WXl2Ds9p2ar7bmmYg0T9cboTTOKBK3M6JhHKEzPI
         0dWpBYSFjD1d2OKKXnwm0i0363LthvcTvNCvG0IQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F41061573
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH 3/7] irqchip/irq-ts4800.c: Use devm_platform_ioremap_resource()
Date:   Thu,  4 Apr 2019 12:50:09 +0530
Message-Id: <1554362413-3305-4-git-send-email-mojha@codeaurora.org>
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
 drivers/irqchip/irq-ts4800.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-ts4800.c b/drivers/irqchip/irq-ts4800.c
index 2325fb3..589a8a1 100644
--- a/drivers/irqchip/irq-ts4800.c
+++ b/drivers/irqchip/irq-ts4800.c
@@ -94,15 +94,13 @@ static int ts4800_ic_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	struct ts4800_irq_data *data;
 	struct irq_chip *irq_chip;
-	struct resource *res;
 	int parent_irq;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->base = devm_ioremap_resource(&pdev->dev, res);
+	data->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->base))
 		return PTR_ERR(data->base);
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

