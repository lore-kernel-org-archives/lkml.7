Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6127AC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7282082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbfDCQqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:46:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:21215 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728926AbfDCQqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:46:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Apr 2019 09:46:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,305,1549958400"; 
   d="scan'208";a="161077458"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Apr 2019 09:46:00 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 08/11] platform/x86: intel_cht_int33fe: Provide software nodes for the devices
Date:   Wed,  3 Apr 2019 19:45:34 +0300
Message-Id: <20190403164537.24643-9-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403164537.24643-1-heikki.krogerus@linux.intel.com>
References: <20190403164537.24643-1-heikki.krogerus@linux.intel.com>
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
 drivers/platform/x86/intel_cht_int33fe.c | 122 +++++++++++++++++------
 1 file changed, 92 insertions(+), 30 deletions(-)

diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index 657b8d61554c..2f12ce154489 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -24,15 +24,25 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+#include <linux/pci.h>
 
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
@@ -63,14 +73,6 @@ static int cht_int33fe_check_for_max17047(struct device *dev, void *data)
 	return 1;
 }
 
-static struct i2c_client *cht_int33fe_find_max17047(void)
-{
-	struct i2c_client *max17047 = NULL;
-
-	i2c_for_each_dev(&max17047, cht_int33fe_check_for_max17047);
-	return max17047;
-}
-
 static const char * const max17047_suppliers[] = { "bq24190-charger" };
 
 static const struct property_entry max17047_props[] = {
@@ -78,6 +80,36 @@ static const struct property_entry max17047_props[] = {
 	{ }
 };
 
+static int
+cht_int33fe_max17047(struct device *dev, struct cht_int33fe_data *data)
+{
+	struct fwnode_handle *fwnode = data->node[INT33FE_NODE_MAX17047];
+	struct i2c_client *max17047 = NULL;
+	struct i2c_board_info board_info;
+	int ret;
+
+	i2c_for_each_dev(&max17047, cht_int33fe_check_for_max17047);
+	if (max17047) {
+		/* Pre-existing i2c-client for the max17047, add device-props */
+		max17047->dev.fwnode->secondary = fwnode;
+		/* And re-probe to get the new device-props applied. */
+		ret = device_reprobe(&max17047->dev);
+		if (ret)
+			dev_warn(dev, "Reprobing max17047 error: %d\n", ret);
+		return 0;
+	}
+
+	memset(&board_info, 0, sizeof(board_info));
+	strlcpy(board_info.type, "max17047", I2C_NAME_SIZE);
+	board_info.dev_name = "max17047";
+	board_info.fwnode = fwnode;
+	data->max17047 = i2c_acpi_new_device(dev, 1, &board_info);
+	if (IS_ERR(data->max17047))
+		return PTR_ERR(data->max17047);
+
+	return 0;
+}
+
 static const struct property_entry fusb302_props[] = {
 	PROPERTY_ENTRY_STRING("linux,extcon-name", "cht_wcove_pwrsrc"),
 	PROPERTY_ENTRY_U32("fcs,max-sink-microvolt", 12000000),
@@ -86,12 +118,50 @@ static const struct property_entry fusb302_props[] = {
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
 	struct i2c_board_info board_info;
 	struct cht_int33fe_data *data;
-	struct i2c_client *max17047;
 	struct regulator *regulator;
 	unsigned long long ptyp;
 	acpi_status status;
@@ -151,26 +221,14 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
+	ret = cht_int33fe_add_nodes(data);
+	if (ret)
+		return ret;
+
 	/* Work around BIOS bug, see comment on cht_int33fe_find_max17047 */
-	max17047 = cht_int33fe_find_max17047();
-	if (max17047) {
-		/* Pre-existing i2c-client for the max17047, add device-props */
-		ret = device_add_properties(&max17047->dev, max17047_props);
-		if (ret)
-			return ret;
-		/* And re-probe to get the new device-props applied. */
-		ret = device_reprobe(&max17047->dev);
-		if (ret)
-			dev_warn(dev, "Reprobing max17047 error: %d\n", ret);
-	} else {
-		memset(&board_info, 0, sizeof(board_info));
-		strlcpy(board_info.type, "max17047", I2C_NAME_SIZE);
-		board_info.dev_name = "max17047";
-		board_info.properties = max17047_props;
-		data->max17047 = i2c_acpi_new_device(dev, 1, &board_info);
-		if (IS_ERR(data->max17047))
-			return PTR_ERR(data->max17047);
-	}
+	ret = cht_int33fe_max17047(dev, data);
+	if (ret)
+		goto out_remove_nodes;
 
 	data->connections[0].endpoint[0] = "port0";
 	data->connections[0].endpoint[1] = "i2c-pi3usb30532-switch";
@@ -187,7 +245,7 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 	memset(&board_info, 0, sizeof(board_info));
 	strlcpy(board_info.type, "typec_fusb302", I2C_NAME_SIZE);
 	board_info.dev_name = "fusb302";
-	board_info.properties = fusb302_props;
+	board_info.fwnode = data->node[INT33FE_NODE_FUSB302];
 	board_info.irq = fusb302_irq;
 
 	data->fusb302 = i2c_acpi_new_device(dev, 2, &board_info);
@@ -198,6 +256,7 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 
 	memset(&board_info, 0, sizeof(board_info));
 	board_info.dev_name = "pi3usb30532";
+	board_info.fwnode = data->node[INT33FE_NODE_PI3USB30532];
 	strlcpy(board_info.type, "pi3usb30532", I2C_NAME_SIZE);
 
 	data->pi3usb30532 = i2c_acpi_new_device(dev, 3, &board_info);
@@ -214,9 +273,11 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 	i2c_unregister_device(data->fusb302);
 
 out_unregister_max17047:
+	device_connections_remove(data->connections);
 	i2c_unregister_device(data->max17047);
 
-	device_connections_remove(data->connections);
+out_remove_nodes:
+	cht_int33fe_remove_nodes(data);
 
 	return ret;
 }
@@ -230,6 +291,7 @@ static int cht_int33fe_remove(struct platform_device *pdev)
 	i2c_unregister_device(data->max17047);
 
 	device_connections_remove(data->connections);
+	cht_int33fe_remove_nodes(data);
 
 	return 0;
 }
-- 
2.20.1

