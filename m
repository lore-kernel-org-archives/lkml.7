Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1E4C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 10:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67AF02086D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 10:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561804613;
	bh=WQISJOmbDdC9q8LZL61fY5BQ5stNZJg9kvf3XL54gkM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Mo/O7f9gtb/Ud89n8SXymPL+SAY7aJSS0c+/aZDGH/sB/hWSoIOe/rZEpsdJT+CtM
	 J//Yl+Tq1E7MV9zvFzC3B8dw7sX+r+mlPBM494U0++scxJnbVV0OOn8JxDQfPcSP4B
	 TKPfC4Fh0ywQbNa9/eOgjbIS1B7JRyROZpMJkaYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfF2Kgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 06:36:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32870 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfF2Kgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 06:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0ZTqox4zKZHSfjynSHuFlYTUSFoi9akGLNFU/TMkLz8=; b=RQlxVlV+vnKr+HuhHrN/9tY/e
        LN2f40ZNR3ZcpjZqJosL+P4ZU6Cjb2XOJS+kmPEIYk6v8Bqht+w+OY4ticHvGN0iEPOalUYhCxg7y
        NjZS2XKOdl/ooLSoW8OpjAkI+M3KyQWH87SZtL9l+5sO7gikQXoNtXgYubcJ4EWQ0inUfXVOu0NVj
        JSK0qvaCkfhtfYMBLLzxEphxuK7oNoXrdJMsjKH1/K8Qqb3hukK7ivA6mNoANbMK6neuonbgcKioq
        3fJDY5S2+rUh2EC/55AmIJQz0Dp6kaPFe7D877eHgcP6OUm22xhSZ9KCjTe2NbN3AI17IUFAjeB/d
        s3yaUFznA==;
Received: from [187.113.3.250] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhAiv-0002ct-C2; Sat, 29 Jun 2019 10:36:49 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hhAit-0006kO-8P; Sat, 29 Jun 2019 07:36:47 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Asmaa Mnebhi <Asmaa@mellanox.com>,
        Corey Minyard <cminyard@mvista.com>, vadimp@mellanox.com
Subject: [PATCH] docs: ipmb: place it at driver-api and convert to ReST
Date:   Sat, 29 Jun 2019 07:36:46 -0300
Message-Id: <d23c36ca65fe6ad56af1723bf70f7a7f4154c410.1561804596.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No new doc should be added at the main Documentation/ directory.

Instead, new docs should be added as ReST files, within the
Kernel documentation body.

Fixes: 51bd6f291583 ("Add support for IPMB driver")
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/driver-api/index.rst            |  1 +
 .../{IPMB.txt => driver-api/ipmb.rst}         | 62 ++++++++++---------
 2 files changed, 33 insertions(+), 30 deletions(-)
 rename Documentation/{IPMB.txt => driver-api/ipmb.rst} (71%)

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index e33849b948c7..e49c34bf16c0 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -75,6 +75,7 @@ available subsections can be seen below.
    dell_rbu
    edid
    eisa
+   ipmb
    isa
    isapnp
    generic-counter
diff --git a/Documentation/IPMB.txt b/Documentation/driver-api/ipmb.rst
similarity index 71%
rename from Documentation/IPMB.txt
rename to Documentation/driver-api/ipmb.rst
index cd20c9764705..3ec3baed84c4 100644
--- a/Documentation/IPMB.txt
+++ b/Documentation/driver-api/ipmb.rst
@@ -32,11 +32,11 @@ This driver works with the I2C driver and a userspace
 program such as OpenIPMI:
 
 1) It is an I2C slave backend driver. So, it defines a callback
-function to set the Satellite MC as an I2C slave.
-This callback function handles the received IPMI requests.
+   function to set the Satellite MC as an I2C slave.
+   This callback function handles the received IPMI requests.
 
 2) It defines the read and write functions to enable a user
-space program (such as OpenIPMI) to communicate with the kernel.
+   space program (such as OpenIPMI) to communicate with the kernel.
 
 
 Load the IPMB driver
@@ -48,34 +48,35 @@ CONFIG_IPMB_DEVICE_INTERFACE=y
 
 1) If you want the driver to be loaded at boot time:
 
-a) Add this entry to your ACPI table, under the appropriate SMBus:
+a) Add this entry to your ACPI table, under the appropriate SMBus::
 
-Device (SMB0) // Example SMBus host controller
-{
-  Name (_HID, "<Vendor-Specific HID>") // Vendor-Specific HID
-  Name (_UID, 0) // Unique ID of particular host controller
-  :
-  :
-    Device (IPMB)
-    {
-      Name (_HID, "IPMB0001") // IPMB device interface
-      Name (_UID, 0) // Unique device identifier
-    }
-}
+     Device (SMB0) // Example SMBus host controller
+     {
+     Name (_HID, "<Vendor-Specific HID>") // Vendor-Specific HID
+     Name (_UID, 0) // Unique ID of particular host controller
+     :
+     :
+       Device (IPMB)
+       {
+         Name (_HID, "IPMB0001") // IPMB device interface
+         Name (_UID, 0) // Unique device identifier
+       }
+     }
 
-b) Example for device tree:
+b) Example for device tree::
 
-&i2c2 {
-         status = "okay";
+     &i2c2 {
+            status = "okay";
 
-         ipmb@10 {
-                 compatible = "ipmb-dev";
-                 reg = <0x10>;
-         };
-};
+            ipmb@10 {
+                    compatible = "ipmb-dev";
+                    reg = <0x10>;
+            };
+     };
 
-2) Manually from Linux:
-modprobe ipmb-dev-int
+2) Manually from Linux::
+
+     modprobe ipmb-dev-int
 
 
 Instantiate the device
@@ -86,15 +87,16 @@ described in 'Documentation/i2c/instantiating-devices.rst'.
 If you have multiple BMCs, each connected to your Satellite MC via
 a different I2C bus, you can instantiate a device for each of
 those BMCs.
+
 The name of the instantiated device contains the I2C bus number
-associated with it as follows:
+associated with it as follows::
 
-BMC1 ------ IPMB/I2C bus 1 ---------|   /dev/ipmb-1
+  BMC1 ------ IPMB/I2C bus 1 ---------|   /dev/ipmb-1
 				Satellite MC
-BMC1 ------ IPMB/I2C bus 2 ---------|   /dev/ipmb-2
+  BMC1 ------ IPMB/I2C bus 2 ---------|   /dev/ipmb-2
 
 For instance, you can instantiate the ipmb-dev-int device from
-user space at the 7 bit address 0x10 on bus 2:
+user space at the 7 bit address 0x10 on bus 2::
 
   # echo ipmb-dev 0x1010 > /sys/bus/i2c/devices/i2c-2/new_device
 
-- 
2.21.0

