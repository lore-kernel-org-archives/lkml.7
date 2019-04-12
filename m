Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA0CC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544502084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfDLNmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:42:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:9855 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbfDLNmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:42:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Apr 2019 06:42:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,341,1549958400"; 
   d="scan'208";a="163824304"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Apr 2019 06:42:01 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3 13/13] platform/x86: intel_cht_int33fe: Replacing the old connections with references
Date:   Fri, 12 Apr 2019 16:41:22 +0300
Message-Id: <20190412134122.82903-14-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190412134122.82903-1-heikki.krogerus@linux.intel.com>
References: <20190412134122.82903-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the software nodes support references, and the
device connection API support parsing fwnode references,
replacing the old connection descriptions with software node
references. Relying on device names when matching the
connection would not have been possible to link the USB
Type-C connector and the DisplayPort connector together, but
with real references it's not problem.

The DisplayPort ACPI node is dag up, and the drivers own
software node for the DisplayPort is set as the secondary
node for it. The USB Type-C connector refers the software
node, but it is now tied to the ACPI node, and therefore any
device entry (struct drm_connector in practice) that the
node combo is assigned to.

The USB role switch device does not have ACPI node, so we
have to wait for the device to appear. Then we can simply
assign our software node for the to the device.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/platform/x86/intel_cht_int33fe.c | 93 +++++++++++++++++++-----
 1 file changed, 76 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index 7711667a3454..e6a1ea7f33af 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -39,15 +39,22 @@ enum {
 	INT33FE_NODE_MAX,
 };
 
+enum {
+	INT33FE_REF_ORIENTATION,
+	INT33FE_REF_MODE_MUX,
+	INT33FE_REF_DISPLAYPORT,
+	INT33FE_REF_ROLE_SWITCH,
+	INT33FE_REF_MAX,
+};
+
 struct cht_int33fe_data {
 	struct i2c_client *max17047;
 	struct i2c_client *fusb302;
 	struct i2c_client *pi3usb30532;
-	/* Contain a list-head must be per device */
-	struct device_connection connections[4];
 
 	struct fwnode_handle *dp;
 	struct fwnode_handle *node[INT33FE_NODE_MAX];
+	struct software_node_reference *ref[INT33FE_REF_MAX];
 };
 
 /*
@@ -280,6 +287,65 @@ static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
 	return ret;
 }
 
+static void cht_int33fe_remove_references(struct cht_int33fe_data *data)
+{
+	int i;
+
+	for (i = 0; i < INT33FE_REF_MAX; i++)
+		fwnode_remove_software_node_reference(data->ref[i]);
+}
+
+static int cht_int33fe_add_references(struct cht_int33fe_data *data)
+{
+	struct fwnode_reference_args args[2] = { };
+	struct software_node_reference *ref;
+	struct fwnode_handle *con;
+
+	con = data->node[INT33FE_NODE_USB_CONNECTOR];
+
+	/* USB Type-C muxes */
+	args[0].fwnode = data->node[INT33FE_NODE_PI3USB30532];
+	args[1].fwnode = NULL;
+
+	ref = fwnode_create_software_node_reference(con, "orientation-switch",
+						    args);
+	if (IS_ERR(ref))
+		return PTR_ERR(ref);
+	data->ref[INT33FE_REF_ORIENTATION] = ref;
+
+	ref = fwnode_create_software_node_reference(con, "mode-switch", args);
+	if (IS_ERR(ref)) {
+		cht_int33fe_remove_references(data);
+		return PTR_ERR(ref);
+	}
+	data->ref[INT33FE_REF_MODE_MUX] = ref;
+
+	/* USB role switch */
+	args[0].fwnode = data->node[INT33FE_NODE_ROLE_SWITCH];
+	args[1].fwnode = NULL;
+
+	ref = fwnode_create_software_node_reference(con, "usb-role-switch",
+						    args);
+	if (IS_ERR(ref)) {
+		cht_int33fe_remove_references(data);
+		return PTR_ERR(ref);
+	}
+	data->ref[INT33FE_REF_ROLE_SWITCH] = ref;
+
+	/* DisplayPort */
+	args[0].fwnode = data->node[INT33FE_NODE_DISPLAYPORT];
+	args[1].fwnode = NULL;
+
+	ref = fwnode_create_software_node_reference(con, "displayport", args);
+	if (IS_ERR(ref)) {
+		cht_int33fe_remove_references(data);
+		return PTR_ERR(ref);
+	}
+	data->ref[INT33FE_REF_DISPLAYPORT] = ref;
+
+	return 0;
+}
+
 static int cht_int33fe_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -348,22 +414,14 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/* Work around BIOS bug, see comment on cht_int33fe_check_for_max17047 */
-	ret = cht_int33fe_register_max17047(dev, data);
+	ret = cht_int33fe_add_references(data);
 	if (ret)
 		goto out_remove_nodes;
 
-	data->connections[0].endpoint[0] = "port0";
-	data->connections[0].endpoint[1] = "i2c-pi3usb30532-switch";
-	data->connections[0].id = "orientation-switch";
-	data->connections[1].endpoint[0] = "port0";
-	data->connections[1].endpoint[1] = "i2c-pi3usb30532-mux";
-	data->connections[1].id = "mode-switch";
-	data->connections[2].endpoint[0] = "i2c-fusb302";
-	data->connections[2].endpoint[1] = "intel_xhci_usb_sw-role-switch";
-	data->connections[2].id = "usb-role-switch";
-
-	device_connections_add(data->connections);
+	/* Work around BIOS bug, see comment on cht_int33fe_check_for_max17047 */
+	ret = cht_int33fe_register_max17047(dev, data);
+	if (ret)
+		goto out_remove_references;
 
 	memset(&board_info, 0, sizeof(board_info));
 	strlcpy(board_info.type, "typec_fusb302", I2C_NAME_SIZE);
@@ -398,7 +456,8 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 out_unregister_max17047:
 	i2c_unregister_device(data->max17047);
 
-	device_connections_remove(data->connections);
+out_remove_references:
+	cht_int33fe_remove_references(data);
 
 out_remove_nodes:
 	cht_int33fe_remove_nodes(data);
@@ -414,7 +473,7 @@ static int cht_int33fe_remove(struct platform_device *pdev)
 	i2c_unregister_device(data->fusb302);
 	i2c_unregister_device(data->max17047);
 
-	device_connections_remove(data->connections);
+	cht_int33fe_remove_references(data);
 	cht_int33fe_remove_nodes(data);
 
 	return 0;
-- 
2.20.1

