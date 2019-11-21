Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020B3C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 05:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD14720898
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 05:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fz4Sk5GV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfKUFvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 00:51:01 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:41002 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfKUFvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 00:51:01 -0500
Received: by mail-pg1-f179.google.com with SMTP id 207so1016910pge.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 21:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JGGvAMwItuoHstBCxzBFlnEPhYOMIX4l46IdZuoC2/M=;
        b=Fz4Sk5GVK5yzfp85dWuOdBmN3v4o/SZkgqWLkcznYBuZpncK+kvROD0g0pgFqHoejx
         QTgjMdMSw6sDhTqB43CpULkdQ/gbixX2e5c1HXIHA+13SaNRpAHQ1S2kKrp03cZ+XnG5
         c97YKLJLOb+t5ibkgqI+zT/ov9ayGp3ddwsm8OruJUm3go7L9jMT8S1mCteS9TZTqjV5
         Dh6jS/sRlwhKHUkRGAdAktDsvXDkr3nyA7Y+5TBAf1yKF1KatCZpL4UK5iQ8EE1zKdOx
         yYUsRmGaFKPQzGfM7hFtoLkH+VxE2+QMW0sl8cinnMKtc4QixHbgnjOQOADrxDAj+Qhc
         iH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JGGvAMwItuoHstBCxzBFlnEPhYOMIX4l46IdZuoC2/M=;
        b=h2sDQgSqHIPxyxoNcOMVYkmKICQ3Kmfdma+XqMy70Jr4F0HYBpIHYIGXMRe2lYwXPj
         UWwXbR7A1E9LAwPBCoavbeOcGncihRxpyRgBqn2YBPavGww/rvyQln8BwlYGtXHfGty/
         JZl6U550TFMxaZoJUlTzyp+add7PRU+VDqPYPxDzqOd+HrcfFPMEu38eH6JXxGgIb+RN
         W0KCyNGenVbfMSPnV15tTM14Ar+Fbzd2v1BiP1PBBPAA7QQcrjEIMFoBrrAx2mjRDNGX
         sfkn0PLDq4A42oqizc/5Drfk9DBPHu8J1HpQKlMNJLP9APq790k6efcXxth82hf39Pxv
         zFzA==
X-Gm-Message-State: APjAAAVPKJl2u7Vsm/VYHrugrFvt4kRktZZGS0Cpk30qApdUD7iJ7T7s
        YYrodP/s+u6eJCJoQ64AO3xw0G98Q0aP6g==
X-Google-Smtp-Source: APXvYqya8XMLiF/AAZZAFUs8GkqZDwAAd1YByFMk4g0oIU4vDMez4wH0hkEat+T+ZiYrqqKJk4NB4A==
X-Received: by 2002:a63:c60f:: with SMTP id w15mr7481209pgg.33.1574315460190;
        Wed, 20 Nov 2019 21:51:00 -0800 (PST)
Received: from localhost ([14.96.100.229])
        by smtp.gmail.com with ESMTPSA id x2sm1443211pfn.167.2019.11.20.21.50.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Nov 2019 21:50:59 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, swboyd@chromium.org, j-keerthy@ti.com,
        thara.gopinath@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     Ram Chandrasekar <rkumbako@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org
Subject: [PATCH] drivers: thermal: step_wise: add support for hysteresis
Date:   Thu, 21 Nov 2019 11:20:56 +0530
Message-Id: <8e812065f4a76325097c5f9c17f3386736d8c1d4.1574315190.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ram Chandrasekar <rkumbako@codeaurora.org>

Currently, step wise governor increases the mitigation when the
temperature goes above a threshold and decreases the mitigation when the
temperature goes below the threshold. If there is a case where the
temperature is wavering around the threshold, the mitigation will be
applied and removed every iteration, which is not very efficient.

The use of hysteresis temperature could avoid this ping-pong of
mitigation by relaxing the mitigation to happen only when the
temperature goes below this lower hysteresis value.

Signed-off-by: Ram Chandrasekar <rkumbako@codeaurora.org>
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
[Rebased patch from downstream]
Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/step_wise.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
index 6e051cbd824ff..2c8a34a7cf959 100644
--- a/drivers/thermal/step_wise.c
+++ b/drivers/thermal/step_wise.c
@@ -24,7 +24,7 @@
  *       for this trip point
  *    d. if the trend is THERMAL_TREND_DROP_FULL, use lower limit
  *       for this trip point
- * If the temperature is lower than a trip point,
+ * If the temperature is lower than a hysteresis temperature,
  *    a. if the trend is THERMAL_TREND_RAISING, do nothing
  *    b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
  *       state for this trip point, if the cooling state already
@@ -115,30 +115,31 @@ static void update_passive_instance(struct thermal_zone_device *tz,
 
 static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 {
-	int trip_temp;
+	int trip_temp, hyst_temp;
 	enum thermal_trip_type trip_type;
 	enum thermal_trend trend;
 	struct thermal_instance *instance;
-	bool throttle = false;
+	bool throttle;
 	int old_target;
 
 	if (trip == THERMAL_TRIPS_NONE) {
-		trip_temp = tz->forced_passive;
+		hyst_temp = trip_temp = tz->forced_passive;
 		trip_type = THERMAL_TRIPS_NONE;
 	} else {
 		tz->ops->get_trip_temp(tz, trip, &trip_temp);
+		hyst_temp = trip_temp;
+		if (tz->ops->get_trip_hyst) {
+			tz->ops->get_trip_hyst(tz, trip, &hyst_temp);
+			hyst_temp = trip_temp - hyst_temp;
+		}
 		tz->ops->get_trip_type(tz, trip, &trip_type);
 	}
 
 	trend = get_tz_trend(tz, trip);
 
-	if (tz->temperature >= trip_temp) {
-		throttle = true;
-		trace_thermal_zone_trip(tz, trip, trip_type);
-	}
-
-	dev_dbg(&tz->device, "Trip%d[type=%d,temp=%d]:trend=%d,throttle=%d\n",
-				trip, trip_type, trip_temp, trend, throttle);
+	dev_dbg(&tz->device,
+		"Trip%d[type=%d,temp=%d,hyst=%d]:trend=%d,throttle=%d\n",
+		trip, trip_type, trip_temp, hyst_temp, trend, throttle);
 
 	mutex_lock(&tz->lock);
 
@@ -147,6 +148,18 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 			continue;
 
 		old_target = instance->target;
+		throttle = false;
+		/*
+		 * Lower the mitigation only if the temperature
+		 * goes below the hysteresis temperature.
+		 */
+		if (tz->temperature >= trip_temp ||
+		    (tz->temperature >= hyst_temp &&
+		     old_target != THERMAL_NO_TARGET)) {
+			throttle = true;
+			trace_thermal_zone_trip(tz, trip, trip_type);
+		}
+
 		instance->target = get_target_state(instance, trend, throttle);
 		dev_dbg(&instance->cdev->device, "old_target=%d, target=%d\n",
 					old_target, (int)instance->target);
-- 
2.17.1

