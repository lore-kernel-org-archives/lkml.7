Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F268C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FB520684
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 13:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbfFENmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 09:42:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:51941 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbfFENmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 09:42:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 06:42:17 -0700
X-ExtLoop1: 1
Received: from xxx.igk.intel.com ([10.237.93.170])
  by orsmga004.jf.intel.com with ESMTP; 05 Jun 2019 06:42:14 -0700
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH 00/14] Fix driver reload issues
Date:   Wed,  5 Jun 2019 15:45:42 +0200
Message-Id: <20190605134556.10322-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series of patches introduces fixes to various issues found while
trying to unload all snd* modules and then loading them again. This
allows for modules to be really _modules_ and be unloaded and loaded on
demand, making it easier to develop and test them without constant
system reboots.

There are some fixes in flow, either we don't initialize things before
cleaning them up, clean up in wrong places or don't clean up at all.
Other patches fix memory management problems, mostly things are not
being freed. And finally there is few miscellaneous patches, please
refer to specific patches to see what they do.

This series was tested on SKL, BXT, GLK & KBL.

Small note:
Patch 2 in this series was already send to this list along with SOF
counterpart, however it seems that there is some problem:
https://mailman.alsa-project.org/pipermail/alsa-devel/2019-May/149638.html
and related patch on SOF side (with discussion):
https://mailman.alsa-project.org/pipermail/alsa-devel/2019-May/149640.html
It is included in this patchset for completeness.

Amadeusz Sławiński (14):
  ASoC: Intel: Skylake: Initialize lists before access so they are safe
    to use
  ALSA: hdac: fix memory release for SST and SOF drivers
  ALSA: hdac: Fix codec name after machine driver is unloaded and
    reloaded
  ASoC: compress: Fix memory leak from snd_soc_new_compress
  ASoC: Intel: Skylake: Don't return failure on machine driver reload
  ASoC: Intel: Skylake: Remove static table index when parsing topology
  ASoC: Intel: Skylake: Add function to cleanup debugfs interface
  ASoC: Intel: Skylake: Properly cleanup on component removal
  ASoC: Intel: Skylake: Fix NULL ptr dereference when unloading clk dev
  SoC: rt274: Fix internal jack assignment in set_jack callback
  ASoC: core: Tell codec that jack is being removed
  ASoC: Intel: hdac_hdmi: Set ops to NULL on remove
  ASoC: topology: Consolidate how dtexts and dvalues are freed
  ASoC: topology: Consolidate and fix asoc_tplg_dapm_widget_*_create
    flow

 sound/hda/ext/hdac_ext_bus.c           |  12 ++-
 sound/soc/codecs/hdac_hdmi.c           |   6 ++
 sound/soc/codecs/rt274.c               |   3 +-
 sound/soc/intel/skylake/skl-debug.c    |   9 ++
 sound/soc/intel/skylake/skl-pcm.c      |  16 ++--
 sound/soc/intel/skylake/skl-ssp-clk.c  |  16 ++--
 sound/soc/intel/skylake/skl-topology.c |  50 ++++++-----
 sound/soc/intel/skylake/skl-topology.h |   2 +
 sound/soc/intel/skylake/skl.c          |   7 +-
 sound/soc/intel/skylake/skl.h          |   5 ++
 sound/soc/soc-compress.c               |  17 ++--
 sound/soc/soc-core.c                   |   1 +
 sound/soc/soc-topology.c               | 114 ++++++++++++-------------
 13 files changed, 143 insertions(+), 115 deletions(-)

-- 
2.17.1

