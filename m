Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E056C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107972084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfDLNly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:41:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:9855 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727157AbfDLNlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:41:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Apr 2019 06:41:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,341,1549958400"; 
   d="scan'208";a="163824278"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Apr 2019 06:41:48 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 09/13] platform/x86: intel_cht_int33fe: Register max17047 in its own function
Date:   Fri, 12 Apr 2019 16:41:18 +0300
Message-Id: <20190412134122.82903-10-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190412134122.82903-1-heikki.krogerus@linux.intel.com>
References: <20190412134122.82903-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving the registration of max17047 out of probe to its own
function. This is only a cleanup of the probe. There should
be no functional affect.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/platform/x86/intel_cht_int33fe.c | 64 +++++++++++++-----------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index 657b8d61554c..d586bb22d7e8 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -63,14 +63,6 @@ static int cht_int33fe_check_for_max17047(struct device *dev, void *data)
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
@@ -78,6 +70,37 @@ static const struct property_entry max17047_props[] = {
 	{ }
 };
 
+static int
+cht_int33fe_register_max17047(struct device *dev, struct cht_int33fe_data *data)
+{
+	struct i2c_client *max17047 = NULL;
+	struct i2c_board_info board_info;
+	int ret;
+
+	i2c_for_each_dev(&max17047, cht_int33fe_check_for_max17047);
+	if (max17047) {
+		/* Pre-existing i2c-client for the max17047, add device-props */
+		ret = device_add_properties(&max17047->dev, max17047_props);
+		if (ret)
+			return ret;
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
+	board_info.properties = max17047_props;
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
@@ -91,7 +114,6 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct i2c_board_info board_info;
 	struct cht_int33fe_data *data;
-	struct i2c_client *max17047;
 	struct regulator *regulator;
 	unsigned long long ptyp;
 	acpi_status status;
@@ -151,26 +173,10 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	/* Work around BIOS bug, see comment on cht_int33fe_find_max17047 */
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
+	/* Work around BIOS bug, see comment on cht_int33fe_check_for_max17047 */
+	ret = cht_int33fe_register_max17047(dev, data);
+	if (ret)
+		return ret;
 
 	data->connections[0].endpoint[0] = "port0";
 	data->connections[0].endpoint[1] = "i2c-pi3usb30532-switch";
-- 
2.20.1

