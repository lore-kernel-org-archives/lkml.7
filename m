Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3D7C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1702F206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mya9sJFC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfFTSxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:53:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35476 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfFTSxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:53:11 -0400
Received: by mail-pf1-f196.google.com with SMTP id d126so2176826pfd.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 11:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=88jbRT+Qt3zbjlF2+8qrnSqMwRS9Jqm0TzjiaMFnxcM=;
        b=Mya9sJFCPfUduJyq+/pJSSDnlhPC8HnUp1yztBsJvQJiAsytcAyUDqSjtvPKH+hkyZ
         +ktqC6gIcH5RhNGHn60c0BmZpx5Y6+ooBVILw1VSjwTEo9WQj5daxFGPLPqb9+W1GZwD
         w4GPK46Rj8o6N0Z+Xvao5V2LWsVRMRj6hIHPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=88jbRT+Qt3zbjlF2+8qrnSqMwRS9Jqm0TzjiaMFnxcM=;
        b=Ej5LCsSSYfWlPG5jNRmyIYeNVeMzjcz1KT6NLonR7nxj+SqQx/glucSoMkvpEtSDw1
         WQDzsD8L5vvZdpTOmDPTo2t1dLe054mtSEb9YwFmgsG/jDltOwekvs832s9TFsa4hHAc
         ICU+j93N94hSuPj5xUhLb5Ug03Cj5FH45qXr+BD8/NFu3RsDKFDG7QDzqEYemc32SSll
         ZjCZZhW/VKBqa9TjFOiqnVlpxxCdxUrtgCUaSquUAwDoyTOim2K5v2JTwrGPCDyvQVUS
         4vW8e91I/X72YfmumLHvZFTsTYaR1Jwx91lKOKboP1u1pZoF2af66rnqgFa8mOVLQAOA
         O7KA==
X-Gm-Message-State: APjAAAU8VOIJ2yPNUex2bVrYvV6XL6ELkRp8YUu2Vo/08NthhhYRQ3ue
        YxvuTNyyyH5xEOPSnU7Has8vUA==
X-Google-Smtp-Source: APXvYqzqkaVtKD/uD4uTOJdpJFjxCNuAD3OHXXXwqPl+jMcdMhUb4/s/xL4Ik1ayMgSjY0Qz+kJiWA==
X-Received: by 2002:a63:7d18:: with SMTP id y24mr9281112pgc.438.1561056790309;
        Thu, 20 Jun 2019 11:53:10 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id h1sm243508pfg.55.2019.06.20.11.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 11:53:09 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 1/2] iio: cros_ec: Add sign vector in core for backward compatibility
Date:   Thu, 20 Jun 2019 11:52:58 -0700
Message-Id: <20190620185259.142133-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190620185259.142133-1-gwendal@chromium.org>
References: <20190620185259.142133-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow cros_ec iio core library to be used with legacy device, add a
vector to rotate sensor data if necessary: legacy devices are not
reporting data in HTML5/Android sensor referential.

TEST=On veyron minnie, check chrome detect tablet mode and rotate
screen in tablet mode.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 5 ++++-
 include/linux/iio/common/cros_ec_sensors_core.h           | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 719a0df5aeeb..1b2e7a8242ad 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -66,8 +66,10 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
 		}
 		state->type = state->resp->info.type;
 		state->loc = state->resp->info.location;
-	}
 
+		/* Set sign vector, only used for backward compatibility. */
+		memset(state->sign, 1, CROS_EC_SENSOR_MAX_AXIS);
+	}
 	return 0;
 }
 EXPORT_SYMBOL_GPL(cros_ec_sensors_core_init);
@@ -254,6 +256,7 @@ static int cros_ec_sensors_read_data_unsafe(struct iio_dev *indio_dev,
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

