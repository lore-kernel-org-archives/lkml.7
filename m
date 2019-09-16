Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1EFC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253762067B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403960AbfIPVXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 17:23:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:27020 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbfIPVXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:23:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 14:23:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,514,1559545200"; 
   d="scan'208";a="201684014"
Received: from dgitin-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.142.45])
  by fmsmga001.fm.intel.com with ESMTP; 16 Sep 2019 14:23:46 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 0/9] soundwire: add Master device support, GreyBus style
Date:   Mon, 16 Sep 2019 16:23:33 -0500
Message-Id: <20190916212342.12578-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current use of platform devices leads to limitations in terms of
API and problematic reference counts flagged during the review of
sysfs patches.

As suggested by Greg KH, this patch series introduces a 'Master
device' and gets rid of platform devices. The code is inspired by
GreyBus, e.g. 'gb_hd_driver' is translated for the SoundWire context
as 'sdw_md_driver' and likewise 'gb_host_device' is translated as
'sdw_master_device'. There are differences in the way devices are
created, using device_register instead of the multiple steps used in
GreyBus.

All I know about GreyBus is that it's based on Unipro, so the
code updates are based on a first-order analysis, it could very well
be I missed concepts while trying to reverse-engineer the code in
staging/greybus/. I focused on the concepts mainly and it's also
possible that the dual-license for new files or plan-vanilla
EXPORT_SYMBOL are not appropriate for all the changes in this
series. Please don't take errors as deliberate intent to work-around
GPL but rather as an indicator of maturity of the code only developed
in the last few days.

These changes make it possible to provide new callbacks, e.g splitting
the bus startup from the initializations in probe, which is very much
desired on Intel platforms to detect the machine driver as early as
possible before the hardware is fully powered/enable. These patches
will be provided as a separate RFC later today to illustrate the
benefit of these changes.

To make the code more consistent the first series of patches are
renames. I did not rename 'sdw_slave' or 'module_sdw_driver' to avoid
compatibility issues since there are codec drivers almost ready for
integration. I don't have any specific opinion on if/when additional
renames should be done, as long as there is a means to clearly
identify what is specific to a SoundWire Master I am fine.

Feedback and reviews welcome.

Bard Liao (1):
  soundwire: add device driver to sdw_md_driver

Pierre-Louis Bossart (8):
  soundwire: renames to prepare support for master drivers/devices
  soundwire: rename dev_to_sdw_dev macro
  soundwire: rename drv_to_sdw_slave_driver macro
  soundwire: bus_type: rename sdw_drv_ to sdw_slave_drv
  soundwire: intel: rename res field as link_res
  soundwire: add support for sdw_slave_type
  soundwire: add initial definitions for sdw_master_device
  soundwire: intel: remove platform devices and provide new interface

 drivers/base/regmap/regmap-sdw.c    |   4 +-
 drivers/soundwire/Makefile          |   2 +-
 drivers/soundwire/bus.c             |   2 +-
 drivers/soundwire/bus_type.c        |  60 +++---
 drivers/soundwire/intel.c           | 117 ++++++-----
 drivers/soundwire/intel.h           |  22 +--
 drivers/soundwire/intel_init.c      | 293 +++++++++++++++++++---------
 drivers/soundwire/master.c          |  80 ++++++++
 drivers/soundwire/slave.c           |   9 +-
 include/linux/soundwire/sdw.h       |  39 +++-
 include/linux/soundwire/sdw_intel.h |  86 +++++++-
 include/linux/soundwire/sdw_type.h  |  34 +++-
 12 files changed, 551 insertions(+), 197 deletions(-)
 create mode 100644 drivers/soundwire/master.c

-- 
2.20.1

