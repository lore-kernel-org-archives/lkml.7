Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40505C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12DC627FE0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfFCJYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:24:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:54536 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727985AbfFCJYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:24:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 02:24:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,546,1549958400"; 
   d="scan'208";a="181096329"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jun 2019 02:24:09 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [char-misc-next 1/7] mei: docs: move documentation under driver-api
Date:   Mon,  3 Jun 2019 12:14:00 +0300
Message-Id: <20190603091406.28915-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190603091406.28915-1-tomas.winkler@intel.com>
References: <20190603091406.28915-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move mei driver documentation under Documentation/driver-api/
Perform some minimal formating changes to produce correct sphinx rendering
and add index.rst

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 Documentation/driver-api/index.rst            |   1 +
 Documentation/driver-api/mei/index.rst        |  22 +++
 .../mei/mei-client-bus.rst}                   | 135 ++++++++++--------
 .../mei/mei.txt => driver-api/mei/mei.rst}    |  30 +---
 MAINTAINERS                                   |   2 +-
 5 files changed, 104 insertions(+), 86 deletions(-)
 create mode 100644 Documentation/driver-api/mei/index.rst
 rename Documentation/{misc-devices/mei/mei-client-bus.txt => driver-api/mei/mei-client-bus.rst} (54%)
 rename Documentation/{misc-devices/mei/mei.txt => driver-api/mei/mei.rst} (94%)

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index d26308af6036..0dbaa987aa11 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -42,6 +42,7 @@ available subsections can be seen below.
    target
    mtdnand
    miscellaneous
+   mei/index
    w1
    rapidio
    s390-drivers
diff --git a/Documentation/driver-api/mei/index.rst b/Documentation/driver-api/mei/index.rst
new file mode 100644
index 000000000000..35c1117d8366
--- /dev/null
+++ b/Documentation/driver-api/mei/index.rst
@@ -0,0 +1,22 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: <isonum.txt>
+
+===================================================
+Intel(R) Management Engine Interface (Intel(R) MEI)
+===================================================
+
+**Copyright** |copy| 2019 Intel Corporation
+
+
+.. only:: html
+
+   .. class:: toc-title
+
+        Table of Contents
+
+.. toctree::
+   :maxdepth: 2
+
+   mei
+   mei-client-bus
diff --git a/Documentation/misc-devices/mei/mei-client-bus.txt b/Documentation/driver-api/mei/mei-client-bus.rst
similarity index 54%
rename from Documentation/misc-devices/mei/mei-client-bus.txt
rename to Documentation/driver-api/mei/mei-client-bus.rst
index 743be4ec8989..a26a85453bdf 100644
--- a/Documentation/misc-devices/mei/mei-client-bus.txt
+++ b/Documentation/driver-api/mei/mei-client-bus.rst
@@ -1,3 +1,6 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================================
 Intel(R) Management Engine (ME) Client bus API
 ==============================================
 
@@ -22,22 +25,24 @@ MEI CL bus API
 
 A driver implementation for an MEI Client is very similar to existing bus
 based device drivers. The driver registers itself as an MEI CL bus driver through
-the mei_cl_driver structure:
+the ``struct mei_cl_driver`` structure:
+
+.. code-block:: C
 
-struct mei_cl_driver {
-	struct device_driver driver;
-	const char *name;
+        struct mei_cl_driver {
+                struct device_driver driver;
+                const char *name;
 
-	const struct mei_cl_device_id *id_table;
+                const struct mei_cl_device_id *id_table;
 
-	int (*probe)(struct mei_cl_device *dev, const struct mei_cl_id *id);
-	int (*remove)(struct mei_cl_device *dev);
-};
+                int (*probe)(struct mei_cl_device *dev, const struct mei_cl_id *id);
+                int (*remove)(struct mei_cl_device *dev);
+        };
 
-struct mei_cl_id {
-	char name[MEI_NAME_SIZE];
-	kernel_ulong_t driver_info;
-};
+        struct mei_cl_id {
+                char name[MEI_NAME_SIZE];
+                kernel_ulong_t driver_info;
+        };
 
 The mei_cl_id structure allows the driver to bind itself against a device name.
 
@@ -61,58 +66,62 @@ Example
 As a theoretical example let's pretend the ME comes with a "contact" NFC IP.
 The driver init and exit routines for this device would look like:
 
-#define CONTACT_DRIVER_NAME "contact"
+.. code-block:: C
 
-static struct mei_cl_device_id contact_mei_cl_tbl[] = {
-	{ CONTACT_DRIVER_NAME, },
+	#define CONTACT_DRIVER_NAME "contact"
 
-	/* required last entry */
-	{ }
-};
-MODULE_DEVICE_TABLE(mei_cl, contact_mei_cl_tbl);
+	static struct mei_cl_device_id contact_mei_cl_tbl[] = {
+		{ CONTACT_DRIVER_NAME, },
 
-static struct mei_cl_driver contact_driver = {
-	.id_table = contact_mei_tbl,
-	.name = CONTACT_DRIVER_NAME,
+		/* required last entry */
+		{ }
+	};
+	MODULE_DEVICE_TABLE(mei_cl, contact_mei_cl_tbl);
 
-	.probe = contact_probe,
-	.remove = contact_remove,
-};
+	static struct mei_cl_driver contact_driver = {
+		.id_table = contact_mei_tbl,
+		.name = CONTACT_DRIVER_NAME,
 
-static int contact_init(void)
-{
-	int r;
+		.probe = contact_probe,
+		.remove = contact_remove,
+	};
 
-	r = mei_cl_driver_register(&contact_driver);
-	if (r) {
-		pr_err(CONTACT_DRIVER_NAME ": driver registration failed\n");
-		return r;
-	}
+	static int contact_init(void)
+	{
+		int r;
+
+		r = mei_cl_driver_register(&contact_driver);
+		if (r) {
+			pr_err(CONTACT_DRIVER_NAME ": driver registration failed\n");
+			return r;
+		}
 
-	return 0;
-}
+		return 0;
+	}
 
-static void __exit contact_exit(void)
-{
-	mei_cl_driver_unregister(&contact_driver);
-}
+	static void __exit contact_exit(void)
+	{
+		mei_cl_driver_unregister(&contact_driver);
+	}
 
-module_init(contact_init);
-module_exit(contact_exit);
+	module_init(contact_init);
+	module_exit(contact_exit);
 
 And the driver's simplified probe routine would look like that:
 
-int contact_probe(struct mei_cl_device *dev, struct mei_cl_device_id *id)
-{
-	struct contact_driver *contact;
+.. code-block:: C
 
-	[...]
-	mei_cl_enable_device(dev);
+	int contact_probe(struct mei_cl_device *dev, struct mei_cl_device_id *id)
+	{
+		struct contact_driver *contact;
 
-	mei_cl_register_event_cb(dev, contact_event_cb, contact);
+		[...]
+		mei_cl_enable_device(dev);
 
-	return 0;
-}
+		mei_cl_register_event_cb(dev, contact_event_cb, contact);
+
+		return 0;
+	}
 
 In the probe routine the driver first enable the MEI device and then registers
 an ME bus event handler which is as close as it can get to registering a
@@ -122,20 +131,22 @@ the pending events:
 
 #define MAX_NFC_PAYLOAD 128
 
-static void contact_event_cb(struct mei_cl_device *dev, u32 events,
-			     void *context)
-{
-	struct contact_driver *contact = context;
+.. code-block:: C
+
+	static void contact_event_cb(struct mei_cl_device *dev, u32 events,
+				     void *context)
+	{
+		struct contact_driver *contact = context;
 
-	if (events & BIT(MEI_EVENT_RX)) {
-		u8 payload[MAX_NFC_PAYLOAD];
-		int payload_size;
+		if (events & BIT(MEI_EVENT_RX)) {
+			u8 payload[MAX_NFC_PAYLOAD];
+			int payload_size;
 
-		payload_size = mei_recv(dev, payload, MAX_NFC_PAYLOAD);
-		if (payload_size <= 0)
-			return;
+			payload_size = mei_recv(dev, payload, MAX_NFC_PAYLOAD);
+			if (payload_size <= 0)
+				return;
 
-		/* Hook to the NFC subsystem */
-		nfc_hci_recv_frame(contact->hdev, payload, payload_size);
+			/* Hook to the NFC subsystem */
+			nfc_hci_recv_frame(contact->hdev, payload, payload_size);
+		}
 	}
-}
diff --git a/Documentation/misc-devices/mei/mei.txt b/Documentation/driver-api/mei/mei.rst
similarity index 94%
rename from Documentation/misc-devices/mei/mei.txt
rename to Documentation/driver-api/mei/mei.rst
index 2b80a0cd621f..5aa3a5e6496a 100644
--- a/Documentation/misc-devices/mei/mei.txt
+++ b/Documentation/driver-api/mei/mei.rst
@@ -1,5 +1,4 @@
-Intel(R) Management Engine Interface (Intel(R) MEI)
-===================================================
+.. SPDX-License-Identifier: GPL-2.0
 
 Introduction
 ============
@@ -70,6 +69,8 @@ user to access it.
 
 A code snippet for an application communicating with Intel AMTHI client:
 
+.. code-block:: C
+
 	struct mei_connect_client_data data;
 	fd = open(MEI_DEVICE);
 
@@ -93,8 +94,8 @@ A code snippet for an application communicating with Intel AMTHI client:
 	close(fd);
 
 
-IOCTL
-=====
+IOCTLs
+======
 
 The Intel MEI Driver supports the following IOCTL commands:
 	IOCTL_MEI_CONNECT_CLIENT	Connect to firmware Feature (client).
@@ -114,8 +115,7 @@ The Intel MEI Driver supports the following IOCTL commands:
 
 	error returns:
 		EINVAL	Wrong IOCTL Number
-		ENODEV	Device or Connection is not initialized or ready.
-			(e.g. Wrong UUID)
+		ENODEV	Device or Connection is not initialized or ready. (e.g. Wrong UUID)
 		ENOMEM	Unable to allocate memory to client internal data.
 		EFAULT	Fatal Error (e.g. Unable to access user input data)
 		EBUSY	Connection Already Open
@@ -241,26 +241,10 @@ watchdog is 120 seconds.
 If the Intel AMT is not enabled in the firmware then the watchdog client won't enumerate
 on the me client bus and watchdog devices won't be exposed.
 
-
 Supported Chipsets
 ==================
+82X38/X48 Express and newer
 
-7 Series Chipset Family
-6 Series Chipset Family
-5 Series Chipset Family
-4 Series Chipset Family
-Mobile 4 Series Chipset Family
-ICH9
-82946GZ/GL
-82G35 Express
-82Q963/Q965
-82P965/G965
-Mobile PM965/GM965
-Mobile GME965/GLE960
-82Q35 Express
-82G33/G31/P35/P31 Express
-82Q33 Express
-82X38/X48 Express
 
 ---
 linux-mei@linux.intel.com
diff --git a/MAINTAINERS b/MAINTAINERS
index 5cfbea4ce575..bfe48cbea84c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8021,7 +8021,7 @@ F:	include/uapi/linux/mei.h
 F:	include/linux/mei_cl_bus.h
 F:	drivers/misc/mei/*
 F:	drivers/watchdog/mei_wdt.c
-F:	Documentation/misc-devices/mei/*
+F:	Documentation/driver-api/mei/*
 F:	samples/mei/*
 
 INTEL MENLOW THERMAL DRIVER
-- 
2.20.1

