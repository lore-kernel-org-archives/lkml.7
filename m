Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D3CC04E87
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 23:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 374132166E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 23:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Lb04dCqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbfEQXNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 19:13:46 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:36207 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbfEQXNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 19:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1558134825; x=1589670825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YzwMlzH7xToQwqdmfuxN3FjSxsAuK3aol4/PCCQcBXk=;
  b=Lb04dCqIPQ2XCIFL103wRVliTHFoFhqm2MG8zcdrDdkxfdEt3zP5+pGG
   lM7VMmVUC15ltWjeQxbpl5wxDzoujTa9LTGrqNqAkPZPJQA+wSokNED7f
   qJTXf6Wo+HSsfPFv23k62SWOIJMDDaELCe9qV/L/riarlL7G01O3XPrfS
   c=;
X-IronPort-AV: E=Sophos;i="5.60,481,1549929600"; 
   d="scan'208";a="805299185"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 May 2019 23:13:42 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x4HNDWrr055781
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 17 May 2019 23:13:41 GMT
Received: from EX13D05UWB001.ant.amazon.com (10.43.161.181) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 17 May 2019 23:13:40 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D05UWB001.ant.amazon.com (10.43.161.181) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 17 May 2019 23:13:40 +0000
Received: from localhost (10.94.216.44) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 17 May 2019 23:13:40 +0000
From:   Eduardo Valentin <eduval@amazon.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Eduardo Valentin <eduval@amazon.com>,
        Jean Delvare <jdelvare@suse.com>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] hwmon: core: fix potential memory leak in *hwmon_device_register*
Date:   Fri, 17 May 2019 16:13:37 -0700
Message-ID: <20190517231337.27859-3-eduval@amazon.com>
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

When registering a hwmon device with HWMON_C_REGISTER_TZ flag
in place, the hwmon subsystem will attempt to register the device
also with the thermal subsystem. When the of-thermal registration
fails, __hwmon_device_register jumps to ida_remove, leaving
the locally allocated hwdev pointer and also the hdev registered.

This patch fixes both issues by jumping to a new label that
will first unregister hdev and the fall into the kfree of hwdev
to finally remove the idas and propagate the error code.

Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduval@amazon.com>
---
 drivers/hwmon/hwmon.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 6b3559f58b67..6f1194952189 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -637,7 +637,7 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
 								hwdev, j);
 					if (err) {
 						device_unregister(hdev);
-						goto ida_remove;
+						goto device_unregister;
 					}
 				}
 			}
@@ -646,6 +646,8 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
 
 	return hdev;
 
+device_unregister:
+	device_unregister(hdev);
 free_hwmon:
 	kfree(hwdev);
 ida_remove:
-- 
2.21.0

