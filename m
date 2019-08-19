Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19412C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 20:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF882087E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 20:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbfHSUqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 16:46:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:38630 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbfHSUqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 16:46:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 13:46:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,406,1559545200"; 
   d="scan'208";a="202443670"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by fmsmga004.fm.intel.com with ESMTP; 19 Aug 2019 13:46:17 -0700
From:   thor.thayer@linux.intel.com
To:     mdf@kernel.org, richard.gong@intel.com, agust@denx.de
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [RESEND PATCHv4 0/3] fpga: altera-cvp: Add Stratix10 Support
Date:   Mon, 19 Aug 2019 15:48:05 -0500
Message-Id: <1566247688-26070-1-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Newer versions (V2) of Altera/Intel FPGAs CvP have different PCI
Vendor Specific Capability offsets than the older (V1) Altera/FPGAs.

Most of the CvP registers and their bitfields remain the same
between both the older parts and the newer parts.

This patchset implements changes to discover the Vendor Specific
Capability offset and then add Stratix10 CvP support.

V2 Changes:
  Remove inline designator from abstraction functions.
  Reverse Christmas Tree format for local variables
  Remove redundant mask from credit calculation
  Add commment for the delay(1) function in wait_for_credit()

V3 Changes
  Return int instead of void for abstraction functions
  Check the return code from read in altera_cvp_chk_error()
  Move reset of current_credit_byte to clear_state().
  Check return codes of read/writes in added functions.

V4 Changes
  Rename delta_credit to space
  Simplify wait for credit do-while loop.
  Change from udelay() to usleep_range()
  Use min() to find length to send
  Remove NULL initialization from private structure
  Use #define for Version1 offsets
  Change current_credit_byte to u32 sent_packets.
  Changes to Kconfig title and description to support Stratix10.

Thor Thayer (3):
  fpga: altera-cvp: Discover Vendor Specific offset
  fpga: altera-cvp: Preparation for V2 parts.
  fpga: altera-cvp: Add Stratix10 (V2) Support

 drivers/fpga/Kconfig      |   6 +-
 drivers/fpga/altera-cvp.c | 339 ++++++++++++++++++++++++++++++++++++----------
 2 files changed, 271 insertions(+), 74 deletions(-)

-- 
2.7.4

