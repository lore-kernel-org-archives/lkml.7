Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA73FC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9EA20663
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfDSTqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:46:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:13189 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbfDSTqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:46:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Apr 2019 12:46:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,371,1549958400"; 
   d="scan'208";a="144129771"
Received: from jmishra-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.185.34])
  by orsmga003.jf.intel.com with ESMTP; 19 Apr 2019 12:46:51 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 0/2] soundwire: fix Kconfig select/depend issues
Date:   Fri, 19 Apr 2019 14:46:47 -0500
Message-Id: <20190419194649.18467-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0-day/Kbuild starts complaining about missed module dependencies and
compilation issues. Since codecs and soc drivers need to be compilable
independently, let's fix this using the following model:

SOF_INTEL_XYZ --- select ---->  SOUNDWIRE_INTEL ---> select ----
                                                               |
				                               v
                                                        SOUNDWIRE_BUS
   							       ^
                                                               |
CODEC_ABC ------- select -----> REGMAP_SOUNDWIRE ---> select ---

The SOUNDWIRE option remains a top-level boolean selector without
impact on compilation, as recommended by Linus [1] and done for all
Intel ASoC stuff.

[1] https://lkml.org/lkml/2017/11/15/554

Changes since v1:
Removed useless depend in REGMAP_SOUNDWIRE (select will ignore dependencies)
Reordered patches to avoid circular dependencies with git bisect

Pierre-Louis Bossart (2):
  soundwire: fix SOUNDWIRE_BUS option
  regmap: soundwire: fix Kconfig select/depend issue

 drivers/base/regmap/Kconfig | 2 +-
 drivers/soundwire/Kconfig   | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

-- 
2.17.1

