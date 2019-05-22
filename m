Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C14C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E506A217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387972AbfEVTsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:48:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:47986 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732384AbfEVTr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:47:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 12:47:57 -0700
X-ExtLoop1: 1
Received: from cjpowell-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.154.39])
  by fmsmga008.fm.intel.com with ESMTP; 22 May 2019 12:47:56 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH v2 07/15] soundwire: mipi-disco: fix clock stop modes
Date:   Wed, 22 May 2019 14:47:23 -0500
Message-Id: <20190522194732.25704-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
References: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix support for clock_stop_mode0 and 1. The existing code uses a
bitmask between enums, one of which being zero. Or-ing with zero is
not very useful in general...Fix by or-ing with a BIT dependent on the
enum value.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/mipi_disco.c | 4 ++--
 include/linux/soundwire/sdw.h  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
index b1770af43fa8..efb87ee0e7fc 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -50,11 +50,11 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 
 	if (fwnode_property_read_bool(link,
 				      "mipi-sdw-clock-stop-mode0-supported"))
-		prop->clk_stop_mode = SDW_CLK_STOP_MODE0;
+		prop->clk_stop_modes |= BIT(SDW_CLK_STOP_MODE0);
 
 	if (fwnode_property_read_bool(link,
 				      "mipi-sdw-clock-stop-mode1-supported"))
-		prop->clk_stop_mode |= SDW_CLK_STOP_MODE1;
+		prop->clk_stop_modes |= BIT(SDW_CLK_STOP_MODE1);
 
 	fwnode_property_read_u32(link,
 				 "mipi-sdw-max-clock-frequency",
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index c6ded0d7a9f2..0e3fdd03e589 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -364,7 +364,7 @@ struct sdw_slave_prop {
 /**
  * struct sdw_master_prop - Master properties
  * @revision: MIPI spec version of the implementation
- * @clk_stop_mode: Bitmap for Clock Stop modes supported
+ * @clk_stop_modes: Bitmap, bit N set when clock-stop-modeN supported
  * @max_clk_freq: Maximum Bus clock frequency, in Hz
  * @num_clk_gears: Number of clock gears supported
  * @clk_gears: Clock gears supported
@@ -379,7 +379,7 @@ struct sdw_slave_prop {
  */
 struct sdw_master_prop {
 	u32 revision;
-	enum sdw_clk_stop_mode clk_stop_mode;
+	u32 clk_stop_modes;
 	u32 max_clk_freq;
 	u32 num_clk_gears;
 	u32 *clk_gears;
-- 
2.20.1

