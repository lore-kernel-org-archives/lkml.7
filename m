Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FFAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F67218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c1KEhAKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbfB1Bf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 20:35:57 -0500
Received: from mail-oi1-f199.google.com ([209.85.167.199]:42412 "EHLO
        mail-oi1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730234AbfB1Bf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 20:35:57 -0500
Received: by mail-oi1-f199.google.com with SMTP id j205so8362009oih.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 17:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=20+mLsEF7OyN/zYxCSZlbEYCsdjr9LEDRYeDS+C5Nhg=;
        b=c1KEhAKONholropM5y7v7rtz7PQROvN3elAQumQW2EM54G9WENqRrI8qYQtj8D9gNQ
         AqadJp54NzZck08kg+UNgRpgNTYd+3NGe/xzAzTD1QWxfo7cG3s3T18ksPiu/mpIRw0w
         F7q2HLlL2Pryj1QJy3dGrZBnjyGehDtjnRF64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=20+mLsEF7OyN/zYxCSZlbEYCsdjr9LEDRYeDS+C5Nhg=;
        b=YR4G06YK1IqgBz1GMlQEGWPMm0OLQ/Klne2Kc2isSvjegYS93YaisgFiuJnkH9sDlH
         QzgKiUBQyIX2lXcgPIAeldezK5dsX/QcDx6mZc5hCk58o5GH5iHWb8d+v5rGP8P+BIM8
         brCybPgD/XDI5ssiwl+jIksk18RTDOagJ/94bHg9RYFHXK76Q22IZt5fiIW7yr5wFxEE
         C8+qH/Q/b+xb9IXAc8+HJN9ybZwSOn2yDF/G7LsJ1JRTY5v7sFM6vp/QKQNSeKr+06Nj
         BrVVBvTR90HyAB3ZPwTjVTJNHJRfsupS1L8W63MeE9YCw9dXJicEJ5JF7o9+C/XLhfu9
         ghzw==
X-Gm-Message-State: AHQUAuaQmc3abiAtAtXMzSvUE5XNiBFD0MNnVT/rGF5aKGv7CM2lLaqv
        oMBmZGUUrNEMXBpAGBMG+Gs14t6zn88ggBma
X-Google-Smtp-Source: AHgI3IZcArc/x5BvpO2wfByxTVoBJrY+TeF20BcdQV/jNNjx0XuPfrRBDeFoCVqU/iF0FQuqkPZE6CX1uo5TjrGl
X-Received: by 2002:a9d:700f:: with SMTP id k15mr3498224otj.22.1551317756568;
 Wed, 27 Feb 2019 17:35:56 -0800 (PST)
Date:   Wed, 27 Feb 2019 17:35:41 -0800
In-Reply-To: <CAMHSBOWZHLnGWXU_z1ouCVuRRWKg_59P5++zwhJOWrWJoNv=GA@mail.gmail.com>
Message-Id: <20190228013541.76792-1-gwendal@chromium.org>
Mime-Version: 1.0
References: <CAMHSBOWZHLnGWXU_z1ouCVuRRWKg_59P5++zwhJOWrWJoNv=GA@mail.gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
Subject: [PATCH v5] mfd: cros_ec_dev: Register cros_ec_accel_legacy driver as
 a subdevice
From:   Gwendal Grignou <gwendal@chromium.org>
To:     andy.shevchenko@gmail.com, groeck@chromium.org,
        enric.balletbo@collabora.com, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enric Balletbo i Serra <enric.balletbo@collabora.com>

With this patch, the cros_ec_ctl driver will register the legacy
accelerometer driver (named cros_ec_accel_legacy) if it fails to
register sensors through the usual path cros_ec_sensors_register().
This legacy device is present on Chromebook devices with older EC
firmware only supporting deprecated EC commands (Glimmer based devices).

Tested-by: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Changes in v5:
- Remove unnecessary white lines.

Changes in v4:
- [5/8] Nit: EC -> ECs (Lee Jones)
- [5/8] Statically define cros_ec_accel_legacy_cells (Lee Jones)

Changes in v3:
- [5/8] Add the Reviewed-by Andy Shevchenko.

Changes in v2:
- [5/8] Add the Reviewed-by Gwendal.

 drivers/mfd/cros_ec_dev.c | 66 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index d275deaecb12..64567bd0a081 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -376,6 +376,69 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
 	kfree(msg);
 }
 
+static struct cros_ec_sensor_platform sensor_platforms[] = {
+	{ .sensor_num = 0 },
+	{ .sensor_num = 1 }
+};
+
+static const struct mfd_cell cros_ec_accel_legacy_cells[] = {
+	{
+		.name = "cros-ec-accel-legacy",
+		.id = 0,
+		.platform_data = &sensor_platforms[0],
+		.pdata_size = sizeof(struct cros_ec_sensor_platform),
+	},
+	{
+		.name = "cros-ec-accel-legacy",
+		.id = 1,
+		.platform_data = &sensor_platforms[1],
+		.pdata_size = sizeof(struct cros_ec_sensor_platform),
+	}
+};
+
+static void cros_ec_accel_legacy_register(struct cros_ec_dev *ec)
+{
+	struct cros_ec_device *ec_dev = ec->ec_dev;
+	u8 status;
+	int ret;
+
+	/*
+	 * ECs that need legacy support are the main EC, directly connected to
+	 * the AP.
+	 */
+	if (ec->cmd_offset != 0)
+		return;
+
+	/*
+	 * Check if EC supports direct memory reads and if EC has
+	 * accelerometers.
+	 */
+	if (!ec_dev->cmd_readmem)
+		return;
+
+	ret = ec_dev->cmd_readmem(ec_dev, EC_MEMMAP_ACC_STATUS, 1, &status);
+	if (ret < 0) {
+		dev_warn(ec->dev, "EC does not support direct reads.\n");
+		return;
+	}
+
+	/* Check if EC has accelerometers. */
+	if (!(status & EC_MEMMAP_ACC_STATUS_PRESENCE_BIT)) {
+		dev_info(ec->dev, "EC does not have accelerometers.\n");
+		return;
+	}
+
+	/*
+	 * Register 2 accelerometers
+	 */
+	ret = mfd_add_devices(ec->dev, PLATFORM_DEVID_AUTO,
+			      cros_ec_accel_legacy_cells,
+			      ARRAY_SIZE(cros_ec_accel_legacy_cells),
+			      NULL, 0, NULL);
+	if (ret)
+		dev_err(ec_dev->dev, "failed to add EC sensors\n");
+}
+
 static const struct mfd_cell cros_ec_cec_cells[] = {
 	{ .name = "cros-ec-cec" }
 };
@@ -437,6 +500,9 @@ static int ec_device_probe(struct platform_device *pdev)
 	/* check whether this EC is a sensor hub. */
 	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
 		cros_ec_sensors_register(ec);
+	else
+		/* Workaroud for older EC firmware */
+		cros_ec_accel_legacy_register(ec);
 
 	/* Check whether this EC instance has CEC host command support */
 	if (cros_ec_check_features(ec, EC_FEATURE_CEC)) {
-- 
2.21.0.rc2.261.ga7da99ff1b-goog

