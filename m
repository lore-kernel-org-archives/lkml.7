Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B999BC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9481A2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfDLOF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:05:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33594 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfDLOF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:05:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D4CE374;
        Fri, 12 Apr 2019 07:05:28 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C7D433F557;
        Fri, 12 Apr 2019 07:05:26 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     linux@roeck-us.net, kamil@wypas.org, b.zolnierkie@samsung.com,
        jdelvare@suse.com
Cc:     stefan.wahren@i2se.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] hwmon: pwm-fan: Report probe errors consistently
Date:   Fri, 12 Apr 2019 15:05:23 +0100
Message-Id: <69fabb7ca6c9d4a8f9c18bcf298d2ce9502a9547.1555069101.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.21.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Printing the error code for a failure provides a head-start for
debugging, since it's often sufficient to pinpoint the origin of the
failure. We already do this for some probe-failure messages, so let's
make the rest of them consistent.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

This is based on Stefan's "[PATCH V5 3/3] hwmon: pwm-fan: Add RPM support
via external interrupt"
 
 drivers/hwmon/pwm-fan.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 8c4c5eefd4ca..556db4bef743 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -330,7 +330,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
 
 	ret = pwm_apply_state(ctx->pwm, &state);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to configure PWM\n");
+		dev_err(&pdev->dev, "Failed to configure PWM: %d\n", ret);
 		goto err_reg_disable;
 	}
 
@@ -348,7 +348,8 @@ static int pwm_fan_probe(struct platform_device *pdev)
 		ret = devm_request_irq(&pdev->dev, ctx->irq, pulse_handler, 0,
 				       pdev->name, ctx);
 		if (ret) {
-			dev_err(&pdev->dev, "Can't get interrupt working.\n");
+			dev_err(&pdev->dev,
+				"Failed to request interrupt: %d\n", ret);
 			goto err_pwm_disable;
 		}
 		ctx->sample_start = ktime_get();
@@ -358,8 +359,9 @@ static int pwm_fan_probe(struct platform_device *pdev)
 	hwmon = devm_hwmon_device_register_with_groups(&pdev->dev, "pwmfan",
 						       ctx, pwm_fan_groups);
 	if (IS_ERR(hwmon)) {
-		dev_err(&pdev->dev, "Failed to register hwmon device\n");
 		ret = PTR_ERR(hwmon);
+		dev_err(&pdev->dev,
+			"Failed to register hwmon device: %d\n", ret);
 		goto err_del_timer;
 	}
 
@@ -373,9 +375,10 @@ static int pwm_fan_probe(struct platform_device *pdev)
 							  "pwm-fan", ctx,
 							  &pwm_fan_cooling_ops);
 		if (IS_ERR(cdev)) {
-			dev_err(&pdev->dev,
-				"Failed to register pwm-fan as cooling device");
 			ret = PTR_ERR(cdev);
+			dev_err(&pdev->dev,
+				"Failed to register pwm-fan as cooling device: %d\n",
+				ret);
 			goto err_del_timer;
 		}
 		ctx->cdev = cdev;
-- 
2.21.0.dirty

