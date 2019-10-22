Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02534CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 23:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF74120578
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 23:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731227AbfJVXy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 19:54:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:15717 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727831AbfJVXy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 19:54:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 16:54:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,218,1569308400"; 
   d="scan'208";a="196612834"
Received: from srajamoh-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.20.203])
  by fmsmga008.fm.intel.com with ESMTP; 22 Oct 2019 16:54:54 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 0/5] soundwire: intel/cadence: better initialization
Date:   Tue, 22 Oct 2019 18:54:43 -0500
Message-Id: <20191022235448.17586-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2: addressed feedback from Vinod Koul on patch 2&4
Add kernel taint when using debugfs hw_reset (similar to regmap)
Remove useless goto label

Changes since v1: addressed feedback from Vinod Koul
clarified init changes impact Intel and Cadence sides
remove unnecessary intermediate variable
disable interrupts when exit_reset fails, updated error handling
returned -EINVAL on debugfs invalid parameter

Pierre-Louis Bossart (5):
  soundwire: intel/cadence: fix startup sequence
  soundwire: cadence_master: add hw_reset capability in debugfs
  soundwire: intel: add helper for initialization
  soundwire: intel/cadence: add flag for interrupt enable
  soundwire: cadence_master: make clock stop exit configurable on init

 drivers/soundwire/cadence_master.c | 134 +++++++++++++++++++++--------
 drivers/soundwire/cadence_master.h |   5 +-
 drivers/soundwire/intel.c          |  39 ++++++---
 3 files changed, 129 insertions(+), 49 deletions(-)

-- 
2.20.1

