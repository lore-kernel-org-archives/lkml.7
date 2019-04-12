Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DE7C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFDC32084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfDLNl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:41:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:9855 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727157AbfDLNlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:41:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Apr 2019 06:41:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,341,1549958400"; 
   d="scan'208";a="163824284"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Apr 2019 06:41:52 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 10/13] platform/x86: intel_cht_int33fe: Provide software nodes for the devices
Date:   Fri, 12 Apr 2019 16:41:19 +0300
Message-Id: <20190412134122.82903-11-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190412134122.82903-1-heikki.krogerus@linux.intel.com>
References: <20190412134122.82903-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Software nodes provide two features that we will need later.
1) Software nodes can have references to other software nodes.
2) Software nodes can exist before a device entry is created.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/platform/x86/intel_cht_int33fe.c | 68 +++++++++++++++++++++---
 1 file changed, 62 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index d586bb22d7e8..863a792d9282 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -27,12 +27,21 @@
 
 #define EXPECTED_PTYPE		4
 
+enum {
+	INT33FE_NODE_FUSB302,
+	INT33FE_NODE_MAX17047,
+	INT33FE_NODE_PI3USB30532,
+	INT33FE_NODE_MAX,
+};
+
 struct cht_int33fe_data {
 	struct i2c_client *max17047;
 	struct i2c_client *fusb302;
 	struct i2c_client *pi3usb30532;
 	/* Contain a list-head must be per device */
 	struct device_connection connections[4];
+
+	struct fwnode_handle *node[INT33FE_NODE_MAX];
 };
 
 /*
@@ -73,6 +82,7 @@ static const struct property_entry max17047_props[] = {
 static int
 cht_int33fe_register_max17047(struct device *dev, struct cht_int33fe_data *data)
 {
+	struct fwnode_handle *fwnode = data->node[INT33FE_NODE_MAX17047];
 	struct i2c_client *max17047 = NULL;
 	struct i2c_board_info board_info;
 	int ret;
@@ -80,9 +90,7 @@ cht_int33fe_register_max17047(struct device *dev, struct cht_int33fe_data *data)
 	i2c_for_each_dev(&max17047, cht_int33fe_check_for_max17047);
 	if (max17047) {
 		/* Pre-existing i2c-client for the max17047, add device-props */
-		ret = device_add_properties(&max17047->dev, max17047_props);
-		if (ret)
-			return ret;
+		max17047->dev.fwnode->secondary = fwnode;
 		/* And re-probe to get the new device-props applied. */
 		ret = device_reprobe(&max17047->dev);
 		if (ret)
@@ -93,7 +101,7 @@ cht_int33fe_register_max17047(struct device *dev, struct cht_int33fe_data *data)
 	memset(&board_info, 0, sizeof(board_info));
 	strlcpy(board_info.type, "max17047", I2C_NAME_SIZE);
 	board_info.dev_name = "max17047";
-	board_info.properties = max17047_props;
+	board_info.fwnode = fwnode;
 	data->max17047 = i2c_acpi_new_device(dev, 1, &board_info);
 	if (IS_ERR(data->max17047))
 		return PTR_ERR(data->max17047);
@@ -109,6 +117,45 @@ static const struct property_entry fusb302_props[] = {
 	{ }
 };
 
+static const struct property_entry *props[] = {
+	[INT33FE_NODE_FUSB302]		= fusb302_props,
+	[INT33FE_NODE_MAX17047]		= max17047_props,
+	[INT33FE_NODE_PI3USB30532]	= NULL,
+};
+
+static void cht_int33fe_remove_nodes(struct cht_int33fe_data *data)
+{
+	int i;
+
+	for (i = 0; i < INT33FE_NODE_MAX; i++) {
+		fwnode_remove_software_node(data->node[i]);
+		data->node[i] = NULL;
+	}
+}
+
+static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
+{
+	struct fwnode_handle *fwnode;
+	int ret;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(props); i++) {
+		fwnode = fwnode_create_software_node(props[i], NULL);
+		if (IS_ERR(fwnode)) {
+			ret = PTR_ERR(fwnode);
+			goto err_remove_nodes;
+		}
+		data->node[i] = fwnode;
+	}
+
+	return 0;
+
+err_remove_nodes:
+	cht_int33fe_remove_nodes(data);
+
+	return ret;
+}
+
 static int cht_int33fe_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -173,10 +220,14 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
+	ret = cht_int33fe_add_nodes(data);
+	if (ret)
+		return ret;
+
 	/* Work around BIOS bug, see comment on cht_int33fe_check_for_max17047 */
 	ret = cht_int33fe_register_max17047(dev, data);
 	if (ret)
-		return ret;
+		goto out_remove_nodes;
 
 	data->connections[0].endpoint[0] = "port0";
 	data->connections[0].endpoint[1] = "i2c-pi3usb30532-switch";
@@ -193,7 +244,7 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 	memset(&board_info, 0, sizeof(board_info));
 	strlcpy(board_info.type, "typec_fusb302", I2C_NAME_SIZE);
 	board_info.dev_name = "fusb302";
-	board_info.properties = fusb302_props;
+	board_info.fwnode = data->node[INT33FE_NODE_FUSB302];
 	board_info.irq = fusb302_irq;
 
 	data->fusb302 = i2c_acpi_new_device(dev, 2, &board_info);
@@ -204,6 +255,7 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 
 	memset(&board_info, 0, sizeof(board_info));
 	board_info.dev_name = "pi3usb30532";
+	board_info.fwnode = data->node[INT33FE_NODE_PI3USB30532];
 	strlcpy(board_info.type, "pi3usb30532", I2C_NAME_SIZE);
 
 	data->pi3usb30532 = i2c_acpi_new_device(dev, 3, &board_info);
@@ -224,6 +276,9 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 
 	device_connections_remove(data->connections);
 
+out_remove_nodes:
+	cht_int33fe_remove_nodes(data);
+
 	return ret;
 }
 
@@ -236,6 +291,7 @@ static int cht_int33fe_remove(struct platform_device *pdev)
 	i2c_unregister_device(data->max17047);
 
 	device_connections_remove(data->connections);
+	cht_int33fe_remove_nodes(data);
 
 	return 0;
 }
-- 
2.20.1

