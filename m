Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E238AC04E84
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 23:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B599E2166E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 23:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Amt6e+kH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbfEQXNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 19:13:45 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:28776 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfEQXNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 19:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1558134824; x=1589670824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QSZH7MhgQ8SSN2c5tgT5vfhoIO9KJ/7q3qvVPDIomGI=;
  b=Amt6e+kH6pK0zqLLpJ7EFizKb+Zn5fud+cWFcp9tlkRxzvxA3WYpf/XN
   aBBOrGgeJ3ahwkDIB5F8PEQ5m2mkPEX75tJOoP8ATcYLAlUWWKqjJBheN
   8SD4enVKsRNJsfuqNweQxxHsdE0prFHNITVkTuwjEZJgpis1/1Pv8qHqx
   o=;
X-IronPort-AV: E=Sophos;i="5.60,481,1549929600"; 
   d="scan'208";a="800301467"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 May 2019 23:13:41 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x4HNDXfM127436
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 17 May 2019 23:13:40 GMT
Received: from EX13D05UWB004.ant.amazon.com (10.43.161.208) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 17 May 2019 23:13:40 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D05UWB004.ant.amazon.com (10.43.161.208) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 17 May 2019 23:13:39 +0000
Received: from localhost (10.94.216.44) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 17 May 2019 23:13:39 +0000
From:   Eduardo Valentin <eduval@amazon.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Eduardo Valentin <eduval@amazon.com>,
        Jean Delvare <jdelvare@suse.com>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] hwmon: core: add thermal sensors only if dev->of_node is present
Date:   Fri, 17 May 2019 16:13:36 -0700
Message-ID: <20190517231337.27859-2-eduval@amazon.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190517231337.27859-1-eduval@amazon.com>
References: <20190517231337.27859-1-eduval@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers may register to hwmon and request for also registering
with the thermal subsystem (HWMON_C_REGISTER_TZ). However,
some of these driver, e.g. marvell phy, may be probed from
Device Tree or being dynamically allocated, and in the later
case, it will not have a dev->of_node entry.

Registering with hwmon without the dev->of_node may result in
different outcomes depending on the device tree, which may
be a bit misleading. If the device tree blob has no 'thermal-zones'
node, the *hwmon_device_register*() family functions are going
to gracefully succeed, because of-thermal,
*thermal_zone_of_sensor_register() return -ENODEV in this case,
and the hwmon error path handles this error code as success to
cover for the case where CONFIG_THERMAL_OF is not set.
However, if the device tree blob has the 'thermal-zones'
entry, the *hwmon_device_register*() will always fail on callers
with no dev->of_node, propagating -EINVAL.

If dev->of_node is not present, calling of-thermal does not
make sense. For this reason, this patch checks first if the
device has a of_node before going over the process of registering
with the thermal subsystem of-thermal interface. And in this case,
when a caller of *hwmon_device_register*() with HWMON_C_REGISTER_TZ
and no dev->of_node will still register with hwmon, but not with
the thermal subsystem. If all the hwmon part bits are in place,
the registration will succeed.

Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduval@amazon.com>
---
 drivers/hwmon/hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index fcdbac4a56e3..6b3559f58b67 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -619,7 +619,7 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
 	if (err)
 		goto free_hwmon;
 
-	if (dev && chip && chip->ops->read &&
+	if (dev && dev->of_node && chip && chip->ops->read &&
 	    chip->info[0]->type == hwmon_chip &&
 	    (chip->info[0]->config[0] & HWMON_C_REGISTER_TZ)) {
 		const struct hwmon_channel_info **info = chip->info;
-- 
2.21.0

