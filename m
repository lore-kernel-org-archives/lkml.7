Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFCAC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D354820663
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfDSTq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:46:58 -0400
Received: from mga04.intel.com ([192.55.52.120]:13189 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbfDSTqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:46:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Apr 2019 12:46:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,371,1549958400"; 
   d="scan'208";a="144129782"
Received: from jmishra-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.185.34])
  by orsmga003.jf.intel.com with ESMTP; 19 Apr 2019 12:46:53 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH v2 1/2] soundwire: fix SOUNDWIRE_BUS option
Date:   Fri, 19 Apr 2019 14:46:48 -0500
Message-Id: <20190419194649.18467-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190419194649.18467-1-pierre-louis.bossart@linux.intel.com>
References: <20190419194649.18467-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing Kconfig can lead to the following warning:

WARNING: unmet direct dependencies detected for REGMAP_SOUNDWIRE
  Depends on [m]: SOUNDWIRE_BUS [=m]
  Selected by [y]:
  - SND_SOC_RT700_SDW [=y] && SOUND [=y] && !UML && SND [=y] &&
    SND_SOC [=y] && SOUNDWIRE [=y]
  Selected by [m]:
  - SOUNDWIRE_BUS [=m] && SOUNDWIRE [=y]

Remove wrong-way link between SOUNDWIRE_BUS and REGMAP_SOUNDWIRE

SOUNDWIRE_BUS can be selected independendly by the SOC driver
(e.g. SOUNDWIRE_INTEL) or the codec driver (via REGMAP_SOUNDWIRE).

Fixes: 6c49b32d3c09 ('soundwire: select REGMAP_SOUNDWIRE')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
index 84876a74874f..d382d80d2fe1 100644
--- a/drivers/soundwire/Kconfig
+++ b/drivers/soundwire/Kconfig
@@ -18,7 +18,6 @@ comment "SoundWire Devices"
 
 config SOUNDWIRE_BUS
 	tristate
-	select REGMAP_SOUNDWIRE
 
 config SOUNDWIRE_CADENCE
 	tristate
-- 
2.17.1

