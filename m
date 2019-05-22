Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0639AC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA90320862
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732837AbfEVTsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:48:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:47986 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731880AbfEVTsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:48:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 12:48:00 -0700
X-ExtLoop1: 1
Received: from cjpowell-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.154.39])
  by fmsmga008.fm.intel.com with ESMTP; 22 May 2019 12:47:59 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH v2 09/15] soundwire: rename/clarify MIPI DisCo properties
Date:   Wed, 22 May 2019 14:47:25 -0500
Message-Id: <20190522194732.25704-10-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
References: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing definitions are ambiguous and possibly misleading.

For DP0, 'flow-control' is only relevant for the BRA protocol and
should not be confused with async modes explicitly not supported for
DP0, add prefix to follow MIPI DisCo definition

The use of 'device_interrupts' is also questionable. The MIPI
SoundWire spec defines Slave-, DP0- and DPN-level
implementation-defined interrupts. Using the 'device' prefix in the
last two cases is misleading, not only is the term 'device' overloaded
but these properties are only valid at the DP0 and DPn levels. Rename
to follow the MIPI definitions, no need to be creative here.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c        |  2 +-
 drivers/soundwire/mipi_disco.c |  6 +++---
 drivers/soundwire/stream.c     |  6 +++---
 include/linux/soundwire/sdw.h  | 13 +++++++------
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 96e42df8f458..fe745830a261 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -648,7 +648,7 @@ static int sdw_initialize_slave(struct sdw_slave *slave)
 		return 0;
 
 	/* Enable DP0 interrupts */
-	val = prop->dp0_prop->device_interrupts;
+	val = prop->dp0_prop->imp_def_interrupts;
 	val |= SDW_DP0_INT_PORT_READY | SDW_DP0_INT_BRA_FAILURE;
 
 	ret = sdw_update(slave, SDW_DP0_INTMASK, val, val);
diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
index efb87ee0e7fc..79fee1b21ab6 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -150,13 +150,13 @@ static int sdw_slave_read_dp0(struct sdw_slave *slave,
 				dp0->words, dp0->num_words);
 	}
 
-	dp0->flow_controlled = fwnode_property_read_bool(port,
+	dp0->BRA_flow_controlled = fwnode_property_read_bool(port,
 				"mipi-sdw-bra-flow-controlled");
 
 	dp0->simple_ch_prep_sm = fwnode_property_read_bool(port,
 				"mipi-sdw-simplified-channel-prepare-sm");
 
-	dp0->device_interrupts = fwnode_property_read_bool(port,
+	dp0->imp_def_interrupts = fwnode_property_read_bool(port,
 				"mipi-sdw-imp-def-dp0-interrupts-supported");
 
 	return 0;
@@ -225,7 +225,7 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 
 		fwnode_property_read_u32(node,
 				"mipi-sdw-imp-def-dpn-interrupts-supported",
-				&dpn[i].device_interrupts);
+				&dpn[i].imp_def_interrupts);
 
 		fwnode_property_read_u32(node, "mipi-sdw-min-channel-number",
 					 &dpn[i].min_ch);
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 89edc897b8eb..ce9cb7fa4724 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -439,7 +439,7 @@ static int sdw_prep_deprep_slave_ports(struct sdw_bus *bus,
 
 	prep_ch.bank = bus->params.next_bank;
 
-	if (dpn_prop->device_interrupts || !dpn_prop->simple_ch_prep_sm)
+	if (dpn_prop->imp_def_interrupts || !dpn_prop->simple_ch_prep_sm)
 		intr = true;
 
 	/*
@@ -449,7 +449,7 @@ static int sdw_prep_deprep_slave_ports(struct sdw_bus *bus,
 	 */
 	if (prep && intr) {
 		ret = sdw_configure_dpn_intr(s_rt->slave, p_rt->num, prep,
-					     dpn_prop->device_interrupts);
+					     dpn_prop->imp_def_interrupts);
 		if (ret < 0)
 			return ret;
 	}
@@ -493,7 +493,7 @@ static int sdw_prep_deprep_slave_ports(struct sdw_bus *bus,
 	/* Disable interrupt after Port de-prepare */
 	if (!prep && intr)
 		ret = sdw_configure_dpn_intr(s_rt->slave, p_rt->num, prep,
-					     dpn_prop->device_interrupts);
+					     dpn_prop->imp_def_interrupts);
 
 	return ret;
 }
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index b7efa819d425..bea46bd8b6ce 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -206,10 +206,11 @@ enum sdw_clk_stop_mode {
  * (inclusive)
  * @num_words: number of wordlengths supported
  * @words: wordlengths supported
- * @flow_controlled: Slave implementation results in an OK_NotReady
+ * @BRA_flow_controlled: Slave implementation results in an OK_NotReady
  * response
  * @simple_ch_prep_sm: If channel prepare sequence is required
- * @device_interrupts: If implementation-defined interrupts are supported
+ * @imp_def_interrupts: If set, each bit corresponds to support for
+ * implementation-defined interrupts
  *
  * The wordlengths are specified by Spec as max, min AND number of
  * discrete values, implementation can define based on the wordlengths they
@@ -220,9 +221,9 @@ struct sdw_dp0_prop {
 	u32 min_word;
 	u32 num_words;
 	u32 *words;
-	bool flow_controlled;
+	bool BRA_flow_controlled;
 	bool simple_ch_prep_sm;
-	bool device_interrupts;
+	bool imp_def_interrupts;
 };
 
 /**
@@ -272,7 +273,7 @@ struct sdw_dpn_audio_mode {
  * @simple_ch_prep_sm: If the port supports simplified channel prepare state
  * machine
  * @ch_prep_timeout: Port-specific timeout value, in milliseconds
- * @device_interrupts: If set, each bit corresponds to support for
+ * @imp_def_interrupts: If set, each bit corresponds to support for
  * implementation-defined interrupts
  * @max_ch: Maximum channels supported
  * @min_ch: Minimum channels supported
@@ -297,7 +298,7 @@ struct sdw_dpn_prop {
 	u32 max_grouping;
 	bool simple_ch_prep_sm;
 	u32 ch_prep_timeout;
-	u32 device_interrupts;
+	u32 imp_def_interrupts;
 	u32 max_ch;
 	u32 min_ch;
 	u32 num_ch;
-- 
2.20.1

