Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCECC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 15:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB66F208C3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 15:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfEAP63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 11:58:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:25560 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbfEAP61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 11:58:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 May 2019 08:58:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,418,1549958400"; 
   d="scan'208";a="296115714"
Received: from modiarvi-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.134.211])
  by orsmga004.jf.intel.com with ESMTP; 01 May 2019 08:58:25 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH v4 10/22] soundwire: mipi_disco: fix alignment issues
Date:   Wed,  1 May 2019 10:57:33 -0500
Message-Id: <20190501155745.21806-11-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use Linux style. In some cases parenthesis alignment is modified to
keep the code readable.

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/mipi_disco.c | 112 ++++++++++++++++++---------------
 1 file changed, 62 insertions(+), 50 deletions(-)

diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
index fdeba0c3b589..95efa82dc73b 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -35,11 +35,12 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 	int nval, i;
 
 	device_property_read_u32(bus->dev,
-			"mipi-sdw-sw-interface-revision", &prop->revision);
+				 "mipi-sdw-sw-interface-revision",
+				 &prop->revision);
 
 	/* Find master handle */
 	snprintf(name, sizeof(name),
-			"mipi-sdw-master-%d-subproperties", bus->link_id);
+		 "mipi-sdw-master-%d-subproperties", bus->link_id);
 
 	link = device_get_named_child_node(bus->dev, name);
 	if (!link) {
@@ -56,7 +57,8 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 		prop->clk_stop_mode |= SDW_CLK_STOP_MODE1;
 
 	fwnode_property_read_u32(link,
-			"mipi-sdw-max-clock-frequency", &prop->max_freq);
+				 "mipi-sdw-max-clock-frequency",
+				 &prop->max_freq);
 
 	nval = fwnode_property_read_u32_array(link,
 			"mipi-sdw-clock-frequencies-supported", NULL, 0);
@@ -64,7 +66,7 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 
 		prop->num_freq = nval;
 		prop->freq = devm_kcalloc(bus->dev, prop->num_freq,
-				sizeof(*prop->freq), GFP_KERNEL);
+					  sizeof(*prop->freq), GFP_KERNEL);
 		if (!prop->freq)
 			return -ENOMEM;
 
@@ -91,44 +93,47 @@ int sdw_master_read_prop(struct sdw_bus *bus)
 
 		prop->num_clk_gears = nval;
 		prop->clk_gears = devm_kcalloc(bus->dev, prop->num_clk_gears,
-				sizeof(*prop->clk_gears), GFP_KERNEL);
+					       sizeof(*prop->clk_gears),
+					       GFP_KERNEL);
 		if (!prop->clk_gears)
 			return -ENOMEM;
 
 		fwnode_property_read_u32_array(link,
-				"mipi-sdw-supported-clock-gears",
-				prop->clk_gears, prop->num_clk_gears);
+					       "mipi-sdw-supported-clock-gears",
+					       prop->clk_gears,
+					       prop->num_clk_gears);
 	}
 
 	fwnode_property_read_u32(link, "mipi-sdw-default-frame-rate",
-			&prop->default_frame_rate);
+				 &prop->default_frame_rate);
 
 	fwnode_property_read_u32(link, "mipi-sdw-default-frame-row-size",
-			&prop->default_row);
+				 &prop->default_row);
 
 	fwnode_property_read_u32(link, "mipi-sdw-default-frame-col-size",
-			&prop->default_col);
+				 &prop->default_col);
 
 	prop->dynamic_frame =  fwnode_property_read_bool(link,
 			"mipi-sdw-dynamic-frame-shape");
 
 	fwnode_property_read_u32(link, "mipi-sdw-command-error-threshold",
-			&prop->err_threshold);
+				 &prop->err_threshold);
 
 	return 0;
 }
 EXPORT_SYMBOL(sdw_master_read_prop);
 
 static int sdw_slave_read_dp0(struct sdw_slave *slave,
-		struct fwnode_handle *port, struct sdw_dp0_prop *dp0)
+			      struct fwnode_handle *port,
+			      struct sdw_dp0_prop *dp0)
 {
 	int nval;
 
 	fwnode_property_read_u32(port, "mipi-sdw-port-max-wordlength",
-			&dp0->max_word);
+				 &dp0->max_word);
 
 	fwnode_property_read_u32(port, "mipi-sdw-port-min-wordlength",
-			&dp0->min_word);
+				 &dp0->min_word);
 
 	nval = fwnode_property_read_u32_array(port,
 			"mipi-sdw-port-wordlength-configs", NULL, 0);
@@ -136,8 +141,8 @@ static int sdw_slave_read_dp0(struct sdw_slave *slave,
 
 		dp0->num_words = nval;
 		dp0->words = devm_kcalloc(&slave->dev,
-				dp0->num_words, sizeof(*dp0->words),
-				GFP_KERNEL);
+					  dp0->num_words, sizeof(*dp0->words),
+					  GFP_KERNEL);
 		if (!dp0->words)
 			return -ENOMEM;
 
@@ -146,20 +151,21 @@ static int sdw_slave_read_dp0(struct sdw_slave *slave,
 				dp0->words, dp0->num_words);
 	}
 
-	dp0->flow_controlled = fwnode_property_read_bool(
-			port, "mipi-sdw-bra-flow-controlled");
+	dp0->flow_controlled = fwnode_property_read_bool(port,
+				"mipi-sdw-bra-flow-controlled");
 
-	dp0->simple_ch_prep_sm = fwnode_property_read_bool(
-			port, "mipi-sdw-simplified-channel-prepare-sm");
+	dp0->simple_ch_prep_sm = fwnode_property_read_bool(port,
+				"mipi-sdw-simplified-channel-prepare-sm");
 
-	dp0->device_interrupts = fwnode_property_read_bool(
-			port, "mipi-sdw-imp-def-dp0-interrupts-supported");
+	dp0->device_interrupts = fwnode_property_read_bool(port,
+				"mipi-sdw-imp-def-dp0-interrupts-supported");
 
 	return 0;
 }
 
 static int sdw_slave_read_dpn(struct sdw_slave *slave,
-		struct sdw_dpn_prop *dpn, int count, int ports, char *type)
+			      struct sdw_dpn_prop *dpn, int count, int ports,
+			      char *type)
 {
 	struct fwnode_handle *node;
 	u32 bit, i = 0;
@@ -173,7 +179,7 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 
 	for_each_set_bit(bit, &addr, 32) {
 		snprintf(name, sizeof(name),
-			"mipi-sdw-dp-%d-%s-subproperties", bit, type);
+			 "mipi-sdw-dp-%d-%s-subproperties", bit, type);
 
 		dpn[i].num = bit;
 
@@ -184,9 +190,9 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 		}
 
 		fwnode_property_read_u32(node, "mipi-sdw-port-max-wordlength",
-					&dpn[i].max_word);
+					 &dpn[i].max_word);
 		fwnode_property_read_u32(node, "mipi-sdw-port-min-wordlength",
-					&dpn[i].min_word);
+					 &dpn[i].min_word);
 
 		nval = fwnode_property_read_u32_array(node,
 				"mipi-sdw-port-wordlength-configs", NULL, 0);
@@ -194,8 +200,9 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 
 			dpn[i].num_words = nval;
 			dpn[i].words = devm_kcalloc(&slave->dev,
-					dpn[i].num_words,
-					sizeof(*dpn[i].words), GFP_KERNEL);
+						    dpn[i].num_words,
+						    sizeof(*dpn[i].words),
+						    GFP_KERNEL);
 			if (!dpn[i].words)
 				return -ENOMEM;
 
@@ -205,28 +212,28 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 		}
 
 		fwnode_property_read_u32(node, "mipi-sdw-data-port-type",
-				&dpn[i].type);
+					 &dpn[i].type);
 
 		fwnode_property_read_u32(node,
-				"mipi-sdw-max-grouping-supported",
-				&dpn[i].max_grouping);
+					 "mipi-sdw-max-grouping-supported",
+					 &dpn[i].max_grouping);
 
 		dpn[i].simple_ch_prep_sm = fwnode_property_read_bool(node,
 				"mipi-sdw-simplified-channelprepare-sm");
 
 		fwnode_property_read_u32(node,
-				"mipi-sdw-port-channelprepare-timeout",
-				&dpn[i].ch_prep_timeout);
+					 "mipi-sdw-port-channelprepare-timeout",
+					 &dpn[i].ch_prep_timeout);
 
 		fwnode_property_read_u32(node,
 				"mipi-sdw-imp-def-dpn-interrupts-supported",
 				&dpn[i].device_interrupts);
 
 		fwnode_property_read_u32(node, "mipi-sdw-min-channel-number",
-				&dpn[i].min_ch);
+					 &dpn[i].min_ch);
 
 		fwnode_property_read_u32(node, "mipi-sdw-max-channel-number",
-				&dpn[i].max_ch);
+					 &dpn[i].max_ch);
 
 		nval = fwnode_property_read_u32_array(node,
 				"mipi-sdw-channel-number-list", NULL, 0);
@@ -234,7 +241,8 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 
 			dpn[i].num_ch = nval;
 			dpn[i].ch = devm_kcalloc(&slave->dev, dpn[i].num_ch,
-					sizeof(*dpn[i].ch), GFP_KERNEL);
+						 sizeof(*dpn[i].ch),
+						 GFP_KERNEL);
 			if (!dpn[i].ch)
 				return -ENOMEM;
 
@@ -265,13 +273,13 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 				"mipi-sdw-modes-supported", &dpn[i].modes);
 
 		fwnode_property_read_u32(node, "mipi-sdw-max-async-buffer",
-				&dpn[i].max_async_buffer);
+					 &dpn[i].max_async_buffer);
 
 		dpn[i].block_pack_mode = fwnode_property_read_bool(node,
 				"mipi-sdw-block-packing-mode");
 
 		fwnode_property_read_u32(node, "mipi-sdw-port-encoding-type",
-				&dpn[i].port_encoding);
+					 &dpn[i].port_encoding);
 
 		/* TODO: Read audio mode */
 
@@ -293,7 +301,7 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
 	int num_of_ports, nval, i, dp0 = 0;
 
 	device_property_read_u32(dev, "mipi-sdw-sw-interface-revision",
-				&prop->mipi_revision);
+				 &prop->mipi_revision);
 
 	prop->wake_capable = device_property_read_bool(dev,
 				"mipi-sdw-wake-up-unavailable");
@@ -311,10 +319,10 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
 			"mipi-sdw-simplified-clockstopprepare-sm-supported");
 
 	device_property_read_u32(dev, "mipi-sdw-clockstopprepare-timeout",
-			&prop->clk_stop_timeout);
+				 &prop->clk_stop_timeout);
 
 	device_property_read_u32(dev, "mipi-sdw-slave-channelprepare-timeout",
-			&prop->ch_prep_timeout);
+				 &prop->ch_prep_timeout);
 
 	device_property_read_u32(dev,
 			"mipi-sdw-clockstopprepare-hard-reset-behavior",
@@ -333,13 +341,13 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
 			"mipi-sdw-port15-read-behavior", &prop->p15_behave);
 
 	device_property_read_u32(dev, "mipi-sdw-master-count",
-				&prop->master_count);
+				 &prop->master_count);
 
 	device_property_read_u32(dev, "mipi-sdw-source-port-list",
-				&prop->source_ports);
+				 &prop->source_ports);
 
 	device_property_read_u32(dev, "mipi-sdw-sink-port-list",
-				&prop->sink_ports);
+				 &prop->sink_ports);
 
 	/* Read dp0 properties */
 	port = device_get_named_child_node(dev, "mipi-sdw-dp-0-subproperties");
@@ -348,7 +356,8 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
 	} else {
 
 		prop->dp0_prop = devm_kzalloc(&slave->dev,
-				sizeof(*prop->dp0_prop), GFP_KERNEL);
+					      sizeof(*prop->dp0_prop),
+					      GFP_KERNEL);
 		if (!prop->dp0_prop)
 			return -ENOMEM;
 
@@ -364,23 +373,25 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
 	/* Allocate memory for set bits in port lists */
 	nval = hweight32(prop->source_ports);
 	prop->src_dpn_prop = devm_kcalloc(&slave->dev, nval,
-				sizeof(*prop->src_dpn_prop), GFP_KERNEL);
+					  sizeof(*prop->src_dpn_prop),
+					  GFP_KERNEL);
 	if (!prop->src_dpn_prop)
 		return -ENOMEM;
 
 	/* Read dpn properties for source port(s) */
 	sdw_slave_read_dpn(slave, prop->src_dpn_prop, nval,
-			prop->source_ports, "source");
+			   prop->source_ports, "source");
 
 	nval = hweight32(prop->sink_ports);
 	prop->sink_dpn_prop = devm_kcalloc(&slave->dev, nval,
-				sizeof(*prop->sink_dpn_prop), GFP_KERNEL);
+					   sizeof(*prop->sink_dpn_prop),
+					   GFP_KERNEL);
 	if (!prop->sink_dpn_prop)
 		return -ENOMEM;
 
 	/* Read dpn properties for sink port(s) */
 	sdw_slave_read_dpn(slave, prop->sink_dpn_prop, nval,
-			prop->sink_ports, "sink");
+			   prop->sink_ports, "sink");
 
 	/* some ports are bidirectional so check total ports by ORing */
 	nval = prop->source_ports | prop->sink_ports;
@@ -388,7 +399,8 @@ int sdw_slave_read_prop(struct sdw_slave *slave)
 
 	/* Allocate port_ready based on num_of_ports */
 	slave->port_ready = devm_kcalloc(&slave->dev, num_of_ports,
-				sizeof(*slave->port_ready), GFP_KERNEL);
+					 sizeof(*slave->port_ready),
+					 GFP_KERNEL);
 	if (!slave->port_ready)
 		return -ENOMEM;
 
-- 
2.17.1

