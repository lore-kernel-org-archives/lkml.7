Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D88C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 20:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D3923405
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 20:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbfHUUFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 16:05:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:53248 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbfHUUF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 16:05:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 13:05:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="196069731"
Received: from smasango-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.252.139.100])
  by fmsmga001.fm.intel.com with ESMTP; 21 Aug 2019 13:05:27 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 00/11] soundwire: intel: simplify DAI/PDI handling
Date:   Wed, 21 Aug 2019 15:05:10 -0500
Message-Id: <20190821200521.17283-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the initial SoundWire code released by Intel, the PDIs and ports on
the Master interface were dynamically allocated. This wasn't a bad
idea at the time and would have allowed for interesting routing.

Fast-forward to 2019, with the hardware available on
CometLake/IceLake, that dynamic allocation makes it complicated to
deal with statically-allocated ASoC dailinks and topology-defined
DAIs. In this series, we suggest a drastic simplification where the
SoundWire code reuses information provided by DAIs and dailinks. We
also suggest removing the dynamic allocation of ports on the master
since in practice there is a 1:1 mapping between ports and PDIs.

In the second part of the series, we suggest adding new callbacks to
SoundWire DAIs, so that all the SoundWire stream operations are
contained at the DAI level. This solution results in a very simple
integration with the SOF code (which will be shared in a separate
series since SOF will not apply directly on top of
soundwire/next). The SOF parts only call a SoundWire init/release API,
and provides 2 callbacks for hw_params and free, with all the details
of the SoundWire DAIs and IP handled in drivers/soundwire.

This solution has been tested on CometLake/IceLake with simple
capture/playback. When ASoC supports the multi-cpu capability needed
for synchronized playback/capture across multiple links, we will have
to modify slightly this solution so that the stream alloc, release and
trigger operations are done once. This is future work that will take
place later, likely after 5.4, and which should not impact the SOF
integration.

The code in this patchset is the result of collaboration between Bard
Liao, Rander Wang and Pierre Bossart, with ideas coming from all 3
sides. It's likely that there are still some parts in the code that
can be improved, hence the RFC state.

Bard Liao (3):
  soundwire: intel: fix intel_register_dai PDI offsets and numbers
  soundwire: intel: remove playback/capture stream_name
  soundwire: cadence_master: improve PDI allocation

Pierre-Louis Bossart (3):
  soundwire: remove DAI_ID_RANGE definitions
  soundwire: cadence/intel: simplify PDI/port mapping
  soundwire: intel: don't filter out PDI0/1

Rander Wang (5):
  soundwire: intel: improve .config_stream callback, add .free_stream
  soundwire: intel: add prepare support in sdw dai driver
  soundwire: intel: add trigger support in sdw dai driver
  soundwire: intel: do sdw stream setup in setup function
  soundwire: intel: free all resources on hw_free()

 drivers/soundwire/cadence_master.c  | 158 ++++------------
 drivers/soundwire/cadence_master.h  |  34 +---
 drivers/soundwire/intel.c           | 278 ++++++++++++++++------------
 include/linux/soundwire/sdw.h       |   3 -
 include/linux/soundwire/sdw_intel.h |   4 +-
 5 files changed, 209 insertions(+), 268 deletions(-)

-- 
2.20.1

