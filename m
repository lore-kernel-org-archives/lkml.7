Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076DAC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 19:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24D7214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 19:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UYHUlmfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfF1TR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 15:17:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45020 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfF1TRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 15:17:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id n2so2993690pgp.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 12:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qTpLIapDj/rrqGy08Nrm9SBzOMwkMreL8u7668CeXy0=;
        b=UYHUlmfCpyp/Rq/Sh84vW7D38yShCRvel4pWMlhyR+FoG65rk/+3VnEY5fxJchI62X
         AGM8glZTsjjQYiMLYxYfEScRzsL/dCl0bSiyMzV0L+uJ3pGXcEMM5E1l/9BMzZ4Eul+T
         f5FOYAZUh89WVxJaxVTPSFRltZXK9qGGizeug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qTpLIapDj/rrqGy08Nrm9SBzOMwkMreL8u7668CeXy0=;
        b=eG9NeWO34HC1RCjDnTZctfM4DQanR0c61+rSUxRWqeIjdfNHiG8o4Elw9X3hme5oH0
         NERnTf3476HfW1fxUKwsuAq1EyqMJ2BmWNj9dJO8lhXKvUrErM1TDdFgrpK8gZBONOEv
         i9512QCsaqpSJ88mLVgK6Nl692tRzZc6kBbjagOeB/MAqlpIo54HZTfGkCJtLquea/0s
         1LRp/2W4TZ02bpw7yiwr3+QJ58KrxL2fLpUrZX+29zwgDw91UPka48T45ehiWg9+jywC
         i6kUng730ycF7NddPiJqy9IzCTwJnEFTGmUB6E7T8MfTJnXX5w1Khxnbb2/iVkvi+skc
         zu2Q==
X-Gm-Message-State: APjAAAX96CCn2hor3Nm955S/dgC8rwooomkrA6F47jHl52XnaESCXDhT
        L87vvPFqwLNZJ0bVlKlWPNg2/g==
X-Google-Smtp-Source: APXvYqxFI1diBCJYCGIBbL5Ayng8s2supWGZgkAkhSjaPVKvRZQT9z6SdHP6K6Gv2lLVrYGzrI1zuw==
X-Received: by 2002:a17:90a:1aa4:: with SMTP id p33mr15305071pjp.27.1561749444272;
        Fri, 28 Jun 2019 12:17:24 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id s5sm2614097pgj.60.2019.06.28.12.17.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 12:17:23 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        fabien.lahoudere@collabora.com, dianders@chromium.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4 1/4] iio: cros_ec: Add sign vector in core for backward compatibility
Date:   Fri, 28 Jun 2019 12:17:08 -0700
Message-Id: <20190628191711.23584-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190628191711.23584-1-gwendal@chromium.org>
References: <20190628191711.23584-1-gwendal@chromium.org>
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

