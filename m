Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E781C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B10E206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 07:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbfCFHb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 02:31:57 -0500
Received: from jax4mhob24.registeredsite.com ([64.69.218.112]:50768 "EHLO
        jax4mhob24.registeredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728438AbfCFHb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 02:31:56 -0500
Received: from mailpod.hostingplatform.com ([10.30.71.203])
        by jax4mhob24.registeredsite.com (8.14.4/8.14.4) with ESMTP id x267Vrkn133180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Wed, 6 Mar 2019 02:31:54 -0500
Received: (qmail 3948 invoked by uid 0); 6 Mar 2019 07:31:53 -0000
X-TCPREMOTEIP: 81.173.50.109
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO mikebuntu.TOPIC.LOCAL) (mike@milosoftware.com@81.173.50.109)
  by 0 with ESMTPA; 6 Mar 2019 07:31:53 -0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     linux-iio@vger.kernel.org, himanshujha199640@gmail.com
Cc:     linux-kernel@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, dpfrey@gmail.com,
        colin.king@canonical.com, Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH v3 1/2] iio/chemical/bme680: Report temperature in millidegrees
Date:   Wed,  6 Mar 2019 08:31:47 +0100
Message-Id: <1551857508-4254-1-git-send-email-mike.looijmans@topic.nl>
X-Mailer: git-send-email 1.9.1
References: <1550238475-25698-1-git-send-email-mike.looijmans@topic.nl>
In-Reply-To: <1550238475-25698-1-git-send-email-mike.looijmans@topic.nl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The standard unit for temperature is millidegrees Celcius. Adapt the
driver to report in millidegrees instead of degrees.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
v2: Remove unused 'addr7' variable                                                       
v3: Split patch into temperature and SPI

 drivers/iio/chemical/bme680_core.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 70c1fe4..fefe32b 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -583,8 +583,7 @@ static int bme680_gas_config(struct bme680_data *data)
 	return ret;
 }
 
-static int bme680_read_temp(struct bme680_data *data,
-			    int *val, int *val2)
+static int bme680_read_temp(struct bme680_data *data, int *val)
 {
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
@@ -617,10 +616,9 @@ static int bme680_read_temp(struct bme680_data *data,
 	 * compensate_press/compensate_humid to get compensated
 	 * pressure/humidity readings.
 	 */
-	if (val && val2) {
-		*val = comp_temp;
-		*val2 = 100;
-		return IIO_VAL_FRACTIONAL;
+	if (val) {
+		*val = comp_temp * 10; /* Centidegrees to millidegrees */
+		return IIO_VAL_INT;
 	}
 
 	return ret;
@@ -635,7 +633,7 @@ static int bme680_read_press(struct bme680_data *data,
 	s32 adc_press;
 
 	/* Read and compensate temperature to get a reading of t_fine */
-	ret = bme680_read_temp(data, NULL, NULL);
+	ret = bme680_read_temp(data, NULL);
 	if (ret < 0)
 		return ret;
 
@@ -668,7 +666,7 @@ static int bme680_read_humid(struct bme680_data *data,
 	u32 comp_humidity;
 
 	/* Read and compensate temperature to get a reading of t_fine */
-	ret = bme680_read_temp(data, NULL, NULL);
+	ret = bme680_read_temp(data, NULL);
 	if (ret < 0)
 		return ret;
 
@@ -761,7 +759,7 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_PROCESSED:
 		switch (chan->type) {
 		case IIO_TEMP:
-			return bme680_read_temp(data, val, val2);
+			return bme680_read_temp(data, val);
 		case IIO_PRESSURE:
 			return bme680_read_press(data, val, val2);
 		case IIO_HUMIDITYRELATIVE:
-- 
1.9.1

