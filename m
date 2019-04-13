Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BAFC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF18F2082E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ka7IQxU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfDMKeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 06:34:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52310 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbfDMKdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 06:33:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id a184so14214632wma.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 03:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C0a8sdiQYaX4oWrE+7muICmRubcJy65i2pEeJPhC6s0=;
        b=Ka7IQxU0wxrOaMULh9S/Y+VuJKQmWMuqf1Msqk6rpgXone3/tl96A5jwiaci9BiwKo
         CcZ5p/+aZMx8qwNyAfezsyxOG2mH2bz0AxidTPzD2aaGLym8t2hVMB3HZ50/l9w2ykqY
         TxdDQyAmUAeVQFEj9JmAkMAB439+F5xeNGr6It0/v5c8X96Ax2FAlZqzwxFHg3dHB8au
         x7OKv+GkPnuS4VThKvau5dBcelHgtnbeNCkqYCBX0z0OPXPUbDZfacbknRSfJyGRxX4T
         LAFo5nXL4GEPTnWxnmLcpAsGuo312wcXYEdAD8YwTu40FJlHBDyfvIf7JpLCNMOJFUAx
         VFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C0a8sdiQYaX4oWrE+7muICmRubcJy65i2pEeJPhC6s0=;
        b=uThryIy9ToUwOqD4SpkzD9OBUX/nF9jeFWkwfenRBOEWWjECAo+G0OnNkim38LBMnw
         FO6KN5B7Dqa2uQmygaOn3boEPMGdLES9odo02wdDA/VWJjHgKu+TOE/y/NdFJ2mxtXnd
         z8flF45jwcM5Dly9fkG8qma92ZekvnRwM1QS2PLmOZ2dPAvqGRY1Vy9Yar7zUyOuxFY3
         BYaLppy4MNa5nsRx6Am7feJXudYHbb177Z4qB1KHLprzIJfwCYrz/Stq26/kkWfyQcVm
         piHHv7PNzeOfO1eBWZ7tRdovh3VQohOqx7MNcrBmlPptqtrUL1DSiJatQG31Cfk8U329
         IMZQ==
X-Gm-Message-State: APjAAAXdbdMIR3AaRLWEqkJM8mFlyC3UcKcooQY7N340iiUeyWB95FKE
        +yG656/8LJ9ZrAO2p6q8Xg+P/Q==
X-Google-Smtp-Source: APXvYqxaHhE384z1PDeqL15KAnma/XuYjQTt8e+kGww5eh23aVgVce0WrtTJ6enp9V3slAujLC2U5Q==
X-Received: by 2002:a1c:9cd1:: with SMTP id f200mr14800540wme.91.1555151602683;
        Sat, 13 Apr 2019 03:33:22 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id u17sm19547303wmu.36.2019.04.13.03.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Apr 2019 03:33:22 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: [RESEND PATCH 15/20] nvmem: mxs-ocotp: use devm_platform_ioremap_resource() to simplify code
Date:   Sat, 13 Apr 2019 11:33:00 +0100
Message-Id: <20190413103305.9576-16-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190413103305.9576-1-srinivas.kandagatla@linaro.org>
References: <20190413103305.9576-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <anson.huang@nxp.com>

Use the new helper devm_platform_ioremap_resource() which wraps the
platform_get_resource() and devm_ioremap_resource() together, to
simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/mxs-ocotp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvmem/mxs-ocotp.c b/drivers/nvmem/mxs-ocotp.c
index 53122f59c4b2..fbb7db6ee1f5 100644
--- a/drivers/nvmem/mxs-ocotp.c
+++ b/drivers/nvmem/mxs-ocotp.c
@@ -145,7 +145,6 @@ static int mxs_ocotp_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	const struct mxs_data *data;
 	struct mxs_ocotp *otp;
-	struct resource *res;
 	const struct of_device_id *match;
 	int ret;
 
@@ -157,8 +156,7 @@ static int mxs_ocotp_probe(struct platform_device *pdev)
 	if (!otp)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	otp->base = devm_ioremap_resource(dev, res);
+	otp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(otp->base))
 		return PTR_ERR(otp->base);
 
-- 
2.21.0

