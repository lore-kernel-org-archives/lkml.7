Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BEBC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5BB27FE8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbfFCJYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:24:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:54536 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbfFCJYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:24:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 02:24:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,546,1549958400"; 
   d="scan'208";a="181096352"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jun 2019 02:24:14 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [char-misc-next 3/7] mei: docs: update mei documentation
Date:   Mon,  3 Jun 2019 12:14:02 +0300
Message-Id: <20190603091406.28915-4-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190603091406.28915-1-tomas.winkler@intel.com>
References: <20190603091406.28915-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mei driver went via multiple changes, update
the documentation and fix formatting.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 Documentation/driver-api/mei/mei.rst | 96 ++++++++++++++++++----------
 1 file changed, 61 insertions(+), 35 deletions(-)

diff --git a/Documentation/driver-api/mei/mei.rst b/Documentation/driver-api/mei/mei.rst
index c7f10a4b46ff..c800d8e5f422 100644
--- a/Documentation/driver-api/mei/mei.rst
+++ b/Documentation/driver-api/mei/mei.rst
@@ -5,34 +5,32 @@ Introduction
 
 The Intel Management Engine (Intel ME) is an isolated and protected computing
 resource (Co-processor) residing inside certain Intel chipsets. The Intel ME
-provides support for computer/IT management features. The feature set
-depends on the Intel chipset SKU.
+provides support for computer/IT management and security features.
+The actual feature set depends on the Intel chipset SKU.
 
 The Intel Management Engine Interface (Intel MEI, previously known as HECI)
 is the interface between the Host and Intel ME. This interface is exposed
-to the host as a PCI device. The Intel MEI Driver is in charge of the
-communication channel between a host application and the Intel ME feature.
+to the host as a PCI device, actually multiple PCI devices might be exposed.
+The Intel MEI Driver is in charge of the communication channel between
+a host application and the Intel ME features.
 
-Each Intel ME feature (Intel ME Client) is addressed by a GUID/UUID and
+Each Intel ME feature, or Intel ME Client is addressed by a unique GUID and
 each client has its own protocol. The protocol is message-based with a
-header and payload up to 512 bytes.
+header and payload up to maximal number of bytes advertised by the client,
+upon connection.
 
 Intel MEI Driver
 ================
 
-The driver exposes a misc device called /dev/mei.
+The driver exposes a character device with device nodes /dev/meiX.
 
 An application maintains communication with an Intel ME feature while
-/dev/mei is open. The binding to a specific feature is performed by calling
-MEI_CONNECT_CLIENT_IOCTL, which passes the desired UUID.
+/dev/meiX is open. The binding to a specific feature is performed by calling
+:c:macro:`MEI_CONNECT_CLIENT_IOCTL`, which passes the desired GUID.
 The number of instances of an Intel ME feature that can be opened
 at the same time depends on the Intel ME feature, but most of the
 features allow only a single instance.
 
-The Intel AMT Host Interface (Intel AMTHI) feature supports multiple
-simultaneous user connected applications. The Intel MEI driver
-handles this internally by maintaining request queues for the applications.
-
 The driver is transparent to data that are passed between firmware feature
 and host application.
 
@@ -40,6 +38,8 @@ Because some of the Intel ME features can change the system
 configuration, the driver by default allows only a privileged
 user to access it.
 
+The session is terminated calling :c:func:`close(int fd)`.
+
 A code snippet for an application communicating with Intel AMTHI client:
 
 .. code-block:: C
@@ -47,13 +47,13 @@ A code snippet for an application communicating with Intel AMTHI client:
 	struct mei_connect_client_data data;
 	fd = open(MEI_DEVICE);
 
-	data.d.in_client_uuid = AMTHI_UUID;
+	data.d.in_client_uuid = AMTHI_GUID;
 
 	ioctl(fd, IOCTL_MEI_CONNECT_CLIENT, &data);
 
 	printf("Ver=%d, MaxLen=%ld\n",
-			data.d.in_client_uuid.protocol_version,
-			data.d.in_client_uuid.max_msg_length);
+	       data.d.in_client_uuid.protocol_version,
+	       data.d.in_client_uuid.max_msg_length);
 
 	[...]
 
@@ -67,60 +67,86 @@ A code snippet for an application communicating with Intel AMTHI client:
 	close(fd);
 
 
-IOCTLs
-======
+User space API
+
+IOCTLs:
+=======
 
 The Intel MEI Driver supports the following IOCTL commands:
-	IOCTL_MEI_CONNECT_CLIENT	Connect to firmware Feature (client).
 
-	usage:
-		struct mei_connect_client_data clientData;
-		ioctl(fd, IOCTL_MEI_CONNECT_CLIENT, &clientData);
+IOCTL_MEI_CONNECT_CLIENT
+-------------------------
+Connect to firmware Feature/Client.
+
+.. code-block:: none
+
+	Usage:
 
-	inputs:
-		mei_connect_client_data struct contain the following
-		input field:
+        struct mei_connect_client_data client_data;
 
-		in_client_uuid -	UUID of the FW Feature that needs
+        ioctl(fd, IOCTL_MEI_CONNECT_CLIENT, &client_data);
+
+	Inputs:
+
+        struct mei_connect_client_data - contain the following
+	Input field:
+
+		in_client_uuid -	GUID of the FW Feature that needs
 					to connect to.
-	outputs:
+         Outputs:
 		out_client_properties - Client Properties: MTU and Protocol Version.
 
-	error returns:
+         Error returns:
+
+                ENOTTY  No such client (i.e. wrong GUID) or connection is not allowed.
 		EINVAL	Wrong IOCTL Number
-		ENODEV	Device or Connection is not initialized or ready. (e.g. Wrong UUID)
+		ENODEV	Device or Connection is not initialized or ready.
 		ENOMEM	Unable to allocate memory to client internal data.
 		EFAULT	Fatal Error (e.g. Unable to access user input data)
 		EBUSY	Connection Already Open
 
+:Note:
         max_msg_length (MTU) in client properties describes the maximum
         data that can be sent or received. (e.g. if MTU=2K, can send
         requests up to bytes 2k and received responses up to 2k bytes).
 
-	IOCTL_MEI_NOTIFY_SET: enable or disable event notifications
+
+IOCTL_MEI_NOTIFY_SET
+---------------------
+Enable or disable event notifications.
+
+
+.. code-block:: none
 
 	Usage:
+
 		uint32_t enable;
+
 		ioctl(fd, IOCTL_MEI_NOTIFY_SET, &enable);
 
-	Inputs:
+
 		uint32_t enable = 1;
 		or
 		uint32_t enable[disable] = 0;
 
 	Error returns:
+
+
 		EINVAL	Wrong IOCTL Number
 		ENODEV	Device  is not initialized or the client not connected
 		ENOMEM	Unable to allocate memory to client internal data.
 		EFAULT	Fatal Error (e.g. Unable to access user input data)
 		EOPNOTSUPP if the device doesn't support the feature
 
+:Note:
 	The client must be connected in order to enable notification events
 
 
-	IOCTL_MEI_NOTIFY_GET : retrieve event
+IOCTL_MEI_NOTIFY_GET
+--------------------
+Retrieve event
+
+.. code-block:: none
 
 	Usage:
 		uint32_t event;
@@ -137,7 +163,7 @@ The Intel MEI Driver supports the following IOCTL commands:
 		EFAULT	Fatal Error (e.g. Unable to access user input data)
 		EOPNOTSUPP if the device doesn't support the feature
 
+:Note:
 	The client must be connected and event notification has to be enabled
 	in order to receive an event
 
-- 
2.20.1

