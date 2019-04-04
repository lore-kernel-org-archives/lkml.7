Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416CEC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102322147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HDHj2Z5G";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hTWPe9t5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfDDHV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:21:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43342 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfDDHV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:21:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5B91D61AD6; Thu,  4 Apr 2019 07:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554362517;
        bh=pz1ferueIQeBlV6rjfmFLqrgocDEOxnV90Rf3nxErqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HDHj2Z5GMERwWbGGGp+ZidtbG9GgK2YZb5PLH9Qbk4poChCTas4KGK3WORg+17jAN
         vyWkans8ms/HuKagSxuKkQRGQXRZu5ZJxseoXHhm2lMHtSrSAmFjSGilhJZ33FyEIU
         PtvUNTGDBMk4KaKiJ6tLgSrVctEt6UIs5/ohIG6k=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3430461AB2;
        Thu,  4 Apr 2019 07:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554362501;
        bh=pz1ferueIQeBlV6rjfmFLqrgocDEOxnV90Rf3nxErqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hTWPe9t5C9EIoMvZELWQvttZlLWlZWRKVnsdXGbTOJM1azNVIhno9xHDJ6Pe20o9Y
         JdmxwV+PM6ZDoTcA58lmOy8vYgk4/UZIwUfm1wtututN+C5vJTCh/pCFj8jaPvNG2z
         gnIr39qcbxJNu8LGILIlgCf2a4ix1mItLiU3ImHM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3430461AB2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH 4/7] irqchip/irq-mbigen.c: Use devm_platform_ioremap_resource()
Date:   Thu,  4 Apr 2019 12:50:10 +0530
Message-Id: <1554362413-3305-5-git-send-email-mojha@codeaurora.org>
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
 drivers/irqchip/irq-ls-scfg-msi.c | 4 +---
 drivers/irqchip/irq-mbigen.c      | 9 +--------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index c671b32..aec5a2f 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -336,7 +336,6 @@ static int ls_scfg_msi_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
 	struct ls_scfg_msi *msi_data;
-	struct resource *res;
 	int i, ret;
 
 	match = of_match_device(ls_scfg_msi_id, &pdev->dev);
@@ -349,8 +348,7 @@ static int ls_scfg_msi_probe(struct platform_device *pdev)
 
 	msi_data->cfg = (struct ls_scfg_msi_cfg *) match->data;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	msi_data->regs = devm_ioremap_resource(&pdev->dev, res);
+	msi_data->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(msi_data->regs)) {
 		dev_err(&pdev->dev, "failed to initialize 'regs'\n");
 		return PTR_ERR(msi_data->regs);
diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 98b6e1d..c9aedfb 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -327,7 +327,6 @@ static inline int mbigen_acpi_create_domain(struct platform_device *pdev,
 static int mbigen_device_probe(struct platform_device *pdev)
 {
 	struct mbigen_device *mgn_chip;
-	struct resource *res;
 	int err;
 
 	mgn_chip = devm_kzalloc(&pdev->dev, sizeof(*mgn_chip), GFP_KERNEL);
@@ -335,13 +334,7 @@ static int mbigen_device_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mgn_chip->pdev = pdev;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -EINVAL;
-
-	mgn_chip->base = devm_ioremap(&pdev->dev, res->start,
-				      resource_size(res));
+	mgn_chip->base = devm_platform_ioremap_resource(pdev, 0);
 	if (!mgn_chip->base) {
 		dev_err(&pdev->dev, "failed to ioremap %pR\n", res);
 		return -ENOMEM;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

