Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504ABC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C3F20828
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfCYDXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 23:23:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:19145 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729361AbfCYDXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 23:23:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Mar 2019 20:23:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="310109607"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by orsmga005.jf.intel.com with ESMTP; 24 Mar 2019 20:23:45 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, Wu Hao <hao.wu@intel.com>
Subject: [PATCH 00/17] add new features for FPGA DFL drivers
Date:   Mon, 25 Mar 2019 11:07:27 +0800
Message-Id: <1553483264-5379-1-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds more features support for FPGA Device Feature List
(DFL) drivers, including PR enhancement, virtualization support based
on PCIe SRIOV, private features to Port, private features to FME, and
enhancement to DFL framework. Please refer to details in below list.

Patch 1: A bug fixing to current dfl-fme-mgr driver.
Patch 2-3: add 512bit data width PR support.
Patch 4-6: add virtualization support based on PCIe SRIOV.
Patch 7-8: add new AFU state and userclock related sysfs to dfl-afu.
Patch 9-10: enhancement to DFL framework in order to support id_table.
Patch 11: add error reporting private feature support to dfl-afu.
Patch 12: add STP (SignalTap) private feature support to dfl-afu.
Patch 13: add capability sysfs interfaces to dfl-fme.
Patch 14: add thermal management private feature support to dfl-fme.
Patch 15: add power management private feature support to dfl-fme.
Patch 16: add global error reporitng private feature support to dfl-fme.
Patch 17: add performance reporting support to dfl-fme.

Wu Hao (17):
  fpga: dfl-fme-mgr: fix FME_PR_INTFC_ID register address.
  fpga: dfl: fme: align PR buffer size per PR datawidth
  fpga: dfl: fme: support 512bit data width PR
  Documentation: fpga: dfl: add descriptions for virtualization and new
    interfaces.
  fpga: dfl: fme: add DFL_FPGA_FME_PORT_RELEASE/ASSIGN ioctl support.
  fpga: dfl: pci: enable SRIOV support.
  fpga: dfl: afu: add AFU state related sysfs interfaces
  fpga: dfl: afu: add userclock sysfs interfaces.
  fpga: dfl: add id_table for dfl private feature driver
  fpga: dfl: afu: export __port_enable/disable function.
  fpga: dfl: afu: add error reporting support.
  fpga: dfl: afu: add STP (SignalTap) support
  fpga: dfl: fme: add capability sysfs interfaces
  fpga: dfl: fme: add thermal management support
  fpga: dfl: fme: add power management support
  fpga: dfl: fme: add global error reporting support
  fpga: dfl: fme: add performance reporting support

 Documentation/ABI/testing/sysfs-platform-dfl-fme  | 279 +++++++
 Documentation/ABI/testing/sysfs-platform-dfl-port |  94 +++
 Documentation/fpga/dfl.txt                        | 115 +++
 drivers/fpga/Makefile                             |   4 +-
 drivers/fpga/dfl-afu-error.c                      | 225 +++++
 drivers/fpga/dfl-afu-main.c                       | 335 +++++++-
 drivers/fpga/dfl-afu.h                            |   7 +
 drivers/fpga/dfl-fme-error.c                      | 390 +++++++++
 drivers/fpga/dfl-fme-main.c                       | 583 ++++++++++++-
 drivers/fpga/dfl-fme-mgr.c                        |  79 +-
 drivers/fpga/dfl-fme-perf.c                       | 950 ++++++++++++++++++++++
 drivers/fpga/dfl-fme-pr.c                         |  64 +-
 drivers/fpga/dfl-fme.h                            |   9 +-
 drivers/fpga/dfl-pci.c                            |  40 +
 drivers/fpga/dfl.c                                | 170 +++-
 drivers/fpga/dfl.h                                |  56 +-
 include/uapi/linux/fpga-dfl.h                     |  32 +
 17 files changed, 3355 insertions(+), 77 deletions(-)
 create mode 100644 drivers/fpga/dfl-afu-error.c
 create mode 100644 drivers/fpga/dfl-fme-error.c
 create mode 100644 drivers/fpga/dfl-fme-perf.c

-- 
2.7.4

