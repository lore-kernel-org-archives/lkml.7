Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFDAC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F69921852
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561595809;
	bh=kI6ys9AICQLvmhzh38MKZn8xjDXYUZV2gWUfr5ffmTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CwzXCt3/L/how3wWy4QaQctjuXwRYUaZwy7SblARsOOv975jO+iBvv7/YDT9fhyK8
	 BcU5G9fE1yxnu07LP0m9nikpeCDR4MydZlIUkIT4PlPfC1qf4McvpIGJvjOnWrMwTQ
	 OiQ+aIkdgFFp7RbF+s0c6v9d3rmGK+GxdnkSVC6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbfF0Ags (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:36:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbfF0Agq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:36:46 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EED921851;
        Thu, 27 Jun 2019 00:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561595805;
        bh=kI6ys9AICQLvmhzh38MKZn8xjDXYUZV2gWUfr5ffmTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BpykYZiRu6UX7Szh2hzZVjedmWuPQ6dN87GKfmwXUyPQEf7qrDNMlqpE65yaRJgnz
         MTcZ47AomJ8+blzL47snjRa9L4q7h0jMtxmvrMga4XoRXDAi/CXB4XwsFlfW+nEgIS
         kle4E3jNCQG/3mnPYTCrLnHE/9GCW+F7DxdqC3kk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Melissa Wen <melissa.srw@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 4.19 09/60] staging:iio:ad7150: fix threshold mode config bit
Date:   Wed, 26 Jun 2019 20:35:24 -0400
Message-Id: <20190627003616.20767-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627003616.20767-1-sashal@kernel.org>
References: <20190627003616.20767-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Melissa Wen <melissa.srw@gmail.com>

[ Upstream commit df4d737ee4d7205aaa6275158aeebff87fd14488 ]

According to the AD7150 configuration register description, bit 7 assumes
value 1 when the threshold mode is fixed and 0 when it is adaptive,
however, the operation that identifies this mode was considering the
opposite values.

This patch renames the boolean variable to describe it correctly and
properly replaces it in the places where it is used.

Fixes: 531efd6aa0991 ("staging:iio:adc:ad7150: chan_spec conv + i2c_smbus commands + drop unused poweroff timeout control.")
Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/iio/cdc/ad7150.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index d16084d7068c..a354ce6b2b7b 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -6,6 +6,7 @@
  * Licensed under the GPL-2 or later.
  */
 
+#include <linux/bitfield.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
@@ -130,7 +131,7 @@ static int ad7150_read_event_config(struct iio_dev *indio_dev,
 {
 	int ret;
 	u8 threshtype;
-	bool adaptive;
+	bool thrfixed;
 	struct ad7150_chip_info *chip = iio_priv(indio_dev);
 
 	ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG);
@@ -138,21 +139,23 @@ static int ad7150_read_event_config(struct iio_dev *indio_dev,
 		return ret;
 
 	threshtype = (ret >> 5) & 0x03;
-	adaptive = !!(ret & 0x80);
+
+	/*check if threshold mode is fixed or adaptive*/
+	thrfixed = FIELD_GET(AD7150_CFG_FIX, ret);
 
 	switch (type) {
 	case IIO_EV_TYPE_MAG_ADAPTIVE:
 		if (dir == IIO_EV_DIR_RISING)
-			return adaptive && (threshtype == 0x1);
-		return adaptive && (threshtype == 0x0);
+			return !thrfixed && (threshtype == 0x1);
+		return !thrfixed && (threshtype == 0x0);
 	case IIO_EV_TYPE_THRESH_ADAPTIVE:
 		if (dir == IIO_EV_DIR_RISING)
-			return adaptive && (threshtype == 0x3);
-		return adaptive && (threshtype == 0x2);
+			return !thrfixed && (threshtype == 0x3);
+		return !thrfixed && (threshtype == 0x2);
 	case IIO_EV_TYPE_THRESH:
 		if (dir == IIO_EV_DIR_RISING)
-			return !adaptive && (threshtype == 0x1);
-		return !adaptive && (threshtype == 0x0);
+			return thrfixed && (threshtype == 0x1);
+		return thrfixed && (threshtype == 0x0);
 	default:
 		break;
 	}
-- 
2.20.1

