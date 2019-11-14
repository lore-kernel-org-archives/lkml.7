Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24DEC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FA9206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfKNR7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 12:59:49 -0500
Received: from mga17.intel.com ([192.55.52.151]:24511 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbfKNR7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 12:59:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 09:59:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,304,1569308400"; 
   d="scan'208";a="207871416"
Received: from chiahuil-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.228.77])
  by orsmga003.jf.intel.com with ESMTP; 14 Nov 2019 09:59:47 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 00/15] soundwire: intel: implement new ASoC interfaces
Date:   Thu, 14 Nov 2019 11:59:18 -0600
Message-Id: <20191114175933.21992-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset applies on top of the series "[PATCH v3 0/6] soundwire:
update ASoC interfaces"

The changes are essentially a removal of the platform devices and the
implementation of the new interfaces required to scan the ACPI tables,
probe the links and start them.

The missing prepare, trigger and setup ASoC callbacks are also
implemented. The hw_params and free callbacks use the new interfaces
as well.

While there are quite a few lines of code changed, this is mostly
about interface changes. The next series will contain more functional
changes and deal with race conditions on probe, enumeration and
suspend/resume issues.

Changes since v2:
moved uevent handling to slave_type (Vinod)

Changes since v1:
fix typo (Vinod)
removed uevent open for Master (Vinod)
clarified commit messages (Cezary)
no functionality change

Bard Liao (1):
  soundwire: add device driver to sdw_md_driver

Pierre-Louis Bossart (11):
  soundwire: renames to prepare support for master drivers/devices
  soundwire: rename dev_to_sdw_dev macro
  soundwire: rename drv_to_sdw_slave_driver macro
  soundwire: bus_type: rename sdw_drv_ to sdw_slave_drv
  soundwire: intel: rename res field as link_res
  soundwire: add support for sdw_slave_type
  soundwire: slave: move uevent handling to slave
  soundwire: add initial definitions for sdw_master_device
  soundwire: intel: remove platform devices and provide new interface
  soundwire: intel: free all resources on hw_free()
  soundwire: intel_init: add implementation of sdw_intel_enable_irq()

Rander Wang (3):
  soundwire: intel: add prepare support in sdw dai driver
  soundwire: intel: add trigger support in sdw dai driver
  soundwire: intel: add sdw_stream_setup helper for .startup callback

 drivers/base/regmap/regmap-sdw.c   |   4 +-
 drivers/soundwire/Makefile         |   2 +-
 drivers/soundwire/bus.c            |   2 +-
 drivers/soundwire/bus.h            |   2 +
 drivers/soundwire/bus_type.c       |  63 +++---
 drivers/soundwire/intel.c          | 280 ++++++++++++++++++++++-----
 drivers/soundwire/intel.h          |   8 +-
 drivers/soundwire/intel_init.c     | 300 ++++++++++++++++++++++-------
 drivers/soundwire/master.c         |  64 ++++++
 drivers/soundwire/slave.c          |  10 +-
 include/linux/soundwire/sdw.h      |  39 +++-
 include/linux/soundwire/sdw_type.h |  34 +++-
 12 files changed, 646 insertions(+), 162 deletions(-)
 create mode 100644 drivers/soundwire/master.c

-- 
2.20.1

