Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C06CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9404E2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391839AbfJWVHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 17:07:07 -0400
Received: from mga12.intel.com ([192.55.52.136]:7010 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391757AbfJWVHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 17:07:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 14:07:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400"; 
   d="scan'208";a="201260286"
Received: from ayamada-mobl1.gar.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.95.208])
  by orsmga003.jf.intel.com with ESMTP; 23 Oct 2019 14:07:04 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/4] soundwire: update ASoC interfaces
Date:   Wed, 23 Oct 2019 16:06:53 -0500
Message-Id: <20191023210657.32440-1-pierre-louis.bossart@linux.intel.com>
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

To avoid conflicts between ASoC and Soundwire trees, these 4 patches
are provided out-of-order, before the functionality enabled in these
header files is added in follow-up patch series which can be applied
separately in the ASoC and Soundwire trees (of course after Vinod and
Mark sync-up so that these patches are present in both trees).

Pierre-Louis Bossart (3):
  soundwire: sdw_slave: add new fields to track probe status
  soundwire: add enumeration_complete structure
  soundwire: intel: update interfaces between ASoC and SoundWire

Rander Wang (1):
  soundwire: intel: update stream callbacks for hwparams/free stream
    operations

 drivers/soundwire/intel.c           |  20 ++++--
 drivers/soundwire/intel.h           |  13 ++--
 drivers/soundwire/intel_init.c      |  31 +++------
 include/linux/soundwire/sdw.h       |   7 ++
 include/linux/soundwire/sdw_intel.h | 103 +++++++++++++++++++++++++---
 5 files changed, 131 insertions(+), 43 deletions(-)

-- 
2.20.1

