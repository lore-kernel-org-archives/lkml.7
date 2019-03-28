Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4FFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3E2217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfC1Mgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:36:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:12039 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfC1Mgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:36:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 05:36:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="138136858"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 28 Mar 2019 05:36:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id AE1EB15A; Thu, 28 Mar 2019 14:36:33 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        Mario.Limonciello@dell.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        netdev@vger.kernel.org
Subject: [PATCH v3 00/36] thunderbolt: Software connection manager improvements
Date:   Thu, 28 Mar 2019 15:35:57 +0300
Message-Id: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is third iteration of the patch series intending to bring same kind of
functionality for older Apple systems than we have in PCs. Software
connection manager is used on Apple hardware with Light Ridge, Cactus Ridge
or Falcon Ridge controllers to create PCIe tunnels when a Thunderbolt
device is connected. Currently only one PCIe tunnel is supported. On newer
Alpine Ridge based Apple systems the driver starts the firmware which then
takes care creating tunnels.

This series improves the software connection manager so that it will
support:

  - Full PCIe daisy chains (up to 6 devices)
  - Display Port tunneling
  - P2P networking

We also add support for Titan Ridge based Apple systems where we can use
the same flows than with Alpine Ridge to start the firmware.

This applies on top of thunderbolt.git/next.

Christian, Mario do you see any issues with patch [05/36] regarding bolt
and fwupd? The kernel is supposed to restart the syscall automatically so
userspace should not be affected but wanted to check with you.

Previous version of the patch series can be viewed here:

  v2: https://lkml.org/lkml/2019/2/6/347
  v1: https://lkml.org/lkml/2019/1/29/924

Making v3 took longer than I anticipated mostly due to some issues I run
during testing the new changes. There are quite many changes so I dropped
the reviewed-by tags I got for v2. Below is the list of major changes from
the previous version:

  * Always set port->remote even in case of dual link connection.

  * Leave (DP, PCIe) tunnels up when the driver is unloaded. When loaded
    back, it discovers the existing tunnels and updated data structures
    accordingly. I noticed that the code in v2 did not support cases
    properly when you unplug something before the driver gets loaded back.
    This version tears down partial paths during discovery.

  * Do not automatically create PCIe tunnels. Instead we implement "user"
    security level in the software connection manager as well taking
    advantage of the existing sysfs interfaces. This allows user to disable
    PCIe tunneling completely or implement different white listing
    policies. Major distros include bolt system daemon that takes care of
    this.

  * When testing on two-port Falcon Ridge based system I realized
    that we always just pick the first available PCIe downstream adapter
    regardless of which Thunderbolt port you plug the device which is not
    consistent. To solve this we add mapping between host PCIe downstream
    adapter and the Thunderbolt port for Cactus Ridge and Falcon Ridge
    based systems.

  * Take domain lock in switch sysfs callbacks. This is needed because the
    software connection manager needs to walk over the topology during
    tunnel creation so switch_lock is not enough anymore.

Changes from v1:

  * Added ACK from David

  * Add constant (TMU_ACCESS_EN) for BIT(20) when TMU access is enabled. We
    keep it in cap.c close to the LR/ER workaround. Also we enable/disable
    only during capability walk. If it turns we need to have it enabled
    elsewhere we can move it to switch.c and enable just once during
    switch enumeration.

  * Use 0 to mean no cap_adap instead of negative value. This follows
    cap_phy.

  * Use correct PCI IDs (_BRIDGE) in the last patch where we start firmware
    on Titan Ridge. It wrongly used NHI PCI IDs in v1.

Mika Westerberg (36):
  net: thunderbolt: Unregister ThunderboltIP protocol handler when suspending
  thunderbolt: Remove unused work field in struct tb_switch
  thunderbolt: Drop duplicated get_switch_by_route()
  thunderbolt: Block reads and writes if switch is unplugged
  thunderbolt: Take domain lock in switch sysfs attribute callbacks
  thunderbolt: Do not allocate switch if depth is greater than 6
  thunderbolt: Enable TMU access when accessing port space on legacy devices
  thunderbolt: Add dummy read after port capability list walk on Light Ridge
  thunderbolt: Move LC specific functionality into a separate file
  thunderbolt: Configure lanes when switch is initialized
  thunderbolt: Set sleep bit when suspending switch
  thunderbolt: Properly disable path
  thunderbolt: Cache adapter specific capability offset into struct port
  thunderbolt: Rename tunnel_pci to tunnel
  thunderbolt: Generalize tunnel creation functionality
  thunderbolt: Add functions for allocating and releasing HopIDs
  thunderbolt: Assign remote for both ports in case of dual link
  thunderbolt: Add helper function to iterate from one port to another
  thunderbolt: Extend tunnel creation to more than 2 adjacent switches
  thunderbolt: Deactivate all paths before restarting them
  thunderbolt: Discover preboot PCIe paths the boot firmware established
  thunderbolt: Add support for full PCIe daisy chains
  thunderbolt: Scan only valid NULL adapter ports in hotplug
  thunderbolt: Generalize port finding routines to support all port types
  thunderbolt: Rework NFC credits handling
  thunderbolt: Add support for Display Port tunnels
  thunderbolt: Do not tear down tunnels when driver is unloaded
  thunderbolt: Run tb_xdp_handle_request() in system workqueue
  thunderbolt: Add XDomain UUID exchange support
  thunderbolt: Add support for DMA tunnels
  thunderbolt: Make tb_switch_alloc() return ERR_PTR()
  thunderbolt: Add support for XDomain connections
  thunderbolt: Make __TB_[SW|PORT]_PRINT take const parameters
  thunderbolt: Make rest of the logging to happen at debug level
  thunderbolt: Reword output of tb_dump_hop()
  thunderbolt: Start firmware on Titan Ridge Apple systems

 drivers/net/thunderbolt.c        |   3 +
 drivers/thunderbolt/Makefile     |   4 +-
 drivers/thunderbolt/cap.c        |  85 +++-
 drivers/thunderbolt/ctl.c        |   2 +-
 drivers/thunderbolt/icm.c        |  60 ++-
 drivers/thunderbolt/lc.c         | 179 ++++++++
 drivers/thunderbolt/nhi.c        |   3 +-
 drivers/thunderbolt/path.c       | 421 ++++++++++++++++---
 drivers/thunderbolt/switch.c     | 551 +++++++++++++++++++-----
 drivers/thunderbolt/tb.c         | 608 ++++++++++++++++++++-------
 drivers/thunderbolt/tb.h         | 173 +++++++-
 drivers/thunderbolt/tb_msgs.h    |  11 +
 drivers/thunderbolt/tb_regs.h    |  50 ++-
 drivers/thunderbolt/tunnel.c     | 691 +++++++++++++++++++++++++++++++
 drivers/thunderbolt/tunnel.h     |  78 ++++
 drivers/thunderbolt/tunnel_pci.c | 226 ----------
 drivers/thunderbolt/tunnel_pci.h |  31 --
 drivers/thunderbolt/xdomain.c    | 147 ++++++-
 include/linux/thunderbolt.h      |   8 +
 19 files changed, 2680 insertions(+), 651 deletions(-)
 create mode 100644 drivers/thunderbolt/lc.c
 create mode 100644 drivers/thunderbolt/tunnel.c
 create mode 100644 drivers/thunderbolt/tunnel.h
 delete mode 100644 drivers/thunderbolt/tunnel_pci.c
 delete mode 100644 drivers/thunderbolt/tunnel_pci.h

-- 
2.20.1

