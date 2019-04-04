Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4331FC10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1371221741
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jaNBO81u";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SPlwaUOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfDDHWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:22:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43456 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfDDHV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:21:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 176E761786; Thu,  4 Apr 2019 07:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554362519;
        bh=mUIF1VfmqkVChPdPc9kiEQsdJjyhQ7P1qReEmHMotks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jaNBO81uTZTX2ZbizN4Ge8Kcl2dIHYs5u4n7T5WcpwVx8GvMljXjVT0OwdGTYLZgS
         tJQerJ+/0ghGx+RxclC1CjvpmgNQ/cC9tP3sU5Kw3D+s0kRxIW/lFLue2LCcniHBXK
         iHzs91G8P6GaxKjJ8m4f+DQjuMkT3IEgjwAXK7DU=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2BD2A61AFB;
        Thu,  4 Apr 2019 07:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554362505;
        bh=mUIF1VfmqkVChPdPc9kiEQsdJjyhQ7P1qReEmHMotks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SPlwaUORNvklBHCvj5mcCHS9Xt1ZYDMt5J+7ut0j9thbsykjbQLcx2/HuXlQcnu+1
         8kj66o4E0/tY3z6P80uucUJuo5OE662lBfpKB5nCqS0pW2NwAkO8/KBv/nOuzWutUj
         yOlNBYdnFj0oQirhZys59oQZk9dZO/uqK+S+0584=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2BD2A61AFB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH 5/7] irqchip/irq-mvebu-icu: Use devm_platform_ioremap_resource()
Date:   Thu,  4 Apr 2019 12:50:11 +0530
Message-Id: <1554362413-3305-6-git-send-email-mojha@codeaurora.org>
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
 drivers/irqchip/irq-mvebu-icu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index 547045d..a54e4cd 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -347,7 +347,6 @@ static int mvebu_icu_subset_probe(struct platform_device *pdev)
 static int mvebu_icu_probe(struct platform_device *pdev)
 {
 	struct mvebu_icu *icu;
-	struct resource *res;
 	int i;
 
 	icu = devm_kzalloc(&pdev->dev, sizeof(struct mvebu_icu),
@@ -357,8 +356,7 @@ static int mvebu_icu_probe(struct platform_device *pdev)
 
 	icu->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	icu->base = devm_ioremap_resource(&pdev->dev, res);
+	icu->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(icu->base)) {
 		dev_err(&pdev->dev, "Failed to map icu base address.\n");
 		return PTR_ERR(icu->base);
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

