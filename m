Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CD6C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 16:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8BE2073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 16:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R340kJVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfLJQmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 11:42:12 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46003 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfLJQmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 11:42:09 -0500
Received: by mail-pg1-f196.google.com with SMTP id b9so8755179pgk.12;
        Tue, 10 Dec 2019 08:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pjibFk638PnQ42hwKONZvOkVbixVgcRlW8yZGOEeC5k=;
        b=R340kJVkWJNHcEMhdnyHpd44lvGwReYozuc5ySZzK5nc1oJ0Pjk60wYFad1hFzc3AA
         t8dN6jAavm6xOs/1GFfbz9hcqOEO4bfr1bRLx2nddNNVyRPWGDov9Sbjut1A8d/IgMw7
         vJ4iX8Sr+njRpuDt7rTRBGpjjVkMnyE2cjFstZIs6cPMa8rFN5ef8hLukjaKC5FUqZvi
         yNLn2WM44kTm3p0GZehSIB7iCqXVciT0X2KXedXbemK1QfehzCkz6Xk5IP7lfOW3aGHu
         MiJ5hy66syJbHNkKz36R3C/IMdop2wl1WamBFAu7HRJcIXNKP+LSgALmNtntkZ8DMN9A
         XMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pjibFk638PnQ42hwKONZvOkVbixVgcRlW8yZGOEeC5k=;
        b=OWvYK7hEzxbstDr7LKFipG0e2SOpZoLAncGOWFeARkEbpwp/5AE55V6exS6sGYMnA1
         Khr1slKJdQFjGV2JUJWBS7bJfk8eEAMZ+X5SwGvorm9nY9I4opsZHUKKT1O6O4xDUdTB
         8i0MKuvoeqoWxzhZ3EnRYcqcKuKLzCR9XROWPbXutg+h6nxLgWUo0gaSQwF8QCyLi0L2
         iK0F3VsNndc9q84BC7bxsnBYBlhwE5gMP5PDP26r3iH352bQxsLaCFXyFFihOQVL9ukN
         ba673NBsJjYWU7Idwl+fBakxK0bHFNYDDneFe7DpCFMqmPbcC/+K5VYP8i4pZFGXBd/T
         K0dg==
X-Gm-Message-State: APjAAAVFbubGrMOquIwSXuY3Y2JOhjqbDKEsaL9L20R4oygvmcqD3UY6
        3bsTQjdhEyN7OJSw6EO5J3Ebgswgr60=
X-Google-Smtp-Source: APXvYqzWk6B2yzJ7FtTSAlswTDUDgrDrRvzUx/IRVowCGQH2J+1hpA2U+w/5ZLO/F5QjJwreNWe3UA==
X-Received: by 2002:a63:4b24:: with SMTP id y36mr25444347pga.176.1575996128192;
        Tue, 10 Dec 2019 08:42:08 -0800 (PST)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id j38sm4034634pgj.27.2019.12.10.08.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 08:42:06 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Chris Healy <cphealy@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 01/12] thermal: qoriq: Add local struct device pointer
Date:   Tue, 10 Dec 2019 08:41:42 -0800
Message-Id: <20191210164153.10463-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191210164153.10463-1-andrew.smirnov@gmail.com>
References: <20191210164153.10463-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a local "struct device *dev" for brevity. No functional change
intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Angus Ainslie (Purism) <angus@akkea.ca>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 45e9fcb172cc..dd47b31aeecc 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -262,8 +262,9 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	u32 ver;
 	struct qoriq_tmu_data *data;
 	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
 
-	data = devm_kzalloc(&pdev->dev, sizeof(struct qoriq_tmu_data),
+	data = devm_kzalloc(dev, sizeof(struct qoriq_tmu_data),
 			    GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -274,17 +275,17 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	data->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->regs)) {
-		dev_err(&pdev->dev, "Failed to get memory region\n");
+		dev_err(dev, "Failed to get memory region\n");
 		return PTR_ERR(data->regs);
 	}
 
-	data->clk = devm_clk_get_optional(&pdev->dev, NULL);
+	data->clk = devm_clk_get_optional(dev, NULL);
 	if (IS_ERR(data->clk))
 		return PTR_ERR(data->clk);
 
 	ret = clk_prepare_enable(data->clk);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to enable clock\n");
+		dev_err(dev, "Failed to enable clock\n");
 		return ret;
 	}
 
@@ -302,7 +303,7 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 
 	ret = qoriq_tmu_register_tmu_zone(pdev);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to register sensors\n");
+		dev_err(dev, "Failed to register sensors\n");
 		ret = -ENODEV;
 		goto err;
 	}
-- 
2.21.0

