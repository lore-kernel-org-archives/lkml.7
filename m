Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CCDC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD5F2082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbfDCQqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:46:08 -0400
Received: from mga11.intel.com ([192.55.52.93]:21215 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbfDCQqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:46:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Apr 2019 09:46:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,305,1549958400"; 
   d="scan'208";a="161077479"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Apr 2019 09:46:02 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 09/11] platform/x86: intel_cht_int33fe: Provide fwnode for the USB connector
Date:   Wed,  3 Apr 2019 19:45:35 +0300
Message-Id: <20190403164537.24643-10-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403164537.24643-1-heikki.krogerus@linux.intel.com>
References: <20190403164537.24643-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ACPI, and now also in DT, the USB connectors usually have
their own device nodes. In case of USB Type-C, those
connector (port) nodes are child nodes of the controller or
PHY device, in our case the fusb302. The software fwnodes
allow us to create a similar child node for fusb302 that
represents the connector also on Intel CHT.

This makes it possible replace the fusb302 specific device
properties which were deprecated with the common USB
connector properties that tcpm.c is able to use directly.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/platform/x86/intel_cht_int33fe.c | 37 ++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index 2f12ce154489..544e0b90aa07 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -25,6 +25,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
+#include <linux/usb/pd.h>
 
 #define EXPECTED_PTYPE		4
 
@@ -32,6 +33,7 @@ enum {
 	INT33FE_NODE_FUSB302,
 	INT33FE_NODE_MAX17047,
 	INT33FE_NODE_PI3USB30532,
+	INT33FE_NODE_USB_CONNECTOR,
 	INT33FE_NODE_MAX,
 };
 
@@ -112,9 +114,29 @@ cht_int33fe_max17047(struct device *dev, struct cht_int33fe_data *data)
 
 static const struct property_entry fusb302_props[] = {
 	PROPERTY_ENTRY_STRING("linux,extcon-name", "cht_wcove_pwrsrc"),
-	PROPERTY_ENTRY_U32("fcs,max-sink-microvolt", 12000000),
-	PROPERTY_ENTRY_U32("fcs,max-sink-microamp",   3000000),
-	PROPERTY_ENTRY_U32("fcs,max-sink-microwatt", 36000000),
+	{ }
+};
+
+#define PDO_FIXED_FLAGS \
+	(PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP | PDO_FIXED_USB_COMM)
+
+static const u32 src_pdo[] = {
+	PDO_FIXED(5000, 1500, PDO_FIXED_FLAGS),
+};
+
+static const u32 snk_pdo[] = {
+	PDO_FIXED(5000, 400, PDO_FIXED_FLAGS),
+	PDO_VAR(5000, 12000, 3000),
+};
+
+static const struct property_entry usb_connector_props[] = {
+	PROPERTY_ENTRY_STRING("name", "connector"),
+	PROPERTY_ENTRY_STRING("data-role", "dual"),
+	PROPERTY_ENTRY_STRING("power-role", "dual"),
+	PROPERTY_ENTRY_STRING("try-power-role", "sink"),
+	PROPERTY_ENTRY_U32_ARRAY("source-pdos", src_pdo),
+	PROPERTY_ENTRY_U32_ARRAY("sink-pdos", snk_pdo),
+	PROPERTY_ENTRY_U32("op-sink-microwatt", 36000000),
 	{ }
 };
 
@@ -149,6 +171,15 @@ static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
 		data->node[i] = fwnode;
 	}
 
+	/* Node for the USB connector (FUSB302 is the parent) */
+	fwnode = fwnode_create_software_node(usb_connector_props,
+					     data->node[INT33FE_NODE_FUSB302]);
+	if (IS_ERR(fwnode)) {
+		ret = PTR_ERR(fwnode);
+		goto err_remove_nodes;
+	}
+	data->node[INT33FE_NODE_USB_CONNECTOR] = fwnode;
+
 	return 0;
 
 err_remove_nodes:
-- 
2.20.1

