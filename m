Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05783C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71BB2183E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FMSJF2cz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KG1sW36e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfDDHVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:21:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41282 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfDDHVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:21:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DCE3161214; Thu,  4 Apr 2019 07:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554362497;
        bh=4QvGmrEcKu6EC3BFBWtNaJqazwAXXDWhFvvO0ubMrK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FMSJF2czzFJu0QxjFiBb0TZLISKi5Cjgn2gcX/SRRmQzDXC2smNDWHd6lMHiMQi+c
         VQMBK47vx1Ldr8cKKJrCCPxIxYj7ka9hCuatUqr/g3DMJ/8nhx7ZWpPDwKvdAhj7vX
         XM7xDTl5mqeuVbk/S02auCLLKTYHFWxKOUG1o+w8=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3DFA360A44;
        Thu,  4 Apr 2019 07:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554362493;
        bh=4QvGmrEcKu6EC3BFBWtNaJqazwAXXDWhFvvO0ubMrK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KG1sW36e/+IW6AcPN2XOItJEKUEStObyUdUFnC4CH7MP/W+okuXO/ZqWF02/g21Cd
         Sre6wp6wo5wcw/FAFXao1F+84ZQKrBoK6YzyMyy1/g7jYKHN/QwSI6lOGz9TIv0EHc
         Rrdovc6fnir7IxAq3CqCZASl0VVU5SBepdj+KlbM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3DFA360A44
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH 2/7] irqchip/irq-imgpdc.c: Use devm_platform_ioremap_resource()
Date:   Thu,  4 Apr 2019 12:50:08 +0530
Message-Id: <1554362413-3305-3-git-send-email-mojha@codeaurora.org>
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
 drivers/irqchip/irq-imgpdc.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-imgpdc.c b/drivers/irqchip/irq-imgpdc.c
index d00489a..8904a5f 100644
--- a/drivers/irqchip/irq-imgpdc.c
+++ b/drivers/irqchip/irq-imgpdc.c
@@ -307,13 +307,6 @@ static int pdc_intc_probe(struct platform_device *pdev)
 	if (!node)
 		return -ENOENT;
 
-	/* Get registers */
-	res_regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res_regs == NULL) {
-		dev_err(&pdev->dev, "cannot find registers resource\n");
-		return -ENOENT;
-	}
-
 	/* Allocate driver data */
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
@@ -324,8 +317,7 @@ static int pdc_intc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, priv);
 
 	/* Ioremap the registers */
-	priv->pdc_base = devm_ioremap(&pdev->dev, res_regs->start,
-				      resource_size(res_regs));
+	priv->pdc_base = devm_platform_ioremap_resource(pdev, 0);
 	if (!priv->pdc_base)
 		return -EIO;
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

