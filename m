Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9392C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951D92075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbfDPSvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:51:17 -0400
Received: from rcdn-iport-7.cisco.com ([173.37.86.78]:17352 "EHLO
        rcdn-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPSvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:51:15 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BhBAAKIrZc/51dJa1mHQEBBQEHBQG?=
 =?us-ascii?q?BZYIRgTkzKLQLEIRthgkjOBMBAwEBCgECAQJtKIZKKYEVE4MiggmsCYowFIE?=
 =?us-ascii?q?ehnSEVheBf4RhhDmFbAOTCpMsCYIIU5E6J2uBHYoBiG2gLoFmIYFWMxoIGxW?=
 =?us-ascii?q?DJ5BsHwMwkHIBAQ?=
X-IronPort-AV: E=Sophos;i="5.60,358,1549929600"; 
   d="scan'208";a="544297874"
Received: from rcdn-core-6.cisco.com ([173.37.93.157])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 16 Apr 2019 18:44:07 +0000
Received: from tusi.cisco.com (tusi.cisco.com [172.24.98.27])
        by rcdn-core-6.cisco.com (8.15.2/8.15.2) with ESMTP id x3GIi30Z026006;
        Tue, 16 Apr 2019 18:44:07 GMT
From:   Ruslan Babayev <ruslan@babayev.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     xe-linux-external@cisco.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] hwmon: (pmbus/tps40422) add support for output voltage margining
Date:   Tue, 16 Apr 2019 11:36:19 -0700
Message-Id: <20190416183620.39950-4-ruslan@babayev.com>
X-Mailer: git-send-email 2.17.1
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 172.24.98.27, tusi.cisco.com
X-Outbound-Node: rcdn-core-6.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TPS40422 has MFR_SPECIFIC registers STEP_VREF_MARGIN_HIGH and
STEP_VREF_MARGIN_LOW, which are signed 16-bit in units of 2mV. This
value is an offset from the nominal reference voltage of 600mV.

For instance, the default value of STEP_VREF_MARGIN_LOW is -30
(decimal), which corresponds to a default margin low voltage of
600 - 30 * 2 = 540mV.

Introduce tps40422_{read/write}_word_data() callbacks to map the
MFR_SPECIFIC registers to standard PMBUS_VOUT_MARGIN_HIGH and
PMBUS_VOUT_MARGIN_LOW. For the latter, pmbus_core stores sensor data
in linear16 format as specified in VOUT_MODE.  Note, that on TPS40422
the exponent is fixed at (-9). The callbacks will perform the
necessary conversions.

Cc: xe-linux-external@cisco.com
Signed-off-by: Ruslan Babayev <ruslan@babayev.com>
---
 drivers/hwmon/pmbus/tps40422.c | 54 ++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/hwmon/pmbus/tps40422.c b/drivers/hwmon/pmbus/tps40422.c
index 32803825d47e..129d1b0e6b43 100644
--- a/drivers/hwmon/pmbus/tps40422.c
+++ b/drivers/hwmon/pmbus/tps40422.c
@@ -21,16 +21,70 @@
 #include <linux/i2c.h>
 #include "pmbus.h"
 
+#define TPS40422_STEP_VREF_MARGIN_HIGH	0xd5
+#define TPS40422_STEP_VREF_MARGIN_LOW	0xd6
+#define TPS40422_VREF			600
+
+static int tps40422_read_word_data(struct i2c_client *client, int page, int reg)
+{
+	int ret;
+
+	switch (reg) {
+	case PMBUS_VOUT_MARGIN_HIGH:
+		reg = TPS40422_STEP_VREF_MARGIN_HIGH;
+		break;
+	case PMBUS_VOUT_MARGIN_LOW:
+		reg = TPS40422_STEP_VREF_MARGIN_LOW;
+		break;
+	default:
+		return -ENODATA;
+	}
+
+	ret = pmbus_read_word_data(client, page, reg);
+	if (ret < 0)
+		return ret;
+
+	ret = (TPS40422_VREF + ((s16)ret) * 2) << 9;
+	ret = DIV_ROUND_CLOSEST(ret, 1000);
+
+	return ret;
+}
+
+static int tps40422_write_word_data(struct i2c_client *client, int page,
+				    int reg, u16 word)
+{
+	u16 val;
+
+	switch (reg) {
+	case PMBUS_VOUT_MARGIN_HIGH:
+		reg = TPS40422_STEP_VREF_MARGIN_HIGH;
+		break;
+	case PMBUS_VOUT_MARGIN_LOW:
+		reg = TPS40422_STEP_VREF_MARGIN_LOW;
+		break;
+	default:
+		return -ENODATA;
+	}
+
+	val = ((((long)word * 1000) >> 9) - TPS40422_VREF + 1) / 2;
+	return pmbus_write_word_data(client, page, reg, val);
+}
+
+
 static struct pmbus_driver_info tps40422_info = {
 	.pages = 2,
+	.read_word_data = tps40422_read_word_data,
+	.write_word_data = tps40422_write_word_data,
 	.format[PSC_VOLTAGE_IN] = linear,
 	.format[PSC_VOLTAGE_OUT] = linear,
 	.format[PSC_TEMPERATURE] = linear,
 	.func[0] = PMBUS_HAVE_VOUT | PMBUS_HAVE_TEMP2
 		| PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_TEMP
+		| PMBUS_HAVE_VOUT_MARGIN_HIGH | PMBUS_HAVE_VOUT_MARGIN_LOW
 		| PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
 	.func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_TEMP2
 		| PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_TEMP
+		| PMBUS_HAVE_VOUT_MARGIN_HIGH | PMBUS_HAVE_VOUT_MARGIN_LOW
 		| PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
 };
 
-- 
2.17.1

