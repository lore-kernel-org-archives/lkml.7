Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356F2C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 23:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A7420721
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 23:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfLIXz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 18:55:28 -0500
Received: from mga02.intel.com ([134.134.136.20]:13468 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbfLIXz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 18:55:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 15:55:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,297,1571727600"; 
   d="scan'208";a="210273596"
Received: from bbower-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.65.172])
  by fmsmga008.fm.intel.com with ESMTP; 09 Dec 2019 15:55:25 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 00/11] soundwire: update ASoC interfaces
Date:   Mon,  9 Dec 2019 17:55:08 -0600
Message-Id: <20191209235520.18727-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need new fields in existing structures to
a) deal with race conditions on codec probe/enumeration
b) allow for multi-step ACPI scan/probe/startup on Intel plaforms
c) deal with MSI issues using a single handler/threads for all audio
interrupts
d) deal with access to registers shared across multiple links on Intel
platforms

These structures for a) will be used by the SOF driver as well as
codec drivers. The b) c) and d) cases are only for the Intel-specific
implementation.

To avoid conflicts between ASoC and Soundwire trees, these 11 patches
are provided out-of-order, before the functionality enabled in these
header files is added in follow-up patch series which can be applied
separately in the ASoC and Soundwire trees. As discussed earlier,
Vinod would need to provide an immutable tag for Mark Brown, and the
integration on the ASoC side of SOF changes and new codecs drivers can
proceed in parallel with SoundWire core changes.

I had multiple offline discussions with Vinod/Mark/Takashi on how to
proceed withe volume of SoundWire changes. Now that v5.5-rc1 is out we
should go ahead with these interface changes. The next patchset has
not changed, the series "[PATCH v3 00/15] soundwire: intel: implement
new ASoC interfaces​" can still be reviewed.

An update for the series "[PATCH v3 00/22] soundwire: code hardening
and suspend-resume support" will be provided later this week (one last
minute issue to fix)

Comments and feedback welcome
~Pierre

Changes since v3:
Reordered code and added kernel doc comments
Added prototypes and fields needed to deal with SoundWire interrupts
in a single handler/thread, following what is already done on the DSP
side.
Added mutex to control access to registers shared across links
Added initial definitions for clock stop support on Intel
platforms. Depending on power and latency requirements, different
"quirks" can be supported.

Changes since v2:
Added new field to deal with a race condition leading to a timeout
when the codec goes through a pm_runtime suspend/resume transition
while the Master remains active.
Clarified commit messages with detailed explanations what those race
conditions are and why the changes were introduced.
Reordered fields for Intel routines
Added kernel-doc definitions for structures
Modified the patch subjects to make the mapping between interface definition
and implementation straightforward.

Changes since v1 (no feedback received since October 23)
additional initialization_complete utility to help codec drivers with
their resume operation, waiting for the enumeration to complete is not
always enough.

Bard Liao (2):
  soundwire: intel: update headers for interrupts
  soundwire: intel: add link_list to handle interrupts with a single
    thread

Pierre-Louis Bossart (7):
  soundwire: sdw_slave: add probe_complete structure and new fields
  soundwire: sdw_slave: add enumeration_complete structure
  soundwire: sdw_slave: add initialization_complete definition
  soundwire: sdw_slave: track unattach_request to handle all init
    sequences
  soundwire: intel: update interfaces between ASoC and SoundWire
  soundwire: intel: add mutex for shared SHIM register access
  soundwire: intel: add clock stop quirks

Rander Wang (2):
  soundwire: intel: update stream callbacks for hwparams/free stream
    operations
  soundwire: intel: add prototype for WAKEEN interrupt processing

 drivers/soundwire/intel.c           |  20 ++--
 drivers/soundwire/intel.h           |  13 ++-
 drivers/soundwire/intel_init.c      |  31 ++----
 include/linux/soundwire/sdw.h       |  19 ++++
 include/linux/soundwire/sdw_intel.h | 154 ++++++++++++++++++++++++++--
 5 files changed, 194 insertions(+), 43 deletions(-)


base-commit: e42617b825f8073569da76dc4510bfa019b1c35a
-- 
2.20.1

