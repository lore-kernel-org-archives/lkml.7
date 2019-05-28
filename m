Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0073DC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 20:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7E420989
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 20:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfE1UIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 16:08:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:48366 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbfE1UI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 16:08:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 13:08:29 -0700
X-ExtLoop1: 1
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga006.fm.intel.com with ESMTP; 28 May 2019 13:08:27 -0700
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dinguyen@kernel.org, atull@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        sen.li@intel.com, richard.gong@linux.intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: [PATCHv4 0/4] add Intel Stratix10 remote system update driver
Date:   Tue, 28 May 2019 15:20:29 -0500
Message-Id: <1559074833-1325-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

This is the 4th submission of Intel Stratix10 remote system update (RSU)
driver.

Intel Stratix10 remote system update driver patches have been reviewed by
Alan Tull and other colleagues at Intel.

The Intel Stratix10 Remote System Update driver exposes interfaces
access through the Intel Stratix10 Service Layer to user space via sysfs
interface. The RSU interfaces report and control some of the optional RSU
features on Intel Stratix 10 SoC.

The RSU feature provides a way for customers to update the boot
configuration of a Intel Stratix 10 SoC device with significantly reduced
risk of corrupting the bitstream storage and bricking the system.

v4: removed devm_device_add_groups() & devm_device_remove_groups(), then
    utilized groups at struct device_driver
    replaced /sys/devices/platform/stratix10-rsu.0/ with /sys/devices/.../
    stratix10-rsu.0/driver/
    removed spaces
v3: changed kernel version from 5.2 to 5.3 in RSU sysfs interface document
v2: removed compatible = "intel,stratix10-rsu"
    added intel stratix10 RSU device
    changed to support RSU in handling watchdog timeout
    s/attr_group/ATTRIBUTE_GROUPS, use devm_device_add_groups() and
    devm_device_remove_groups()
    added check the return value from rsu_send_msg()
    removed RSU binding text file
    other corrections/change 

Richard Gong (4):
  firmware: stratix10-svc: extend svc to support RSU notify and WD
    features
  firmware: add Intel Stratix10 remote system update driver
  firmware: rsu: document sysfs interface
  MAINTAINERS: add maintainer for Intel Stratix10 FW drivers

 .../testing/sysfs-devices-platform-stratix10-rsu   | 100 +++++
 MAINTAINERS                                        |  11 +
 drivers/firmware/Kconfig                           |  18 +
 drivers/firmware/Makefile                          |   1 +
 drivers/firmware/stratix10-rsu.c                   | 403 +++++++++++++++++++++
 drivers/firmware/stratix10-svc.c                   |  74 +++-
 include/linux/firmware/intel/stratix10-smc.h       |  48 ++-
 .../linux/firmware/intel/stratix10-svc-client.h    |  12 +-
 8 files changed, 657 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu
 create mode 100644 drivers/firmware/stratix10-rsu.c

-- 
2.7.4

