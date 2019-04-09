Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE16C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 18:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0567420883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 18:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfDIShY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 14:37:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:40624 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbfDIShT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 14:37:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 11:37:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,330,1549958400"; 
   d="scan'208";a="141403373"
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga007.fm.intel.com with ESMTP; 09 Apr 2019 11:37:18 -0700
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dinguyen@kernel.org, atull@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [PATCHv1 5/6] firmware: rsu: document sysfs interface
Date:   Tue,  9 Apr 2019 13:46:01 -0500
Message-Id: <1554835562-25056-6-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554835562-25056-1-git-send-email-richard.gong@linux.intel.com>
References: <1554835562-25056-1-git-send-email-richard.gong@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Describe Intel Stratix10 Remote System Update (RSU) device attributes

Signed-off-by: Richard Gong <richard.gong@intel.com>
Reviewed-by: Alan Tull <atull@kernel.org>
---
 .../testing/sysfs-devices-platform-stratix10-rsu   | 78 ++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu

diff --git a/Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu b/Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu
new file mode 100644
index 0000000..cb461ee
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu
@@ -0,0 +1,78 @@
+		Intel Stratix10 Remote System Update (RSU) device attributes
+
+What:		/sys/devices/platform/soc:firmware:svc/soc:firmware:svc:rsu/current_image
+Date:		April 2019
+KernelVersion:	5.2
+Contact:	Richard Gong <richard.gong@intel.com>
+Description:
+		(RO) the address of image currently running in flash.
+
+What:           /sys/devices/platform/soc:firmware:svc/soc:firmware:svc:rsu/fail_image
+Date:           April 2019
+KernelVersion:  5.2
+Contact:        Richard Gong <richard.gong@intel.com>
+Description:
+		(RO) the address of failed image in flash.
+
+What:           /sys/devices/platform/soc:firmware:svc/soc:firmware:svc:rsu/state
+Date:           April 2019
+KernelVersion:  5.2
+Contact:        Richard Gong <richard.gong@intel.com>
+Description:
+		(RO) the state of RSU system.
+		The state field has two parts: major error code in upper 16 bits and minor error code
+		in lower 16 bits.
+		1. Major error code
+			0xF001 -- bitstream error
+			0xF002 -- hardware access failure
+			0xF003 -- bitstream corruption
+			0xF004 -- internal error
+			0xF005 -- device error
+			0xF006 -- HPS watchdog timeout
+			0xF007 -- internal unknown error
+		2: Minor error code
+			Currently used only when major error is 0xF006 (HPS watchdog timeout), in which
+		case the minor error code is the value reported by HPS to firmware through the RSU notify
+		command before the watchdog timeout occurs.
+
+What:           /sys/devices/platform/soc:firmware:svc/soc:firmware:svc:rsu/version
+Date:           April 2019
+KernelVersion:  5.2
+Contact:        Richard Gong <richard.gong@intel.com>
+Description:
+		(RO) the version number of RSU firmware.
+
+What:           /sys/devices/platform/soc:firmware:svc/soc:firmware:svc:rsu/error_location
+Date:           April 2019
+KernelVersion:  5.2
+Contact:        Richard Gong <richard.gong@intel.com>
+Description:
+		(RO) the error offset inside the image that failed.
+
+What:           /sys/devices/platform/soc:firmware:svc/soc:firmware:svc:rsu/error_details
+Date:           April 2019
+KernelVersion:  5.2
+Contact:        Richard Gong <richard.gong@intel.com>
+Description:
+		(RO) error code.
+
+What:           /sys/devices/platform/soc:firmware:svc/soc:firmware:svc:rsu/reboot_image
+Date:           April 2019
+KernelVersion:  5.2
+Contact:        Richard Gong <richard.gong@intel.com>
+Description:
+		(WO) the address of image to be loaded on next reboot command.
+
+What:           /sys/devices/platform/soc:firmware:svc/soc:firmware:svc:rsu/notify
+Date:           April 2019
+KernelVersion:  5.2
+Contact:        Richard Gong <richard.gong@intel.com>
+Description:
+		(WO) inform firmware that the current software state as a 16-bit
+		numerical value below:
+		0 -- the first stage bootloader didn't run or didn't reach the
+		     point of launching second stage bootloader
+		1 -- failed in second bootloader or didn't get to the point of
+		     launching the operating system
+		2 -- both first and second stage bootloader ran and the operating
+		     system launch was attempted.
-- 
2.7.4

