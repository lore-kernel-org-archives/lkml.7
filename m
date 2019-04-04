Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FF4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932972147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YdraUt92";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bxKun/JT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfDDHSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:18:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36358 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbfDDHSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:18:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8F4416141D; Thu,  4 Apr 2019 07:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554362332;
        bh=D5UNxLrC1aCufR9HttQTKtuFo+WmQLBmfJpT125xMxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YdraUt92/1YeXHXM+OBMKB8BzIDlH5uTWLSw8oD5g5BrW3R/WnQmXfDEPBEFVOhTi
         Hsk2ONS5UpZcbN+6GHvbrnL0PdSGXCDjwrzr0gPGAtmjlTWRuGSOfb0nUTrQqVCcSP
         A38+tSEvKnqgoh3opde2HDePEn4zJEr92331dk8E=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3617C616B8;
        Thu,  4 Apr 2019 07:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554362302;
        bh=D5UNxLrC1aCufR9HttQTKtuFo+WmQLBmfJpT125xMxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bxKun/JT3U2V9LFA8vFST5kQ5QDXT+ebToF4p9ZzM3QJBa9tP3Zy2m+cW9EwjbISB
         OaD/vLZPi6Puk5JHAxskPjj6rKt5RoYlkTWx94BUE4kk4UzH8CYeMzC1cIg91/c7VU
         QPXnjQQZLOeRMp1RxM0Vv1u5VIWrwvV43gBu4Jmc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3617C616B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     dmitry.torokhov@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linux-imx@nxp.com,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH 4/5] Input: sun4i-ts: Use devm_platform_ioremap_resource()
Date:   Thu,  4 Apr 2019 12:47:22 +0530
Message-Id: <1554362243-2888-5-git-send-email-mojha@codeaurora.org>
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
 drivers/input/touchscreen/sun4i-ts.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchscreen/sun4i-ts.c
index d2e14d9..bbb0104 100644
--- a/drivers/input/touchscreen/sun4i-ts.c
+++ b/drivers/input/touchscreen/sun4i-ts.c
@@ -309,8 +309,7 @@ static int sun4i_ts_probe(struct platform_device *pdev)
 		input_set_drvdata(ts->input, ts);
 	}
 
-	ts->base = devm_ioremap_resource(dev,
-			      platform_get_resource(pdev, IORESOURCE_MEM, 0));
+	ts->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ts->base))
 		return PTR_ERR(ts->base);
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

