Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E79C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13EDF2253D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733244AbfGWUeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 16:34:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:63973 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729564AbfGWUeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 16:34:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2019 13:34:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,300,1559545200"; 
   d="scan'208";a="253344182"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 23 Jul 2019 13:34:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DE45E81; Tue, 23 Jul 2019 23:34:12 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chun-Yi Lee <jlee@suse.com>
Subject: [PATCH v1] platform/x86: acer-wmi: Switch to acpi_dev_get_first_match_dev()
Date:   Tue, 23 Jul 2019 23:34:11 +0300
Message-Id: <20190723203411.71448-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The acpi_dev_get_first_match_dev() helper will find and return
an ACPI device pointer of the first registered device in the system
by its HID.

Use it instead of open coded variant.

Cc: Chun-Yi Lee <jlee@suse.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
- Chun-Yi, please, test it if possible
 drivers/platform/x86/acer-wmi.c | 49 +++++----------------------------
 1 file changed, 7 insertions(+), 42 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 62b54e137231..60c18f21588d 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1881,52 +1881,17 @@ static int __init acer_wmi_enable_rf_button(void)
 	return status;
 }
 
-#define ACER_WMID_ACCEL_HID	"BST0001"
-
-static acpi_status __init acer_wmi_get_handle_cb(acpi_handle ah, u32 level,
-						void *ctx, void **retval)
-{
-	struct acpi_device *dev;
-
-	if (!strcmp(ctx, "SENR")) {
-		if (acpi_bus_get_device(ah, &dev))
-			return AE_OK;
-		if (strcmp(ACER_WMID_ACCEL_HID, acpi_device_hid(dev)))
-			return AE_OK;
-	} else
-		return AE_OK;
-
-	*(acpi_handle *)retval = ah;
-
-	return AE_CTRL_TERMINATE;
-}
-
-static int __init acer_wmi_get_handle(const char *name, const char *prop,
-					acpi_handle *ah)
-{
-	acpi_status status;
-	acpi_handle handle;
-
-	BUG_ON(!name || !ah);
-
-	handle = NULL;
-	status = acpi_get_devices(prop, acer_wmi_get_handle_cb,
-					(void *)name, &handle);
-	if (ACPI_SUCCESS(status) && handle) {
-		*ah = handle;
-		return 0;
-	} else {
-		return -ENODEV;
-	}
-}
-
 static int __init acer_wmi_accel_setup(void)
 {
+	struct acpi_device *adev;
 	int err;
 
-	err = acer_wmi_get_handle("SENR", ACER_WMID_ACCEL_HID, &gsensor_handle);
-	if (err)
-		return err;
+	adev = acpi_dev_get_first_match_dev("BST0001", NULL, -1);
+	if (!adev)
+		return -ENODEV;
+
+	gsensor_handle = acpi_device_handle(adev);
+	acpi_dev_put(adev);
 
 	interface->capability |= ACER_CAP_ACCEL;
 
-- 
2.20.1

