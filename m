Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438BAC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CEDF2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfCMLkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 07:40:41 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35492 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfCMLkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 07:40:41 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 99F0727FD1A
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@collabora.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] iio: cros_ec: Drop unnecessary include files
Date:   Wed, 13 Mar 2019 12:40:32 +0100
Message-Id: <20190313114032.11455-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <groeck@chromium.org>

The cros_ec sensors drivers do not call any sysfs functions
or use any sysfs defines, and thus do not need to include
linux/sysfs.h. Also, some cros_ec drivers include linux/delay.h
and is not used.

Signed-off-by: Guenter Roeck <groeck@chromium.org>
[remove linux/delay.h]
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/iio/accel/cros_ec_accel_legacy.c                  | 1 -
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c      | 2 --
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 1 -
 drivers/iio/light/cros_ec_light_prox.c                    | 2 --
 drivers/iio/pressure/cros_ec_baro.c                       | 1 -
 5 files changed, 7 deletions(-)

diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
index 021f9f5cd3bb..3be10b121a28 100644
--- a/drivers/iio/accel/cros_ec_accel_legacy.c
+++ b/drivers/iio/accel/cros_ec_accel_legacy.c
@@ -29,7 +29,6 @@
 #include <linux/mfd/cros_ec_commands.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/sysfs.h>
 #include <linux/platform_device.h>
 
 #define DRV_NAME	"cros-ec-accel-legacy"
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index 8d76afb87d87..7d3950952ae6 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -16,7 +16,6 @@
  * EC about sensors data. Data access is presented through iio sysfs.
  */
 
-#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/common/cros_ec_sensors_core.h>
@@ -30,7 +29,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-#include <linux/sysfs.h>
 
 #define CROS_EC_SENSORS_MAX_CHANNELS 4
 
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index 414cc43c287e..c770a2a809d7 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -25,7 +25,6 @@
 #include <linux/mfd/cros_ec_commands.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/sysfs.h>
 #include <linux/platform_device.h>
 
 static char *cros_ec_loc[] = {
diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
index fd1609e975ab..7bb3078217b3 100644
--- a/drivers/iio/light/cros_ec_light_prox.c
+++ b/drivers/iio/light/cros_ec_light_prox.c
@@ -13,7 +13,6 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/common/cros_ec_sensors_core.h>
@@ -28,7 +27,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-#include <linux/sysfs.h>
 
 /*
  * We only represent one entry for light or proximity. EC is merging different
diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
index 87c07af9181f..886690785047 100644
--- a/drivers/iio/pressure/cros_ec_baro.c
+++ b/drivers/iio/pressure/cros_ec_baro.c
@@ -13,7 +13,6 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/common/cros_ec_sensors_core.h>
-- 
2.20.1

