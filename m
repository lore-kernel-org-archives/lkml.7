Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709FDC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E35320731
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfKNSRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:17:30 -0500
Received: from mga03.intel.com ([134.134.136.65]:36344 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbfKNSR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:17:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 10:17:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; 
   d="scan'208";a="195123359"
Received: from chiahuil-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.228.77])
  by orsmga007.jf.intel.com with ESMTP; 14 Nov 2019 10:17:27 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 00/22] soundwire: code hardening and suspend-resume support
Date:   Thu, 14 Nov 2019 12:16:40 -0600
Message-Id: <20191114181702.22254-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patchset applies on top of "[PATCH v3 00/15] soundwire: intel:
implement new ASoC interfaces".

It implements a series of improvements for:
a) interrupt handling on Intel platforms in MSI mode
b) race conditions on codec probe and enumeration
c) suspend-resume issues (clock-stop mode not supported for now)
d) underflow handling
e) updates to the stream state machine which did not support valid
ALSA transitions.

These patches were tested extensively on 4 different platforms and are
viewed as required for any sort of SoundWire-based product. While
tested extensively on Intel platforms only, they should also benefit
Qualcomm platforms who haven't yet enabled power management.

Changes since v2: (no feedback received since November 6)
Added idle scheduling to deal with pm_runtime issues when devices are
exposed in the DSDT, but are not populated on the board. A quirk is
introduced to deal with potential cases where the devices might be
powered at a later time, in which case it's legit to leave the bus
active.
Fixed .prepare callback to handle both underflow and resume cases. The
previous version was incorrect in the first case and did not follow
recommended programming sequence
Fixed an additional race condition leading to a timeout when the codec
device was suspended while the master remained active.
Fixed a couple of warnings reported by static analysis
Removed non-essential pr_err() traces in stream.c, left others when
useful
Changed subject of patches dealing with race conditions to make sure
reviewers can link with the interface changes.


Changes since v1: (no feedback received since October 23)
added support for initialization_complete, integration with Realtek
codecs exposed an additional race condition between the resume
operation and restoration of settings in separate thread triggered by
Slave status change.
No other functional change

Bard Liao (3):
  soundwire: intel/cadence: fix timeouts in MSI mode
  soundwire: stream: only prepare stream when it is configured.
  soundwire: intel: reinitialize IP+DSP in .prepare(), but only when
    resuming

Pierre-Louis Bossart (19):
  soundwire: bus: fix race condition with probe_complete signaling
  soundwire: bus: add PM/no-PM versions of read/write functions
  soundwire: bus: write Slave Device Number without runtime_pm
  soundwire: intel: add helpers for link power down and shim wake
  soundwire: intel: Add basic power management support
  soundwire: intel: add pm_runtime support
  soundwire: intel: reset pm_runtime status during system resume
  soundwire: bus: add helper to reset Slave status to UNATTACHED
  soundwire: intel: call helper to reset Slave states on resume
  soundwire: bus: check first if Slaves become UNATTACHED
  soundwire: bus: fix race condition with enumeration_complete signaling
  soundwire: bus: fix race condition with initialization_complete
    signaling
  soundwire: bus: fix race condition by tracking UNATTACHED transition
  soundwire: intel: disable pm_runtime when removing a master
  soundwire: bus: disable pm_runtime in sdw_slave_delete
  soundwire: stream: remove redundant pr_err traces
  soundwire: stream: update state machine and add state checks
  soundwire: stream: do not update parameters during DISABLED-PREPARED
    transition
  soundwire: intel: pm_runtime idle scheduling

 Documentation/driver-api/soundwire/stream.rst |  63 ++-
 drivers/soundwire/bus.c                       | 169 +++++++-
 drivers/soundwire/bus.h                       |   9 +
 drivers/soundwire/bus_type.c                  |   5 +
 drivers/soundwire/cadence_master.c            |  17 +-
 drivers/soundwire/cadence_master.h            |   8 +
 drivers/soundwire/intel.c                     | 400 ++++++++++++++++--
 drivers/soundwire/intel.h                     |   2 +
 drivers/soundwire/intel_init.c                |  45 +-
 drivers/soundwire/slave.c                     |   4 +
 drivers/soundwire/stream.c                    |  71 +++-
 include/linux/soundwire/sdw.h                 |   1 +
 include/linux/soundwire/sdw_intel.h           |   4 +
 13 files changed, 714 insertions(+), 84 deletions(-)

-- 
2.20.1

