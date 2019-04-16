Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703C5C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407DB2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Z9zHZVtZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbfDPTAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:00:44 -0400
Received: from alln-iport-6.cisco.com ([173.37.142.93]:38066 "EHLO
        alln-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfDPTAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:00:44 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Apr 2019 15:00:43 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3075; q=dns/txt; s=iport;
  t=1555441243; x=1556650843;
  h=from:to:cc:subject:date:message-id;
  bh=+ziyYOrGFOxYwYIkbsuRKrlf1AgxIqu6pCnnwpnCIyQ=;
  b=Z9zHZVtZ05bQC7PCNK+Kay2At09DBy0pubxGSFSOLiVMbzcoCMODxCAo
   QjLg4E4k0Bq7w4/VDx0NRJkjGqjmpNevCoVLkrwu80EGboe43G1XFlW/f
   VYfz/I34a0NsiMNRPv7p1ue/PzbcbWVeVmytX4vWWBQVqrQyC63wFFOKG
   o=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BEAABrJLZc/4gNJK1mGwEBAQEDAQE?=
 =?us-ascii?q?BBwMBAQGBVAMBAQELAYIQgTkzKJgMBop8kH0QhG2GCSM3Bg4BAwEBCgECAQJ?=
 =?us-ascii?q?tKIZKKQeBDhODIoF1FKwAijAUgR4BhnOEVhd4gQeEYYQ5hWwDkwqTLAmCCJI?=
 =?us-ascii?q?NDBuCCIoBiG2gLoFlIoFWMxoIGxWDJ5BsHwMwkHIBAQ?=
X-IronPort-AV: E=Sophos;i="5.60,358,1549929600"; 
   d="scan'208";a="262846191"
Received: from alln-core-3.cisco.com ([173.36.13.136])
  by alln-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 16 Apr 2019 18:53:35 +0000
Received: from tusi.cisco.com (tusi.cisco.com [172.24.98.27])
        by alln-core-3.cisco.com (8.15.2/8.15.2) with ESMTP id x3GIrUMq020521;
        Tue, 16 Apr 2019 18:53:34 GMT
From:   Ruslan Babayev <fib@cisco.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Ruslan Babayev <ruslan@babayev.com>, xe-linux-external@cisco.com,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] hwmon: (pmbus/tps40422) add support for output voltage margining
Date:   Tue, 16 Apr 2019 11:45:46 -0700
Message-Id: <20190416184547.40128-4-fib@cisco.com>
X-Mailer: git-send-email 2.17.1
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 172.24.98.27, tusi.cisco.com
X-Outbound-Node: alln-core-3.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ruslan Babayev <ruslan@babayev.com>

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

