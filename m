Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44B3C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 11:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51312064A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 11:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbfHOL2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 07:28:34 -0400
Received: from mga12.intel.com ([192.55.52.136]:30184 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbfHOL2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 07:28:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 04:28:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="194750096"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 15 Aug 2019 04:28:31 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] usb: roles: intel_xhci: Supplying software node for the role mux
Date:   Thu, 15 Aug 2019 14:28:25 +0300
Message-Id: <20190815112826.81785-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815112826.81785-1-heikki.krogerus@linux.intel.com>
References: <20190815112826.81785-1-heikki.krogerus@linux.intel.com>
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
 drivers/usb/roles/intel-xhci-usb-role-switch.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/roles/intel-xhci-usb-role-switch.c b/drivers/usb/roles/intel-xhci-usb-role-switch.c
index 277de96181f9..1e86c01da35c 100644
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
@@ -122,7 +126,7 @@ static enum usb_role intel_xhci_usb_get_role(struct device *dev)
 	return role;
 }
 
-static const struct usb_role_switch_desc sw_desc = {
+static struct usb_role_switch_desc sw_desc = {
 	.set = intel_xhci_usb_set_role,
 	.get = intel_xhci_usb_get_role,
 	.allow_userspace_control = true,
@@ -133,6 +137,7 @@ static int intel_xhci_usb_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct intel_xhci_usb_data *data;
 	struct resource *res;
+	int ret;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -147,6 +152,12 @@ static int intel_xhci_usb_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
+	ret = software_node_register(&intel_xhci_usb_node);
+	if (ret)
+		return ret;
+
+	sw_desc.fwnode = software_node_fwnode(&intel_xhci_usb_node);
+
 	data->role_sw = usb_role_switch_register(dev, &sw_desc);
 	if (IS_ERR(data->role_sw))
 		return PTR_ERR(data->role_sw);
-- 
2.20.1

