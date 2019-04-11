Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0648C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E2120663
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfDKT2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 15:28:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:26330 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbfDKT2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 15:28:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Apr 2019 12:28:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,338,1549958400"; 
   d="scan'208";a="160850569"
Received: from arajaman-mobl4.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.134.140])
  by fmsmga004.fm.intel.com with ESMTP; 11 Apr 2019 12:28:21 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/2] soundwire: fix Kconfig select/depend issues
Date:   Thu, 11 Apr 2019 14:28:12 -0500
Message-Id: <20190411192814.10663-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0-day/Kbuild starts complaining about missed module dependencies and
compilation issues. Since codecs and soc drivers need to be compilable
independently, let's fix this using the following model:

SOUNDWIRE_INTEL ---- select -----------
                                      |
				      v
REGMAP_SOUNDWIRE --- select ---> SOUNDWIRE_BUS


Pierre-Louis Bossart (2):
  regmap: soundwire: fix Kconfig select/depend issue
  soundwire: fix SOUNDWIRE_BUS option

 drivers/base/regmap/Kconfig | 3 ++-
 drivers/soundwire/Kconfig   | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.17.1

