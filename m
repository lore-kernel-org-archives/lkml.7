Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6B7C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EEB02173C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfDKT21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 15:28:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:26330 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbfDKT2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 15:28:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Apr 2019 12:28:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,338,1549958400"; 
   d="scan'208";a="160850570"
Received: from arajaman-mobl4.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.134.140])
  by fmsmga004.fm.intel.com with ESMTP; 11 Apr 2019 12:28:22 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 1/2] regmap: soundwire: fix Kconfig select/depend issue
Date:   Thu, 11 Apr 2019 14:28:13 -0500
Message-Id: <20190411192814.10663-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411192814.10663-1-pierre-louis.bossart@linux.intel.com>
References: <20190411192814.10663-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mechanism should be

config CODEC_XYX_SDW
       depends on SOUNDWIRE
       select REGMAP_SOUNDWIRE

config REGMAP_SOUNDWIRE
       depends on SOUNDWIRE
       select SOUNDWIRE_BUS

SOUNDWIRE_BUS can be independently selected by the SOC driver. The SOC
driver should not know or care about REGMAP_SOUNDWIRE.

Fixes: 7c22ce6e2184 ('03fc8746f7915b5a391d8227f7e1')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/base/regmap/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index 6ad5ef48b61e..4e422afe3c0d 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -44,7 +44,8 @@ config REGMAP_IRQ
 
 config REGMAP_SOUNDWIRE
 	tristate
-	depends on SOUNDWIRE_BUS
+	depends on SOUNDWIRE
+	select SOUNDWIRE_BUS
 
 config REGMAP_SCCB
 	tristate
-- 
2.17.1

