Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856B4C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF052084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbfDZLjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 07:39:51 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38696 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfDZLjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 07:39:51 -0400
Received: from laptop.home (unknown [IPv6:2a01:cb19:8ad6:900:42dd:dd1c:19ee:7c60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: aragua)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id CE6D626117F;
        Fri, 26 Apr 2019 12:39:48 +0100 (BST)
From:   Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] iio: cros_ec: add 'id' sysfs entry
Date:   Fri, 26 Apr 2019 13:39:16 +0200
Message-Id: <20190426113917.10282-1-fabien.lahoudere@collabora.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gwendal Grignou <gwendal@chromium.org>

This new sysfs entry is used to interpret ring buffer information,
mainly by Android sensor HAL.
It expand to all sensors, the documentation about 'id' we can found
in Documentation/ABI/testing/sysfs-bus-iio-cros-ec.

Also fix typo in docs, I replace 'Septembre' by 'September'.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-cros-ec    | 10 +++++-----
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  | 14 ++++++++++++++
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-cros-ec b/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
index 0e95c2ca105c..6158f831c761 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
+++ b/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
@@ -18,11 +18,11 @@ Description:
 		values are 'base' and 'lid'.
 
 What:		/sys/bus/iio/devices/iio:deviceX/id
-Date:		Septembre 2017
+Date:		September 2017
 KernelVersion:	4.14
 Contact:	linux-iio@vger.kernel.org
 Description:
-		This attribute is exposed by the CrOS EC legacy accelerometer
-		driver and represents the sensor ID as exposed by the EC. This
-		ID is used by the Android sensor service hardware abstraction
-		layer (sensor HAL) through the Android container on ChromeOS.
+		This attribute is exposed by the CrOS EC sensors driver and
+		represents the sensor ID as exposed by the EC. This ID is used
+		by the Android sensor service hardware abstraction layer (sensor
+		HAL) through the Android container on ChromeOS.
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 719a0df5aeeb..130362ca421b 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -125,6 +125,15 @@ static ssize_t cros_ec_sensors_calibrate(struct iio_dev *indio_dev,
 	return ret ? ret : len;
 }
 
+static ssize_t cros_ec_sensors_id(struct iio_dev *indio_dev,
+				  uintptr_t private,
+				  const struct iio_chan_spec *chan, char *buf)
+{
+	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", st->param.info.sensor_num);
+}
+
 static ssize_t cros_ec_sensors_loc(struct iio_dev *indio_dev,
 		uintptr_t private, const struct iio_chan_spec *chan,
 		char *buf)
@@ -140,6 +149,11 @@ const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[] = {
 		.shared = IIO_SHARED_BY_ALL,
 		.write = cros_ec_sensors_calibrate
 	},
+	{
+		.name = "id",
+		.shared = IIO_SHARED_BY_ALL,
+		.read = cros_ec_sensors_id
+	},
 	{
 		.name = "location",
 		.shared = IIO_SHARED_BY_ALL,
-- 
2.19.2

