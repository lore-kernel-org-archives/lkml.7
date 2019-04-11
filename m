Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67ACAC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBDD2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfDKT23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 15:28:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:26330 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbfDKT2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 15:28:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Apr 2019 12:28:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,338,1549958400"; 
   d="scan'208";a="160850576"
Received: from arajaman-mobl4.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.134.140])
  by fmsmga004.fm.intel.com with ESMTP; 11 Apr 2019 12:28:23 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 2/2] soundwire: fix SOUNDWIRE_BUS option
Date:   Thu, 11 Apr 2019 14:28:14 -0500
Message-Id: <20190411192814.10663-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411192814.10663-1-pierre-louis.bossart@linux.intel.com>
References: <20190411192814.10663-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SOUNDWIRE_BUS can be selected independendly by the SOC driver
(e.g. SOUNDWIRE_INTEL) or the codec driver (via REGMAP_SOUNDWIRE).

Remove wrong-way link between SOUNDWIRE_BUS and REGMAP_SOUNDWIRE

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

