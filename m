Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FE4C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D584521841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfDKDRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 23:17:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:50947 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726615AbfDKDRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 23:17:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 20:17:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,335,1549958400"; 
   d="scan'208";a="160147287"
Received: from slin7-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.252.204.16])
  by fmsmga002.fm.intel.com with ESMTP; 10 Apr 2019 20:17:14 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH v3 1/5] soundwire: intel: fix inversion in devm_kcalloc parameters
Date:   Wed, 10 Apr 2019 22:16:57 -0500
Message-Id: <20190411031701.5926-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411031701.5926-1-pierre-louis.bossart@linux.intel.com>
References: <20190411031701.5926-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the number of elements and size are inverted, fix.

This probably only worked because the number of properties is
hard-coded to 1.

Fixes: 71bb8a1b059e ('soundwire: intel: Add Intel Master driver')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index fd8d034cfec1..8669b314c476 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -796,8 +796,8 @@ static int intel_prop_read(struct sdw_bus *bus)
 
 	/* BIOS is not giving some values correctly. So, lets override them */
 	bus->prop.num_freq = 1;
-	bus->prop.freq = devm_kcalloc(bus->dev, sizeof(*bus->prop.freq),
-					bus->prop.num_freq, GFP_KERNEL);
+	bus->prop.freq = devm_kcalloc(bus->dev, bus->prop.num_freq,
+				      sizeof(*bus->prop.freq), GFP_KERNEL);
 	if (!bus->prop.freq)
 		return -ENOMEM;
 
-- 
2.17.1

