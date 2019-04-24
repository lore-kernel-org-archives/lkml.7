Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941DCC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62F6621773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556128147;
	bh=OJXbiAaP8LNk4kZ5L590osmCuArlqPwop/o6L+rHJi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VB6PA1adEaGo67vON/HRGJ4pjZta/PX2jR6MgOu3vrmV9/+V3R7iJBbasdIMY80UJ
	 h8x0aSqSYKjykAth3QVGSNiYyZ/CLNpxHojYSFNeNWEy8Ay2+lOLFzWe2L6KM9QHKS
	 9xkYWamFvhLkTU6aTVVgD/KZlYGQkzS0nga5Xf1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391894AbfDXRtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:49:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390438AbfDXRam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:30:42 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 000D32054F;
        Wed, 24 Apr 2019 17:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127041;
        bh=OJXbiAaP8LNk4kZ5L590osmCuArlqPwop/o6L+rHJi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kc3q+XPk85P53RnQix6RiyUyh8siMUigaHlcgBGvNJtt7XR3+oxP2QcobDAWL4PFH
         nl/BRcsLKcffqJJq2GU8zpxReglfwr3Ej610j8ry63atmfKh6ELLtSj/qqadNC66uW
         Zw69I29lQTtSPPyBBAMwXJ37d1lpQ3cgDbGvQUBs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Looijmans <mike.looijmans@topic.nl>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.19 38/96] iio:chemical:bme680: Fix, report temperature in millidegrees
Date:   Wed, 24 Apr 2019 19:09:43 +0200
Message-Id: <20190424170922.469746830@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Looijmans <mike.looijmans@topic.nl>

commit 9436f45dd53595e21566a8c6627411077dfdb776 upstream.

The standard unit for temperature is millidegrees Celcius. Adapt the
driver to report in millidegrees instead of degrees.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
Fixes: 1b3bd8592780 ("iio: chemical: Add support for Bosch BME680 sensor");
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/chemical/bme680_core.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -591,8 +591,7 @@ static int bme680_gas_config(struct bme6
 	return ret;
 }
 
-static int bme680_read_temp(struct bme680_data *data,
-			    int *val, int *val2)
+static int bme680_read_temp(struct bme680_data *data, int *val)
 {
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
@@ -625,10 +624,9 @@ static int bme680_read_temp(struct bme68
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
@@ -643,7 +641,7 @@ static int bme680_read_press(struct bme6
 	s32 adc_press;
 
 	/* Read and compensate temperature to get a reading of t_fine */
-	ret = bme680_read_temp(data, NULL, NULL);
+	ret = bme680_read_temp(data, NULL);
 	if (ret < 0)
 		return ret;
 
@@ -676,7 +674,7 @@ static int bme680_read_humid(struct bme6
 	u32 comp_humidity;
 
 	/* Read and compensate temperature to get a reading of t_fine */
-	ret = bme680_read_temp(data, NULL, NULL);
+	ret = bme680_read_temp(data, NULL);
 	if (ret < 0)
 		return ret;
 
@@ -769,7 +767,7 @@ static int bme680_read_raw(struct iio_de
 	case IIO_CHAN_INFO_PROCESSED:
 		switch (chan->type) {
 		case IIO_TEMP:
-			return bme680_read_temp(data, val, val2);
+			return bme680_read_temp(data, val);
 		case IIO_PRESSURE:
 			return bme680_read_press(data, val, val2);
 		case IIO_HUMIDITYRELATIVE:


