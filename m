Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6363AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2282220663
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="IKJTkM/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbfDPTBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:01:04 -0400
Received: from rcdn-iport-7.cisco.com ([173.37.86.78]:20701 "EHLO
        rcdn-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730252AbfDPTAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:00:49 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Apr 2019 15:00:48 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1592; q=dns/txt; s=iport;
  t=1555441249; x=1556650849;
  h=from:to:cc:subject:date:message-id;
  bh=6OTqq9UBO33rB5E+Ee8TkqfEVHZNhw4VoyHDIOgNse8=;
  b=IKJTkM/O8rL2T55WK7DXEf4ZC5T9biOKJ6YYXVL7n7sxWpRJfiTNijsN
   NI5gpHaf0D3oYvbz2kyZ6if12AkZId5ME2XLxCXpax2WmCtA8q1irhs1H
   tWpx83NZCFNuBd8IaPbOQyn2aOHL1q6e5Zvuj2kt3uX5c9l/1QnYStZt9
   A=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AfAQBrJLZc/4gNJK1mGwEBAQEDAQE?=
 =?us-ascii?q?BBwMBAQGBZYIRgTkzKJgMBop8kH0QhG2GCSM4EwEDAQEKAQIBAm0ohXhSKQe?=
 =?us-ascii?q?BDhODIoF1FKtNM4owFIEehnSEVhd4gQeEYYolA5F/gQuTLAmCCJINDBuUdi2?=
 =?us-ascii?q?INpdLgWYhgVYzGggbFYMnkGwfAzCQcgEB?=
X-IronPort-AV: E=Sophos;i="5.60,358,1549929600"; 
   d="scan'208";a="544300452"
Received: from alln-core-3.cisco.com ([173.36.13.136])
  by rcdn-iport-7.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 16 Apr 2019 18:53:32 +0000
Received: from tusi.cisco.com (tusi.cisco.com [172.24.98.27])
        by alln-core-3.cisco.com (8.15.2/8.15.2) with ESMTP id x3GIrUMo020521;
        Tue, 16 Apr 2019 18:53:31 GMT
From:   Ruslan Babayev <fib@cisco.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Ruslan Babayev <ruslan@babayev.com>, xe-linux-external@cisco.com,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] hwmon: (pmbus) mark registers READ_VIN and READ_IIN as paged
Date:   Tue, 16 Apr 2019 11:45:44 -0700
Message-Id: <20190416184547.40128-2-fib@cisco.com>
X-Mailer: git-send-email 2.17.1
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 172.24.98.27, tusi.cisco.com
X-Outbound-Node: alln-core-3.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ruslan Babayev <ruslan@babayev.com>

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

