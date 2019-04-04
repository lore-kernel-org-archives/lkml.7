Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30861C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0097E20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="g3R7hHpk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TxmJiGi9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfDDHST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:18:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:32834 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfDDHST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:18:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F37436133A; Thu,  4 Apr 2019 07:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554362298;
        bh=3Pw1kQtwRp65A9eGD4hzWPNesktfZo1lAAMVELyXxsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g3R7hHpkUb9n9X7jRb/5UNKjwA6MzbENFvGkE6cyePMtyk2XBDNrYudH4oke3nVZH
         ZWRcKQ/d8Do+fXAyhx4FCxHe7V/TlHGIOU4VEZJcX0SxL35c4438yTgdvGcNqmZ+De
         jVjpG69kPYJUKPja4Xell7YZBVlRKoxOtDctbwFo=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 56D0F60D0C;
        Thu,  4 Apr 2019 07:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554362292;
        bh=3Pw1kQtwRp65A9eGD4hzWPNesktfZo1lAAMVELyXxsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TxmJiGi9Kj3/gFvS9XAew0VK28o2/YtxjpWTRyGluk5jyrCXMvuZwX/N7Cq6F5nH0
         lrpOAtx3+56Ju2nF/hZYdTYw4HBr/e6XyVlU8x4QiZbYXomZbcefsHx6xBL19X0KF9
         HHHGYTvIBJYrd/ql4Mmz5OeaN0VUEJKbuSKmXBWQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 56D0F60D0C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     dmitry.torokhov@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linux-imx@nxp.com,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH 2/5] Input: mxs-lradc-ts.c: Use devm_platform_ioremap_resource()
Date:   Thu,  4 Apr 2019 12:47:20 +0530
Message-Id: <1554362243-2888-3-git-send-email-mojha@codeaurora.org>
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
 drivers/input/touchscreen/mxs-lradc-ts.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/mxs-lradc-ts.c b/drivers/input/touchscreen/mxs-lradc-ts.c
index c850b51..af047fa 100644
--- a/drivers/input/touchscreen/mxs-lradc-ts.c
+++ b/drivers/input/touchscreen/mxs-lradc-ts.c
@@ -615,7 +615,6 @@ static int mxs_lradc_ts_probe(struct platform_device *pdev)
 	struct device_node *node = dev->parent->of_node;
 	struct mxs_lradc *lradc = dev_get_drvdata(dev->parent);
 	struct mxs_lradc_ts *ts;
-	struct resource *iores;
 	int ret, irq, virq, i;
 	u32 ts_wires = 0, adapt;
 
@@ -629,10 +628,7 @@ static int mxs_lradc_ts_probe(struct platform_device *pdev)
 	ts->dev = dev;
 	spin_lock_init(&ts->lock);
 
-	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!iores)
-		return -EINVAL;
-	ts->base = devm_ioremap(dev, iores->start, resource_size(iores));
+	ts->base = devm_platform_ioremap_resource(pdev, 0);
 	if (!ts->base)
 		return -ENOMEM;
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

