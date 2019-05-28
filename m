Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7ABC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 20:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA0120B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 20:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfE1UIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 16:08:35 -0400
Received: from mga17.intel.com ([192.55.52.151]:48366 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727728AbfE1UId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 16:08:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 13:08:32 -0700
X-ExtLoop1: 1
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga006.fm.intel.com with ESMTP; 28 May 2019 13:08:30 -0700
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dinguyen@kernel.org, atull@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        sen.li@intel.com, richard.gong@linux.intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: [PATCHv4 3/4] firmware: rsu: document sysfs interface
Date:   Tue, 28 May 2019 15:20:32 -0500
Message-Id: <1559074833-1325-4-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559074833-1325-1-git-send-email-richard.gong@linux.intel.com>
References: <1559074833-1325-1-git-send-email-richard.gong@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Describe Intel Stratix10 Remote System Update (RSU) device attributes

Signed-off-by: Richard Gong <richard.gong@intel.com>
Reviewed-by: Alan Tull <atull@kernel.org>
---
v2: changed to use tab everywhere and wrap lines at 72 colums
    s/soc:firmware:svc:rsu/stratix10-rsu.0
    added for watchdog
v3: s/KernelVersion:5.2/KernelVersion:5.3
v4: replaced /sys/devices/platform/stratix10-rsu.0/ with
    /sys/devices/.../stratix10-rsu.0/driver/
    removed spaces
---
 .../testing/sysfs-devices-platform-stratix10-rsu   | 100 +++++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu

diff --git a/Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu b/Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu
new file mode 100644
index 0000000..29ae1c7
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu
@@ -0,0 +1,100 @@
+		Intel Stratix10 Remote System Update (RSU) device attributes
+
+What:		/sys/devices/.../stratix10-rsu.0/driver/current_image
+Date:		May 2019
+KernelVersion:	5.3
+Contact:	Richard Gong <richard.gong@intel.com>
+Description:
+		(RO) the address of image currently running in flash.
+
+What:		/sys/devices/.../stratix10-rsu.0/driver/fail_image
+Date:		May 2019
+KernelVersion:	5.3
+Contact:	Richard Gong <richard.gong@intel.com>
+Description:
+		(RO) the address of failed image in flash.
+
+What:		/sys/devices/.../stratix10-rsu.0/driver/state
+Date:		May 2019
+KernelVersion:	5.3
+Contact:	Richard Gong <richard.gong@intel.com>
+Description:
+		(RO) the state of RSU system.
+		The state field has two parts: major error code in upper 16 bits and
+		minor error code in lower 16 bits.
+
+		Major error code:
+			0xF001	bitstream error
+			0xF002	hardware access failure
+			0xF003	bitstream corruption
+			0xF004	internal error
+			0xF005	device error
+			0xF006	CPU watchdog timeout
+			0xF007	internal unknown error
+		Minor error code:
+			Currently used only when major error is 0xF006
+			(CPU watchdog timeout), in which case the minor
+			error code is the value reported by CPU to
+			firmware through the RSU notify command before
+			the watchdog timeout occurs.
+
+What:		/sys/devices/.../stratix10-rsu.0/driver/fail_image
+Date:		May 2019
+KernelVersion:	5.3
+Contact:	Richard Gong <richard.gong@intel.com>
+Description:
+		(RO) the version number of RSU firmware.
+
+What:		/sys/devices/.../stratix10-rsu.0/driver/error_location
+Date:		May 2019
+KernelVersion:	5.3
+Contact:	Richard Gong <richard.gong@intel.com>
+Description:
+		(RO) the error offset inside the image that failed.
+
+What:		/sys/devices/.../stratix10-rsu.0/driver/error_details
+Date:		May 2019
+KernelVersion:	5.3
+Contact:	Richard Gong <richard.gong@intel.com>
+Description:
+		(RO) error code.
+
+What:		/sys/devices/.../stratix10-rsu.0/driver/reboot_image
+Date:		May 2019
+KernelVersion:	5.3
+Contact:	Richard Gong <richard.gong@intel.com>
+Description:
+		(WO) the address of image to be loaded on next reboot command.
+
+What:		/sys/devices/.../stratix10-rsu.0/driver/notify
+Date:		May 2019
+KernelVersion:	5.3
+Contact:	Richard Gong <richard.gong@intel.com>
+Description:
+		(WO) inform firmware that the current software state as
+		a 16-bit numerical value below:
+			0 is for the first stage bootloader didn't run
+			or didn't reach the point of launching second
+			stage bootloader.
+			1 is for failed in second bootloader or didn't
+			get to the point of launching the operating
+			system.
+			2 is for both first and second stage bootloader
+			ran and the operating system launch was
+			attempted.
+
+What:		/sys/devices/.../stratix10-rsu.0/driver/watchdog
+Date:		May 2019
+KernelVersion:	5.3
+Contact:	Richard Gong <richard.gong@intel.com>
+Description:
+		(WO) instruct firmware what to do when rebooting due to
+		a watchdog timer expiration. The attribute takes a
+		32 bits word as the parameter indicating the action for
+		firmware to take:
+
+			b[0] is set to 0, the firmware should reboot
+			with the normal RSU flow.
+			b[0] is set to 1, the firmware shall always
+			reboot with the current running image.
+			b[31:1] reserved.
-- 
2.7.4

