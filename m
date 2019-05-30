Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BC1C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 02:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9DA02444F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 02:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bNBXxBWX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfE3C4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 22:56:18 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:2423 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbfE3C4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 22:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559184975; x=1590720975;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q0hg2IWCcaHXAkM88ceASeZAnofrWOY4R4oYb9tjtt8=;
  b=bNBXxBWXxvWn+aQBGZxVA2WN7UnD4XE9bu5YzBqHK693aRNFBgpmJh08
   HGU/F5psfYM1EiRU3PMpxURbXlyCCv2dIGHdH+gGJ9Nty5RJQRpuUv3uL
   sfS2jyDuDZf1QVL42Iv3c+LcFEvAJQw4zDDwDUIzSo6LcWTo4KT0fU+QW
   8=;
X-IronPort-AV: E=Sophos;i="5.60,529,1549929600"; 
   d="scan'208";a="768210709"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 30 May 2019 02:56:11 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com (Postfix) with ESMTPS id 43735A2153;
        Thu, 30 May 2019 02:56:11 +0000 (UTC)
Received: from EX13D05UWB003.ant.amazon.com (10.43.161.26) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 30 May 2019 02:56:10 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D05UWB003.ant.amazon.com (10.43.161.26) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 30 May 2019 02:56:10 +0000
Received: from localhost (10.94.220.85) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 30 May 2019 02:56:10 +0000
From:   Eduardo Valentin <eduval@amazon.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Eduardo Valentin <eduval@amazon.com>,
        Jean Delvare <jdelvare@suse.com>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCHv2 1/2] hwmon: core: add thermal sensors only if dev->of_node is present
Date:   Wed, 29 May 2019 19:56:04 -0700
Message-ID: <20190530025605.3698-2-eduval@amazon.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530025605.3698-1-eduval@amazon.com>
References: <20190530025605.3698-1-eduval@amazon.com>
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
V1->V2: no change

 drivers/hwmon/hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index e694c46ff039..429784edd5ff 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -636,7 +636,7 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
 	if (err)
 		goto free_hwmon;
 
-	if (dev && chip && chip->ops->read &&
+	if (dev && dev->of_node && chip && chip->ops->read &&
 	    chip->info[0]->type == hwmon_chip &&
 	    (chip->info[0]->config[0] & HWMON_C_REGISTER_TZ)) {
 		const struct hwmon_channel_info **info = chip->info;
-- 
2.21.0

