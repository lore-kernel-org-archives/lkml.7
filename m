Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80152C10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA2220675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfCGPKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:10:52 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38110 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGPKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:10:51 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id B671F280667
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@collabora.com,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: [PATCH v2] iio: cros_ec: Fix the maths for gyro scale calculation
Date:   Thu,  7 Mar 2019 16:10:41 +0100
Message-Id: <20190307151041.10113-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gwendal Grignou <gwendal@chromium.org>

Calculation did not use IIO_DEGREE_TO_RAD and implemented a variant to
avoid precision loss as we aim a nano value. The offset added to avoid
rounding error, though, doesn't give us a close result to the expected
value. E.g.

For 1000dps, the result should be:

    (1000 * pi ) / 180 >> 15 ~= 0.000532632218

But with current calculation we get

    $ cat scale
    0.000547890

Fix the calculation by just doing the maths involved for a nano value

   val * pi * 10e12 / (180 * 2^15)

so we get a closer result.

    $ cat scale
    0.000532632

Fixes: c14dca07a31d ("iio: cros_ec_sensors: add ChromeOS EC Contiguous Sensors driver")
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v2:
- Do the maths instead of play with dividers as pointed by Jonathan.

 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index 89cb0066a6e0..401b22e08d48 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -103,9 +103,10 @@ static int cros_ec_sensors_read(struct iio_dev *indio_dev,
 			 * Do not use IIO_DEGREE_TO_RAD to avoid precision
 			 * loss. Round to the nearest integer.
 			 */
-			*val = div_s64(val64 * 314159 + 9000000ULL, 1000);
-			*val2 = 18000 << (CROS_EC_SENSOR_BITS - 1);
-			ret = IIO_VAL_FRACTIONAL;
+			*val = 0;
+			*val2 = div_s64(val64 * 3141592653,
+					180 << (CROS_EC_SENSOR_BITS - 1));
+			ret = IIO_VAL_INT_PLUS_NANO;
 			break;
 		case MOTIONSENSE_TYPE_MAG:
 			/*
-- 
2.20.1

