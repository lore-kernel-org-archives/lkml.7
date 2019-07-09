Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9DFC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 10:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5F920844
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 10:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfGIKuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 06:50:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:28940 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbfGIKuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 06:50:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 03:50:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,470,1557212400"; 
   d="scan'208";a="316996020"
Received: from hu.sh.intel.com ([10.239.158.51])
  by orsmga004.jf.intel.com with ESMTP; 09 Jul 2019 03:50:02 -0700
From:   "Chen, Hu" <hu1.chen@intel.com>
To:     hdegoede@redhat.com
Cc:     hu1.chen@intel.com, m.balaji@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: roles: Add PM callbacks
Date:   Tue,  9 Jul 2019 18:30:25 +0800
Message-Id: <20190709103025.25761-1-hu1.chen@intel.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <8d304bb6-9849-ea77-3bd6-fe378de78ce7@redhat.com>
References: <8d304bb6-9849-ea77-3bd6-fe378de78ce7@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some Broxton NUC, the usb role is lost after S3 (it becomes "none").
Add PM callbacks to address this. In .suspend, save the role. In
.resume, restore usb role to saved one if it's lost.

Tests:
Run Android on UC6CAY, a NUC powered by Broxton. The usb port near to
the power button is switchable.
- as device. Access the NUC via "adb shell" from a host PC. Adb works
after S3 cycle.
- as host. Mouse works on that usb port after S3 cycle.

Without this fix, both of tests fails.

Signed-off-by: Chen, Hu <hu1.chen@intel.com>
Signed-off-by: Balaji <m.balaji@intel.com>
---
v2: The role maybe changed by ISR or firmware etc. between .suspend and
.resume (Hans).
 .../usb/roles/intel-xhci-usb-role-switch.c    | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/usb/roles/intel-xhci-usb-role-switch.c b/drivers/usb/roles/intel-xhci-usb-role-switch.c
index 277de96181f9..e830299c401e 100644
--- a/drivers/usb/roles/intel-xhci-usb-role-switch.c
+++ b/drivers/usb/roles/intel-xhci-usb-role-switch.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/usb/role.h>
+#include <linux/power_supply.h>
 
 /* register definition */
 #define DUAL_ROLE_CFG0			0x68
@@ -37,6 +38,7 @@
 struct intel_xhci_usb_data {
 	struct usb_role_switch *role_sw;
 	void __iomem *base;
+	enum usb_role role;
 };
 
 static int intel_xhci_usb_set_role(struct device *dev, enum usb_role role)
@@ -167,6 +169,29 @@ static int intel_xhci_usb_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int intel_xhci_usb_suspend(struct platform_device *pdev,
+				  pm_message_t state)
+{
+	struct intel_xhci_usb_data *data = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+
+	data->role = intel_xhci_usb_get_role(dev);
+
+	return 0;
+}
+
+static int intel_xhci_usb_resume(struct platform_device *pdev)
+{
+	struct intel_xhci_usb_data *data = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+
+	if (intel_xhci_usb_get_role(dev) == USB_ROLE_NONE &&
+	    power_supply_is_system_supplied())
+		intel_xhci_usb_set_role(dev, data->role);
+
+	return 0;
+}
+
 static const struct platform_device_id intel_xhci_usb_table[] = {
 	{ .name = DRV_NAME },
 	{}
@@ -180,6 +205,8 @@ static struct platform_driver intel_xhci_usb_driver = {
 	.id_table = intel_xhci_usb_table,
 	.probe = intel_xhci_usb_probe,
 	.remove = intel_xhci_usb_remove,
+	.suspend = intel_xhci_usb_suspend,
+	.resume = intel_xhci_usb_resume,
 };
 
 module_platform_driver(intel_xhci_usb_driver);
-- 
2.22.0

