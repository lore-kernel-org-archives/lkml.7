Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226B0C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 00:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E982075C
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 00:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfEDA3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 20:29:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:11134 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfEDA3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 20:29:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 17:29:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,427,1549958400"; 
   d="scan'208";a="170430416"
Received: from jlwhitty-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.28.45])
  by fmsmga001.fm.intel.com with ESMTP; 03 May 2019 17:29:38 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/8] soundwire: corrections to ACPI and DisCo properties
Date:   Fri,  3 May 2019 19:29:18 -0500
Message-Id: <20190504002926.28815-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we are done with cleanups, we can start fixing the code with
actual semantic or functional changes.

This patchset applies on top of everything Vinod and I contributed
this week.

The fist patch correct a simplifying assumption made earlier. With the
IceLake BIOS the existing code is fooled by the presence of a second
child device and the namespace walk needs to be filtered. This was not
needed on previous generations.

The second patch fixes a long-standing misalignment between code and
DisCo specification, preventing MIPI DisCo properties from being
parsed successfully.

The third and fourth patch remove restrictions preventing codec
drivers from reading DisCo properties.

The fifth patch adds definitions from the SoundWire spec that were
missed somehow, but will be very much needed for dynamic bandwidth
allocation.

The last 3 patches realign the code with the MIPI specification. The
existing code exposes properties that don't exist, or exposes them
with ambiguous wording. Sticking to the specification helps avoid
interpretation issues for integrators, and will make sure the
follow-up sysfs support is self-explanatory.

Parts of this code was initially written by my Intel colleagues Vinod
Koul, Sanyog Kale, Shreyas Nc and Hardik Shah, who are either no
longer with Intel or no longer involved in SoundWire development. When
relevant, I explictly added a note in commit messages to give them
credit for their hard work, but I removed their signed-off-by tags to
avoid email bounces and avoid spamming them forever with SoundWire
patches.

Pierre-Louis Bossart (8):
  soundwire: intel: filter SoundWire controller device search
  soundwire: mipi_disco: fix master/link error
  soundwire: mipi_disco: expose sdw_slave_read_dpn as symbol
  soundwire: mipi_disco: expose sdw_slave_read_dp0 as symbol
  soundwire: add port-related definitions
  soundwire: remove master data port properties
  soundwire: fix master properties
  soundwire: rename/clarify MIPI DisCo properties

 drivers/soundwire/bus.c        |  6 +--
 drivers/soundwire/intel.c      | 11 ++--
 drivers/soundwire/intel_init.c | 19 ++++++-
 drivers/soundwire/mipi_disco.c | 49 +++++++++---------
 drivers/soundwire/stream.c     |  8 +--
 include/linux/soundwire/sdw.h  | 94 +++++++++++++++++++++++++++-------
 6 files changed, 132 insertions(+), 55 deletions(-)

-- 
2.17.1

