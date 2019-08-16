Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B315AC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 10:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914BF206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 10:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfHPKpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 06:45:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:44447 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbfHPKpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 06:45:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 03:45:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,391,1559545200"; 
   d="scan'208";a="194970286"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 16 Aug 2019 03:45:22 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] platform/x86: intel_cht_int33fe: Use new API to gain access to the role switch
Date:   Fri, 16 Aug 2019 13:45:15 +0300
Message-Id: <20190816104515.63613-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190816104515.63613-1-heikki.krogerus@linux.intel.com>
References: <20190816104515.63613-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver for the Intel USB role mux now always supplies
software node for the role switch, so no longer checking
that, and never creating separate node for the role switch.
From now on using software_node_find_by_name() function to
get the handle to the USB role switch.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel_cht_int33fe.c | 57 +++++-------------------
 1 file changed, 10 insertions(+), 47 deletions(-)

diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index 4fbdff48a4b5..1d5d877b9582 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -34,7 +34,6 @@ enum {
 	INT33FE_NODE_MAX17047,
 	INT33FE_NODE_PI3USB30532,
 	INT33FE_NODE_DISPLAYPORT,
-	INT33FE_NODE_ROLE_SWITCH,
 	INT33FE_NODE_USB_CONNECTOR,
 	INT33FE_NODE_MAX,
 };
@@ -45,7 +44,6 @@ struct cht_int33fe_data {
 	struct i2c_client *pi3usb30532;
 
 	struct fwnode_handle *dp;
-	struct fwnode_handle *mux;
 };
 
 static const struct software_node nodes[];
@@ -139,46 +137,10 @@ static const struct software_node nodes[] = {
 	{ "max17047", NULL, max17047_props },
 	{ "pi3usb30532" },
 	{ "displayport" },
-	{ "usb-role-switch" },
 	{ "connector", &nodes[0], usb_connector_props, usb_connector_refs },
 	{ }
 };
 
-static int cht_int33fe_setup_mux(struct cht_int33fe_data *data)
-{
-	struct fwnode_handle *fwnode;
-	struct device *dev;
-	struct device *p;
-
-	fwnode = software_node_fwnode(&nodes[INT33FE_NODE_ROLE_SWITCH]);
-	if (!fwnode)
-		return -ENODEV;
-
-	/* First finding the platform device */
-	p = bus_find_device_by_name(&platform_bus_type, NULL,
-				    "intel_xhci_usb_sw");
-	if (!p)
-		return -EPROBE_DEFER;
-
-	/* Then the mux child device */
-	dev = device_find_child_by_name(p, "intel_xhci_usb_sw-role-switch");
-	put_device(p);
-	if (!dev)
-		return -EPROBE_DEFER;
-
-	/* If there already is a node for the mux, using that one. */
-	if (dev->fwnode)
-		fwnode_remove_software_node(fwnode);
-	else
-		dev->fwnode = fwnode;
-
-	data->mux = fwnode_handle_get(dev->fwnode);
-	put_device(dev);
-	mux_ref.node = to_software_node(data->mux);
-
-	return 0;
-}
-
 static int cht_int33fe_setup_dp(struct cht_int33fe_data *data)
 {
 	struct fwnode_handle *fwnode;
@@ -211,10 +173,9 @@ static void cht_int33fe_remove_nodes(struct cht_int33fe_data *data)
 {
 	software_node_unregister_nodes(nodes);
 
-	if (data->mux) {
-		fwnode_handle_put(data->mux);
+	if (mux_ref.node) {
+		fwnode_handle_put(software_node_fwnode(mux_ref.node));
 		mux_ref.node = NULL;
-		data->mux = NULL;
 	}
 
 	if (data->dp) {
@@ -235,14 +196,16 @@ static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
 	/* The devices that are not created in this driver need extra steps. */
 
 	/*
-	 * There is no ACPI device node for the USB role mux, so we need to find
-	 * the mux device and assign our node directly to it. That means we
-	 * depend on the mux driver. This function will return -PROBE_DEFER
-	 * until the mux device is registered.
+	 * There is no ACPI device node for the USB role mux, so we need to wait
+	 * until the mux driver has created software node for the mux device.
+	 * It means we depend on the mux driver. This function will return
+	 * -EPROBE_DEFER until the mux device is registered.
 	 */
-	ret = cht_int33fe_setup_mux(data);
-	if (ret)
+	mux_ref.node = software_node_find_by_name(NULL, "intel-xhci-usb-sw");
+	if (!mux_ref.node) {
+		ret = -EPROBE_DEFER;
 		goto err_remove_nodes;
+	}
 
 	/*
 	 * The DP connector does have ACPI device node. In this case we can just
-- 
2.23.0.rc1

