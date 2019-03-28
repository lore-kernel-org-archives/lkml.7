Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BDBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D060B2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfC1Kw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:52:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:53260 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfC1Kw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:52:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 03:52:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="311114446"
Received: from hu.sh.intel.com ([10.239.158.51])
  by orsmga005.jf.intel.com with ESMTP; 28 Mar 2019 03:52:54 -0700
From:   "Chen, Hu" <hu1.chen@intel.com>
Cc:     hdegoede@redhat.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ACPI / PM: Propagate KEY_POWER to user space when resume
Date:   Thu, 28 Mar 2019 18:34:48 +0800
Message-Id: <20190328103448.20335-1-hu1.chen@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAJZ5v0g3+S0vkW0XTzMKA8rYCtgy7yJ+UDc5xG4rRcdTbcJ=Lg@mail.gmail.com>
References: <CAJZ5v0g3+S0vkW0XTzMKA8rYCtgy7yJ+UDc5xG4rRcdTbcJ=Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I run Android on x86 PC (it's a NUC). Everytime I press the power button
to wake the system, it suspends right away. After some debug, I find
that Android wants to see KEY_POWER at resume. Otherwise, its
opportunistic suspend will kick in shortly.

However, other OS such as Ubuntu doesn't like KEY_POWER at resume. So
add a knob "/sys/module/button/parameters/key_power_at_resume" for users
to select.

Signed-off-by: Chen, Hu <hu1.chen@intel.com>
---

 drivers/acpi/button.c | 6 +++++-
 drivers/acpi/sleep.c  | 8 ++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index a19ff3977ac4..f98e6d85dd2b 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -129,6 +129,10 @@ struct acpi_button {
 	bool suspended;
 };
 
+/* does userspace want to see KEY_POWER at resume? */
+static bool key_power_at_resume __read_mostly;
+module_param(key_power_at_resume, bool, 0644);
+
 static BLOCKING_NOTIFIER_HEAD(acpi_lid_notifier);
 static struct acpi_device *lid_device;
 static u8 lid_init_state = ACPI_BUTTON_LID_INIT_METHOD;
@@ -417,7 +421,7 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
 			int keycode;
 
 			acpi_pm_wakeup_event(&device->dev);
-			if (button->suspended)
+			if (button->suspended && !key_power_at_resume)
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

