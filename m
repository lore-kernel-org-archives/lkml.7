Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9243C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 00:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B87217D4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 00:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfEDAaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 20:30:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:53757 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbfEDA3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 20:29:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 17:29:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,427,1549958400"; 
   d="scan'208";a="170430476"
Received: from jlwhitty-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.28.45])
  by fmsmga001.fm.intel.com with ESMTP; 03 May 2019 17:29:46 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 7/8] soundwire: fix master properties
Date:   Fri,  3 May 2019 19:29:25 -0500
Message-Id: <20190504002926.28815-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504002926.28815-1-pierre-louis.bossart@linux.intel.com>
References: <20190504002926.28815-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The master-count is only defined for a controller or a Slave in the
MIPI DisCo for SoundWire document.

rename all fields with 'freq' as 'clk_freq' to follow the MIPI
specification and avoid confusion between bus clock and audio clocks.

fix support for clock_stop_mode0 and 1. The existing code uses a
bitmask between enums, one of which being zero. Or'ing with zero is
not very useful in general...Fix by or-ing with a BIT dependent on the
enum value.

Fix additional comments to align with MIPI spec

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c        |  4 ++--
 drivers/soundwire/intel.c      | 11 ++++++-----
 drivers/soundwire/mipi_disco.c | 27 ++++++++++++++-------------
 drivers/soundwire/stream.c     |  2 +-
 include/linux/soundwire/sdw.h  | 20 +++++++++-----------
 5 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index aac35fc3cf22..96e42df8f458 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -87,7 +87,7 @@ int sdw_add_bus_master(struct sdw_bus *bus)
 
 	/*
 	 * Initialize clock values based on Master properties. The max
-	 * frequency is read from max_freq property. Current assumption
+	 * frequency is read from max_clk_freq property. Current assumption
 	 * is that the bus will start at highest clock frequency when
 	 * powered on.
 	 *
@@ -95,7 +95,7 @@ int sdw_add_bus_master(struct sdw_bus *bus)
 	 * to start with bank 0 (Table 40 of Spec)
 	 */
 	prop = &bus->prop;
-	bus->params.max_dr_freq = prop->max_freq * SDW_DOUBLE_RATE_FACTOR;
+	bus->params.max_dr_freq = prop->max_clk_freq * SDW_DOUBLE_RATE_FACTOR;
 	bus->params.curr_dr_freq = bus->params.max_dr_freq;
 	bus->params.curr_bank = SDW_BANK0;
 	bus->params.next_bank = SDW_BANK1;
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 31336b0271b0..4ac141730b13 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -796,13 +796,14 @@ static int intel_prop_read(struct sdw_bus *bus)
 	sdw_master_read_prop(bus);
 
 	/* BIOS is not giving some values correctly. So, lets override them */
-	bus->prop.num_freq = 1;
-	bus->prop.freq = devm_kcalloc(bus->dev, bus->prop.num_freq,
-				      sizeof(*bus->prop.freq), GFP_KERNEL);
-	if (!bus->prop.freq)
+	bus->prop.num_clk_freq = 1;
+	bus->prop.clk_freq = devm_kcalloc(bus->dev, bus->prop.num_clk_freq,
+					  sizeof(*bus->prop.clk_freq),
+					  GFP_KERNEL);
+	if (!bus->prop.clk_freq)
 		return -ENOMEM;
 
-	bus->prop.freq[0] = bus->prop.max_freq;
+	bus->prop.clk_freq[0] = bus->prop.max_clk_freq;
 	bus->prop.err_threshold = 5;
 
 	return 0;
diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
index f6b1be920a19..7db816691393 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -50,39 +50,40 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 
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
-				 &prop->max_freq);
+				 &prop->max_clk_freq);
 
 	nval = fwnode_property_read_u32_array(link,
 			"mipi-sdw-clock-frequencies-supported", NULL, 0);
 	if (nval > 0) {
-		prop->num_freq = nval;
-		prop->freq = devm_kcalloc(bus->dev, prop->num_freq,
-					  sizeof(*prop->freq), GFP_KERNEL);
-		if (!prop->freq)
+		prop->num_clk_freq = nval;
+		prop->clk_freq = devm_kcalloc(bus->dev, prop->num_clk_freq,
+					      sizeof(*prop->clk_freq),
+					      GFP_KERNEL);
+		if (!prop->clk_freq)
 			return -ENOMEM;
 
 		fwnode_property_read_u32_array(link,
 				"mipi-sdw-clock-frequencies-supported",
-				prop->freq, prop->num_freq);
+				prop->clk_freq, prop->num_clk_freq);
 	}
 
 	/*
 	 * Check the frequencies supported. If FW doesn't provide max
 	 * freq, then populate here by checking values.
 	 */
-	if (!prop->max_freq && prop->freq) {
-		prop->max_freq = prop->freq[0];
-		for (i = 1; i < prop->num_freq; i++) {
-			if (prop->freq[i] > prop->max_freq)
-				prop->max_freq = prop->freq[i];
+	if (!prop->max_clk_freq && prop->clk_freq) {
+		prop->max_clk_freq = prop->clk_freq[0];
+		for (i = 1; i < prop->num_clk_freq; i++) {
+			if (prop->clk_freq[i] > prop->max_clk_freq)
+				prop->max_clk_freq = prop->clk_freq[i];
 		}
 	}
 
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index d01060dbee96..89edc897b8eb 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1474,7 +1474,7 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream)
 		memcpy(&params, &bus->params, sizeof(params));
 
 		/* TODO: Support Asynchronous mode */
-		if ((prop->max_freq % stream->params.rate) != 0) {
+		if ((prop->max_clk_freq % stream->params.rate) != 0) {
 			dev_err(bus->dev, "Async mode not supported\n");
 			return -EINVAL;
 		}
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 80584e9d5970..89c51838b7ec 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -364,29 +364,27 @@ struct sdw_slave_prop {
 /**
  * struct sdw_master_prop - Master properties
  * @revision: MIPI spec version of the implementation
- * @master_count: Number of masters
- * @clk_stop_mode: Bitmap for Clock Stop modes supported
- * @max_freq: Maximum Bus clock frequency, in Hz
+ * @clk_stop_modes: Bitmap, bit N set when clock-stop-modeN supported
+ * @max_clk_freq: Maximum Bus clock frequency, in Hz
  * @num_clk_gears: Number of clock gears supported
  * @clk_gears: Clock gears supported
- * @num_freq: Number of clock frequencies supported, in Hz
- * @freq: Clock frequencies supported, in Hz
+ * @num_clk_freq: Number of clock frequencies supported, in Hz
+ * @clk_freq: Clock frequencies supported, in Hz
  * @default_frame_rate: Controller default Frame rate, in Hz
  * @default_row: Number of rows
  * @default_col: Number of columns
- * @dynamic_frame: Dynamic frame supported
+ * @dynamic_frame: Dynamic frame shape supported
  * @err_threshold: Number of times that software may retry sending a single
  * command
  */
 struct sdw_master_prop {
 	u32 revision;
-	u32 master_count;
-	enum sdw_clk_stop_mode clk_stop_mode;
-	u32 max_freq;
+	u32 clk_stop_modes;
+	u32 max_clk_freq;
 	u32 num_clk_gears;
 	u32 *clk_gears;
-	u32 num_freq;
-	u32 *freq;
+	u32 num_clk_freq;
+	u32 *clk_freq;
 	u32 default_frame_rate;
 	u32 default_row;
 	u32 default_col;
-- 
2.17.1

