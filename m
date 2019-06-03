Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD10C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3AB27FE8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfFCJYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:24:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:54536 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728122AbfFCJYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:24:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 02:24:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,546,1549958400"; 
   d="scan'208";a="181096361"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jun 2019 02:24:16 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [char-misc-next 4/7] mei: docs: update mei client bus documentation.
Date:   Mon,  3 Jun 2019 12:14:03 +0300
Message-Id: <20190603091406.28915-5-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190603091406.28915-1-tomas.winkler@intel.com>
References: <20190603091406.28915-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mei client bus API has changed significantly from
time it was documented, and had required update.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 .../driver-api/mei/mei-client-bus.rst         | 162 +++++++++---------
 1 file changed, 85 insertions(+), 77 deletions(-)

diff --git a/Documentation/driver-api/mei/mei-client-bus.rst b/Documentation/driver-api/mei/mei-client-bus.rst
index a26a85453bdf..7310dd45c484 100644
--- a/Documentation/driver-api/mei/mei-client-bus.rst
+++ b/Documentation/driver-api/mei/mei-client-bus.rst
@@ -8,13 +8,13 @@ Intel(R) Management Engine (ME) Client bus API
 Rationale
 =========
 
-MEI misc character device is useful for dedicated applications to send and receive
+The MEI character device is useful for dedicated applications to send and receive
 data to the many FW appliance found in Intel's ME from the user space.
-However for some of the ME functionalities it make sense to leverage existing software
+However, for some of the ME functionalities it makes sense to leverage existing software
 stack and expose them through existing kernel subsystems.
 
 In order to plug seamlessly into the kernel device driver model we add kernel virtual
-bus abstraction on top of the MEI driver. This allows implementing linux kernel drivers
+bus abstraction on top of the MEI driver. This allows implementing Linux kernel drivers
 for the various MEI features as a stand alone entities found in their respective subsystem.
 Existing device drivers can even potentially be re-used by adding an MEI CL bus layer to
 the existing code.
@@ -23,9 +23,9 @@ the existing code.
 MEI CL bus API
 ==============
 
-A driver implementation for an MEI Client is very similar to existing bus
+A driver implementation for an MEI Client is very similar to any other existing bus
 based device drivers. The driver registers itself as an MEI CL bus driver through
-the ``struct mei_cl_driver`` structure:
+the ``struct mei_cl_driver`` structure defined in :file:`include/linux/mei_cl_bus.c`
 
 .. code-block:: C
 
@@ -39,25 +39,38 @@ the ``struct mei_cl_driver`` structure:
                 int (*remove)(struct mei_cl_device *dev);
         };
 
-        struct mei_cl_id {
-                char name[MEI_NAME_SIZE];
+
+
+The mei_cl_device_id structure defined in :file:`include/linux/mod_devicetable.h` allows a
+driver to bind itself against a device name.
+
+.. code-block:: C
+
+        struct mei_cl_device_id {
+                char name[MEI_CL_NAME_SIZE];
+                uuid_le uuid;
+                __u8    version;
                 kernel_ulong_t driver_info;
         };
 
-The mei_cl_id structure allows the driver to bind itself against a device name.
+To actually register a driver on the ME Client bus one must call the :c:func:`mei_cl_add_driver`
+API. This is typically called at module initialization time.
+
+Once the driver is registered and bound to the device, a driver will typically
+try to do some I/O on this bus and this should be done through the :c:func:`mei_cl_send`
+and :c:func:`mei_cl_recv` functions. More detailed information is in :ref:`api` section.
+
+In order for a driver to be notified about pending traffic or event, the driver
+should register a callback via :c:func:`mei_cl_devev_register_rx_cb` and
+:c:func:`mei_cldev_register_notify_cb` function respectively.
 
-To actually register a driver on the ME Client bus one must call the mei_cl_add_driver()
-API. This is typically called at module init time.
+.. _api:
+
+API:
+----
+.. kernel-doc:: drivers/misc/mei/bus.c
+    :export: drivers/misc/mei/bus.c
 
-Once registered on the ME Client bus, a driver will typically try to do some I/O on
-this bus and this should be done through the mei_cl_send() and mei_cl_recv()
-routines. The latter is synchronous (blocks and sleeps until data shows up).
-In order for drivers to be notified of pending events waiting for them (e.g.
-an Rx event) they can register an event handler through the
-mei_cl_register_event_cb() routine. Currently only the MEI_EVENT_RX event
-will trigger an event handler call and the driver implementation is supposed
-to call mei_recv() from the event handler in order to fetch the pending
-received buffers.
 
 
 Example
@@ -68,85 +81,80 @@ The driver init and exit routines for this device would look like:
 
 .. code-block:: C
 
-	#define CONTACT_DRIVER_NAME "contact"
+        #define CONTACT_DRIVER_NAME "contact"
 
-	static struct mei_cl_device_id contact_mei_cl_tbl[] = {
-		{ CONTACT_DRIVER_NAME, },
+        static struct mei_cl_device_id contact_mei_cl_tbl[] = {
+                { CONTACT_DRIVER_NAME, },
 
-		/* required last entry */
-		{ }
-	};
-	MODULE_DEVICE_TABLE(mei_cl, contact_mei_cl_tbl);
+                /* required last entry */
+                { }
+        };
+        MODULE_DEVICE_TABLE(mei_cl, contact_mei_cl_tbl);
 
-	static struct mei_cl_driver contact_driver = {
-		.id_table = contact_mei_tbl,
-		.name = CONTACT_DRIVER_NAME,
+        static struct mei_cl_driver contact_driver = {
+                .id_table = contact_mei_tbl,
+                .name = CONTACT_DRIVER_NAME,
 
-		.probe = contact_probe,
-		.remove = contact_remove,
-	};
+                .probe = contact_probe,
+                .remove = contact_remove,
+        };
 
-	static int contact_init(void)
-	{
-		int r;
+        static int contact_init(void)
+        {
+                int r;
 
-		r = mei_cl_driver_register(&contact_driver);
-		if (r) {
-			pr_err(CONTACT_DRIVER_NAME ": driver registration failed\n");
-			return r;
-		}
+                r = mei_cl_driver_register(&contact_driver);
+                if (r) {
+                        pr_err(CONTACT_DRIVER_NAME ": driver registration failed\n");
+                        return r;
+                }
 
-		return 0;
-	}
+                return 0;
+        }
 
-	static void __exit contact_exit(void)
-	{
-		mei_cl_driver_unregister(&contact_driver);
-	}
+        static void __exit contact_exit(void)
+        {
+                mei_cl_driver_unregister(&contact_driver);
+        }
 
-	module_init(contact_init);
-	module_exit(contact_exit);
+        module_init(contact_init);
+        module_exit(contact_exit);
 
 And the driver's simplified probe routine would look like that:
 
 .. code-block:: C
 
-	int contact_probe(struct mei_cl_device *dev, struct mei_cl_device_id *id)
-	{
-		struct contact_driver *contact;
+        int contact_probe(struct mei_cl_device *dev, struct mei_cl_device_id *id)
+        {
+                [...]
+                mei_cldev_enable(dev);
 
-		[...]
-		mei_cl_enable_device(dev);
+                mei_cldev_register_rx_cb(dev, contact_rx_cb);
 
-		mei_cl_register_event_cb(dev, contact_event_cb, contact);
-
-		return 0;
-	}
+                return 0;
+        }
 
 In the probe routine the driver first enable the MEI device and then registers
-an ME bus event handler which is as close as it can get to registering a
-threaded IRQ handler.
-The handler implementation will typically call some I/O routine depending on
-the pending events:
-
-#define MAX_NFC_PAYLOAD 128
+an rx handler which is as close as it can get to registering a threaded IRQ handler.
+The handler implementation will typically call :c:func:`mei_cldev_recv` and then
+process received data.
 
 .. code-block:: C
 
-	static void contact_event_cb(struct mei_cl_device *dev, u32 events,
-				     void *context)
-	{
-		struct contact_driver *contact = context;
+        #define MAX_PAYLOAD 128
+        #define HDR_SIZE 4
+        static void conntact_rx_cb(struct mei_cl_device *cldev)
+        {
+                struct contact *c = mei_cldev_get_drvdata(cldev);
+                unsigned char payload[MAX_PAYLOAD];
+                ssize_t payload_sz;
+
+                payload_sz = mei_cldev_recv(cldev, payload,  MAX_PAYLOAD)
+                if (reply_size < HDR_SIZE) {
+                        return;
+                }
 
-		if (events & BIT(MEI_EVENT_RX)) {
-			u8 payload[MAX_NFC_PAYLOAD];
-			int payload_size;
+                c->process_rx(payload);
 
-			payload_size = mei_recv(dev, payload, MAX_NFC_PAYLOAD);
-			if (payload_size <= 0)
-				return;
+        }
 
-			/* Hook to the NFC subsystem */
-			nfc_hci_recv_frame(contact->hdev, payload, payload_size);
-		}
-	}
-- 
2.20.1

