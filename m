Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F95C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FEFF2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PMuk7/TM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731099AbfFTILh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 04:11:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37527 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730487AbfFTILe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 04:11:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id f17so2137803wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 01:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yk3s13nDy3wSE2QTnTVmJsFL5rtqbtjjYEZwrzIJL/A=;
        b=PMuk7/TM00B26wtlQCEp4fvfPYDH1EjBHokXQOuvImdF3IPX3gmBnSatBUGaYk21yh
         MYvbbxy5pB8fQTv6AwsWdLEdEl+SsYH9oPDLOF9qXnUkDTdUDRD7XIPZbn+NGTbM9IsL
         p6tf41Y0IWR1srVcVC6pypiBqf7xbDFBArqvO99E1VHg6mMahVqkKolpbpqXKDjluEe1
         gyszNh6ogGL7flbzMxpoghetcTsCUzVjw97bNLHo79bjHJTqr9YZa0BdwrjGWRkc7yhh
         +LfgXIyuGfgygHLQaw1sGDyDLckz5SCUNn9ssmzhfe7h3dbsB/Ezp8l+MIWVyGzevXhN
         LI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yk3s13nDy3wSE2QTnTVmJsFL5rtqbtjjYEZwrzIJL/A=;
        b=DHThZBtAwQPE4wODmCsVFRlRa+Bwc6xRJIRsqQmiLpDu5iXk6MOAzpEsOrQq8wRIXP
         Jt0Joj35pSnJr0Rx6q8GuxUM37PKxNl2V/C5u0wqtH3xeGHNpQGMg3VY1qSnh/L99fVd
         8RFvd12fgl9nPxgtURqToumrrpGaSHUnWA3N8ob77Q7TdXJvU+nr5YGKBnaPMsv9+IDO
         aOnvw2QMuiAICUYVaPPED0XZHXGoj0UQ4M4uOqT3TdUApQoC1/Z8QKq2095gT6ipNgLA
         xpioXsCHHxDC4hnJeBo2Wa8sUslvYL1FD7TnCbUJSlNgMeXSqMVvuyG+jYb+BolQv76o
         t8PQ==
X-Gm-Message-State: APjAAAVOpTEqIVOkyshFbRcoQOuLMi5w2Od/8bd3cdeMxhHgz38VyxZx
        C5j5LUR2L3REaohum9Ejna2u3A==
X-Google-Smtp-Source: APXvYqzFPyDmaPJveN3ecvw3TwBmOa+cYJ1fMko5IK4yMl9dLNTOEMofLfwsA/PRV30Md/iuCWG/QA==
X-Received: by 2002:a1c:f319:: with SMTP id q25mr1613578wmq.129.1561018292890;
        Thu, 20 Jun 2019 01:11:32 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id q12sm17559174wrp.50.2019.06.20.01.11.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 01:11:32 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] slimbus: remove redundant dev_err message
Date:   Thu, 20 Jun 2019 09:11:28 +0100
Message-Id: <20190620081129.4721-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190620081129.4721-1-srinivas.kandagatla@linaro.org>
References: <20190620081129.4721-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ding Xiang <dingxiang@cmss.chinamobile.com>

devm_ioremap_resource already contains error message, so remove
the redundant dev_err message

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ctrl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index ad3e2e23f56e..a444badd8df5 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -528,10 +528,8 @@ static int qcom_slim_probe(struct platform_device *pdev)
 
 	slim_mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl");
 	ctrl->base = devm_ioremap_resource(ctrl->dev, slim_mem);
-	if (IS_ERR(ctrl->base)) {
-		dev_err(&pdev->dev, "IOremap failed\n");
+	if (IS_ERR(ctrl->base))
 		return PTR_ERR(ctrl->base);
-	}
 
 	sctrl->set_laddr = qcom_set_laddr;
 	sctrl->xfer_msg = qcom_xfer_msg;
-- 
2.21.0

