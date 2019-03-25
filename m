Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD695C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898D120811
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbfCYDYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 23:24:03 -0400
Received: from mga18.intel.com ([134.134.136.126]:19149 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729478AbfCYDX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 23:23:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Mar 2019 20:23:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="310109634"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by orsmga005.jf.intel.com with ESMTP; 24 Mar 2019 20:23:54 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH 04/17] Documentation: fpga: dfl: add descriptions for virtualization and new interfaces.
Date:   Mon, 25 Mar 2019 11:07:31 +0800
Message-Id: <1553483264-5379-5-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553483264-5379-1-git-send-email-hao.wu@intel.com>
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds virtualization support description for DFL based
FPGA devices (based on PCIe SRIOV), and introductions to new
interfaces added by new dfl private features.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
---
 Documentation/fpga/dfl.txt | 115 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/Documentation/fpga/dfl.txt b/Documentation/fpga/dfl.txt
index 6df4621..360c1d9 100644
--- a/Documentation/fpga/dfl.txt
+++ b/Documentation/fpga/dfl.txt
@@ -84,6 +84,8 @@ The following functions are exposed through ioctls:
  Get driver API version (DFL_FPGA_GET_API_VERSION)
  Check for extensions (DFL_FPGA_CHECK_EXTENSION)
  Program bitstream (DFL_FPGA_FME_PORT_PR)
+ Assign port to PF (DFL_FPGA_FME_PORT_ASSIGN)
+ Release port from PF (DFL_FPGA_FME_PORT_RELEASE)
 
 More functions are exposed through sysfs
 (/sys/class/fpga_region/regionX/dfl-fme.n/):
@@ -99,6 +101,24 @@ More functions are exposed through sysfs
      one FPGA device may have more than one port, this sysfs interface indicates
      how many ports the FPGA device has.
 
+ Power management (power_mgmt/)
+     power management sysfs interfaces allow user to read power management
+     information (power consumption, power limits, throttling thresholds,
+     thresholds status, etc) and configure power thresholds for different
+     throttling levels.
+
+ Thermal management (thermal_mgmt/)
+     thermal management sysfs interfaces allow user to read temperature,
+     thresholds, thresholds status and other thermal related information.
+
+ Global error reporting management (errors/)
+     error reporting sysfs interfaces allow user to read errors detected by the
+     hardware, and clear the logged errors.
+
+ Performance counters (perf/)
+     performance counters sysfs interfaces allow user to use different counters
+     to get performance data.
+
 
 FIU - PORT
 ==========
@@ -139,6 +159,10 @@ More functions are exposed through sysfs:
  Read Accelerator GUID (afu_id)
      afu_id indicates which PR bitstream is programmed to this AFU.
 
+ Error reporting (errors/)
+     error reporting sysfs interfaces allow user to read port/afu errors
+     detected by the hardware, and clear the logged errors.
+
 
 DFL Framework Overview
 ======================
@@ -212,6 +236,97 @@ the compat_id exposed by the target FPGA region. This check is usually done by
 userspace before calling the reconfiguration IOCTL.
 
 
+FPGA virtualization - PCIe SRIOV
+================================
+This section describes the virtualization support on DFL based FPGA device to
+enable accessing an accelerator from applications running in a virtual machine
+(VM). This section only describes the PCIe based FPGA device with SRIOV support.
+
+Features supported by the particular FPGA device are exposed through Device
+Feature Lists, as illustrated below:
+
+  +-------------------------------+  +-------------+
+  |              PF               |  |     VF      |
+  +-------------------------------+  +-------------+
+      ^            ^         ^              ^
+      |            |         |              |
++-----|------------|---------|--------------|-------+
+|     |            |         |              |       |
+|  +-----+     +-------+ +-------+      +-------+   |
+|  | FME |     | Port0 | | Port1 |      | Port2 |   |
+|  +-----+     +-------+ +-------+      +-------+   |
+|                  ^         ^              ^       |
+|                  |         |              |       |
+|              +-------+ +------+       +-------+   |
+|              |  AFU  | |  AFU |       |  AFU  |   |
+|              +-------+ +------+       +-------+   |
+|                                                   |
+|            DFL based FPGA PCIe Device             |
++---------------------------------------------------+
+
+FME is always accessed through the physical function (PF).
+
+Ports (and related AFUs) are accessed via PF by default, but could be exposed
+through virtual function (VF) devices via PCIe SRIOV. Each VF only contains
+1 Port and 1 AFU for isolation. Users could assign individual VFs (accelerators)
+created via PCIe SRIOV interface, to virtual machines.
+
+The driver organization in virtualization case is illustrated below:
+
+  +-------++------++------+             |
+  | FME   || FME  || FME  |             |
+  | FPGA  || FPGA || FPGA |             |
+  |Manager||Bridge||Region|             |
+  +-------++------++------+             |
+  +-----------------------+  +--------+ |             +--------+
+  |          FME          |  |  AFU   | |             |  AFU   |
+  |         Module        |  | Module | |             | Module |
+  +-----------------------+  +--------+ |             +--------+
+        +-----------------------+       |       +-----------------------+
+        | FPGA Container Device |       |       | FPGA Container Device |
+        |  (FPGA Base Region)   |       |       |  (FPGA Base Region)   |
+        +-----------------------+       |       +-----------------------+
+          +------------------+          |         +------------------+
+          | FPGA PCIE Module |          | Virtual | FPGA PCIE Module |
+          +------------------+   Host   | Machine +------------------+
+ -------------------------------------- | ------------------------------
+           +---------------+            |          +---------------+
+           | PCI PF Device |            |          | PCI VF Device |
+           +---------------+            |          +---------------+
+
+FPGA PCIe device driver is always loaded first once a FPGA PCIe PF or VF device
+is detected. It:
+
+	a) finish enumeration on both FPGA PCIe PF and VF device using common
+	   interfaces from DFL framework.
+	b) supports SRIOV.
+
+The FME device driver plays a management role in this driver architecture, it
+provides ioctls to release Port from PF and assign Port to PF. After release
+a port from PF, then it's safe to expose this port through a VF via PCIe SRIOV
+sysfs interface.
+
+To enable accessing an accelerator from applications running in a VM, the
+respective AFU's port needs to be assigned to a VF using the following steps:
+
+	a) The PF owns all AFU ports by default. Any port that needs to be
+	   reassigned to a VF must first be released through the
+	   DFL_FPGA_FME_PORT_RELEASE ioctl on the FME device.
+
+	b) Once N ports are released from PF, then user can use command below
+	   to enable SRIOV and VFs. Each VF owns only one Port with AFU.
+
+	   echo N > $PCI_DEVICE_PATH/sriov_numvfs
+
+	c) Pass through the VFs to VMs
+
+	d) The AFU under VF is accessible from applications in VM (using the
+	   same driver inside the VF).
+
+Note that an FME can't be assigned to a VF, thus PR and other management
+functions are only available via the PF.
+
+
 Device enumeration
 ==================
 This section introduces how applications enumerate the fpga device from
-- 
2.7.4

