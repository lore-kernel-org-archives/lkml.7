Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F252C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8F32067D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfHMVct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 17:32:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:18152 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbfHMVcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 17:32:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 14:32:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="177922890"
Received: from ccalgarr-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.252.205.92])
  by fmsmga007.fm.intel.com with ESMTP; 13 Aug 2019 14:32:42 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/6] soundwire: inits and PM additions for 5.4
Date:   Tue, 13 Aug 2019 16:32:20 -0500
Message-Id: <20190813213227.5163-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an update on the RFC, to be applied after the '[PATCH v2 0/3]
soundwire: debugfs support for 5.4' and '[PATCH 00/17] soundwire:
fixes for 5.4' series.

Total that makes 28 patches submitted for review, broken in 3 sets.

Changes since RFC (Feedback from GregKH, Vinod, Cezary, Guennadi):
Squashed init sequence fixes in one patch, which remains
readable. Tested all return values and called update_config() as
needed.
Fixed hw-reset debugfs (removed -unsafe and noisy dev_info traces)
Simplified enable_interrupt() with goto
Fixed style, removed typos and FIXMES in pm_runtime code
Clarified commit messages

Pierre-Louis Bossart (6):
  soundwire: fix startup sequence for Intel/Cadence
  soundwire: cadence_master: add hw_reset capability in debugfs
  soundwire: intel: add helper for initialization
  soundwire: intel: Add basic power management support
  soundwire: cadence_master: make clock stop exit configurable on init
  soundwire: intel: add pm_runtime support

 drivers/soundwire/cadence_master.c | 135 ++++++++++++++------
 drivers/soundwire/cadence_master.h |   5 +-
 drivers/soundwire/intel.c          | 194 +++++++++++++++++++++++++++--
 3 files changed, 289 insertions(+), 45 deletions(-)

-- 
2.20.1

