Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F4EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 03:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A51620835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 03:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfCDDS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 22:18:27 -0500
Received: from mga09.intel.com ([134.134.136.24]:10356 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfCDDS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 22:18:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2019 19:18:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,438,1544515200"; 
   d="scan'208";a="279475356"
Received: from hu.sh.intel.com ([10.239.158.51])
  by orsmga004.jf.intel.com with ESMTP; 03 Mar 2019 19:18:23 -0800
From:   "Chen, Hu" <hu1.chen@intel.com>
Cc:     hu1.chen@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI / PM: Propagate KEY_POWER wakeup events to user space
Date:   Mon,  4 Mar 2019 11:00:21 +0800
Message-Id: <20190304030022.22492-1-hu1.chen@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the system is woken from S3 by the ACPI fixed power button, send
KEY_POWER to user space.

I run Android on x86 PC (it's a NUC). Everytime I press the power button
to wake the system, it suspends right away. After some debug, I find
that Android wants to see KEY_POWER at resume. Otherwise, its
opportunistic suspend will kick in shortly.

Signed-off-by: Chen, Hu <hu1.chen@intel.com>
---
 drivers/acpi/button.c | 4 +++-
 drivers/acpi/sleep.c  | 8 ++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index a19ff3977ac4..117718057938 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -33,6 +33,7 @@
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 #include <acpi/button.h>
+#include <linux/suspend.h>
 
 #define PREFIX "ACPI: "
 
@@ -417,7 +418,8 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
 			int keycode;
 
 			acpi_pm_wakeup_event(&device->dev);
-			if (button->suspended)
+			if (button->suspended &&
+			    mem_sleep_current == PM_SUSPEND_TO_IDLE)
 				break;
 
 			keycode = test_bit(KEY_SLEEP, input->keybit) ?
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 403c4ff15349..c5dcee9f5872 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -462,6 +462,13 @@ static int find_powerf_dev(struct device *dev, void *data)
 	return !strcmp(hid, ACPI_BUTTON_HID_POWERF);
 }
 
+static void pwr_btn_notify(struct device *dev)
+{
+	struct acpi_device *device = to_acpi_device(dev);
+
+	device->driver->ops.notify(device, ACPI_FIXED_HARDWARE_EVENT);
+}
+
 /**
  *	acpi_pm_finish - Instruct the platform to leave a sleep state.
  *
@@ -505,6 +512,7 @@ static void acpi_pm_finish(void)
 				      find_powerf_dev);
 	if (pwr_btn_dev) {
 		pm_wakeup_event(pwr_btn_dev, 0);
+		pwr_btn_notify(pwr_btn_dev);
 		put_device(pwr_btn_dev);
 	}
 }
-- 
2.20.1

