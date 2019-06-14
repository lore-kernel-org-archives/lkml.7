Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CB1C31E4D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09FE2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560534769;
	bh=61JYeRwKr/E7KtFVixycI2mkjlk7oG4FP3Fjd46Mcrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=drI5YCAb/S4K0D6s/uxebyeT44Sn2rJ1GjT2ITIivgZGuWtcdpNSzemQZbFMGnRkw
	 pVmssFdRlTHycazX7nwiopmGLmd5vYv0PbolPKxmbfuWRXia+9+JeYfS5K6zxFjAhz
	 Cz9ISYf6xQyClwEQ62dCVtSpWuMZFBkjANydhNXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfFNRwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:52:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38744 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbfFNRwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=x8eDpGA9tkzRBlOBNNKR3eS8jBR9t93239y1JkYnhbQ=; b=kuA0elOUHo2L9KKLSGfNfwbvs3
        G60U+4BUfljcguaEdp1oh1fdtJK9CHqB9ChT2aAITfeKI92oqotdfWGywmviMxaQy2CyCdYJyqYOL
        fiVcjSKZrn5KGrO29grE7mKfsvFmGJWzjIX11UeQCU2pOHJ9dfE4z28vjKjxA41rswwC9OD/GHxxd
        LACD6BQndscYbq201doqmw++JM04ZYJq/8GV/WY+LhUXit03e8csYjmVc6NgX+pJXakRtjHEXen/z
        e5m2rk8ea/CdTMitrBu3e0VQaGuT+aCFdK59X4znceZLUKdfmIExkKxaey7XWPL7Twsr+b5F77YK7
        vgY+sPAA==;
Received: from 177.133.85.52.dynamic.adsl.gvt.net.br ([177.133.85.52] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbqNT-0000Pj-CM; Fri, 14 Jun 2019 17:52:39 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hbqNL-0002OW-NX; Fri, 14 Jun 2019 14:52:31 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 02/16] ABI: Fix KernelVersion tags
Date:   Fri, 14 Jun 2019 14:52:16 -0300
Message-Id: <08110b8914ae2ac61e5b284f7488475a3c761f4b.1560534648.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <3b8d7c64f887ddea01df3c4eeabc745c8ec45406.1560534648.git.mchehab+samsung@kernel.org>
References: <3b8d7c64f887ddea01df3c4eeabc745c8ec45406.1560534648.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is "KernelVersion:" and not "Kernel Version:".

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/ABI/testing/pstore              |  2 +-
 .../sysfs-bus-event_source-devices-format     |  2 +-
 .../ABI/testing/sysfs-bus-i2c-devices-hm6352  |  6 ++---
 .../testing/sysfs-bus-pci-devices-aer_stats   | 12 +++++-----
 .../ABI/testing/sysfs-bus-pci-devices-cciss   | 22 +++++++++----------
 .../testing/sysfs-bus-usb-devices-usbsevseg   | 10 ++++-----
 .../ABI/testing/sysfs-driver-altera-cvp       |  2 +-
 Documentation/ABI/testing/sysfs-driver-ppi    |  2 +-
 Documentation/ABI/testing/sysfs-driver-st     |  2 +-
 Documentation/ABI/testing/sysfs-driver-wacom  |  2 +-
 10 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/Documentation/ABI/testing/pstore b/Documentation/ABI/testing/pstore
index 8d6e48f4e8ef..d45209abdb1b 100644
--- a/Documentation/ABI/testing/pstore
+++ b/Documentation/ABI/testing/pstore
@@ -1,6 +1,6 @@
 What:		/sys/fs/pstore/... (or /dev/pstore/...)
 Date:		March 2011
-Kernel Version: 2.6.39
+KernelVersion: 2.6.39
 Contact:	tony.luck@intel.com
 Description:	Generic interface to platform dependent persistent storage.
 
diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-format b/Documentation/ABI/testing/sysfs-bus-event_source-devices-format
index b6f8748e0200..5bb793ec926c 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-format
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-format
@@ -1,6 +1,6 @@
 What:		/sys/bus/event_source/devices/<dev>/format
 Date:		January 2012
-Kernel Version: 3.3
+KernelVersion: 3.3
 Contact:	Jiri Olsa <jolsa@redhat.com>
 Description:
 		Attribute group to describe the magic bits that go into
diff --git a/Documentation/ABI/testing/sysfs-bus-i2c-devices-hm6352 b/Documentation/ABI/testing/sysfs-bus-i2c-devices-hm6352
index 29bd447e50a0..4a251b7f11e4 100644
--- a/Documentation/ABI/testing/sysfs-bus-i2c-devices-hm6352
+++ b/Documentation/ABI/testing/sysfs-bus-i2c-devices-hm6352
@@ -1,20 +1,20 @@
 What:		/sys/bus/i2c/devices/.../heading0_input
 Date:		April 2010
-Kernel Version: 2.6.36?
+KernelVersion: 2.6.36?
 Contact:	alan.cox@intel.com
 Description:	Reports the current heading from the compass as a floating
 		point value in degrees.
 
 What:		/sys/bus/i2c/devices/.../power_state
 Date:		April 2010
-Kernel Version: 2.6.36?
+KernelVersion: 2.6.36?
 Contact:	alan.cox@intel.com
 Description:	Sets the power state of the device. 0 sets the device into
 		sleep mode, 1 wakes it up.
 
 What:		/sys/bus/i2c/devices/.../calibration
 Date:		April 2010
-Kernel Version: 2.6.36?
+KernelVersion: 2.6.36?
 Contact:	alan.cox@intel.com
 Description:	Sets the calibration on or off (1 = on, 0 = off). See the
 		chip data sheet.
diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
index ff229d71961c..3c9a8c4a25eb 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
@@ -11,7 +11,7 @@ saw any problems).
 
 What:		/sys/bus/pci/devices/<dev>/aer_dev_correctable
 Date:		July 2018
-Kernel Version: 4.19.0
+KernelVersion: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	List of correctable errors seen and reported by this
 		PCI device using ERR_COR. Note that since multiple errors may
@@ -33,7 +33,7 @@ TOTAL_ERR_COR 2
 
 What:		/sys/bus/pci/devices/<dev>/aer_dev_fatal
 Date:		July 2018
-Kernel Version: 4.19.0
+KernelVersion: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	List of uncorrectable fatal errors seen and reported by this
 		PCI device using ERR_FATAL. Note that since multiple errors may
@@ -64,7 +64,7 @@ TOTAL_ERR_FATAL 0
 
 What:		/sys/bus/pci/devices/<dev>/aer_dev_nonfatal
 Date:		July 2018
-Kernel Version: 4.19.0
+KernelVersion: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	List of uncorrectable nonfatal errors seen and reported by this
 		PCI device using ERR_NONFATAL. Note that since multiple errors
@@ -105,18 +105,18 @@ messages on the PCI hierarchy originating at that root port.
 
 What:		/sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_cor
 Date:		July 2018
-Kernel Version: 4.19.0
+KernelVersion: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	Total number of ERR_COR messages reported to rootport.
 
 What:	    /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_fatal
 Date:		July 2018
-Kernel Version: 4.19.0
+KernelVersion: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	Total number of ERR_FATAL messages reported to rootport.
 
 What:	    /sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_nonfatal
 Date:		July 2018
-Kernel Version: 4.19.0
+KernelVersion: 4.19.0
 Contact:	linux-pci@vger.kernel.org, rajatja@google.com
 Description:	Total number of ERR_NONFATAL messages reported to rootport.
diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-cciss b/Documentation/ABI/testing/sysfs-bus-pci-devices-cciss
index eb449169c30b..92a94e1068c2 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci-devices-cciss
+++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-cciss
@@ -1,68 +1,68 @@
 What:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/model
 Date:		March 2009
-Kernel Version: 2.6.30
+KernelVersion: 2.6.30
 Contact:	iss_storagedev@hp.com
 Description:	Displays the SCSI INQUIRY page 0 model for logical drive
 		Y of controller X.
 
 What:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/rev
 Date:		March 2009
-Kernel Version: 2.6.30
+KernelVersion: 2.6.30
 Contact:	iss_storagedev@hp.com
 Description:	Displays the SCSI INQUIRY page 0 revision for logical
 		drive Y of controller X.
 
 What:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/unique_id
 Date:		March 2009
-Kernel Version: 2.6.30
+KernelVersion: 2.6.30
 Contact:	iss_storagedev@hp.com
 Description:	Displays the SCSI INQUIRY page 83 serial number for logical
 		drive Y of controller X.
 
 What:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/vendor
 Date:		March 2009
-Kernel Version: 2.6.30
+KernelVersion: 2.6.30
 Contact:	iss_storagedev@hp.com
 Description:	Displays the SCSI INQUIRY page 0 vendor for logical drive
 		Y of controller X.
 
 What:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/block:cciss!cXdY
 Date:		March 2009
-Kernel Version: 2.6.30
+KernelVersion: 2.6.30
 Contact:	iss_storagedev@hp.com
 Description:	A symbolic link to /sys/block/cciss!cXdY
 
 What:		/sys/bus/pci/devices/<dev>/ccissX/rescan
 Date:		August 2009
-Kernel Version:	2.6.31
+KernelVersion:	2.6.31
 Contact:	iss_storagedev@hp.com
 Description:	Kicks of a rescan of the controller to discover logical
 		drive topology changes.
 
 What:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/lunid
 Date:		August 2009
-Kernel Version: 2.6.31
+KernelVersion: 2.6.31
 Contact:	iss_storagedev@hp.com
 Description:	Displays the 8-byte LUN ID used to address logical
 		drive Y of controller X.
 
 What:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/raid_level
 Date:		August 2009
-Kernel Version: 2.6.31
+KernelVersion: 2.6.31
 Contact:	iss_storagedev@hp.com
 Description:	Displays the RAID level of logical drive Y of
 		controller X.
 
 What:		/sys/bus/pci/devices/<dev>/ccissX/cXdY/usage_count
 Date:		August 2009
-Kernel Version: 2.6.31
+KernelVersion: 2.6.31
 Contact:	iss_storagedev@hp.com
 Description:	Displays the usage count (number of opens) of logical drive Y
 		of controller X.
 
 What:		/sys/bus/pci/devices/<dev>/ccissX/resettable
 Date:		February 2011
-Kernel Version:	2.6.38
+KernelVersion:	2.6.38
 Contact:	iss_storagedev@hp.com
 Description:	Value of 1 indicates the controller can honor the reset_devices
 		kernel parameter.  Value of 0 indicates reset_devices cannot be
@@ -73,7 +73,7 @@ Description:	Value of 1 indicates the controller can honor the reset_devices
 
 What:		/sys/bus/pci/devices/<dev>/ccissX/transport_mode
 Date:		July 2011
-Kernel Version:	3.0
+KernelVersion:	3.0
 Contact:	iss_storagedev@hp.com
 Description:	Value of "simple" indicates that the controller has been placed
 		in "simple mode". Value of "performant" indicates that the
diff --git a/Documentation/ABI/testing/sysfs-bus-usb-devices-usbsevseg b/Documentation/ABI/testing/sysfs-bus-usb-devices-usbsevseg
index f6199b314196..9ade80f81f96 100644
--- a/Documentation/ABI/testing/sysfs-bus-usb-devices-usbsevseg
+++ b/Documentation/ABI/testing/sysfs-bus-usb-devices-usbsevseg
@@ -1,6 +1,6 @@
 What:		/sys/bus/usb/.../powered
 Date:		August 2008
-Kernel Version:	2.6.26
+KernelVersion:	2.6.26
 Contact:	Harrison Metzger <harrisonmetz@gmail.com>
 Description:	Controls whether the device's display will powered.
 		A value of 0 is off and a non-zero value is on.
@@ -8,7 +8,7 @@ Description:	Controls whether the device's display will powered.
 What:		/sys/bus/usb/.../mode_msb
 What:		/sys/bus/usb/.../mode_lsb
 Date:		August 2008
-Kernel Version:	2.6.26
+KernelVersion:	2.6.26
 Contact:	Harrison Metzger <harrisonmetz@gmail.com>
 Description:	Controls the devices display mode.
 		For a 6 character display the values are
@@ -18,7 +18,7 @@ Description:	Controls the devices display mode.
 
 What:		/sys/bus/usb/.../textmode
 Date:		August 2008
-Kernel Version:	2.6.26
+KernelVersion:	2.6.26
 Contact:	Harrison Metzger <harrisonmetz@gmail.com>
 Description:	Controls the way the device interprets its text buffer.
 		raw:	each character controls its segment manually
@@ -27,13 +27,13 @@ Description:	Controls the way the device interprets its text buffer.
 
 What:		/sys/bus/usb/.../text
 Date:		August 2008
-Kernel Version:	2.6.26
+KernelVersion:	2.6.26
 Contact:	Harrison Metzger <harrisonmetz@gmail.com>
 Description:	The text (or data) for the device to display
 
 What:		/sys/bus/usb/.../decimals
 Date:		August 2008
-Kernel Version:	2.6.26
+KernelVersion:	2.6.26
 Contact:	Harrison Metzger <harrisonmetz@gmail.com>
 Description:	Controls the decimal places on the device.
 		To set the nth decimal place, give this field
diff --git a/Documentation/ABI/testing/sysfs-driver-altera-cvp b/Documentation/ABI/testing/sysfs-driver-altera-cvp
index 8cde64a71edb..fbd8078fd7ad 100644
--- a/Documentation/ABI/testing/sysfs-driver-altera-cvp
+++ b/Documentation/ABI/testing/sysfs-driver-altera-cvp
@@ -1,6 +1,6 @@
 What:		/sys/bus/pci/drivers/altera-cvp/chkcfg
 Date:		May 2017
-Kernel Version:	4.13
+KernelVersion:	4.13
 Contact:	Anatolij Gustschin <agust@denx.de>
 Description:
 		Contains either 1 or 0 and controls if configuration
diff --git a/Documentation/ABI/testing/sysfs-driver-ppi b/Documentation/ABI/testing/sysfs-driver-ppi
index 9921ef285899..1a56fc507689 100644
--- a/Documentation/ABI/testing/sysfs-driver-ppi
+++ b/Documentation/ABI/testing/sysfs-driver-ppi
@@ -1,6 +1,6 @@
 What:		/sys/class/tpm/tpmX/ppi/
 Date:		August 2012
-Kernel Version:	3.6
+KernelVersion:	3.6
 Contact:	xiaoyan.zhang@intel.com
 Description:
 		This folder includes the attributes related with PPI (Physical
diff --git a/Documentation/ABI/testing/sysfs-driver-st b/Documentation/ABI/testing/sysfs-driver-st
index ba5d77008a85..88cab66fd77f 100644
--- a/Documentation/ABI/testing/sysfs-driver-st
+++ b/Documentation/ABI/testing/sysfs-driver-st
@@ -1,6 +1,6 @@
 What:		/sys/bus/scsi/drivers/st/debug_flag
 Date:		October 2015
-Kernel Version:	?.?
+KernelVersion:	?.?
 Contact:	shane.seymour@hpe.com
 Description:
 		This file allows you to turn debug output from the st driver
diff --git a/Documentation/ABI/testing/sysfs-driver-wacom b/Documentation/ABI/testing/sysfs-driver-wacom
index 2aa5503ee200..afc48fc163b5 100644
--- a/Documentation/ABI/testing/sysfs-driver-wacom
+++ b/Documentation/ABI/testing/sysfs-driver-wacom
@@ -1,6 +1,6 @@
 What:		/sys/bus/hid/devices/<bus>:<vid>:<pid>.<n>/speed
 Date:		April 2010
-Kernel Version:	2.6.35
+KernelVersion:	2.6.35
 Contact:	linux-bluetooth@vger.kernel.org
 Description:
 		The /sys/bus/hid/devices/<bus>:<vid>:<pid>.<n>/speed file
-- 
2.21.0

