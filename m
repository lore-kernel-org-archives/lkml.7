Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0067C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 13:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD30122D6D
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 13:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfHaN4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 09:56:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:18917 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbfHaN4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 09:56:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Aug 2019 06:56:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,451,1559545200"; 
   d="scan'208";a="198244965"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 31 Aug 2019 06:56:17 -0700
Received: by lahna (sSMTP sendmail emulation); Sat, 31 Aug 2019 16:56:16 +0300
Date:   Sat, 31 Aug 2019 16:56:16 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Thunderbolt changes for v5.4
Message-ID: <20190831135616.GR3177@lahna.fi.intel.com>
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

The following changes since commit e21a712a9685488f5ce80495b37b9fdbe96c230d:

  Linux 5.3-rc3 (2019-08-04 18:40:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git tags/thunderbolt-for-v5.4

for you to fetch changes up to dfda204198848b47bdb98ab83b94dbb7c7692b55:

  ACPI / property: Add two new Thunderbolt property GUIDs to the list (2019-08-26 12:15:11 +0300)

----------------------------------------------------------------
thunderbolt: Changes for v5.4 merge window

The biggest change is the addition of Intel Ice Lake integrated
Thunderbolt support. There are also a couple of smaller changes like
converting the driver to use better device property interface and use
correct format string in service key attribute.

----------------------------------------------------------------
Andy Shevchenko (1):
      thunderbolt: Switch to use device_property_count_uXX()

J. Bruce Fields (1):
      thunderbolt: Show key using %*pE not %*pEp

Mika Westerberg (8):
      thunderbolt: Correct path indices for PCIe tunnel
      thunderbolt: Move NVM upgrade support flag to struct icm
      thunderbolt: Use 32-bit writes when writing ring producer/consumer
      thunderbolt: Do not fail adding switch if some port is not implemented
      thunderbolt: Hide switch attributes that are not set
      thunderbolt: Expose active parts of NVM even if upgrade is not supported
      thunderbolt: Add support for Intel Ice Lake
      ACPI / property: Add two new Thunderbolt property GUIDs to the list

 drivers/acpi/property.c        |   6 ++
 drivers/thunderbolt/Makefile   |   2 +-
 drivers/thunderbolt/ctl.c      |  23 ++++-
 drivers/thunderbolt/eeprom.c   |   6 +-
 drivers/thunderbolt/icm.c      | 194 +++++++++++++++++++++++++++++++++++++----
 drivers/thunderbolt/nhi.c      | 134 +++++++++++++++++++++++++---
 drivers/thunderbolt/nhi.h      |  22 +++++
 drivers/thunderbolt/nhi_ops.c  | 179 +++++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/nhi_regs.h |  37 ++++++++
 drivers/thunderbolt/switch.c   |  52 ++++++++---
 drivers/thunderbolt/tb_msgs.h  |  16 +++-
 drivers/thunderbolt/tunnel.c   |   4 +-
 drivers/thunderbolt/xdomain.c  |   2 +-
 include/linux/thunderbolt.h    |   2 +
 14 files changed, 624 insertions(+), 55 deletions(-)
 create mode 100644 drivers/thunderbolt/nhi_ops.c
