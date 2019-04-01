Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42EAC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D767213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlO6dWOP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfDAEOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:14:39 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33571 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfDAEOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 00:14:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id b12so4074608pgk.0;
        Sun, 31 Mar 2019 21:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J7V1tW0wzuICJfE4QvUi9tGQD5fUR5GSdSZwupsDRjY=;
        b=XlO6dWOP/Fc7FfKKVXnh4dDo9Im2V5c9fEn0PEO0RIesQxZnIi33M4CPaPdwd7iSRv
         P/N204AoWyC4r/HYr2KNKvkxvgfdrw/b4HgEDn5TKCV2PaBRG58i0V5B+UCIOlu5bKrX
         ULqaO2ii09PpArAeTHTp4uDAjG0/YbtnDecaVY/teXnHnEwUALMkl9ivlJG9Wov30fpn
         xxmK0b1OGADEBryV3AQfuUbR0/wFzOQe/Ax6KZXSWZ5R0qcgdbTStHMet6hPJIfHf/2l
         3nlLE+vkAzmTK6rVd1HYqFTy1UBpG4TEQbS/1tGgTp37MVwWKSb+IGwHh0nEdG3s+KNy
         M6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J7V1tW0wzuICJfE4QvUi9tGQD5fUR5GSdSZwupsDRjY=;
        b=kbK1QeiDima1y+S5nkOtBSJjoLcd6jmo1nDhmtX5Kh4a/FODj/H20JWWVh09GUEcrL
         7jRn+zuEOceaccRK/mhpAr6M82KTx5B8MXiqHp1oFyzRP/+I9kFoBaKg9V+z9kkMCDDA
         tokLy6VTxG77lt45ZljeSjhZQjDyCjQNiyYtr/VWOQI7eSYKyboqp5S78ssIWiLCFdz2
         XYGL3YWOVFdb5BPrDLm3U+9QG3MSdgpC326Wh2c1y/bisoKBAtgdOHSGspiHOrtJzM+v
         UkU+i7p6jr2dvWq8rL6QYPS8VhU7deMvHaxrwj8prTl0cwf4B74bGkQA2G2UT1Z4U+Kb
         to0Q==
X-Gm-Message-State: APjAAAWVxqO8C6sUFjDB+6R8VZbzXaF3HbzGmfy9Cqa8z5XyOPNv6iAc
        L8mEJTNrEJKCEu2x1DMDxuCqsdye
X-Google-Smtp-Source: APXvYqyMz40lB7YbDwbEUX8CvBB1flew339yoa5AUiYtEgSlwZg5cfzE/+MawoXSOD89mlCEzmFUcQ==
X-Received: by 2002:a63:5a20:: with SMTP id o32mr56287804pgb.225.1554092076691;
        Sun, 31 Mar 2019 21:14:36 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id a12sm9968504pgq.21.2019.03.31.21.14.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 21:14:35 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/13] thermal: qoriq: Add local struct device pointer
Date:   Sun, 31 Mar 2019 21:14:07 -0700
Message-Id: <20190401041418.5999-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401041418.5999-1-andrew.smirnov@gmail.com>
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a local "struct device *dev" for brevity. No functional change
intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 7b364933bfb1..91f9f49d2776 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -192,8 +192,9 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	int ret;
 	struct qoriq_tmu_data *data;
 	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
 
-	data = devm_kzalloc(&pdev->dev, sizeof(struct qoriq_tmu_data),
+	data = devm_kzalloc(dev, sizeof(struct qoriq_tmu_data),
 			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -204,7 +205,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	data->regs = of_iomap(np, 0);
 	if (!data->regs) {
-		dev_err(&pdev->dev, "Failed to get memory region\n");
+		dev_err(dev, "Failed to get memory region\n");
 		ret = -ENODEV;
 		goto err_iomap;
 	}
@@ -217,7 +218,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	ret = qoriq_tmu_register_tmu_zone(pdev);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to register sensors\n");
+		dev_err(dev, "Failed to register sensors\n");
 		ret = -ENODEV;
 		goto err_iomap;
 	}
-- 
2.20.1

