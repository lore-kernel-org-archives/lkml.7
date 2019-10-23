Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C85BCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E642064A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404802AbfJWLWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 07:22:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:29695 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404659AbfJWLWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:22:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 04:21:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; 
   d="scan'208";a="399359438"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 23 Oct 2019 04:21:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 001041CC; Wed, 23 Oct 2019 14:21:54 +0300 (EEST)
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
        Oliver Neukum <oneukum@suse.com>,
        Christian Kellner <ckellner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/25] thunderbolt: Add support for USB4
Date:   Wed, 23 Oct 2019 14:21:29 +0300
Message-Id: <20191023112154.64235-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

USB4 is the public specification of Thunderbolt 3 protocol and can be
downloaded here:

  https://www.usb.org/sites/default/files/USB4%20Specification_1.zip

USB4 is about tunneling different protocols over a single cable (in the
same way as Thunderbolt). The current USB4 spec supports PCIe, Display Port
and USB 3.x, and also software based protocols such as networking between
domains (hosts).

So far PCs have been using firmware based Connection Manager (FW CM, ICM)
and Apple systems have been using software based one (SW CM, ECM). A
Connection Manager is the entity that handles creation of different tunnel
types through the USB4 (and Thunderbolt) fabric. With USB4 the plan is to
have software based Connection Manager everywhere but some early systems
will also support firmware to allow OS downgrade for example.

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

The previous RFC version of the series can be seen here:

  https://lore.kernel.org/lkml/20191001113830.13028-1-mika.westerberg@linux.intel.com/

Changes from the RFC version:

  * Spelled out what are ICM, and SW CM (and ECM)
  * Log warning in tb_switch_add() instead of the caller
  * Use Lukas' suggestion in port walk helper macro and also drop
    tb_switch_for_each_remote_port() and tb_switch_for_each_connected_port()
  * Rework icm.c::add_switch() so that we don't need to pass huge amount of
    parameters to it
  * Add rx/tx versions of link width/speed attributes following convention
    used in USB bus (with the exception that we provide rx_speed and
    tx_speed as well).
  * Spell out DROM and try to clarify what linking in patch [11/25] means.
  * Add a new patch that expands controller name in existing tb_switch_is_xy()
    functions and do the same for tb_switch_is_ar()/tr().
  * Move register name conversion pathes up in the series so that we can
    apply them for v5.5 already.
  * Update changelog of patch [14/25] so that it only mentions Titan Ridge.
  * Rename CONFIG_THUNDERBOLT to CONFIG_USB4, this should be more future
    proof.
  * Check if TMU is enabled in tb_switch_tmu_enable().
  * Use "usb3" and "USB3" in USB 3.x tunneling functionality instead of
    plain "usb".
  * Reword documentation patch [25/25] according to received comments.
  * Introduce icm_firmware_running().

I did not yet add the hw_vendor_id and hw_product_id attributes because I
clocked that 'dd if=nvm_activeX/nvmem of=/dev/null bs=64 count=2' (that's
what fwupd does) takes typically less than 10 ms when the controller is
powered on. That should not slow down fwupd. We can add them later if it is
really a problem (I'm just trying to avoid adding too much attributes that
we need to maintain forever).

I think patches 1 to 17 can be applied for v5.5 already since they are
pretty much about adding support for existing Thunderbolt 3 devices to the
software connection manager. This allows Apple systems with Alpine or Titan
Ridge controller to work without need to start the firmware. Please let me
know if there are objections.

USB4 support patches 18 - 25 have been tested on development hardware but
since it is rather early stage hardware we have not been able to properly
test all features such as power management (which is why it is currently
missing in this series).

Mika Westerberg (22):
  thunderbolt: Introduce tb_switch_is_icm()
  thunderbolt: Log switch route string on config read/write timeout
  thunderbolt: Log error if adding switch fails
  thunderbolt: Convert basic adapter register names to follow the USB4 spec
  thunderbolt: Convert PCIe adapter register names to follow the USB4 spec
  thunderbolt: Convert DP adapter register names to follow the USB4 spec
  thunderbolt: Make tb_sw_write() take const parameter
  thunderbolt: Add helper macro to iterate over switch ports
  thunderbolt: Refactor add_switch() into two functions
  thunderbolt: Add support for lane bonding
  thunderbolt: Add default linking between lane adapters if not provided by DROM
  thunderbolt: Expand controller name in tb_switch_is_xy()
  thunderbolt: Add downstream PCIe port mappings for Alpine and Titan Ridge
  thunderbolt: Add Display Port CM handshake for Titan Ridge devices
  thunderbolt: Add Display Port adapter pairing and resource management
  thunderbolt: Add bandwidth management for Display Port tunnels
  thunderbolt: Do not start firmware unless asked by the user
  thunderbolt: Make tb_find_port() available to other files
  thunderbolt: Call tb_eeprom_get_drom_offset() from tb_eeprom_read_n()
  thunderbolt: Add initial support for USB4
  thunderbolt: Update Kconfig entry to USB4
  thunderbolt: Update documentation with the USB4 information

Rajmohan Mani (3):
  thunderbolt: Make tb_switch_find_cap() available to other files
  thunderbolt: Add support for Time Management Unit
  thunderbolt: Add support for USB 3.x tunnels

 .../ABI/testing/sysfs-bus-thunderbolt         |  28 +
 Documentation/admin-guide/thunderbolt.rst     |  25 +-
 drivers/Makefile                              |   2 +-
 drivers/net/Kconfig                           |   2 +-
 drivers/thunderbolt/Kconfig                   |  11 +-
 drivers/thunderbolt/Makefile                  |   4 +-
 drivers/thunderbolt/cap.c                     |  17 +-
 drivers/thunderbolt/ctl.c                     |   8 +-
 drivers/thunderbolt/eeprom.c                  | 146 +--
 drivers/thunderbolt/icm.c                     | 157 +--
 drivers/thunderbolt/lc.c                      | 193 +++-
 drivers/thunderbolt/nhi.c                     |   3 +
 drivers/thunderbolt/nhi.h                     |   2 +
 drivers/thunderbolt/path.c                    |  52 +-
 drivers/thunderbolt/switch.c                  | 943 +++++++++++++++---
 drivers/thunderbolt/tb.c                      | 536 ++++++++--
 drivers/thunderbolt/tb.h                      | 182 +++-
 drivers/thunderbolt/tb_msgs.h                 |   2 +
 drivers/thunderbolt/tb_regs.h                 | 160 ++-
 drivers/thunderbolt/tmu.c                     | 383 +++++++
 drivers/thunderbolt/tunnel.c                  | 527 +++++++++-
 drivers/thunderbolt/tunnel.h                  |  19 +-
 drivers/thunderbolt/usb4.c                    | 763 ++++++++++++++
 drivers/thunderbolt/xdomain.c                 |  11 +-
 24 files changed, 3718 insertions(+), 458 deletions(-)
 create mode 100644 drivers/thunderbolt/tmu.c
 create mode 100644 drivers/thunderbolt/usb4.c

-- 
2.23.0

