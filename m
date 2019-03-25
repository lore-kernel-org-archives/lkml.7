Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E95C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFA82083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbfCYPMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:12:16 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:34328 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfCYPMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 11:12:14 -0400
Received: from [167.98.27.226] (helo=ct-lt-1124)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1h8RGl-0005oR-Ix; Mon, 25 Mar 2019 15:12:11 +0000
Received: from tpreston by ct-lt-1124 with local (Exim 4.89)
        (envelope-from <tpreston@ct-lt-1124>)
        id 1h8RGl-00063K-3d; Mon, 25 Mar 2019 15:12:11 +0000
From:   Thomas Preston <thomas.preston@codethink.co.uk>
To:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        mika.westerberg@linux.intel.com
Cc:     Thomas Preston <thomas.preston@codethink.co.uk>
Subject: [PATCH v2] Documentation: acpi: Add an example for PRP0001
Date:   Mon, 25 Mar 2019 15:12:10 +0000
Message-Id: <20190325151210.23226-1-thomas.preston@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an example for the magic PRP0001 device ID which allows matching
ACPI devices against drivers using OF Device Tree compatible property.
It wasn't clear to me that PRP0001 could be used in _CID.

Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
---
 Documentation/acpi/enumeration.txt | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/acpi/enumeration.txt b/Documentation/acpi/enumeration.txt
index 7bcf9c3d9fbe..8375fc506b47 100644
--- a/Documentation/acpi/enumeration.txt
+++ b/Documentation/acpi/enumeration.txt
@@ -410,6 +410,37 @@ Specifically, the device IDs returned by _HID and preceding PRP0001 in the _CID
 return package will be checked first.  Also in that case the bus type the device
 will be enumerated to depends on the device ID returned by _HID.
 
+For example, the following ACPI sample might be used to enumerate an lm75-type
+I2C temperature sensor and match it to the driver using the Device Tree
+namespace link:
+
+	Device (TMP0)
+	{
+		/* _HID will appear in sysfs */
+		Name (_HID, "PRP0001")
+
+		/* _CID can also be used to search for "compatible" property */
+		Name (_CID, "PRP0001")
+
+		Name (_DSD, Package() {
+			ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+			Package () {
+				Package (2) { "compatible", "ti,tmp75" },
+			}
+		})
+		Method (_CRS, 0, Serialized)
+		{
+			Name (SBUF, ResourceTemplate ()
+			{
+				I2cSerialBusV2 (0x48, ControllerInitiated,
+					400000, AddressingMode7Bit,
+					"\\_SB.PCI0.I2C1", 0x00,
+					ResourceConsumer, , Exclusive,)
+			})
+			Return (SBUF)
+		}
+	}
+
 It is valid to define device objects with a _HID returning PRP0001 and without
 the "compatible" property in the _DSD or a _CID as long as one of their
 ancestors provides a _DSD with a valid "compatible" property.  Such device
-- 
2.11.0

