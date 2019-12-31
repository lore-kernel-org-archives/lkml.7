Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04C0C2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 10:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB405206E4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 10:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfLaK3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 05:29:55 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:60199 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726702AbfLaK30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 05:29:26 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from vadimp@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 31 Dec 2019 12:29:22 +0200
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id xBVATJ7a008518;
        Tue, 31 Dec 2019 12:29:22 +0200
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     andy@infradead.org, dvhart@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH platform-next v1 3/9] Documentation/ABI: Add new attribute for mlxreg-io sysfs interfaces
Date:   Tue, 31 Dec 2019 10:29:11 +0000
Message-Id: <20191231102917.24181-4-vadimp@mellanox.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191231102917.24181-1-vadimp@mellanox.com>
References: <20191231102917.24181-1-vadimp@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the new attributes for:
- Exposing reset causes types asserted by: platform reset, SoC reset,
  AC power failure, software power off request.
- Setting and removing system VPD (EEPROM) hardware write protection.
- Voltage regulator devices configuration update status and firmware
  version.
- Setting PCIe ASIC reset to disable or enable state during PCIe root
  complex reset.
- System static topology identification, like system's static I2C
  topology, number and type of FPGA devices within the system and so on.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
 Documentation/ABI/stable/sysfs-driver-mlxreg-io | 69 +++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-driver-mlxreg-io b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
index fe30fe505c9b..afb73021a8d8 100644
--- a/Documentation/ABI/stable/sysfs-driver-mlxreg-io
+++ b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
@@ -150,3 +150,72 @@ What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_from_asic
 What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_reload_bios
 What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_sff_wd
 What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_swb_wd
+
+Date:		December 2019
+KernelVersion:	5.6
+Contact:	Vadim Pasternak <vadimpmellanox.com>
+Description:	These files show system static topology identification
+		like system's static I2C topology, number and type of FPGA
+		devices within the system and so on.
+
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/config1
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/config2
+
+		The files are read only.
+
+Date:		December 2019
+KernelVersion:	5.6
+Contact:	Vadim Pasternak <vadimpmellanox.com>
+Description:	These files show the system reset causes, as following: reset
+		due to AC power failure, reset invoked from software by
+		assertion reset signal through CPLD. reset caused by signal
+		asserted by SOC through ACPI register, reset invoked from
+		software by assertion power off signal through CPLD.
+
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_ac_pwr_fail
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_platform
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_soc
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/reset_sw_pwr_off
+
+		The files are read only.
+
+Date:		December 2019
+KernelVersion:	5.6
+Contact:	Vadim Pasternak <vadimpmellanox.com>
+Description:	This file allows to retain ASIC up during PCIe root complex
+		reset, when attribute is set 1.
+
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/pcie_asic_reset_dis
+
+		The file is read/write.
+
+Date:		December 2019
+KernelVersion:	5.6
+Contact:	Vadim Pasternak <vadimpmellanox.com>
+Description:	This file allows to overwrite system VPD hardware wrtie
+		protection when attribute is set 1.
+
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/vpd_wp
+
+		The file is read/write.
+
+Date:		December 2019
+KernelVersion:	5.6
+Contact:	Vadim Pasternak <vadimpmellanox.com>
+Description:	This file exposes the configuration update status of burnable
+		voltage regulator devices. The status values are as following:
+		0 - OK; 1 - CRC failure; 2 = I2C failure; 3 - in progress.
+
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/voltreg_update_status
+
+		The file is read only.
+
+Date:		December 2019
+KernelVersion:	5.6
+Contact:	Vadim Pasternak <vadimpmellanox.com>
+Description:	This file exposes the firmware version of burnable voltage
+		regulator devices.
+
+What:		/sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/ufm_version
+
+		The file is read only.
-- 
2.11.0

