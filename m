Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B65C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B4B20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CRYKqvQJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EqHekJID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfDDHWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:22:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44706 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfDDHWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:22:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B247161B2A; Thu,  4 Apr 2019 07:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554362530;
        bh=tXR+MvEu/epB8pzLiVTl+75mh5aE4R49HkHZYkjYpIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CRYKqvQJ0yxCk3qTa8Pi3iL3XWgs8e/3JzPrXO2+WGyksQn5Y8b9vhb0nop6NzgbX
         wWxMjnjp/BbeZaqIjfyCECvk1vlOOf/O7W2iN+vNywKhQuE3TteGYmCoZyc1RAjOKc
         5cXR322eHx82gEyPyMrjv8AAqWIOra7EipPWI+7w=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DC9F461AFF;
        Thu,  4 Apr 2019 07:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554362513;
        bh=tXR+MvEu/epB8pzLiVTl+75mh5aE4R49HkHZYkjYpIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EqHekJIDOEqaPIiPijqyc5978vKb5TTwVV8VDh0lu5qGXr+0YGF6rAttTQih+A6cY
         zO8WWzYmbPFuRU4WVe1xxvqzGIyt/uZKH6bT45nSjRyxKhnMA4R34MfF1ojwDv7OC7
         /RM4jR7Fp2onPZCjzdFlOJJ8pcyh6EtVuItkEiIA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC9F461AFF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH 7/7] irqchip/irq-mvebu-sei: Use devm_platform_ioremap_resource()
Date:   Thu,  4 Apr 2019 12:50:13 +0530
Message-Id: <1554362413-3305-8-git-send-email-mojha@codeaurora.org>
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
 drivers/irqchip/irq-mvebu-sei.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-sei.c b/drivers/irqchip/irq-mvebu-sei.c
index 18832cc..0a09dcc 100644
--- a/drivers/irqchip/irq-mvebu-sei.c
+++ b/drivers/irqchip/irq-mvebu-sei.c
@@ -382,8 +382,7 @@ static int mvebu_sei_probe(struct platform_device *pdev)
 	mutex_init(&sei->cp_msi_lock);
 	raw_spin_lock_init(&sei->mask_lock);
 
-	sei->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	sei->base = devm_ioremap_resource(sei->dev, sei->res);
+	sei->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sei->base)) {
 		dev_err(sei->dev, "Failed to remap SEI resource\n");
 		return PTR_ERR(sei->base);
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

