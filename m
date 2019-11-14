Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3D5C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885C520718
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfKNRxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 12:53:55 -0500
Received: from mga05.intel.com ([192.55.52.43]:8273 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbfKNRxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 12:53:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 09:53:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; 
   d="scan'208";a="203132942"
Received: from chiahuil-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.228.77])
  by fmsmga008.fm.intel.com with ESMTP; 14 Nov 2019 09:53:52 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 0/6] soundwire: update ASoC interfaces
Date:   Thu, 14 Nov 2019 11:53:39 -0600
Message-Id: <20191114175345.21836-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need new fields in existing structures to
a) deal with race conditions on codec probe/enumeration
b) allow for multi-step ACPI scan/probe/startup on Intel plaforms

These structures will be used by the SOF driver as well as codec
drivers.

To avoid conflicts between ASoC and Soundwire trees, these 6 patches
are provided out-of-order, before the functionality enabled in these
header files is added in follow-up patch series which can be applied
separately in the ASoC and Soundwire trees. As discussed earlier,
Vinod would need to provide an immutable tag for Mark Brown, and the
integration on the ASoC side of SOF changes and new codecs drivers can
proceed in parallel with SoundWire core changes.

Note that the SOF changes are not provided as a v3 today due to
conflicts with other in-flight SOF cleanups to facilitate support for
Device Tree devices. Those changes don't impact the interface
definition suggested here but the machine driver detection for
SoundWire. The changes should be ready in next week.

The mapping between the patches in this series and follow-up ones
shouldn't give anyone a migraine:

soundwire: sdw_slave: add probe_complete structure and new fields
soundwire: bus: fix race condition with probe_complete signaling

soundwire: sdw_slave: add enumeration_complete structure
soundwire: bus: fix race condition with enumeration_complete signaling

soundwire: sdw_slave: add initialization_complete definition
soundwire: bus: fix race condition with initialization_complete signaling

soundwire: sdw_slave: track unattach_request to handle all init sequences
soundwire: bus: fix race condition by tracking UNATTACHED transition

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

Pierre-Louis Bossart (5):
  soundwire: sdw_slave: add probe_complete structure and new fields
  soundwire: sdw_slave: add enumeration_complete structure
  soundwire: sdw_slave: add initialization_complete definition
  soundwire: sdw_slave: track unattach_request to handle all init
    sequences
  soundwire: intel: update interfaces between ASoC and SoundWire

Rander Wang (1):
  soundwire: intel: update stream callbacks for hwparams/free stream
    operations

 drivers/soundwire/intel.c           |  20 +++--
 drivers/soundwire/intel.h           |  13 ++--
 drivers/soundwire/intel_init.c      |  31 ++------
 include/linux/soundwire/sdw.h       |  19 +++++
 include/linux/soundwire/sdw_intel.h | 109 +++++++++++++++++++++++++---
 5 files changed, 149 insertions(+), 43 deletions(-)

-- 
2.20.1

