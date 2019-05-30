Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F40C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 02:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60AE72444F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 02:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MjLytlaq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfE3C4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 22:56:15 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:23435 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfE3C4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 22:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559184973; x=1590720973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qDsL18aDwQTcILov+CgblUA1JhXa5nFHLDzuuC/mnGA=;
  b=MjLytlaqESDRNy/PcQzbkUWUbn1LeIPx37VN2HYgfvsUNA4kaTLVjS6k
   3UYNZf/8DF9ygNvwE2RwZ8JJER9ilvdRD8nff3HsvQlRAvQ5bUzcpRasB
   wYye1qZduNZB+tks77k312dUt+xEiazQ52FJF1K8rzZWK1JOXcSDYO9kh
   4=;
X-IronPort-AV: E=Sophos;i="5.60,529,1549929600"; 
   d="scan'208";a="807528124"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-3714e498.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 30 May 2019 02:56:12 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-3714e498.us-west-2.amazon.com (Postfix) with ESMTPS id 2C6DDA25B0;
        Thu, 30 May 2019 02:56:11 +0000 (UTC)
Received: from EX13D05UWB004.ant.amazon.com (10.43.161.208) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 30 May 2019 02:56:11 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D05UWB004.ant.amazon.com (10.43.161.208) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 30 May 2019 02:56:10 +0000
Received: from localhost (10.94.220.85) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 30 May 2019 02:56:11 +0000
From:   Eduardo Valentin <eduval@amazon.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Eduardo Valentin <eduval@amazon.com>,
        Jean Delvare <jdelvare@suse.com>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCHv2 2/2] hwmon: core: fix potential memory leak in *hwmon_device_register*
Date:   Wed, 29 May 2019 19:56:05 -0700
Message-ID: <20190530025605.3698-3-eduval@amazon.com>
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

When registering a hwmon device with HWMON_C_REGISTER_TZ flag
in place, the hwmon subsystem will attempt to register the device
also with the thermal subsystem. When the of-thermal registration
fails, __hwmon_device_register jumps to ida_remove, leaving
the locally allocated hwdev pointer.

This patch fixes the leak by jumping to a new label that
will first unregister hdev and then fall into the kfree of hwdev
to finally remove the idas and propagate the error code.

Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduval@amazon.com>
---
V1->V2: removed the device_unregister() before jumping
into the new label, as suggested in the first review round.

 drivers/hwmon/hwmon.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 429784edd5ff..620f05fc412a 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -652,10 +652,8 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
 				if (info[i]->config[j] & HWMON_T_INPUT) {
 					err = hwmon_thermal_add_sensor(dev,
 								hwdev, j);
-					if (err) {
-						device_unregister(hdev);
-						goto ida_remove;
-					}
+					if (err)
+						goto device_unregister;
 				}
 			}
 		}
@@ -663,6 +661,8 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
 
 	return hdev;
 
+device_unregister:
+	device_unregister(hdev);
 free_hwmon:
 	kfree(hwdev);
 ida_remove:
-- 
2.21.0

