Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA04C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 07:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4821D212F5
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 07:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NcQkgXfm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404154AbfFKHMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 03:12:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45552 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403812AbfFKHMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 03:12:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id w34so6408066pga.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 00:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2zflAisppPi3XH8PNGYAeS6Mc1+luPDWwoAOPJ/TYcg=;
        b=NcQkgXfmzyNO0YSn/QeFYQVmDP4+ca/BNM9xc48Wx4NL49tHZMfhtks6eGJxrmsQJW
         SbRL5ri918gaEOhJJFOxEUL8yGN/m8/VRRE4rYiq/0WGit68pfkZq4YgpX016b4qYV4E
         F4k7D4NoAiMvBUC1y7fRot7PLitXBe3HVd8o8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2zflAisppPi3XH8PNGYAeS6Mc1+luPDWwoAOPJ/TYcg=;
        b=EoC+kJMqVOUULfuoKEzXnpM221g7WKEZbpTd5rcVrtuXQMFG6IrSPwH0NkNJTre/Tx
         OQKOh/WlaOmdanTut7B0umDHJjXerkQ/tRbW7xpwJKDQ/6ZcnDjEJI7TNrvkMSUJkYcE
         6UgBkN9PvyV7WRXC9E2RBPNSrgEu7qB7GThlb2X8FU8IsBajXVsSYtoWXw8a1g3O+exG
         uhni1LIyEvUlnWLYKvMRZSbC3bH5M6GY207K49OCGfr737c+R6Fb4P33Eic8h078D0Yn
         DL3t5lOm6fvaOWemn8pfTV7+3IfpjeIw4w5Dbx8GUT22V3UOxWDEk9UTBC3/itHgbOkw
         Sygw==
X-Gm-Message-State: APjAAAX+YcJc+pILhkFV5PHghLU0zoitpSvmtl2oM3yBUPd3TSAWx2FX
        Y0oCQVHaAd09/I7uhcGLz2KicA==
X-Google-Smtp-Source: APXvYqyw4K4ehNs3kP90MsjbeU3jHXkIAVRqccZH3OYXIi8GpLrgJ+96LkyLEa6uULz8q6lzL5g6zg==
X-Received: by 2002:a65:44c8:: with SMTP id g8mr18952381pgs.443.1560237172184;
        Tue, 11 Jun 2019 00:12:52 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id m5sm1641345pjl.24.2019.06.11.00.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 00:12:51 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v6] mfd: cros_ec_dev: Register cros_ec_accel_legacy driver as a subdevice
Date:   Tue, 11 Jun 2019 00:12:36 -0700
Message-Id: <20190611071236.171518-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this patch, the cros_ec_ctl driver will register the legacy
accelerometer driver (named cros_ec_accel_legacy) if it fails to
register sensors through the usual path cros_ec_sensors_register().
This legacy device is present on Chromebook devices with older EC
firmware only supporting deprecated EC commands:
- Glimmer based devices [Intel SOC using LPC transport]
- Veyron minnie devices [ARM SOC using SPI transport]

Tested-by: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v6:
- Remove .id field in mfd_cell, PLATFORM_DEVID_AUTO is set to auto
  assign ids.
- Add support for ARM devices with older EC.

Changes in v5:
- Remove unnecessary white lines.

Changes in v4:
- [5/8] Nit: EC -> ECs (Lee Jones)
- [5/8] Statically define cros_ec_accel_legacy_cells (Lee Jones)

Changes in v3:
- [5/8] Add the Reviewed-by Andy Shevchenko.

Changes in v2:
- [5/8] Add the Reviewed-by Gwendal.

 drivers/mfd/cros_ec_dev.c | 69 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 54a58df571b6..c2156b6086eb 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -376,6 +376,72 @@ static void cros_ec_sensors_register(struct cros_ec_dev *ec)
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
+		.platform_data = &sensor_platforms[0],
+		.pdata_size = sizeof(struct cros_ec_sensor_platform),
+	},
+	{
+		.name = "cros-ec-accel-legacy",
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
+	if (ec_dev->cmd_readmem) {
+		ret = ec_dev->cmd_readmem(ec_dev, EC_MEMMAP_ACC_STATUS, 1,
+					  &status);
+		if (ret < 0) {
+			dev_warn(ec->dev, "EC direct read error.\n");
+			return;
+		}
+
+		/* Check if EC has accelerometers. */
+		if (!(status & EC_MEMMAP_ACC_STATUS_PRESENCE_BIT)) {
+			dev_info(ec->dev, "EC does not have accelerometers.\n");
+			return;
+		}
+	}
+
+	/*
+	 * The device may still support accelerometers:
+	 * it would be an older ARM based device that do not suppor the
+	 * EC_CMD_GET_FEATURES command.
+	 *
+	 * Register 2 accelerometers, we will fail in the IIO driver if there
+	 * are no sensors.
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
@@ -471,6 +537,9 @@ static int ec_device_probe(struct platform_device *pdev)
 	/* check whether this EC is a sensor hub. */
 	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE))
 		cros_ec_sensors_register(ec);
+	else
+		/* Workaroud for older EC firmware */
+		cros_ec_accel_legacy_register(ec);
 
 	/* Check whether this EC instance has CEC host command support */
 	if (cros_ec_check_features(ec, EC_FEATURE_CEC)) {
-- 
2.22.0.rc1.257.g3120a18244-goog

