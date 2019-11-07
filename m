Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59E7C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7075214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388938AbfKGNSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:18:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:23195 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727142AbfKGNSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:18:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 05:18:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,278,1569308400"; 
   d="scan'208";a="213019851"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 07 Nov 2019 05:18:44 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 07 Nov 2019 15:18:43 +0200
Date:   Thu, 7 Nov 2019 15:18:43 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [GIT PULL] Thunderbolt changes for v5.5
Message-ID: <20191107131843.GL2552@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please pull Thunderbolt changes for v5.5 merge window. I needed to merge
my fixes branch here because there is dependency between some of the
commits. The fixes branch is already included in your char-misc-linus
branch.

Thanks!

The following changes since commit da0c9ea146cbe92b832f1b0f694840ea8eb33cce:

  Linux 5.4-rc2 (2019-10-06 14:27:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git tags/thunderbolt-for-v5.5

for you to fetch changes up to 354a7a7716edb377953a324421915d7788e0bca9:

  thunderbolt: Do not start firmware unless asked by the user (2019-11-02 12:13:31 +0300)

----------------------------------------------------------------
thunderbolt: Changes for v5.5 merge window

This adds Thunderbolt 3 support for the software connection manager. It
is currently only used in Apple systems. Previously the driver started
the firmware connection manager on those but it is not necessary anymore
with these patches (we still leave user an option to start the firmware
in case there are problems with the software connection manager).

This includes:

  - Expose 'generation' attribute under each device in sysfs
  - Converting register names to follow the USB4 spec.
  - Lane bonding support
  - Expose link speed and width in sysfs
  - Display Port handshake needed for Titan Ridge devices
  - Display Port pairing and resource management
  - Display Port bandwidth management

----------------------------------------------------------------
Christian Kellner (1):
      thunderbolt: Add 'generation' attribute for devices

Mika Westerberg (21):
      thunderbolt: Read DP IN adapter first two dwords in one go
      thunderbolt: Fix lockdep circular locking depedency warning
      thunderbolt: Drop unnecessary read when writing LC command in Ice Lake
      Merge branch 'thunderbolt/fixes' into thunderbolt/next
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

 Documentation/ABI/testing/sysfs-bus-thunderbolt |  36 ++
 drivers/thunderbolt/cap.c                       |   6 +-
 drivers/thunderbolt/ctl.c                       |   8 +-
 drivers/thunderbolt/eeprom.c                    |  11 -
 drivers/thunderbolt/icm.c                       | 157 ++++---
 drivers/thunderbolt/lc.c                        | 193 ++++++++-
 drivers/thunderbolt/nhi_ops.c                   |   1 -
 drivers/thunderbolt/path.c                      |  52 ++-
 drivers/thunderbolt/switch.c                    | 544 ++++++++++++++++++++----
 drivers/thunderbolt/tb.c                        | 340 ++++++++++++---
 drivers/thunderbolt/tb.h                        |  81 +++-
 drivers/thunderbolt/tb_msgs.h                   |   2 +
 drivers/thunderbolt/tb_regs.h                   |  97 +++--
 drivers/thunderbolt/tunnel.c                    | 364 +++++++++++++++-
 drivers/thunderbolt/tunnel.h                    |  10 +-
 drivers/thunderbolt/xdomain.c                   |   5 +-
 16 files changed, 1631 insertions(+), 276 deletions(-)
