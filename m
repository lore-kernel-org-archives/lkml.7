Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9B8C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213982080C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="lLaslcUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfD3LOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:14:11 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39275 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfD3LOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:14:10 -0400
Received: by mail-pl1-f194.google.com with SMTP id e92so6559437plb.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 04:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rZRpyIeJasHQay9EzoU7E+Xe/OUCe0O0rVD5IYIGa7c=;
        b=lLaslcURv7+lD6tBxsx4Yz0Ii7N73jPfQKh3AorTftgg2b1EBcrW1HeF3sp7eitkX9
         sDUiY16SMr4X/DAeWh2UtyQLQDT166qFdJN/m7seFE2V3MKguIop5hIeYwwS6+Gnd41z
         QuXlk7Wwi7PerZ+CkkQZoaThRo4b1D2AHOwWsQ2pao+rWU/+lkL2IHaiJaE4Y61AE9nf
         BTbFZGke6C9SwhYofC+8MWkXjW4RmJ5eF+Uk7MoVs8b+Ipjtx+8IMoUn8PgdS3mdpgve
         xTkTJtXIToRpUvms8Fy/bVwOUC6aNEO0lmvE14Ofp7FAqZcQWVDSSvDU3id67JmTV2Bz
         sBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rZRpyIeJasHQay9EzoU7E+Xe/OUCe0O0rVD5IYIGa7c=;
        b=FhpeNezpyVXel2fgcb006mH9w489tHjuq3QUfjc49TZZ/BhTUcpkHSpLQk2o+jeH1v
         T8utFHEI4vX7FfGWGaDENLHlQVlFcMsfAVy6S6jBaZbAE/aUw97nbU2SQ764gMOrDG5g
         wC08xXuyKvffxhWPjCaQh9+n56gsXeU6Uy8ZaTYMu6aLrXfoYSaSe5lwat35MS86qEXZ
         T7YRUYMSyPN5G1g6o8yMrM9khGHEcTU+fftDaq6J+F4gJrfoL8Fne5ArAcP+HDgJ/0fg
         /qe841RsQFv9T4Rb+ZrAGOGcoX5Ui4FfyMKFM/5kFxz3C+twq7asWQvEgazBq4GAje9n
         jQSQ==
X-Gm-Message-State: APjAAAX+WquG035XVKEMdD6ia1x2MLT56CzQqI4oSBCU+vglA1mq3icV
        LDGJh2K+Lo6g1aVe+ygui/bO4g==
X-Google-Smtp-Source: APXvYqweppFBGxKHkVzArez11SbQZzKtq9TXCg2BTYjoLwKgeept9cmp1+UyTEvSWgw8hEKcKgFukQ==
X-Received: by 2002:a17:902:bd92:: with SMTP id q18mr69237251pls.136.1556622849792;
        Tue, 30 Apr 2019 04:14:09 -0700 (PDT)
Received: from localhost.localdomain (36-239-226-61.dynamic-ip.hinet.net. [36.239.226.61])
        by smtp.gmail.com with ESMTPSA id b14sm45483887pfi.92.2019.04.30.04.14.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 04:14:09 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Pascal Paillet <p.paillet@st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: stm32-pwr: Remove unneeded *desc from struct stm32_pwr_reg
Date:   Tue, 30 Apr 2019 19:13:45 +0800
Message-Id: <20190430111346.23427-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just use rdev->desc instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/stm32-pwr.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/stm32-pwr.c b/drivers/regulator/stm32-pwr.c
index 7b39a41530d4..8bd15e4d2cea 100644
--- a/drivers/regulator/stm32-pwr.c
+++ b/drivers/regulator/stm32-pwr.c
@@ -40,7 +40,6 @@ static u32 ready_mask_table[STM32PWR_REG_NUM_REGS] = {
 
 struct stm32_pwr_reg {
 	void __iomem *base;
-	const struct regulator_desc *desc;
 	u32 ready_mask;
 };
 
@@ -61,7 +60,7 @@ static int stm32_pwr_reg_is_enabled(struct regulator_dev *rdev)
 
 	val = readl_relaxed(priv->base + REG_PWR_CR3);
 
-	return (val & priv->desc->enable_mask);
+	return (val & rdev->desc->enable_mask);
 }
 
 static int stm32_pwr_reg_enable(struct regulator_dev *rdev)
@@ -71,7 +70,7 @@ static int stm32_pwr_reg_enable(struct regulator_dev *rdev)
 	u32 val;
 
 	val = readl_relaxed(priv->base + REG_PWR_CR3);
-	val |= priv->desc->enable_mask;
+	val |= rdev->desc->enable_mask;
 	writel_relaxed(val, priv->base + REG_PWR_CR3);
 
 	/* use an arbitrary timeout of 20ms */
@@ -90,7 +89,7 @@ static int stm32_pwr_reg_disable(struct regulator_dev *rdev)
 	u32 val;
 
 	val = readl_relaxed(priv->base + REG_PWR_CR3);
-	val &= ~priv->desc->enable_mask;
+	val &= ~rdev->desc->enable_mask;
 	writel_relaxed(val, priv->base + REG_PWR_CR3);
 
 	/* use an arbitrary timeout of 20ms */
@@ -153,7 +152,6 @@ static int stm32_pwr_regulator_probe(struct platform_device *pdev)
 		if (!priv)
 			return -ENOMEM;
 		priv->base = base;
-		priv->desc = &stm32_pwr_desc[i];
 		priv->ready_mask = ready_mask_table[i];
 		config.driver_data = priv;
 
-- 
2.17.1

