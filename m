Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8CFC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA422081C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387924AbfEVTr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:47:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:47986 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730495AbfEVTr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:47:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 12:47:55 -0700
X-ExtLoop1: 1
Received: from cjpowell-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.154.39])
  by fmsmga008.fm.intel.com with ESMTP; 22 May 2019 12:47:54 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH v2 06/15] soundwire: rename 'freq' fields
Date:   Wed, 22 May 2019 14:47:22 -0500
Message-Id: <20190522194732.25704-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
References: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename all fields with 'freq' as 'clk_freq' to follow the MIPI
specification and avoid confusion between bus clock and audio clocks.

No functionality change.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c        |  4 ++--
 drivers/soundwire/intel.c      | 11 ++++++-----
 drivers/soundwire/mipi_disco.c | 23 ++++++++++++-----------
 drivers/soundwire/stream.c     |  2 +-
 include/linux/soundwire/sdw.h  | 12 ++++++------
 5 files changed, 27 insertions(+), 25 deletions(-)

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
index 6df68584c963..b1770af43fa8 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -58,31 +58,32 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 
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
index 14376d8458c3..c6ded0d7a9f2 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -365,11 +365,11 @@ struct sdw_slave_prop {
  * struct sdw_master_prop - Master properties
  * @revision: MIPI spec version of the implementation
  * @clk_stop_mode: Bitmap for Clock Stop modes supported
- * @max_freq: Maximum Bus clock frequency, in Hz
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
@@ -380,11 +380,11 @@ struct sdw_slave_prop {
 struct sdw_master_prop {
 	u32 revision;
 	enum sdw_clk_stop_mode clk_stop_mode;
-	u32 max_freq;
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
2.20.1

