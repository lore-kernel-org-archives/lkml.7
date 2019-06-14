Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89776C31E50
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 23:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DBD32184C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 23:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wYFDcfZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfFNXPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 19:15:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39019 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfFNXO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 19:14:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id j2so2266950pfe.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 16:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LNT+l1wAM3ExTzu8kAKF3OCBx9DgMUq0svFdafuGiNA=;
        b=wYFDcfZ8k1FgZfZP+uKORVWTSenE7XCVBZUbUaLM0tiQX93fBu7dfK0YQEg9UDLF6C
         qqK11P3GuYr7IOpkAdCgbHvbL2OGheySKIFN/6ntMsqCBuZ5dxFwaDsyUCVoWU/NjEPQ
         Tkn0v2JwZnrnOMOkdiIddAlvO62weHSLlJLhMaPnQTuyUeFVAnhgiNt8T/mqkKgjHE2L
         3Sv9ZBZEWg5RTjpR7kWLg+crbIAo+mXxXNYXve0d3c6zXOm9eWklgcY/mSC9UEthVb/X
         d5E3dQ1y55M5fav9SUthGLm6b5eyL8GEnNmx17/qhPRjwjCarY6MsW56KZf4B6kP8aha
         2dmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LNT+l1wAM3ExTzu8kAKF3OCBx9DgMUq0svFdafuGiNA=;
        b=AwQKUCHWMkt8D1zZ26pasWfO9pPof6nJU/aQTklgq27URz5RgMJ3P4Ly7MtKE65idv
         jYeKojPLzghd/j37vO0OBf+XuFPYhBMLK7qRkzWJDn5BppXm6Z9OpR+peh9DnKZf4LYY
         8fJIkTtcuUPPOGGFIka6UHOD0Ka8RLa7kC707e46832FlxdDAqNc7d36paecfLkAxcXW
         1NhSzkq9vS0Ke+eL1YQ37RHp9OxrZVwbhNtUKXyTTArHy3kJhnVJigLIVnO1nbuaDIpp
         WImBwql58oWyireku5KdZCwXS009q+BoTKw1LjpeH8ztartv2/U1BBghW1YcXe0aWRbw
         f+Fg==
X-Gm-Message-State: APjAAAWltAeGaE8fjyN6TFDkZNAEHZBI/RS55Kino/K8doNwRCzgCk79
        rmrgc5er+ghjYJWBCxytYBOsBYo0weg=
X-Google-Smtp-Source: APXvYqxOD8GTJnH35iTniIMOV5Lz2lveQxN9ZM+F4ldKe83xY1Gf3nvXifB6teZ/Q/hiULACCOiVnw==
X-Received: by 2002:a65:65c9:: with SMTP id y9mr38227850pgv.76.1560554098017;
        Fri, 14 Jun 2019 16:14:58 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id w187sm4486445pfb.4.2019.06.14.16.14.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 16:14:57 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 2/3] reset: qcom-pon: Add support for gen2 pon
Date:   Fri, 14 Jun 2019 23:14:50 +0000
Message-Id: <20190614231451.45998-2-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614231451.45998-1-john.stultz@linaro.org>
References: <20190614231451.45998-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for gen2 pon register so "reboot bootloader" can
work on pixel3 and db845.

Cc: Andy Gross <agross@kernel.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Amit Pundir <amit.pundir@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>

v2:
* Split out dts changes into separate path
* Minor cleanups and remove unused variables
---
 drivers/power/reset/qcom-pon.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
index 3fa1642d4c543..22a743a0bf28c 100644
--- a/drivers/power/reset/qcom-pon.c
+++ b/drivers/power/reset/qcom-pon.c
@@ -14,11 +14,15 @@
 
 #define PON_SOFT_RB_SPARE		0x8f
 
+#define GEN1_REASON_SHIFT		2
+#define GEN2_REASON_SHIFT		1
+
 struct pm8916_pon {
 	struct device *dev;
 	struct regmap *regmap;
 	u32 baseaddr;
 	struct reboot_mode_driver reboot_mode;
+	long reason_shift;
 };
 
 static int pm8916_reboot_mode_write(struct reboot_mode_driver *reboot,
@@ -30,7 +34,7 @@ static int pm8916_reboot_mode_write(struct reboot_mode_driver *reboot,
 
 	ret = regmap_update_bits(pon->regmap,
 				 pon->baseaddr + PON_SOFT_RB_SPARE,
-				 0xfc, magic << 2);
+				 0xfc, magic << pon->reason_shift);
 	if (ret < 0)
 		dev_err(pon->dev, "update reboot mode bits failed\n");
 
@@ -60,6 +64,7 @@ static int pm8916_pon_probe(struct platform_device *pdev)
 		return error;
 
 	pon->reboot_mode.dev = &pdev->dev;
+	pon->reason_shift = (long)of_device_get_match_data(&pdev->dev);
 	pon->reboot_mode.write = pm8916_reboot_mode_write;
 	error = devm_reboot_mode_register(&pdev->dev, &pon->reboot_mode);
 	if (error) {
@@ -73,8 +78,9 @@ static int pm8916_pon_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id pm8916_pon_id_table[] = {
-	{ .compatible = "qcom,pm8916-pon" },
-	{ .compatible = "qcom,pms405-pon" },
+	{ .compatible = "qcom,pm8916-pon", .data = (void *)GEN1_REASON_SHIFT },
+	{ .compatible = "qcom,pms405-pon", .data = (void *)GEN1_REASON_SHIFT },
+	{ .compatible = "qcom,pm8998-pon", .data = (void *)GEN2_REASON_SHIFT },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pm8916_pon_id_table);
-- 
2.17.1

