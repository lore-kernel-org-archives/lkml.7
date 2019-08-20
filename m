Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD4DC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 05:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0C52087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 05:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GtlBx2K5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbfHTFKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 01:10:51 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46301 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729024AbfHTFKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 01:10:50 -0400
Received: by mail-pg1-f194.google.com with SMTP id m3so2485591pgv.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 22:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AucSo0iTG1cMBc8FIWdp3OKtOSf3xX/XdVDaCB+1w3E=;
        b=GtlBx2K57kgXonIcp24pVGTKNMUMW2gH4Ka/ZnrNxGwyCABh9lNy6Dm2MpjIZImJ26
         jU5y7MbU+ntQQYcCO02dfYsNsy3lD57BsjZjq5GFbK5hlEVPc4P2NEGqDWk6Sx6PSPdl
         81cIek9c7CeGB0heLGXoLWzXk5ncVehlORCtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AucSo0iTG1cMBc8FIWdp3OKtOSf3xX/XdVDaCB+1w3E=;
        b=B953ogxUzsCFCg78O6WijOtUi1y+/O3FEaM/yiFEsCYIRlJb3FALkbCEY6BR8dIS/J
         tSBtMcrA7Fv4KJGmBvpwDEQy22rWbFKEgl1oGZD/Jp8ln0qTmJCWqBQXQDi7905Kzowq
         iSrTx2xFtFw8GF8xTOScCFBalQxTbdM7ySN2PDH+sFDLQblGZRXMQG+B9slvvOtyfe9A
         +r/lHcz8jJqGc2HT5/WTxCDrstPcEhJxlgnv7PzdBDT7p4Q4nQHu9Kk46BOhxoRMdNPd
         CrGASGA7fwZRj8UdGFPfZ0yZ2X8gjMD3x6FdAGpXNGEiyoWhhjCyNvrBpu/K1peWadGg
         GJkA==
X-Gm-Message-State: APjAAAX9/DIrVgiJH8pRkh+6+QLM2BZf31IjXvaSRoBCpR2K8B5G3MPv
        3qYYP6Y8BqUO/oy4dUsvXe6JyA==
X-Google-Smtp-Source: APXvYqy9EyoevmrNpsIqO5DMd+laWuPTmqYg30O6Tg+dLWKU64cDPDNIaFnu2C4J1cZccf0uzNhjOg==
X-Received: by 2002:a65:49cc:: with SMTP id t12mr21549032pgs.83.1566277849606;
        Mon, 19 Aug 2019 22:10:49 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id p189sm18873562pfb.112.2019.08.19.22.10.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 22:10:48 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org
Cc:     enric.balletbo@collabora.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Nick Vaccaro <nvaccaro@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: cros_ec: set calibscale for 3d MEMS to unit vector
Date:   Mon, 19 Aug 2019 22:10:29 -0700
Message-Id: <20190820051029.118905-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, set the calibscale vector to unit vector.
It prevents sending 0 as calibscale when not initialized.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---

 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index fd833295bb173..d44ae126f4578 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -90,7 +90,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 	struct cros_ec_dev *ec = dev_get_drvdata(pdev->dev.parent);
 	struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
 	u32 ver_mask;
-	int ret;
+	int ret, i;
 
 	platform_set_drvdata(pdev, indio_dev);
 
@@ -136,6 +136,9 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 		/* Set sign vector, only used for backward compatibility. */
 		memset(state->sign, 1, CROS_EC_SENSOR_MAX_AXIS);
 
+		for (i = CROS_EC_SENSOR_X; i < CROS_EC_SENSOR_MAX_AXIS; i++)
+			state->calib[i].scale = MOTION_SENSE_DEFAULT_SCALE;
+
 		/* 0 is a correct value used to stop the device */
 		state->frequencies[0] = 0;
 		if (state->msg->version < 3) {
-- 
2.23.0.rc1.153.gdeed80330f-goog

