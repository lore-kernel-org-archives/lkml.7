Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C73DC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786ED2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfLQVDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 16:03:19 -0500
Received: from mga04.intel.com ([192.55.52.120]:15620 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbfLQVDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 16:03:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 13:03:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,326,1571727600"; 
   d="scan'208";a="240560928"
Received: from smcdonal-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.83.42])
  by fmsmga004.fm.intel.com with ESMTP; 17 Dec 2019 13:03:17 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v5 00/17] soundwire: intel: implement new ASoC interfaces
Date:   Tue, 17 Dec 2019 15:02:57 -0600
Message-Id: <20191217210314.20410-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset applies on top of soundwire/next, now that the interface
definitions are merged.

The changes are essentially a removal of the platform devices,
replaced by explicit device(s)/driver for the SoundWire Master(s), and
the implementation of the new interfaces required to scan the ACPI
tables, probe the links and start them.

The missing prepare, trigger and setup ASoC callbacks are also
implemented. The hw_params and free callbacks use the new interfaces
as well.

While there are quite a few lines of code changed, this is mostly
about interface changes. The next series will contain more functional
changes and deal with race conditions on probe, enumeration and
suspend/resume issues.

Thanks to Vinod Kould and GregKH for the reviews on previous versions,
much appreciated.

Changes since v4: (feedback from GregKH except last point flagged by
Intel validation)

Clarified error handling with uevents
Added better commit messages and rationale behind exposing a Master Device.
Used 'master_device' instead of 'md' when possible (kept the shortcut
with really long function names)
Added namespace check support for Intel code (the Cadence and core
stuff should be done in a separate patchset).
Fixed GPLv2 license/EXPORT_SYMBOL_GPL error for the Master Device code.
Fixed missing error handling in sdw_md_add
Added kerneldoc comments for sdw_md_driver structure (with explanation
on what 'md' stands for)
Fixed NULL pointer assignment leading to issues with driver_unregister

Changes since v3:
One line change to re-add EXPORT_SYMBOL
Add missing driver_registration 

Changes since v2:
moved uevent handling to slave_type (Vinod)

Changes since v1:
fix typo (Vinod)
removed uevent open for Master (Vinod)
clarified commit messages (Cezary)
no functionality change

Bard Liao (1):
  soundwire: register master device driver

Pierre-Louis Bossart (13):
  soundwire: renames to prepare support for master drivers/devices
  soundwire: rename dev_to_sdw_dev macro
  soundwire: rename drv_to_sdw_slave_driver macro
  soundwire: bus_type: rename sdw_drv_ to sdw_slave_drv
  soundwire: intel: rename res field as link_res
  soundwire: add support for sdw_slave_type
  soundwire: slave: move uevent handling to slave device level
  soundwire: add initial definitions for sdw_master_device
  soundwire: intel: remove platform devices and use 'Master Devices'
    instead
  soundwire: intel: free all resources on hw_free()
  soundwire: intel_init: add implementation of sdw_intel_enable_irq()
  soundwire: intel_init: use EXPORT_SYMBOL_NS
  soundwire: intel: use EXPORT_SYMBOL_NS

Rander Wang (3):
  soundwire: intel: add prepare support in sdw dai driver
  soundwire: intel: add trigger support in sdw dai driver
  soundwire: intel: add sdw_stream_setup helper for .startup callback

 drivers/base/regmap/regmap-sdw.c   |   4 +-
 drivers/soundwire/Makefile         |   2 +-
 drivers/soundwire/bus.c            |   2 +-
 drivers/soundwire/bus.h            |   2 +
 drivers/soundwire/bus_type.c       |  70 ++++---
 drivers/soundwire/intel.c          | 281 +++++++++++++++++++++-----
 drivers/soundwire/intel.h          |   8 +-
 drivers/soundwire/intel_init.c     | 312 ++++++++++++++++++++++-------
 drivers/soundwire/master.c         |  64 ++++++
 drivers/soundwire/slave.c          |  10 +-
 include/linux/soundwire/sdw.h      |  42 +++-
 include/linux/soundwire/sdw_type.h |  34 +++-
 12 files changed, 668 insertions(+), 163 deletions(-)
 create mode 100644 drivers/soundwire/master.c

-- 
2.20.1

