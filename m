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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA96DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78AC920870
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqpWaDeG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731685AbfDAEOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:14:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44903 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbfDAEOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 00:14:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id y13so3855838pfm.11;
        Sun, 31 Mar 2019 21:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PbKmeyjLaw5QfVmDsIrvR0+awEg3ChkmncNMda3QxSE=;
        b=OqpWaDeGeRYbkawGBK34oRdnPEQj0FZHDer0RBcZ1d5BvLaK4bTFQEqw0KZBGwYrgI
         6yW4SCuoAhb3DyTV+EirEY6pmgM4ld4VsWDLS28t9NfybA5wLeYFeza0zEF1lJC5CGfC
         2WDjm0I9+H5TNMuVojokW2dropOdF2uab+T7AKce8k5azWQedhJW/kRlpntLep8QfMNm
         6UQnCNj4xgrmRBkjCewAWBwmXyy5T2wt0cbyhcu9NQlrTKB30K7YIqxOBPhPApfK+y1L
         +Po9241h+k6mGbADP/3i2wf2hh4V2aIUpmy/rtbjiOAzR9+urM3LIPc0deIbS5CXaT8p
         YBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PbKmeyjLaw5QfVmDsIrvR0+awEg3ChkmncNMda3QxSE=;
        b=JwUG2U6kvlH3v92VdjAmX7N3xtGBDgvN27xOZTawKGv/UhbqcBgorY5A0Qjh7bsH+P
         sCZ6tzRjz/DuBE4Vj9Ozt7TbBYZ8/fJWTGzORybjLkJwOK4MrWTWa5sAdL4It4XJlejw
         pS4v9knEr9NOt4R6NKoA/v5LUJgQNd/YNXCu23w1skL28ntyQss0S4EwSwngIrrKSwjR
         vgs4CT0sVZxeOkGxfSmJSa1Lz+hmQMm9f6RYuB00w4mPFn5XkZUpioKqkzIbK/Vur/W6
         /tromSyX4ClA+jr/4I+4kgryqeJKjxd1KJgh0Lfxm86TlWNWnCXPfJHwmQDstVL1QS+M
         v9cA==
X-Gm-Message-State: APjAAAWSQYrAVw6TlnraTemecRyGWX+otJnV5t2WzXGPuKnTmNWQQIVb
        l2/XUqiQB4yhyrLac04lFJtAEfpZ
X-Google-Smtp-Source: APXvYqzMEHgPsbtzibUZfkpMo9zz5GcqbIw4/aTdHloT+aXwFIBL445TFnIlhFD+SqjahQlOalAI4Q==
X-Received: by 2002:a62:4290:: with SMTP id h16mr60573758pfd.8.1554092083684;
        Sun, 31 Mar 2019 21:14:43 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id a12sm9968504pgq.21.2019.03.31.21.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 21:14:42 -0700 (PDT)
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
Subject: [PATCH v3 07/13] thermal: qoriq: Pass data to qoriq_tmu_calibration() directly
Date:   Sun, 31 Mar 2019 21:14:12 -0700
Message-Id: <20190401041418.5999-8-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401041418.5999-1-andrew.smirnov@gmail.com>
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can simplify error cleanup code if instead of passing a "struct
platform_device *" to qoriq_tmu_calibration() and deriving a bunch of
pointers from it, we pass those pointers directly. This way we won't
be force to call platform_set_drvdata() as early in qoriq_tmu_probe()
and consequently would be able to drop the "err_iomap" error path.

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
 drivers/thermal/qoriq_thermal.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 24a2a57f61c9..a3ddb55740e4 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -139,16 +139,16 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
 	return 0;
 }
 
-static int qoriq_tmu_calibration(struct platform_device *pdev)
+static int qoriq_tmu_calibration(struct device *dev,
+				 struct qoriq_tmu_data *data)
 {
 	int i, val, len;
 	u32 range[4];
 	const u32 *calibration;
-	struct device_node *np = pdev->dev.of_node;
-	struct qoriq_tmu_data *data = platform_get_drvdata(pdev);
+	struct device_node *np = dev->of_node;
 
 	if (of_property_read_u32_array(np, "fsl,tmu-range", range, 4)) {
-		dev_err(&pdev->dev, "missing calibration range.\n");
+		dev_err(dev, "missing calibration range.\n");
 		return -ENODEV;
 	}
 
@@ -160,7 +160,7 @@ static int qoriq_tmu_calibration(struct platform_device *pdev)
 
 	calibration = of_get_property(np, "fsl,tmu-calibration", &len);
 	if (calibration == NULL || len % 8) {
-		dev_err(&pdev->dev, "invalid calibration data.\n");
+		dev_err(dev, "invalid calibration data.\n");
 		return -ENODEV;
 	}
 
@@ -198,20 +198,17 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, data);
-
 	data->little_endian = of_property_read_bool(np, "little-endian");
 
 	data->regs = of_iomap(np, 0);
 	if (!data->regs) {
 		dev_err(dev, "Failed to get memory region\n");
-		ret = -ENODEV;
-		goto err_iomap;
+		return -ENODEV;
 	}
 
 	qoriq_tmu_init_device(data);	/* TMU initialization */
 
-	ret = qoriq_tmu_calibration(pdev);	/* TMU calibration */
+	ret = qoriq_tmu_calibration(dev, data);	/* TMU calibration */
 	if (ret < 0)
 		goto err_tmu;
 
@@ -222,14 +219,13 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 		goto err_iomap;
 	}
 
+	platform_set_drvdata(pdev, data);
+
 	return 0;
 
 err_tmu:
 	iounmap(data->regs);
 
-err_iomap:
-	platform_set_drvdata(pdev, NULL);
-
 	return ret;
 }
 
-- 
2.20.1

