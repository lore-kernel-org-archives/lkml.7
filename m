Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1C8C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10CBE2133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732386AbfJALif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:38:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:46305 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbfJALie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:38:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 04:38:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="391165495"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 01 Oct 2019 04:38:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id D1DD6130; Tue,  1 Oct 2019 14:38:30 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-usb@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 00/22] thunderbolt: Add support for USB4
Date:   Tue,  1 Oct 2019 14:38:08 +0300
Message-Id: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm sending this as RFC because the series is still missing important
features such as power management so not ready for merging. However, I
think it is good to get any early feedback from the community. We are
working to add support for the missing features.

USB4 is the public specification of Thunderbolt 3 protocol and can be
downloaded here:

  https://www.usb.org/sites/default/files/USB4%20Specification_1.zip

USB4 is about tunneling different protocols over a single cable (in the
same way as Thunderbolt). The current USB4 spec supports PCIe, Display Port
and USB 3.x, and also software based protocols such as networking between
domains (hosts).

So far PCs have been using firmware based Connection Manager and Apple
systems have been using software based one. A Connection Manager is the
entity that handles creation of different tunnel types through the USB4
(and Thunderbolt) fabric. With USB4 the plan is to have software based
Connection Manager everywhere but some early systems will also support
firmware to allow OS downgrade for example.

Current Linux Thunderbolt driver supports both "modes" and can detect which
one to use dynamically.

This series first adds support for Thunderbolt 3 devices to the software
connection manager and then extends that to support USB4 compliant hosts
and devices (this applies to both firmware and software based connection
managers). With this series the following features are supported also for
USB4 compliant devices:

  - PCIe tunneling
  - Display Port tunneling
  - USB 3.x tunneling
  - P2P networking (implemented in drivers/net/thunderbolt.c)
  - Host and device NVM firmware upgrade

We also add two new sysfs attributes under each device that expose link
speed and width to userspace. The rest of the userspace ABI stays the same.

I'm including Linux USB folks as well because USB4 is officially coming
from USB-IF which puts us on same boat now.

While I changed the user visible Kconfig string to mention "USB4" (the
Kconfig option is still CONFIG_THUNDERBOLT), I'm wondering whether we
should move the whole Thunderbolt driver under drivers/usb/thunderbolt as
well? 

Mika Westerberg (19):
  thunderbolt: Introduce tb_switch_is_icm()
  thunderbolt: Log switch route string on config read/write timeout
  thunderbolt: Log warning if adding switch fails
  thunderbolt: Make tb_sw_write() take const parameter
  thunderbolt: Add helper macros to iterate over switch ports
  thunderbolt: Add support for lane bonding
  thunderbolt: Add default linking between ports if not provided by DROM
  thunderbolt: Add downstream PCIe port mappings for Alpine and Titan Ridge
  thunderbolt: Convert basic adapter register names to follow the USB4 spec
  thunderbolt: Convert PCIe adapter register names to use USB4 names
  thunderbolt: Convert DP adapter register names to follow the USB4 spec
  thunderbolt: Add Display Port CM handshake for Titan Ridge devices
  thunderbolt: Add Display Port adapter pairing and resource management
  thunderbolt: Add bandwidth management for Display Port tunnels
  thunderbolt: Make tb_find_port() available to other files
  thunderbolt: Call tb_eeprom_get_drom_offset() from tb_eeprom_read_n()
  thunderbolt: Add initial support for USB4
  thunderbolt: Update documentation with the USB4 information
  thunderbolt: Do not start firmware unless asked by the user

Rajmohan Mani (3):
  thunderbolt: Make tb_switch_find_cap() available to other files
  thunderbolt: Add support for Time Management Unit
  thunderbolt: Add support for USB tunnels

 .../ABI/testing/sysfs-bus-thunderbolt         |  17 +
 Documentation/admin-guide/thunderbolt.rst     |  27 +-
 drivers/thunderbolt/Kconfig                   |   9 +-
 drivers/thunderbolt/Makefile                  |   2 +-
 drivers/thunderbolt/cap.c                     |  11 +-
 drivers/thunderbolt/ctl.c                     |   8 +-
 drivers/thunderbolt/eeprom.c                  | 146 +--
 drivers/thunderbolt/icm.c                     |  36 +-
 drivers/thunderbolt/lc.c                      | 193 +++-
 drivers/thunderbolt/nhi.c                     |   3 +
 drivers/thunderbolt/nhi.h                     |   2 +
 drivers/thunderbolt/path.c                    |  52 +-
 drivers/thunderbolt/switch.c                  | 870 +++++++++++++++---
 drivers/thunderbolt/tb.c                      | 529 +++++++++--
 drivers/thunderbolt/tb.h                      | 198 +++-
 drivers/thunderbolt/tb_msgs.h                 |   2 +
 drivers/thunderbolt/tb_regs.h                 | 160 +++-
 drivers/thunderbolt/tmu.c                     | 380 ++++++++
 drivers/thunderbolt/tunnel.c                  | 517 ++++++++++-
 drivers/thunderbolt/tunnel.h                  |  19 +-
 drivers/thunderbolt/usb4.c                    | 761 +++++++++++++++
 drivers/thunderbolt/xdomain.c                 |   8 +-
 22 files changed, 3578 insertions(+), 372 deletions(-)
 create mode 100644 drivers/thunderbolt/tmu.c
 create mode 100644 drivers/thunderbolt/usb4.c

-- 
2.23.0

