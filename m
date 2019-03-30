Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44423C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE70D21773
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553909453;
	bh=2FDXyPAWlTa6tRcHnX32gx7N2bnrKb1NEsVzn6IVfKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VYM6bhFpsd43RIavXXZwenr63CVHC7Ksz6J2Tj9NWtSbQP/lsqwEFq/j65mq/yGNS
	 hGswoGBfDIaOZ9nMjrgmWtjDwdOEsewQrMozsQMvo0xjNKw8McZHIj3vxpqJnYLO7y
	 nrgBgsU10yQGtBvixDv8OPMg6r+C5ncbcgdBUvQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731758AbfC3Baw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:30:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730419AbfC3Bat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:30:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 900592184C;
        Sat, 30 Mar 2019 01:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909448;
        bh=2FDXyPAWlTa6tRcHnX32gx7N2bnrKb1NEsVzn6IVfKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fvbohPmWJsfY4Bya3G3ASRZgp6uyPJsHJGDimumxOO4BjVAohg46pxG3W5GNAu1a0
         +6tiEMFkFvOv5S87QmPQd5a9KXTkpwp171ShC5gOQQbRIJn0/vKnB4YlKHx1UEhcBw
         2BsBodk4VEVo9Am6n7gYRddia6FL5JqbIGhZJvv4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julian Sax <jsbc@gmx.de>, Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 10/37] HID: i2c-hid: override HID descriptors for certain devices
Date:   Fri, 29 Mar 2019 21:29:53 -0400
Message-Id: <20190330013020.379-10-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330013020.379-1-sashal@kernel.org>
References: <20190330013020.379-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Sax <jsbc@gmx.de>

[ Upstream commit 9ee3e06610fdb8a601cde59c92089fb6c1deb4aa ]

A particular touchpad (SIPODEV SP1064) refuses to supply the HID
descriptors. This patch provides the framework for overriding these
descriptors based on DMI data. It also includes the descriptors for
said touchpad, which were extracted by listening to the traffic of the
windows filter driver, as well as the DMI data for the laptops known
to use this device.

Relevant Bug: https://bugzilla.redhat.com/show_bug.cgi?id=1526312

Cc: Hans de Goede <hdegoede@redhat.com>
Reported-and-tested-by: ahormann@gmx.net
Reported-and-tested-by: Bruno Jesus <bruno.fl.jesus@gmail.com>
Reported-and-tested-by: Dietrich <enaut.w@googlemail.com>
Reported-and-tested-by: kloxdami@yahoo.com
Signed-off-by: Julian Sax <jsbc@gmx.de>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/i2c-hid/Makefile                  |   3 +
 .../hid/i2c-hid/{i2c-hid.c => i2c-hid-core.c} |  56 ++-
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c      | 376 ++++++++++++++++++
 drivers/hid/i2c-hid/i2c-hid.h                 |  20 +
 4 files changed, 437 insertions(+), 18 deletions(-)
 rename drivers/hid/i2c-hid/{i2c-hid.c => i2c-hid-core.c} (96%)
 create mode 100644 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
 create mode 100644 drivers/hid/i2c-hid/i2c-hid.h

diff --git a/drivers/hid/i2c-hid/Makefile b/drivers/hid/i2c-hid/Makefile
index 832d8f9aaba2..099e1ce2f234 100644
--- a/drivers/hid/i2c-hid/Makefile
+++ b/drivers/hid/i2c-hid/Makefile
@@ -3,3 +3,6 @@
 #
 
 obj-$(CONFIG_I2C_HID)				+= i2c-hid.o
+
+i2c-hid-objs					=  i2c-hid-core.o
+i2c-hid-$(CONFIG_DMI)				+= i2c-hid-dmi-quirks.o
diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid-core.c
similarity index 96%
rename from drivers/hid/i2c-hid/i2c-hid.c
rename to drivers/hid/i2c-hid/i2c-hid-core.c
index 136a34dc31b8..7842d76aa813 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -43,6 +43,7 @@
 #include <linux/platform_data/i2c-hid.h>
 
 #include "../hid-ids.h"
+#include "i2c-hid.h"
 
 /* quirks to control the device */
 #define I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV	BIT(0)
@@ -663,6 +664,7 @@ static int i2c_hid_parse(struct hid_device *hid)
 	char *rdesc;
 	int ret;
 	int tries = 3;
+	char *use_override;
 
 	i2c_hid_dbg(ihid, "entering %s\n", __func__);
 
@@ -681,26 +683,37 @@ static int i2c_hid_parse(struct hid_device *hid)
 	if (ret)
 		return ret;
 
-	rdesc = kzalloc(rsize, GFP_KERNEL);
+	use_override = i2c_hid_get_dmi_hid_report_desc_override(client->name,
+								&rsize);
 
-	if (!rdesc) {
-		dbg_hid("couldn't allocate rdesc memory\n");
-		return -ENOMEM;
-	}
+	if (use_override) {
+		rdesc = use_override;
+		i2c_hid_dbg(ihid, "Using a HID report descriptor override\n");
+	} else {
+		rdesc = kzalloc(rsize, GFP_KERNEL);
 
-	i2c_hid_dbg(ihid, "asking HID report descriptor\n");
+		if (!rdesc) {
+			dbg_hid("couldn't allocate rdesc memory\n");
+			return -ENOMEM;
+		}
 
-	ret = i2c_hid_command(client, &hid_report_descr_cmd, rdesc, rsize);
-	if (ret) {
-		hid_err(hid, "reading report descriptor failed\n");
-		kfree(rdesc);
-		return -EIO;
+		i2c_hid_dbg(ihid, "asking HID report descriptor\n");
+
+		ret = i2c_hid_command(client, &hid_report_descr_cmd,
+				      rdesc, rsize);
+		if (ret) {
+			hid_err(hid, "reading report descriptor failed\n");
+			kfree(rdesc);
+			return -EIO;
+		}
 	}
 
 	i2c_hid_dbg(ihid, "Report Descriptor: %*ph\n", rsize, rdesc);
 
 	ret = hid_parse_report(hid, rdesc, rsize);
-	kfree(rdesc);
+	if (!use_override)
+		kfree(rdesc);
+
 	if (ret) {
 		dbg_hid("parsing report descriptor failed\n");
 		return ret;
@@ -827,12 +840,19 @@ static int i2c_hid_fetch_hid_descriptor(struct i2c_hid *ihid)
 	int ret;
 
 	/* i2c hid fetch using a fixed descriptor size (30 bytes) */
-	i2c_hid_dbg(ihid, "Fetching the HID descriptor\n");
-	ret = i2c_hid_command(client, &hid_descr_cmd, ihid->hdesc_buffer,
-				sizeof(struct i2c_hid_desc));
-	if (ret) {
-		dev_err(&client->dev, "hid_descr_cmd failed\n");
-		return -ENODEV;
+	if (i2c_hid_get_dmi_i2c_hid_desc_override(client->name)) {
+		i2c_hid_dbg(ihid, "Using a HID descriptor override\n");
+		ihid->hdesc =
+			*i2c_hid_get_dmi_i2c_hid_desc_override(client->name);
+	} else {
+		i2c_hid_dbg(ihid, "Fetching the HID descriptor\n");
+		ret = i2c_hid_command(client, &hid_descr_cmd,
+				      ihid->hdesc_buffer,
+				      sizeof(struct i2c_hid_desc));
+		if (ret) {
+			dev_err(&client->dev, "hid_descr_cmd failed\n");
+			return -ENODEV;
+		}
 	}
 
 	/* Validate the length of HID descriptor, the 4 first bytes:
diff --git a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
new file mode 100644
index 000000000000..1d645c9ab417
--- /dev/null
+++ b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
@@ -0,0 +1,376 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Quirks for I2C-HID devices that do not supply proper descriptors
+ *
+ * Copyright (c) 2018 Julian Sax <jsbc@gmx.de>
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/dmi.h>
+#include <linux/mod_devicetable.h>
+
+#include "i2c-hid.h"
+
+
+struct i2c_hid_desc_override {
+	union {
+		struct i2c_hid_desc *i2c_hid_desc;
+		uint8_t             *i2c_hid_desc_buffer;
+	};
+	uint8_t              *hid_report_desc;
+	unsigned int          hid_report_desc_size;
+	uint8_t              *i2c_name;
+};
+
+
+/*
+ * descriptors for the SIPODEV SP1064 touchpad
+ *
+ * This device does not supply any descriptors and on windows a filter
+ * driver operates between the i2c-hid layer and the device and injects
+ * these descriptors when the device is prompted. The descriptors were
+ * extracted by listening to the i2c-hid traffic that occurs between the
+ * windows filter driver and the windows i2c-hid driver.
+ */
+
+static const struct i2c_hid_desc_override sipodev_desc = {
+	.i2c_hid_desc_buffer = (uint8_t [])
+	{0x1e, 0x00,                  /* Length of descriptor                 */
+	 0x00, 0x01,                  /* Version of descriptor                */
+	 0xdb, 0x01,                  /* Length of report descriptor          */
+	 0x21, 0x00,                  /* Location of report descriptor        */
+	 0x24, 0x00,                  /* Location of input report             */
+	 0x1b, 0x00,                  /* Max input report length              */
+	 0x25, 0x00,                  /* Location of output report            */
+	 0x11, 0x00,                  /* Max output report length             */
+	 0x22, 0x00,                  /* Location of command register         */
+	 0x23, 0x00,                  /* Location of data register            */
+	 0x11, 0x09,                  /* Vendor ID                            */
+	 0x88, 0x52,                  /* Product ID                           */
+	 0x06, 0x00,                  /* Version ID                           */
+	 0x00, 0x00, 0x00, 0x00       /* Reserved                             */
+	},
+
+	.hid_report_desc = (uint8_t [])
+	{0x05, 0x01,                  /* Usage Page (Desktop),                */
+	 0x09, 0x02,                  /* Usage (Mouse),                       */
+	 0xA1, 0x01,                  /* Collection (Application),            */
+	 0x85, 0x01,                  /*     Report ID (1),                   */
+	 0x09, 0x01,                  /*     Usage (Pointer),                 */
+	 0xA1, 0x00,                  /*     Collection (Physical),           */
+	 0x05, 0x09,                  /*         Usage Page (Button),         */
+	 0x19, 0x01,                  /*         Usage Minimum (01h),         */
+	 0x29, 0x02,                  /*         Usage Maximum (02h),         */
+	 0x25, 0x01,                  /*         Logical Maximum (1),         */
+	 0x75, 0x01,                  /*         Report Size (1),             */
+	 0x95, 0x02,                  /*         Report Count (2),            */
+	 0x81, 0x02,                  /*         Input (Variable),            */
+	 0x95, 0x06,                  /*         Report Count (6),            */
+	 0x81, 0x01,                  /*         Input (Constant),            */
+	 0x05, 0x01,                  /*         Usage Page (Desktop),        */
+	 0x09, 0x30,                  /*         Usage (X),                   */
+	 0x09, 0x31,                  /*         Usage (Y),                   */
+	 0x15, 0x81,                  /*         Logical Minimum (-127),      */
+	 0x25, 0x7F,                  /*         Logical Maximum (127),       */
+	 0x75, 0x08,                  /*         Report Size (8),             */
+	 0x95, 0x02,                  /*         Report Count (2),            */
+	 0x81, 0x06,                  /*         Input (Variable, Relative),  */
+	 0xC0,                        /*     End Collection,                  */
+	 0xC0,                        /* End Collection,                      */
+	 0x05, 0x0D,                  /* Usage Page (Digitizer),              */
+	 0x09, 0x05,                  /* Usage (Touchpad),                    */
+	 0xA1, 0x01,                  /* Collection (Application),            */
+	 0x85, 0x04,                  /*     Report ID (4),                   */
+	 0x05, 0x0D,                  /*     Usage Page (Digitizer),          */
+	 0x09, 0x22,                  /*     Usage (Finger),                  */
+	 0xA1, 0x02,                  /*     Collection (Logical),            */
+	 0x15, 0x00,                  /*         Logical Minimum (0),         */
+	 0x25, 0x01,                  /*         Logical Maximum (1),         */
+	 0x09, 0x47,                  /*         Usage (Touch Valid),         */
+	 0x09, 0x42,                  /*         Usage (Tip Switch),          */
+	 0x95, 0x02,                  /*         Report Count (2),            */
+	 0x75, 0x01,                  /*         Report Size (1),             */
+	 0x81, 0x02,                  /*         Input (Variable),            */
+	 0x95, 0x01,                  /*         Report Count (1),            */
+	 0x75, 0x03,                  /*         Report Size (3),             */
+	 0x25, 0x05,                  /*         Logical Maximum (5),         */
+	 0x09, 0x51,                  /*         Usage (Contact Identifier),  */
+	 0x81, 0x02,                  /*         Input (Variable),            */
+	 0x75, 0x01,                  /*         Report Size (1),             */
+	 0x95, 0x03,                  /*         Report Count (3),            */
+	 0x81, 0x03,                  /*         Input (Constant, Variable),  */
+	 0x05, 0x01,                  /*         Usage Page (Desktop),        */
+	 0x26, 0x44, 0x0A,            /*         Logical Maximum (2628),      */
+	 0x75, 0x10,                  /*         Report Size (16),            */
+	 0x55, 0x0E,                  /*         Unit Exponent (14),          */
+	 0x65, 0x11,                  /*         Unit (Centimeter),           */
+	 0x09, 0x30,                  /*         Usage (X),                   */
+	 0x46, 0x1A, 0x04,            /*         Physical Maximum (1050),     */
+	 0x95, 0x01,                  /*         Report Count (1),            */
+	 0x81, 0x02,                  /*         Input (Variable),            */
+	 0x46, 0xBC, 0x02,            /*         Physical Maximum (700),      */
+	 0x26, 0x34, 0x05,            /*         Logical Maximum (1332),      */
+	 0x09, 0x31,                  /*         Usage (Y),                   */
+	 0x81, 0x02,                  /*         Input (Variable),            */
+	 0xC0,                        /*     End Collection,                  */
+	 0x05, 0x0D,                  /*     Usage Page (Digitizer),          */
+	 0x09, 0x22,                  /*     Usage (Finger),                  */
+	 0xA1, 0x02,                  /*     Collection (Logical),            */
+	 0x25, 0x01,                  /*         Logical Maximum (1),         */
+	 0x09, 0x47,                  /*         Usage (Touch Valid),         */
+	 0x09, 0x42,                  /*         Usage (Tip Switch),          */
+	 0x95, 0x02,                  /*         Report Count (2),            */
+	 0x75, 0x01,                  /*         Report Size (1),             */
+	 0x81, 0x02,                  /*         Input (Variable),            */
+	 0x95, 0x01,                  /*         Report Count (1),            */
+	 0x75, 0x03,                  /*         Report Size (3),             */
+	 0x25, 0x05,                  /*         Logical Maximum (5),         */
+	 0x09, 0x51,                  /*         Usage (Contact Identifier),  */
+	 0x81, 0x02,                  /*         Input (Variable),            */
+	 0x75, 0x01,                  /*         Report Size (1),             */
+	 0x95, 0x03,                  /*         Report Count (3),            */
+	 0x81, 0x03,                  /*         Input (Constant, Variable),  */
+	 0x05, 0x01,                  /*         Usage Page (Desktop),        */
+	 0x26, 0x44, 0x0A,            /*         Logical Maximum (2628),      */
+	 0x75, 0x10,                  /*         Report Size (16),            */
+	 0x09, 0x30,                  /*         Usage (X),                   */
+	 0x46, 0x1A, 0x04,            /*         Physical Maximum (1050),     */
+	 0x95, 0x01,                  /*         Report Count (1),            */
+	 0x81, 0x02,                  /*         Input (Variable),            */
+	 0x46, 0xBC, 0x02,            /*         Physical Maximum (700),      */
+	 0x26, 0x34, 0x05,            /*         Logical Maximum (1332),      */
+	 0x09, 0x31,                  /*         Usage (Y),                   */
+	 0x81, 0x02,                  /*         Input (Variable),            */
+	 0xC0,                        /*     End Collection,                  */
+	 0x05, 0x0D,                  /*     Usage Page (Digitizer),          */
+	 0x09, 0x22,                  /*     Usage (Finger),                  */
+	 0xA1, 0x02,                  /*     Collection (Logical),            */
+	 0x25, 0x01,                  /*         Logical Maximum (1),         */
+	 0x09, 0x47,                  /*         Usage (Touch Valid),         */
+	 0x09, 0x42,                  /*         Usage (Tip Switch),          */
+	 0x95, 0x02,                  /*         Report Count (2),            */
+	 0x75, 0x01,                  /*         Report Size (1),             */
+	 0x81, 0x02,                  /*         Input (Variable),            */
+	 0x95, 0x01,                  /*         Report Count (1),            */
+	 0x75, 0x03,                  /*         Report Size (3),             */
+	 0x25, 0x05,                  /*         Logical Maximum (5),         */
+	 0x09, 0x51,                  /*         Usage (Contact Identifier),  */
+	 0x81, 0x02,                  /*         Input (Variable),            */
+	 0x75, 0x01,                  /*         Report Size (1),             */
+	 0x95, 0x03,                  /*         Report Count (3),            */
+	 0x81, 0x03,                  /*         Input (Constant, Variable),  */
+	 0x05, 0x01,                  /*         Usage Page (Desktop),        */
+	 0x26, 0x44, 0x0A,            /*         Logical Maximum (2628),      */
+	 0x75, 0x10,                  /*         Report Size (16),            */
+	 0x09, 0x30,                  /*         Usage (X),                   */
+	 0x46, 0x1A, 0x04,            /*         Physical Maximum (1050),     */
+	 0x95, 0x01,                  /*         Report Count (1),            */
+	 0x81, 0x02,                  /*         Input (Variable),            */
+	 0x46, 0xBC, 0x02,            /*         Physical Maximum (700),      */
+	 0x26, 0x34, 0x05,            /*         Logical Maximum (1332),      */
+	 0x09, 0x31,                  /*         Usage (Y),                   */
+	 0x81, 0x02,                  /*         Input (Variable),            */
+	 0xC0,                        /*     End Collection,                  */
+	 0x05, 0x0D,                  /*     Usage Page (Digitizer),          */
+	 0x09, 0x22,                  /*     Usage (Finger),                  */
+	 0xA1, 0x02,                  /*     Collection (Logical),            */
+	 0x25, 0x01,                  /*         Logical Maximum (1),         */
+	 0x09, 0x47,                  /*         Usage (Touch Valid),         */
+	 0x09, 0x42,                  /*         Usage (Tip Switch),          */
+	 0x95, 0x02,                  /*         Report Count (2),            */
+	 0x75, 0x01,                  /*         Report Size (1),             */
+	 0x81, 0x02,                  /*         Input (Variable),            */
+	 0x95, 0x01,                  /*         Report Count (1),            */
+	 0x75, 0x03,                  /*         Report Size (3),             */
+	 0x25, 0x05,                  /*         Logical Maximum (5),         */
+	 0x09, 0x51,                  /*         Usage (Contact Identifier),  */
+	 0x81, 0x02,                  /*         Input (Variable),            */
+	 0x75, 0x01,                  /*         Report Size (1),             */
+	 0x95, 0x03,                  /*         Report Count (3),            */
+	 0x81, 0x03,                  /*         Input (Constant, Variable),  */
+	 0x05, 0x01,                  /*         Usage Page (Desktop),        */
+	 0x26, 0x44, 0x0A,            /*         Logical Maximum (2628),      */
+	 0x75, 0x10,                  /*         Report Size (16),            */
+	 0x09, 0x30,                  /*         Usage (X),                   */
+	 0x46, 0x1A, 0x04,            /*         Physical Maximum (1050),     */
+	 0x95, 0x01,                  /*         Report Count (1),            */
+	 0x81, 0x02,                  /*         Input (Variable),            */
+	 0x46, 0xBC, 0x02,            /*         Physical Maximum (700),      */
+	 0x26, 0x34, 0x05,            /*         Logical Maximum (1332),      */
+	 0x09, 0x31,                  /*         Usage (Y),                   */
+	 0x81, 0x02,                  /*         Input (Variable),            */
+	 0xC0,                        /*     End Collection,                  */
+	 0x05, 0x0D,                  /*     Usage Page (Digitizer),          */
+	 0x55, 0x0C,                  /*     Unit Exponent (12),              */
+	 0x66, 0x01, 0x10,            /*     Unit (Seconds),                  */
+	 0x47, 0xFF, 0xFF, 0x00, 0x00,/*     Physical Maximum (65535),        */
+	 0x27, 0xFF, 0xFF, 0x00, 0x00,/*     Logical Maximum (65535),         */
+	 0x75, 0x10,                  /*     Report Size (16),                */
+	 0x95, 0x01,                  /*     Report Count (1),                */
+	 0x09, 0x56,                  /*     Usage (Scan Time),               */
+	 0x81, 0x02,                  /*     Input (Variable),                */
+	 0x09, 0x54,                  /*     Usage (Contact Count),           */
+	 0x25, 0x7F,                  /*     Logical Maximum (127),           */
+	 0x75, 0x08,                  /*     Report Size (8),                 */
+	 0x81, 0x02,                  /*     Input (Variable),                */
+	 0x05, 0x09,                  /*     Usage Page (Button),             */
+	 0x09, 0x01,                  /*     Usage (01h),                     */
+	 0x25, 0x01,                  /*     Logical Maximum (1),             */
+	 0x75, 0x01,                  /*     Report Size (1),                 */
+	 0x95, 0x01,                  /*     Report Count (1),                */
+	 0x81, 0x02,                  /*     Input (Variable),                */
+	 0x95, 0x07,                  /*     Report Count (7),                */
+	 0x81, 0x03,                  /*     Input (Constant, Variable),      */
+	 0x05, 0x0D,                  /*     Usage Page (Digitizer),          */
+	 0x85, 0x02,                  /*     Report ID (2),                   */
+	 0x09, 0x55,                  /*     Usage (Contact Count Maximum),   */
+	 0x09, 0x59,                  /*     Usage (59h),                     */
+	 0x75, 0x04,                  /*     Report Size (4),                 */
+	 0x95, 0x02,                  /*     Report Count (2),                */
+	 0x25, 0x0F,                  /*     Logical Maximum (15),            */
+	 0xB1, 0x02,                  /*     Feature (Variable),              */
+	 0x05, 0x0D,                  /*     Usage Page (Digitizer),          */
+	 0x85, 0x07,                  /*     Report ID (7),                   */
+	 0x09, 0x60,                  /*     Usage (60h),                     */
+	 0x75, 0x01,                  /*     Report Size (1),                 */
+	 0x95, 0x01,                  /*     Report Count (1),                */
+	 0x25, 0x01,                  /*     Logical Maximum (1),             */
+	 0xB1, 0x02,                  /*     Feature (Variable),              */
+	 0x95, 0x07,                  /*     Report Count (7),                */
+	 0xB1, 0x03,                  /*     Feature (Constant, Variable),    */
+	 0x85, 0x06,                  /*     Report ID (6),                   */
+	 0x06, 0x00, 0xFF,            /*     Usage Page (FF00h),              */
+	 0x09, 0xC5,                  /*     Usage (C5h),                     */
+	 0x26, 0xFF, 0x00,            /*     Logical Maximum (255),           */
+	 0x75, 0x08,                  /*     Report Size (8),                 */
+	 0x96, 0x00, 0x01,            /*     Report Count (256),              */
+	 0xB1, 0x02,                  /*     Feature (Variable),              */
+	 0xC0,                        /* End Collection,                      */
+	 0x06, 0x00, 0xFF,            /* Usage Page (FF00h),                  */
+	 0x09, 0x01,                  /* Usage (01h),                         */
+	 0xA1, 0x01,                  /* Collection (Application),            */
+	 0x85, 0x0D,                  /*     Report ID (13),                  */
+	 0x26, 0xFF, 0x00,            /*     Logical Maximum (255),           */
+	 0x19, 0x01,                  /*     Usage Minimum (01h),             */
+	 0x29, 0x02,                  /*     Usage Maximum (02h),             */
+	 0x75, 0x08,                  /*     Report Size (8),                 */
+	 0x95, 0x02,                  /*     Report Count (2),                */
+	 0xB1, 0x02,                  /*     Feature (Variable),              */
+	 0xC0,                        /* End Collection,                      */
+	 0x05, 0x0D,                  /* Usage Page (Digitizer),              */
+	 0x09, 0x0E,                  /* Usage (Configuration),               */
+	 0xA1, 0x01,                  /* Collection (Application),            */
+	 0x85, 0x03,                  /*     Report ID (3),                   */
+	 0x09, 0x22,                  /*     Usage (Finger),                  */
+	 0xA1, 0x02,                  /*     Collection (Logical),            */
+	 0x09, 0x52,                  /*         Usage (Device Mode),         */
+	 0x25, 0x0A,                  /*         Logical Maximum (10),        */
+	 0x95, 0x01,                  /*         Report Count (1),            */
+	 0xB1, 0x02,                  /*         Feature (Variable),          */
+	 0xC0,                        /*     End Collection,                  */
+	 0x09, 0x22,                  /*     Usage (Finger),                  */
+	 0xA1, 0x00,                  /*     Collection (Physical),           */
+	 0x85, 0x05,                  /*         Report ID (5),               */
+	 0x09, 0x57,                  /*         Usage (57h),                 */
+	 0x09, 0x58,                  /*         Usage (58h),                 */
+	 0x75, 0x01,                  /*         Report Size (1),             */
+	 0x95, 0x02,                  /*         Report Count (2),            */
+	 0x25, 0x01,                  /*         Logical Maximum (1),         */
+	 0xB1, 0x02,                  /*         Feature (Variable),          */
+	 0x95, 0x06,                  /*         Report Count (6),            */
+	 0xB1, 0x03,                  /*         Feature (Constant, Variable),*/
+	 0xC0,                        /*     End Collection,                  */
+	 0xC0                         /* End Collection                       */
+	},
+	.hid_report_desc_size = 475,
+	.i2c_name = "SYNA3602:00"
+};
+
+
+static const struct dmi_system_id i2c_hid_dmi_desc_override_table[] = {
+	{
+		.ident = "Teclast F6 Pro",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "TECLAST"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "F6 Pro"),
+		},
+		.driver_data = (void *)&sipodev_desc
+	},
+	{
+		.ident = "Teclast F7",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "TECLAST"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "F7"),
+		},
+		.driver_data = (void *)&sipodev_desc
+	},
+	{
+		.ident = "Trekstor Primebook C13",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "TREKSTOR"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Primebook C13"),
+		},
+		.driver_data = (void *)&sipodev_desc
+	},
+	{
+		.ident = "Trekstor Primebook C11",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "TREKSTOR"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Primebook C11"),
+		},
+		.driver_data = (void *)&sipodev_desc
+	},
+	{
+		.ident = "Direkt-Tek DTLAPY116-2",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Direkt-Tek"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "DTLAPY116-2"),
+		},
+		.driver_data = (void *)&sipodev_desc
+	},
+	{
+		.ident = "Mediacom Flexbook Edge 11",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "MEDIACOM"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "FlexBook edge11 - M-FBE11"),
+		},
+		.driver_data = (void *)&sipodev_desc
+	}
+};
+
+
+struct i2c_hid_desc *i2c_hid_get_dmi_i2c_hid_desc_override(uint8_t *i2c_name)
+{
+	struct i2c_hid_desc_override *override;
+	const struct dmi_system_id *system_id;
+
+	system_id = dmi_first_match(i2c_hid_dmi_desc_override_table);
+	if (!system_id)
+		return NULL;
+
+	override = system_id->driver_data;
+	if (strcmp(override->i2c_name, i2c_name))
+		return NULL;
+
+	return override->i2c_hid_desc;
+}
+
+char *i2c_hid_get_dmi_hid_report_desc_override(uint8_t *i2c_name,
+					       unsigned int *size)
+{
+	struct i2c_hid_desc_override *override;
+	const struct dmi_system_id *system_id;
+
+	system_id = dmi_first_match(i2c_hid_dmi_desc_override_table);
+	if (!system_id)
+		return NULL;
+
+	override = system_id->driver_data;
+	if (strcmp(override->i2c_name, i2c_name))
+		return NULL;
+
+	*size = override->hid_report_desc_size;
+	return override->hid_report_desc;
+}
diff --git a/drivers/hid/i2c-hid/i2c-hid.h b/drivers/hid/i2c-hid/i2c-hid.h
new file mode 100644
index 000000000000..a8c19aef5824
--- /dev/null
+++ b/drivers/hid/i2c-hid/i2c-hid.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef I2C_HID_H
+#define I2C_HID_H
+
+
+#ifdef CONFIG_DMI
+struct i2c_hid_desc *i2c_hid_get_dmi_i2c_hid_desc_override(uint8_t *i2c_name);
+char *i2c_hid_get_dmi_hid_report_desc_override(uint8_t *i2c_name,
+					       unsigned int *size);
+#else
+static inline struct i2c_hid_desc
+		   *i2c_hid_get_dmi_i2c_hid_desc_override(uint8_t *i2c_name)
+{ return NULL; }
+static inline char *i2c_hid_get_dmi_hid_report_desc_override(uint8_t *i2c_name,
+							     unsigned int *size)
+{ return NULL; }
+#endif
+
+#endif
-- 
2.19.1

