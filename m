Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63467CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1FA2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407637AbfJWVqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 17:46:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:39636 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389396AbfJWVqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 17:46:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 14:46:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400"; 
   d="scan'208";a="196908081"
Received: from ayamada-mobl1.gar.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.95.208])
  by fmsmga008.fm.intel.com with ESMTP; 23 Oct 2019 14:46:09 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 00/18] soundwire: code hardening and suspend-resume support
Date:   Wed, 23 Oct 2019 16:45:43 -0500
Message-Id: <20191023214601.883-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patchset applies on top of "[PATCH 00/14] soundwire: intel:
implement new ASoC interfaces". It implements a series of improvements
for:
a) interrupt handling on Intel platforms in MSI mode
b) race conditions on codec probe and enumeration
c) suspend-resume issues (clock-stop mode not supported for now)
d) underflow handling
e) updates to the stream state machine which did not support valid
ALSA transitions.

These patches were tested extensively on 4 different platforms and are
viewed as required for any sort of SoundWire-based product.

Bard Liao (3):
  soundwire: intel/cadence: fix timeouts in MSI mode
  soundwire: stream: only prepare stream when it is configured.
  soundwire: intel: reinitialize IP+DSP in .prepare()

Pierre-Louis Bossart (15):
  soundwire: fix race between driver probe and update_status callback
  soundwire: bus: add PM/no-PM versions of read/write functions
  soundwire: bus: write Slave Device Number without runtime_pm
  soundwire: intel: add helpers for link power down and shim wake
  soundwire: intel: Add basic power management support
  soundwire: intel: add pm_runtime support
  soundwire: intel: reset pm_runtime status during system resume
  soundwire: bus: add helper to reset Slave status to UNATTACHED
  soundwire: intel: call helper to reset Slave states on resume
  soundwire: bus: check first if Slaves become UNATTACHED
  soundwire: add enumeration_complete signaling
  soundwire: intel: disable pm_runtime when removing a master
  soundwire: bus: disable pm_runtime in sdw_slave_delete
  soundwire: stream: update state machine and add state checks
  soundwire: stream: do not update parameters during DISABLED-PREPARED
    transition

 Documentation/driver-api/soundwire/stream.rst |  63 +++-
 drivers/soundwire/bus.c                       | 157 +++++++--
 drivers/soundwire/bus.h                       |   3 +
 drivers/soundwire/bus_type.c                  |   5 +
 drivers/soundwire/cadence_master.c            |  17 +-
 drivers/soundwire/cadence_master.h            |   4 +
 drivers/soundwire/intel.c                     | 328 ++++++++++++++++--
 drivers/soundwire/intel.h                     |   2 +
 drivers/soundwire/intel_init.c                |  45 ++-
 drivers/soundwire/slave.c                     |   3 +
 drivers/soundwire/stream.c                    |  64 +++-
 include/linux/soundwire/sdw.h                 |   1 +
 include/linux/soundwire/sdw_intel.h           |   2 +
 13 files changed, 623 insertions(+), 71 deletions(-)

-- 
2.20.1

