Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A25C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419442087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i6bRs4gY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbfDPRWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:22:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36881 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbfDPRWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:22:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so28229326wrm.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 10:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=l+DLE4OaxNb2V7PhvGWjDpmhBvdDO716f9vETkoZ5+s=;
        b=i6bRs4gYw/rAuJvBXxk3XDxz4oFRVoi2rTyNwK0Se4vZMe49iY+tw+v9bwWN0UNIDj
         m0kfs2SYosn13L34hsmzQLkr60D1/kf2xzhVgrevNUSKMkAnOe7GDc9aIYzAIkMxWPnJ
         hgNLePc6+RVSik5dIR6XVCGttrZs7rBatZRDz75yXC6/Ac221n+owvp4Bfy+Cj9Pq4Kl
         zHyJwoSYyrtdJS7GcWgetj4EFYT6wk5jxyiEVts+MiN6S1CpsudpnuDIeSslPyRi3fmA
         u7vxAD+58czTA6Sy3dKih5YneDrPiG5xZUCxKkHukqnHKhOe/5veUZ/QGZ97B3qodQQE
         dP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l+DLE4OaxNb2V7PhvGWjDpmhBvdDO716f9vETkoZ5+s=;
        b=YNQQ5MHviWd5iSTbM7wdT/j44w/UY01fQ8165b0jK11wXnvAnXuAc4lsgGqr1JA0Qx
         aq6UoV7X3ejQX2J06trdqCLMg3UmlAyBGEJXNbx+BNNTeqK0zvMhXiBK4QqgGYf8O32P
         bxDzh40TXDMkVgLxpR5qNgx90XHeyVxHPiz36ys9hI7RLkerQdQmef1iVQlZTDys/x7L
         qqNZ6SMDJhCzsVqELUpU6yT5TeNHNvqCZ8aIwoYZC+ZstVhlPDxeSAKNazzj+62mFB25
         dMZhvSE4oYrxfI4EaVspBjmLlTHzXPt8heKfGXONzQUmIiSJB7ePn2bf3omLxe1mZM0L
         AZ4A==
X-Gm-Message-State: APjAAAWQ0P+xX9eBWub4ONopxcNgmGADOp8Nl4eHJksME+Syrdd+Uy/k
        1rdxdAmaD/3KgxIgnuLuek/r9Q==
X-Google-Smtp-Source: APXvYqxHKQKug2Y6hJy/Xrf74+5gMH98BPdDAevRl+IpL5gNC+voqySeT8d4WzTUJSqhXWkaFfjKlw==
X-Received: by 2002:adf:afee:: with SMTP id y46mr52015150wrd.217.1555435334298;
        Tue, 16 Apr 2019 10:22:14 -0700 (PDT)
Received: from mai.imgcgcw.net (50.251.95.92.rev.sfr.net. [92.95.251.50])
        by smtp.gmail.com with ESMTPSA id j11sm69473544wrw.85.2019.04.16.10.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 10:22:13 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com, edubezval@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        andrew.smirnov@gmail.com
Subject: [PATCH] thermal/drivers/of: Add a get_temp_id callback function
Date:   Tue, 16 Apr 2019 19:22:03 +0200
Message-Id: <20190416172203.4679-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently when we register a sensor, we specify the sensor id and a data
pointer to be passed when the get_temp function is called. However the
sensor_id is not passed to the get_temp callback forcing the driver to
do extra allocation and adding back pointer to find out from the sensor
information the driver data and then back to the sensor id.

Add a new callback get_temp_id() which will be called if set. It will
call the get_temp_id() with the sensor id.

That will be more consistent with the registering function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/thermal/of-thermal.c | 19 +++++++++++++------
 include/linux/thermal.h      |  1 +
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 2df059cc07e2..787d1cbe13f3 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -78,6 +78,8 @@ struct __thermal_zone {
 
 	/* sensor interface */
 	void *sensor_data;
+	int sensor_id;
+
 	const struct thermal_zone_of_device_ops *ops;
 };
 
@@ -88,10 +90,14 @@ static int of_thermal_get_temp(struct thermal_zone_device *tz,
 {
 	struct __thermal_zone *data = tz->devdata;
 
-	if (!data->ops->get_temp)
-		return -EINVAL;
+	if (data->ops->get_temp)
+		return data->ops->get_temp(data->sensor_data, temp);
 
-	return data->ops->get_temp(data->sensor_data, temp);
+	if (data->ops->get_temp_id)
+		return data->ops->get_temp_id(data->sensor_id,
+					      data->sensor_data, temp);
+
+	return -EINVAL;
 }
 
 static int of_thermal_set_trips(struct thermal_zone_device *tz,
@@ -407,8 +413,8 @@ static struct thermal_zone_device_ops of_thermal_ops = {
 /***   sensor API   ***/
 
 static struct thermal_zone_device *
-thermal_zone_of_add_sensor(struct device_node *zone,
-			   struct device_node *sensor, void *data,
+thermal_zone_of_add_sensor(struct device_node *zone, struct device_node *sensor,
+			   int sensor_id, void *data,
 			   const struct thermal_zone_of_device_ops *ops)
 {
 	struct thermal_zone_device *tzd;
@@ -426,6 +432,7 @@ thermal_zone_of_add_sensor(struct device_node *zone,
 	mutex_lock(&tzd->lock);
 	tz->ops = ops;
 	tz->sensor_data = data;
+	tz->sensor_id = sensor_id;
 
 	tzd->ops->get_temp = of_thermal_get_temp;
 	tzd->ops->get_trend = of_thermal_get_trend;
@@ -516,7 +523,7 @@ thermal_zone_of_sensor_register(struct device *dev, int sensor_id, void *data,
 		}
 
 		if (sensor_specs.np == sensor_np && id == sensor_id) {
-			tzd = thermal_zone_of_add_sensor(child, sensor_np,
+			tzd = thermal_zone_of_add_sensor(child, sensor_np, sensor_id,
 							 data, ops);
 			if (!IS_ERR(tzd))
 				tzd->ops->set_mode(tzd, THERMAL_DEVICE_ENABLED);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 5f4705f46c2f..2762d7e6dd86 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -351,6 +351,7 @@ struct thermal_genl_event {
  *		   hardware.
  */
 struct thermal_zone_of_device_ops {
+	int (*get_temp_id)(int, void *, int *);
 	int (*get_temp)(void *, int *);
 	int (*get_trend)(void *, int, enum thermal_trend *);
 	int (*set_trips)(void *, int, int);
-- 
2.17.1

