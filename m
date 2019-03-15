Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D41BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D4F218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 16:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbfCOQ6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:58:25 -0400
Received: from mga17.intel.com ([192.55.52.151]:39359 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728458AbfCOQ6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 12:58:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 09:58:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,482,1544515200"; 
   d="scan'208";a="155397250"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 15 Mar 2019 09:58:18 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 09/12] platform/x86: intel_cht_int33fe: Link with external dependencies using fwnodes
Date:   Fri, 15 Mar 2019 19:57:57 +0300
Message-Id: <20190315165800.5058-10-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190315165800.5058-1-heikki.krogerus@linux.intel.com>
References: <20190315165800.5058-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Supplying also external devices - the DisplayPort connector
and the USB role switch - software fwnodes. After this the
driver has access to all the components tied to the USB
Type-C connector and can start creating software node
references to actually associate them with the USB Type-C
connector device.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/platform/x86/intel_cht_int33fe.c | 102 +++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index 44860c748bf5..aa71b97a22e9 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -33,6 +33,8 @@ enum {
 	INT33FE_NODE_FUSB302,
 	INT33FE_NODE_MAX17047,
 	INT33FE_NODE_PI3USB30532,
+	INT33FE_NODE_DISPLAYPORT,
+	INT33FE_NODE_ROLE_SWITCH,
 	INT33FE_NODE_USB_CONNECTOR,
 	INT33FE_NODE_MAX,
 };
@@ -44,6 +46,7 @@ struct cht_int33fe_data {
 	/* Contain a list-head must be per device */
 	struct device_connection connections[4];
 
+	struct fwnode_handle *dp;
 	struct fwnode_handle *node[INT33FE_NODE_MAX];
 };
 
@@ -144,8 +147,81 @@ static const struct property_entry *props[] = {
 	[INT33FE_NODE_FUSB302]		= fusb302_props,
 	[INT33FE_NODE_MAX17047]		= NULL,
 	[INT33FE_NODE_PI3USB30532]	= NULL,
+	[INT33FE_NODE_DISPLAYPORT]	= NULL,
+	[INT33FE_NODE_ROLE_SWITCH]	= NULL,
 };
 
+static const char *dp_acpi_node_name = "DD02";
+static const char *mux_platfrom_dev_name = "intel_xhci_usb_sw";
+static const char *mux_name = "intel_xhci_usb_sw-role-switch";
+
+static int cht_int33fe_setup_dp(struct cht_int33fe_data *data)
+{
+	struct fwnode_handle *fwnode = data->node[INT33FE_NODE_DISPLAYPORT];
+	struct pci_dev *pdev;
+
+	/* First let's find the GPU PCI device */
+	pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, NULL);
+	if (!pdev || (pdev->vendor != PCI_VENDOR_ID_INTEL))
+		return -ENODEV;
+
+	/* Then the DP child device node */
+	data->dp = device_get_named_child_node(&pdev->dev, dp_acpi_node_name);
+	pci_dev_put(pdev);
+	if (!data->dp)
+		return -ENODEV;
+
+	fwnode->secondary = ERR_PTR(-ENODEV);
+	data->dp->secondary = fwnode;
+
+	return 0;
+}
+
+static int role_switch_match(struct device *dev, void *name)
+{
+	return !strcmp(dev_name(dev), name);
+}
+
+static int cht_int33fe_setup_mux(struct cht_int33fe_data *data)
+{
+	struct fwnode_handle *fwnode = data->node[INT33FE_NODE_ROLE_SWITCH];
+	struct pci_dev *pdev;
+	struct device *dev;
+	struct device *p;
+
+	/* First let's find xHCI PCI device */
+	pdev = pci_get_class(PCI_CLASS_SERIAL_USB_XHCI, NULL);
+	if (!pdev || (pdev->vendor != PCI_VENDOR_ID_INTEL))
+		return -ENODEV;
+
+	/* Then the child platform device */
+	p = device_find_child(&pdev->dev, (void *)mux_platfrom_dev_name,
+			      role_switch_match);
+	pci_dev_put(pdev);
+	if (!p)
+		return -EPROBE_DEFER;
+
+	/* Finally the mux device */
+	dev = device_find_child(p, (void *)mux_name, role_switch_match);
+	put_device(p);
+	if (!dev)
+		return -EPROBE_DEFER;
+
+	/* If there already is a node for the mux, using that one. */
+	if (dev->fwnode) {
+		fwnode_handle_get(dev->fwnode);
+		fwnode_remove_software_node(fwnode);
+		data->node[INT33FE_NODE_ROLE_SWITCH] = dev->fwnode;
+	} else {
+		/* The node can be tied to the lifetime of the device. */
+		dev->fwnode = fwnode_handle_get(dev->fwnode);
+	}
+
+	put_device(dev);
+
+	return 0;
+}
+
 static void cht_int33fe_remove_nodes(struct cht_int33fe_data *data)
 {
 	int i;
@@ -154,6 +230,12 @@ static void cht_int33fe_remove_nodes(struct cht_int33fe_data *data)
 		fwnode_remove_software_node(data->node[i]);
 		data->node[i] = NULL;
 	}
+
+	if (data->dp) {
+		data->dp->secondary = NULL;
+		fwnode_handle_put(data->dp);
+		data->dp = NULL;
+	}
 }
 
 static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
@@ -180,6 +262,26 @@ static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
 	}
 	data->node[INT33FE_NODE_USB_CONNECTOR] = fwnode;
 
+	/* The devices that are not created in this driver need extra steps. */
+
+	/*
+	 * There is no ACPI device node for the USB role mux, so we need to find
+	 * the mux device and assign our node directly to it. That means we
+	 * depend on the mux driver. This function will return -PROBE_DEFER
+	 * until the mux device is registered.
+	 */
+	ret = cht_int33fe_setup_mux(data);
+	if (ret)
+		goto err_remove_nodes;
+
+	/*
+	 * The DP connector does have ACPI device node. In this case we can just
+	 * find that ACPI node and assing our node as the secondary node to it.
+	 */
+	ret = cht_int33fe_setup_dp(data);
+	if (ret)
+		goto err_remove_nodes;
+
 	return 0;
 
 err_remove_nodes:
-- 
2.20.1

