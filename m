Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C13C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F6D20675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfEGShQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 14:37:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:41333 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfEGShQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 14:37:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 May 2019 11:37:15 -0700
X-ExtLoop1: 1
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga004.fm.intel.com with ESMTP; 07 May 2019 11:37:15 -0700
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dinguyen@kernel.org, atull@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [PATCHv2 0/4] add Intel Stratix10 remote system update driver
Date:   Tue,  7 May 2019 13:46:35 -0500
Message-Id: <1557254799-7416-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

This is the 2nd submission of Intel Stratix10 remote system update (RSU)
driver.

Intel Stratix10 remote system update driver patches have been reviewed by
Alan Tull and other colleagues at Intel.

The Intel Stratix10 Remote System Update (RSU) driver exposes interfaces
access through the Intel Stratix10 Service Layer to user space via sysfs
interface. The RSU interfaces report and control some of the optional RSU
features on Intel Stratix 10 SoC.

The RSU feature provides a way for customers to update the boot
configuration of a Intel Stratix 10 SoC device with significantly reduced
risk of corrupting the bitstream storage and bricking the system.

v2: removed compatible = "intel,stratix10-rsu"
    added intel stratix10 RSU device
    changed to support RSU in handling watchdog timeout
    s/attr_group/ATTRIBUTE_GROUPS, use devm_device_add_groups() and
    devm_device_remove_groups()
    added check the return value from rsu_send_msg()
    removed RSU binding text file
    other corrections/changes

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
 drivers/firmware/stratix10-rsu.c                   | 409 +++++++++++++++++++++
 drivers/firmware/stratix10-svc.c                   |  74 +++-
 include/linux/firmware/intel/stratix10-smc.h       |  48 ++-
 .../linux/firmware/intel/stratix10-svc-client.h    |  12 +-
 8 files changed, 663 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu
 create mode 100644 drivers/firmware/stratix10-rsu.c

-- 
2.7.4

