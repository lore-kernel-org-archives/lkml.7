Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10700C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC998216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbfIPVm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 17:42:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:54985 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbfIPVm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:42:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 14:42:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,514,1559545200"; 
   d="scan'208";a="198479862"
Received: from dgitin-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.142.45])
  by orsmga002.jf.intel.com with ESMTP; 16 Sep 2019 14:42:56 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 00/12] soundwire/SOF: updated interfaces, functional integration
Date:   Mon, 16 Sep 2019 16:42:39 -0500
Message-Id: <20190916214251.13130-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series builds on the 'soundwire: add Master device support,
GreyBus style' RFC'. It provides enhancements to the stream callbacks,
a split initialization. Most of the SOF patches were already submitted
in an earlier RFC, and feedback on the parameters was taken into
account. The main change here are the API changes with a split between
ACPI scan, probe, startup steps.


Known limits:
a) Power management (regular suspend/resume and pm_runtime) is not
supported for now as we need to run additional checks on
hardware. This will be provided as a separate series.
b) during validation checks on CML/ICL, initialization and
playback/capture worked fine, but we observed a reproducible system
freeze while doing load/unload tests, so likely an initialization
missing or a leak to be fixed.

Comments and feedback welcome.

Pierre-Louis Bossart (7):
  ASoC: soc-acpi: add link_mask field
  ASoC: SOF: support alternate list of machines
  ASoC: SOF: Intel: add SoundWire configuration interface
  ASoC: SOF: Intel: add build support for SoundWire
  ASoC: SOF: IPC: dai-intel: move ALH declarations in header file
  ASoC: SOF: Intel: hda: add SoundWire stream config/free callbacks
  ASoC: SOF: Intel: hda: initial SoundWire machine driver autodetect

Rander Wang (5):
  soundwire: intel: update stream callbacks for hwparams/free stream
    operations
  soundwire: intel: add prepare support in sdw dai driver
  soundwire: intel: add trigger support in sdw dai driver
  soundwire: intel: add sdw_stream_setup helper for .startup callback
  soundwire: intel: free all resources on hw_free()

 drivers/soundwire/intel.c           | 181 ++++++++++++++++++-
 drivers/soundwire/intel_init.c      |   2 +-
 include/linux/soundwire/sdw_intel.h |  40 ++++-
 include/sound/soc-acpi.h            |   2 +
 include/sound/sof.h                 |   3 +
 include/sound/sof/dai-intel.h       |  18 +-
 sound/soc/sof/intel/Kconfig         |  23 +++
 sound/soc/sof/intel/hda-loader.c    |   9 +
 sound/soc/sof/intel/hda.c           | 261 +++++++++++++++++++++++++++-
 sound/soc/sof/intel/hda.h           |  36 ++++
 10 files changed, 546 insertions(+), 29 deletions(-)

-- 
2.20.1

