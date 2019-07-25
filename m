Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D33C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5772083B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q3VoDjlj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388723AbfGYH4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 03:56:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35006 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388695AbfGYH4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 03:56:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id u14so22343605pfn.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 00:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=dVOPmsmstAoEDKTiIIalnKNSCwtrFiFJM+QU0aXv5Hg=;
        b=q3VoDjljk5e6aCPg9VPeTJlpzqq1Wt+sb3zq4UtlLWr5HQQU7OBcq8vmSbYjjSeQgU
         5ejFDZ0kNQ/v4WVI75bNfHVDGNKHgH3GMILwwhCRkKEwookapnslrRCHibZv1jfnJyQM
         eqwZD5iJifsTxEkAT3k7N/flx6qcJqnRW9njkqUZMJhM2I8CIs+rDZ7jQyPAWvRPD+x7
         wvm16SIcp72lqY5UhvcpOEGh9dYOImIHMC58FRsYALy9Zq9vWBEh+juwY6jFnWKFcM5+
         xb9enbHGu07rhJ5mcWN8TsGwsbZ8d0sjzresMdu8QDqhly4Y0p5SONdy7cR5s7y0w5Xt
         95Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=dVOPmsmstAoEDKTiIIalnKNSCwtrFiFJM+QU0aXv5Hg=;
        b=OafGJwzJE0r+j5ZMgm1y6v0GPAPzM4AHnoKaCWnY6ZPJJcgbgrb4G/LDCyJiJAyFDj
         5UeyHgcJGbZTs2ehDhJDzevbLG1NA572RVUGbmNlxpt3HW8+aKqH0QMnol6/92jL3mwm
         3XoHEK6Az1JAhm42dHQqKuhbd8ob3K+nKJPHD8BHfKw+eV4EUkHMYi3WUbmyHzR802u5
         BxpCrkCHk9Mb19puh1TAeMw+cBQNmEd+531Lm3fmgTWW1qdMkEUoasrG11jwnkJpj152
         R7HLT/uCUxyoHEJPcf6969xI2vbqVVxhm3F0EOYkv1K0Hn+NtsqUwiXRhKSdp4PBEMJA
         gm/Q==
X-Gm-Message-State: APjAAAUs4YsIJ23X/RPBNM3dUK1WOJEkdFsYFRox4neEXlbQ3S3brEBC
        H6XwaZ3f+j+JrfmmZ0Wqg+dlgg==
X-Google-Smtp-Source: APXvYqwa4/Ww2exQ29LVKUzjoJMY2ByVqNXS1YvJBVQtvvkrKr4pTPo6wJs6DJAZTDb8y8IyWAKUpQ==
X-Received: by 2002:a17:90a:d996:: with SMTP id d22mr91584319pjv.86.1564041398081;
        Thu, 25 Jul 2019 00:56:38 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id m9sm89021419pgr.24.2019.07.25.00.56.35
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jul 2019 00:56:37 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     wsa+renesas@sang-engineering.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] i2c: sprd: Change to use devm_platform_ioremap_resource()
Date:   Thu, 25 Jul 2019 15:56:17 +0800
Message-Id: <29fa51009a97e6b7d8622190810b7505819ac0b2.1564041157.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <c9e2c50b54577e4b5cb7cc424f4c6de5f116cf60.1564041157.git.baolin.wang@linaro.org>
References: <c9e2c50b54577e4b5cb7cc424f4c6de5f116cf60.1564041157.git.baolin.wang@linaro.org>
In-Reply-To: <c9e2c50b54577e4b5cb7cc424f4c6de5f116cf60.1564041157.git.baolin.wang@linaro.org>
References: <c9e2c50b54577e4b5cb7cc424f4c6de5f116cf60.1564041157.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/i2c/busses/i2c-sprd.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sprd.c b/drivers/i2c/busses/i2c-sprd.c
index 8002835..bbcb056 100644
--- a/drivers/i2c/busses/i2c-sprd.c
+++ b/drivers/i2c/busses/i2c-sprd.c
@@ -478,7 +478,6 @@ static int sprd_i2c_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct sprd_i2c *i2c_dev;
-	struct resource *res;
 	u32 prop;
 	int ret;
 
@@ -488,8 +487,7 @@ static int sprd_i2c_probe(struct platform_device *pdev)
 	if (!i2c_dev)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	i2c_dev->base = devm_ioremap_resource(dev, res);
+	i2c_dev->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(i2c_dev->base))
 		return PTR_ERR(i2c_dev->base);
 
-- 
1.7.9.5

