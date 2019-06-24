Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BE7C4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5A520663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iH0VGFtG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfFXWxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 18:53:25 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38611 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbfFXWxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 18:53:22 -0400
Received: by mail-pl1-f194.google.com with SMTP id g4so7682986plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 15:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qTpLIapDj/rrqGy08Nrm9SBzOMwkMreL8u7668CeXy0=;
        b=iH0VGFtGmpwf1/HwJZDZjC0uw0FCnozVD2q+/zX0xLExC5vd3jzPYEgWhbLssjGyrE
         jMt51uv0Zr6xCBEfJk28KGUDTMGSEtHAeJ3KnVs6lpQYy0KNFHmn+rm9wuomLtvSCdaj
         fSS7UQRdMr8VmFPTdDayYn/Pi3kn6N+06l4rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qTpLIapDj/rrqGy08Nrm9SBzOMwkMreL8u7668CeXy0=;
        b=gVAC7w5/TgEoo5nBl/uRlD/wa+/9coPYhrTGxv/2UD07SAB8MK/D9KhgmEGgukPeWY
         cqM9uHK+EIREIE5hQrezK8XUS51LIf3XHzV4MLLS0rXS+B+yx045zpBB82Ax4jEMC+kQ
         +CMXcZaZ9edGkc8ELo6IWVDfPD4Fld515kmaG4dRgqEI2wTea0RyLDMbUWVkC3VLk4Dl
         ATRpDByYOwpvgPcaranELwwBAaNzaKaREA6anee97y4gvvb4wOEb11srFIDmOoYUtxSZ
         PetbS2m07WWFYStsi70gUtLX4s6qCuyY7Wr/KwifYrPEPCBDyDL1RmHw4YKBE3rIDCNu
         xvpA==
X-Gm-Message-State: APjAAAWHtFLVX6ijrW2NIKFgjxZWVjDyQScBYF3/IGE86CY8BIcmWqUq
        SV99+4O9lf3lZIctlwAih/JYFw==
X-Google-Smtp-Source: APXvYqzfbJVS7ijoDPx/biER9UXjp5qTt7B3WzV6pQIt2FxsZ84Che7EiwuSnP2zdxtkYi5MflJFLQ==
X-Received: by 2002:a17:902:a9cb:: with SMTP id b11mr12316299plr.69.1561416801306;
        Mon, 24 Jun 2019 15:53:21 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id k16sm13185404pfa.87.2019.06.24.15.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 15:53:20 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        fabien.lahoudere@collabora.com, dianders@chromium.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 1/2] iio: cros_ec: Add sign vector in core for backward compatibility
Date:   Mon, 24 Jun 2019 15:53:11 -0700
Message-Id: <20190624225312.131745-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190624225312.131745-1-gwendal@chromium.org>
References: <20190624225312.131745-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow cros_ec iio core library to be used with legacy device, add a
vector to rotate sensor data if necessary: legacy devices are not
reporting data in HTML5/Android sensor referential.

Check the data is not rotated on recent chromebooks that use the HTML5
standard to present sensor data.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 4 ++++
 include/linux/iio/common/cros_ec_sensors_core.h           | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 719a0df5aeeb..e8a4d78659c8 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -66,6 +66,9 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 		}
 		state->type = state->resp->info.type;
 		state->loc = state->resp->info.location;
+
+		/* Set sign vector, only used for backward compatibility. */
+		memset(state->sign, 1, CROS_EC_SENSOR_MAX_AXIS);
 	}
 
 	return 0;
@@ -254,6 +257,7 @@ static int cros_ec_sensors_read_data_unsafe(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 
+		*data *= st->sign[i];
 		data++;
 	}
 
diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index ce16445411ac..a1c85ad4df91 100644
--- a/include/linux/iio/common/cros_ec_sensors_core.h
+++ b/include/linux/iio/common/cros_ec_sensors_core.h
@@ -71,6 +71,7 @@ struct cros_ec_sensors_core_state {
 	enum motionsensor_location loc;
 
 	s16 calib[CROS_EC_SENSOR_MAX_AXIS];
+	s8 sign[CROS_EC_SENSOR_MAX_AXIS];
 
 	u8 samples[CROS_EC_SAMPLE_SIZE];
 
-- 
2.22.0.410.gd8fdbe21b5-goog

