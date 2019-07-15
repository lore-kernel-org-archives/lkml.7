Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C163C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 22:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A89720665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 22:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ckEXxsin"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733021AbfGOWCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 18:02:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36107 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732978AbfGOWCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 18:02:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id l21so8363340pgm.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 15:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W/N1OmGfFxQK9nmuC/X+2LE+Tf1HeTL3guKyaeoei5c=;
        b=ckEXxsinSkMn7214o32ISQ3H5cakf16mWUrXXH3q9Jf1xGwYbbLE7b7AhzLgTej9Rb
         5Nv9LATKXA2SN+I11BkYRbL27zSKhIMd88AskD23IHjcwPooENlckHZqv5s5Ebbn1Xbw
         1EkiJurHIRIlYHoKkGx/nAmmViqnFZ4Wv8JJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W/N1OmGfFxQK9nmuC/X+2LE+Tf1HeTL3guKyaeoei5c=;
        b=imM065MWWuugE3AHHZyECquEPxDVC+BzC2dqrcZ7ASL9Okx83/ZjtYpOOqwA1U7dsL
         a9/7qDk1iSE1Ei5UwxBreRLHzg6leS29Kei00oIFiwWxRnyLxF4LcGZhLAwOAm+JSYUF
         wy/nDs+uSi0yXyxRguHEWCq6VtFNFwYHmKzXCk5H+Otq2XT9ng6XvWVVUgdiEo+aG/GL
         4wyxvu2WoNpkzzpA4Dyr3Lr7hbAteqwcpIJh+c9PJGbtV+z6ZZBZ+29jXhtXlyxSFgXW
         E9L+N7vUJIFUXmlcaHnRu0ZAn5/PwEi+DiGovTCQ4pkptcXQo8lV/iwAhex3ltGNQ7Ck
         1oOA==
X-Gm-Message-State: APjAAAUOgIUm/BedMrA11IUyft61HYmFvdZNrRR/QFRvrBrPeQW9KBIt
        89RcrG0yRhJ702+UNPrmZOwrww==
X-Google-Smtp-Source: APXvYqwjautSSRg34L2Q15aZGrHbSMMDBKwVmSRu2KDpi1SjHi5dChu3Yj+x071FmkMzReGX0JOtAg==
X-Received: by 2002:a63:e14d:: with SMTP id h13mr29301058pgk.431.1563228134163;
        Mon, 15 Jul 2019 15:02:14 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id q36sm16218609pgl.23.2019.07.15.15.02.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 15:02:13 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        fabien.lahoudere@collabora.com, dianders@chromium.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 4/4] iio: cros_ec_accel_legacy: Add support for veyron-minnie
Date:   Mon, 15 Jul 2019 15:01:52 -0700
Message-Id: <20190715220152.119531-5-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <20190715220152.119531-1-gwendal@chromium.org>
References: <20190715220152.119531-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Veyron minnie embedded controller presents 2 accelerometers using an
older interface. Add function to query the data in cros_ec_accel.

Verify accelerometers on veyron-minnie are presented and working.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/cros_ec_accel_legacy.c | 40 ++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
index 4d77472e2f72..545e23f0c033 100644
--- a/drivers/iio/accel/cros_ec_accel_legacy.c
+++ b/drivers/iio/accel/cros_ec_accel_legacy.c
@@ -5,7 +5,7 @@
  * Copyright 2017 Google, Inc
  *
  * This driver uses the memory mapper cros-ec interface to communicate
- * with the Chrome OS EC about accelerometer data.
+ * with the Chrome OS EC about accelerometer data or older commands.
  * Accelerometer access is presented through iio sysfs.
  */
 
@@ -33,6 +33,39 @@
  */
 #define ACCEL_LEGACY_NSCALE 9586168
 
+static int cros_ec_accel_legacy_read_cmd(struct iio_dev *indio_dev,
+				  unsigned long scan_mask, s16 *data)
+{
+	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
+	int ret;
+	unsigned int i;
+	u8 sensor_num;
+
+	/*
+	 * Read all sensor data through a command.
+	 * Save sensor_num, it is assumed to stay.
+	 */
+	sensor_num = st->param.info.sensor_num;
+	st->param.cmd = MOTIONSENSE_CMD_DUMP;
+	st->param.dump.max_sensor_count = CROS_EC_SENSOR_LEGACY_NUM;
+	ret = cros_ec_motion_send_host_cmd(st,
+			sizeof(st->resp->dump) + CROS_EC_SENSOR_LEGACY_NUM *
+			sizeof(struct ec_response_motion_sensor_data));
+	st->param.info.sensor_num = sensor_num;
+	if (ret != 0) {
+		dev_warn(&indio_dev->dev, "Unable to read sensor data\n");
+		return ret;
+	}
+
+	for_each_set_bit(i, &scan_mask, indio_dev->masklength) {
+		*data = st->resp->dump.sensor[sensor_num].data[i] *
+			st->sign[i];
+		data++;
+	}
+
+	return 0;
+}
+
 static int cros_ec_accel_legacy_read(struct iio_dev *indio_dev,
 				     struct iio_chan_spec const *chan,
 				     int *val, int *val2, long mask)
@@ -149,7 +182,10 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
 	indio_dev->info = &cros_ec_accel_legacy_info;
 	state = iio_priv(indio_dev);
 
-	state->read_ec_sensors_data = cros_ec_sensors_read_lpc;
+	if (state->ec->cmd_readmem != NULL)
+		state->read_ec_sensors_data = cros_ec_sensors_read_lpc;
+	else
+		state->read_ec_sensors_data = cros_ec_accel_legacy_read_cmd;
 
 	indio_dev->channels = cros_ec_accel_legacy_channels;
 	indio_dev->num_channels = ARRAY_SIZE(cros_ec_accel_legacy_channels);
-- 
2.22.0.510.g264f2c817a-goog

