Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036A9C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA39923401
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbfICNGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 09:06:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:32285 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729255AbfICNGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:06:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 06:06:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,463,1559545200"; 
   d="scan'208";a="183548849"
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga007.fm.intel.com with ESMTP; 03 Sep 2019 06:06:22 -0700
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dinguyen@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        sen.li@intel.com, richard.gong@intel.com
Subject: [PATCHv5 3/4] firmware: rsu: document sysfs interface
Date:   Tue,  3 Sep 2019 08:18:20 -0500
Message-Id: <1567516701-26026-4-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567516701-26026-1-git-send-email-richard.gong@linux.intel.com>
References: <1567516701-26026-1-git-send-email-richard.gong@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Describe Intel Stratix10 Remote System Update (RSU) device attributes

Signed-off-by: Richard Gong <richard.gong@intel.com>
Reviewed-by: Alan Tull <atull@kernel.org>
---
v2: changed to use tab everywhere and wrap lines at 72 columns
    s/soc:firmware:svc:rsu/stratix10-rsu.0
    added for watchdog
v3: s/KernelVersion:5.2/KernelVersion:5.3
v4: replaced /sys/devices/platform/stratix10-rsu.0/ with
    /sys/devices/.../stratix10-rsu.0/driver/
    removed spaces
v5: corrected typo in the previous version
    s/KernelVersion:5.3/KernelVersion:5.4
    replace contact email address with richard.gong@linux.intel.com
    replaced /sys/devices/.../stratix10-rsu.0/driver/ with
    /sys/devices/platform/stratix10-rsu.0/
---
 .../testing/sysfs-devices-platform-stratix10-rsu   | 128 +++++++++++++++++++++
 1 file changed, 128 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu

diff --git a/Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu b/Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu
new file mode 100644
index 0000000..ae9af98
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu
@@ -0,0 +1,128 @@
+	Intel Stratix10 Remote System Update (RSU) device attributes
+
+What:		/sys/devices/platform/stratix10-rsu.0/current_image
+Date:		August 2019
+KernelVersion:	5.4
+Contact:	Richard Gong <richard.gong@linux.intel.com>
+Description:
+		(RO) the address in flash of currently running image.
+
+What:		/sys/devices/platform/stratix10-rsu.0/fail_image
+Date:		August 2019
+KernelVersion:	5.4
+Contact:	Richard Gong <richard.gong@linux.intel.com>
+Description:
+		(RO) the address in flash of failed image.
+
+What:		/sys/devices/platform/stratix10-rsu.0/state
+Date:		August 2019
+KernelVersion:	5.4
+Contact:	Richard Gong <richard.gong@linux.intel.com>
+Description:
+		(RO) the state of RSU system.
+		The state field has two parts: major error code in
+		upper 16 bits and minor error code in lower 16 bits.
+
+		b[15:0]
+			Currently used only when major error is 0xF006
+			(CPU watchdog timeout), in which case the minor
+			error code is the value reported by CPU to
+			firmware through the RSU notify command before
+			the watchdog timeout occurs.
+
+		b[31:16]
+			0xF001	bitstream error
+			0xF002	hardware access failure
+			0xF003	bitstream corruption
+			0xF004	internal error
+			0xF005	device error
+			0xF006	CPU watchdog timeout
+			0xF007	internal unknown error
+
+What:		/sys/devices/platform/stratix10-rsu.0/version
+Date:		August 2019
+KernelVersion:	5.4
+Contact:	Richard Gong <richard.gong@linux.intel.com>
+Description:
+		(RO) the version number of RSU firmware. 19.3 or late
+		version includes information about the firmware which
+		reported the error.
+
+		pre 19.3:
+			b[31:0]
+				0x0	version number
+
+		19.3 or late:
+			b[15:0]
+				0x1	version number
+			b[31:16]
+				0x0	no error
+				0x0DCF	Decision CMF error
+				0x0ACF	Application CMF error
+
+What:		/sys/devices/platform/stratix10-rsu.0/error_location
+Date:		August 2019
+KernelVersion:	5.4
+Contact:	Richard Gong <richard.gong@linux.intel.com>
+Description:
+		(RO) the error offset inside the image that failed.
+
+What:		/sys/devices/platform/stratix10-rsu.0/error_details
+Date:		August 2019
+KernelVersion:	5.4
+Contact:	Richard Gong <richard.gong@linux.intel.com>
+Description:
+		(RO) error code.
+
+What:		/sys/devices/platform/stratix10-rsu.0/retry_counter
+Date:		August 2019
+KernelVersion:	5.4
+Contact:	Richard Gong <richard.gong@linux.intel.com>
+Description:
+		(RO) the current image's retry counter, which is used by
+		user to know how many times the images is still allowed
+		to reload itself before giving up and starting RSU
+		fail-over flow.
+
+What:		/sys/devices/platform/stratix10-rsu.0/reboot_image
+Date:		August 2019
+KernelVersion:	5.4
+Contact:	Richard Gong <richard.gong@linux.intel.com>
+Description:
+		(WO) the address in flash of image to be loaded on next
+		reboot command.
+
+What:		/sys/devices/platform/stratix10-rsu.0/notify
+Date:		August 2019
+KernelVersion:	5.4
+Contact:	Richard Gong <richard.gong@linux.intel.com>
+Description:
+		(WO) client to notify firmware with different actions.
+
+		b[15:0]
+			inform firmware the current software execution
+			stage.
+			0	the first stage bootloader didn't run or
+				didn't reach the point of launching second
+				stage bootloader.
+			1	failed in second bootloader or didn't get
+				to the point of launching the operating
+				system.
+			2	both first and second stage bootloader ran
+				and the operating system launch was
+				attempted.
+
+		b[16]
+			1	firmware to reset current image retry
+				counter.
+			0	no action.
+
+		b[17]
+			1	firmware to clear RSU log
+			0	no action.
+
+		b[18]
+			this is negative logic
+			1	no action
+			0	firmware record the notify code defined
+				in b[15:0].
-- 
2.7.4

