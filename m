Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57357C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24AF3206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbfDPSvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:51:15 -0400
Received: from rcdn-iport-3.cisco.com ([173.37.86.74]:49211 "EHLO
        rcdn-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPSvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:51:13 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BiBAAKIrZc/51dJa1mHQEBBQEHBQG?=
 =?us-ascii?q?BZYIRgTkzKLQLEIRthgkjOBMBAwEBCgECAQJtKIV4UimBFRODIoIJq1YzijA?=
 =?us-ascii?q?UgR6GdIRWF4F/hGGKJQORf4ELkywJgghTkTona5QLLYg2l0uBZiGBVjMaCBs?=
 =?us-ascii?q?VgyeQbB8DMJByAQE?=
X-IronPort-AV: E=Sophos;i="5.60,358,1549929600"; 
   d="scan'208";a="537122893"
Received: from rcdn-core-6.cisco.com ([173.37.93.157])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 16 Apr 2019 18:44:04 +0000
Received: from tusi.cisco.com (tusi.cisco.com [172.24.98.27])
        by rcdn-core-6.cisco.com (8.15.2/8.15.2) with ESMTP id x3GIi30X026006;
        Tue, 16 Apr 2019 18:44:04 GMT
From:   Ruslan Babayev <ruslan@babayev.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     xe-linux-external@cisco.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] hwmon: (pmbus) mark registers READ_VIN and READ_IIN as paged
Date:   Tue, 16 Apr 2019 11:36:17 -0700
Message-Id: <20190416183620.39950-2-ruslan@babayev.com>
X-Mailer: git-send-email 2.17.1
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 172.24.98.27, tusi.cisco.com
X-Outbound-Node: rcdn-core-6.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some devices (like IR35215) READ_VIN and READ_IIN registers are
paged.

For devices where these registers are not paged the extra check
ensures we expose only the registers that are actually present.

Cc: xe-linux-external@cisco.com
Signed-off-by: Ruslan Babayev <ruslan@babayev.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index f35b239961e3..fac966967816 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1379,6 +1379,9 @@ static int pmbus_add_sensor_attrs(struct i2c_client *client,
 		for (page = 0; page < pages; page++) {
 			if (!(info->func[page] & attrs->func))
 				continue;
+			if (!pmbus_check_word_register(client, page,
+						       attrs->reg))
+				continue;
 			ret = pmbus_add_sensor_attrs_one(client, data, info,
 							 name, index, page,
 							 attrs);
@@ -1498,6 +1501,7 @@ static const struct pmbus_sensor_attr voltage_attributes[] = {
 		.reg = PMBUS_READ_VIN,
 		.class = PSC_VOLTAGE_IN,
 		.label = "vin",
+		.paged = true,
 		.func = PMBUS_HAVE_VIN,
 		.sfunc = PMBUS_HAVE_STATUS_INPUT,
 		.sbase = PB_STATUS_INPUT_BASE,
@@ -1602,6 +1606,7 @@ static const struct pmbus_sensor_attr current_attributes[] = {
 		.reg = PMBUS_READ_IIN,
 		.class = PSC_CURRENT_IN,
 		.label = "iin",
+		.paged = true,
 		.func = PMBUS_HAVE_IIN,
 		.sfunc = PMBUS_HAVE_STATUS_INPUT,
 		.sbase = PB_STATUS_INPUT_BASE,
-- 
2.17.1

