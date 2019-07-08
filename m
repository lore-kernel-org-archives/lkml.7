Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC62DC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 02:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D08820659
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 02:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfGHCov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 22:44:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:3515 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfGHCov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 22:44:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jul 2019 19:44:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,465,1557212400"; 
   d="scan'208";a="340322921"
Received: from hu.sh.intel.com ([10.239.158.51])
  by orsmga005.jf.intel.com with ESMTP; 07 Jul 2019 19:44:49 -0700
From:   "Chen, Hu" <hu1.chen@intel.com>
To:     hdegoede@redhat.com
Cc:     hu1.chen@intel.com, Balaji <m.balaji@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: roles: Add PM callbacks
Date:   Mon,  8 Jul 2019 10:25:14 +0800
Message-Id: <20190708022514.7161-1-hu1.chen@intel.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some Broxton NUC, the usb role is lost after S3 (it becomes "none").
Add PM callbacks to address this issue: save the role during suspend and
restore usb to that role during resume.

Test:
Run Android on UC6CAY, a NUC powered by Broxton. Access this NUC via
"adb shell" from a host PC. After a suspend/resume cycle, the adb still
works well.

Signed-off-by: Chen, Hu <hu1.chen@intel.com>
Signed-off-by: Balaji <m.balaji@intel.com>

diff --git a/drivers/usb/roles/intel-xhci-usb-role-switch.c b/drivers/usb/roles/intel-xhci-usb-role-switch.c
index 277de96181f9..caa1cfab41cc 100644
--- a/drivers/usb/roles/intel-xhci-usb-role-switch.c
+++ b/drivers/usb/roles/intel-xhci-usb-role-switch.c
@@ -37,6 +37,7 @@
 struct intel_xhci_usb_data {
 	struct usb_role_switch *role_sw;
 	void __iomem *base;
+	enum usb_role role;
 };
 
 static int intel_xhci_usb_set_role(struct device *dev, enum usb_role role)
@@ -167,6 +168,30 @@ static int intel_xhci_usb_remove(struct platform_device *pdev)
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
+	if (intel_xhci_usb_get_role(dev) != data->role) {
+		if (intel_xhci_usb_set_role(dev, data->role) != 0)
+			dev_warn(dev, "Failed to set role during resume\n");
+	}
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

