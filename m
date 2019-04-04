Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9891C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E00B20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZQ0v5O9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfDDIHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:07:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37088 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfDDIHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:07:05 -0400
Received: by mail-pl1-f195.google.com with SMTP id w23so770369ply.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 01:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X5EjowjeZ3lBCaiOxRkIEY3EgwtWt+4pPPGinUjsGf0=;
        b=ZQ0v5O9TBvpHSZWD1HXxvJy3G27safHY07lxtBzZc0TsvglUPkaCctkATHKclz9/0I
         DPaGgB7voUEjbPbAYR38btNBdH3SII2DxiWhNhn91DnE+ZwQkRncAwWuUpVLDI0EnQbA
         l5+vNtyfHgk946oXNrRbmuvjo0azGoBs9Hy/AMt/bv2MbfyenYW4urdN2jD+MrxqVmv8
         pi4j8qGQ4HaN7AEFq/ubJ5+M0gyA0CX+vaDq0YpyexgM0I+a+agFFZuzzggG4Z7wqaAO
         xLDEFA/gOQcS2kVqsb1GnmmqvMf+OKqOwj51rxF9T6f3aBaX2jCppeqllJgwy1t31K8N
         wXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X5EjowjeZ3lBCaiOxRkIEY3EgwtWt+4pPPGinUjsGf0=;
        b=o/tqt2nndCBQkvFlzZOH6xtwDuv3TdpgXFxGbM/BWeiJGiK9vVZQ1uIZamdm9JP2D6
         8wTHhUD63V5mOJwqFkHmucx10kB+zEufGLZT6xmVb2RyhoDgFi3Iuo8nBBlNCmA+/NhY
         LZ3rR6OM4psp2OFu9lrD+df+906k6YEtiwEuO8FvZvrp/ucHArjddPedUFXnkzQZZcR1
         qUWOJ+ea5iV9DmDyjuxY7r7NnU4GLFGlwckbi/edmc2iPcYWAonSNhGGYa0E5pb8gjSR
         h5maKlI43JZu+WNaP9YD9vx+pUgwl4QLR8haeCQq8asezHd9/f0mF+xWqDyFiMCY55IA
         Iwjw==
X-Gm-Message-State: APjAAAWs7YKnokhVA1QGky12AbeW7SjI8YIdXPseAYuVuyNFRpUdsM6n
        ciZg2piU4PVqJvwWJlbUvZ4TYA==
X-Google-Smtp-Source: APXvYqzTKJX8dl5Tw5XFicD9if4J/2Ic5jaAAv+ky4WB10lY0m8hLnMfKi7rYQb3A8FWQIFn8jlcqg==
X-Received: by 2002:a17:902:bd41:: with SMTP id b1mr4951965plx.221.1554365224645;
        Thu, 04 Apr 2019 01:07:04 -0700 (PDT)
Received: from mai.imgcgcw.net ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id x9sm32380940pfn.60.2019.04.04.01.07.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 01:07:03 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     andrew.smirnov@gmail.com
Cc:     linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RFC 1/2] thermal/drivers/of: Add a get_temp_id callback function
Date:   Thu,  4 Apr 2019 10:06:46 +0200
Message-Id: <20190404080647.8173-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <00a5711b-5120-9e77-91a0-e0cbab456d92@linaro.org>
References: <00a5711b-5120-9e77-91a0-e0cbab456d92@linaro.org>
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

