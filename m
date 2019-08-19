Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A793FC3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819302147A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfHSKHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 06:07:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:8477 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbfHSKHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:07:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 03:07:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; 
   d="scan'208";a="195506070"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Aug 2019 03:07:29 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] usb: roles: intel_xhci: Supplying software node for the role mux
Date:   Mon, 19 Aug 2019 13:07:23 +0300
Message-Id: <20190819100724.30051-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190819100724.30051-1-heikki.krogerus@linux.intel.com>
References: <20190819100724.30051-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The primary purpose for this node will be to allow linking
the users of the switch to it. The users will be for example
USB Type-C connectors. By supplying a reference to this
node in the software nodes representing the USB Type-C
controllers or connectors, the drivers for those devices can
access the switch.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 .../usb/roles/intel-xhci-usb-role-switch.c    | 27 ++++++++++++++-----
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/roles/intel-xhci-usb-role-switch.c b/drivers/usb/roles/intel-xhci-usb-role-switch.c
index 277de96181f9..7325a84dd1c8 100644
--- a/drivers/usb/roles/intel-xhci-usb-role-switch.c
+++ b/drivers/usb/roles/intel-xhci-usb-role-switch.c
@@ -39,6 +39,10 @@ struct intel_xhci_usb_data {
 	void __iomem *base;
 };
 
+static const struct software_node intel_xhci_usb_node = {
+	"intel-xhci-usb-sw",
+};
+
 static int intel_xhci_usb_set_role(struct device *dev, enum usb_role role)
 {
 	struct intel_xhci_usb_data *data = dev_get_drvdata(dev);
@@ -122,17 +126,13 @@ static enum usb_role intel_xhci_usb_get_role(struct device *dev)
 	return role;
 }
 
-static const struct usb_role_switch_desc sw_desc = {
-	.set = intel_xhci_usb_set_role,
-	.get = intel_xhci_usb_get_role,
-	.allow_userspace_control = true,
-};
-
 static int intel_xhci_usb_probe(struct platform_device *pdev)
 {
+	struct usb_role_switch_desc sw_desc = { };
 	struct device *dev = &pdev->dev;
 	struct intel_xhci_usb_data *data;
 	struct resource *res;
+	int ret;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -147,9 +147,20 @@ static int intel_xhci_usb_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
+	ret = software_node_register(&intel_xhci_usb_node);
+	if (ret)
+		return ret;
+
+	sw_desc.set = intel_xhci_usb_set_role,
+	sw_desc.get = intel_xhci_usb_get_role,
+	sw_desc.allow_userspace_control = true,
+	sw_desc.fwnode = software_node_fwnode(&intel_xhci_usb_node);
+
 	data->role_sw = usb_role_switch_register(dev, &sw_desc);
-	if (IS_ERR(data->role_sw))
+	if (IS_ERR(data->role_sw)) {
+		fwnode_handle_put(sw_desc.fwnode);
 		return PTR_ERR(data->role_sw);
+	}
 
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
@@ -164,6 +175,8 @@ static int intel_xhci_usb_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 
 	usb_role_switch_unregister(data->role_sw);
+	fwnode_handle_put(software_node_fwnode(&intel_xhci_usb_node));
+
 	return 0;
 }
 
-- 
2.23.0.rc1

