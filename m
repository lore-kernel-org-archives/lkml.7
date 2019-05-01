Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04E1C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 15:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999A821734
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 15:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfEAP7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 11:59:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:25560 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbfEAP6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 11:58:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 May 2019 08:58:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,418,1549958400"; 
   d="scan'208";a="296115743"
Received: from modiarvi-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.134.211])
  by orsmga004.jf.intel.com with ESMTP; 01 May 2019 08:58:39 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH v4 18/22] soundwire: cadence_master: fix alignment issues
Date:   Wed,  1 May 2019 10:57:41 -0500
Message-Id: <20190501155745.21806-19-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use Linux style

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 79 +++++++++++++++---------------
 1 file changed, 40 insertions(+), 39 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index cb6a331f448a..e45076be1e09 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -226,9 +226,9 @@ static int cdns_clear_bit(struct sdw_cdns *cdns, int offset, u32 value)
 /*
  * IO Calls
  */
-static enum sdw_command_response cdns_fill_msg_resp(
-			struct sdw_cdns *cdns,
-			struct sdw_msg *msg, int count, int offset)
+static enum sdw_command_response
+cdns_fill_msg_resp(struct sdw_cdns *cdns,
+		   struct sdw_msg *msg, int count, int offset)
 {
 	int nack = 0, no_ack = 0;
 	int i;
@@ -263,7 +263,7 @@ static enum sdw_command_response cdns_fill_msg_resp(
 
 static enum sdw_command_response
 _cdns_xfer_msg(struct sdw_cdns *cdns, struct sdw_msg *msg, int cmd,
-				int offset, int count, bool defer)
+	       int offset, int count, bool defer)
 {
 	unsigned long time;
 	u32 base, i, data;
@@ -296,7 +296,7 @@ _cdns_xfer_msg(struct sdw_cdns *cdns, struct sdw_msg *msg, int cmd,
 
 	/* wait for timeout or response */
 	time = wait_for_completion_timeout(&cdns->tx_complete,
-				msecs_to_jiffies(CDNS_TX_TIMEOUT));
+					   msecs_to_jiffies(CDNS_TX_TIMEOUT));
 	if (!time) {
 		dev_err(cdns->dev, "IO transfer timed out\n");
 		msg->len = 0;
@@ -306,8 +306,8 @@ _cdns_xfer_msg(struct sdw_cdns *cdns, struct sdw_msg *msg, int cmd,
 	return cdns_fill_msg_resp(cdns, msg, count, offset);
 }
 
-static enum sdw_command_response cdns_program_scp_addr(
-			struct sdw_cdns *cdns, struct sdw_msg *msg)
+static enum sdw_command_response
+cdns_program_scp_addr(struct sdw_cdns *cdns, struct sdw_msg *msg)
 {
 	int nack = 0, no_ack = 0;
 	unsigned long time;
@@ -336,7 +336,7 @@ static enum sdw_command_response cdns_program_scp_addr(
 	cdns_writel(cdns, base, data[1]);
 
 	time = wait_for_completion_timeout(&cdns->tx_complete,
-				msecs_to_jiffies(CDNS_TX_TIMEOUT));
+					   msecs_to_jiffies(CDNS_TX_TIMEOUT));
 	if (!time) {
 		dev_err(cdns->dev, "SCP Msg trf timed out\n");
 		msg->len = 0;
@@ -410,7 +410,7 @@ cdns_xfer_msg(struct sdw_bus *bus, struct sdw_msg *msg)
 
 	for (i = 0; i < msg->len / CDNS_MCP_CMD_LEN; i++) {
 		ret = _cdns_xfer_msg(cdns, msg, cmd, i * CDNS_MCP_CMD_LEN,
-				CDNS_MCP_CMD_LEN, false);
+				     CDNS_MCP_CMD_LEN, false);
 		if (ret < 0)
 			goto exit;
 	}
@@ -419,7 +419,7 @@ cdns_xfer_msg(struct sdw_bus *bus, struct sdw_msg *msg)
 		goto exit;
 
 	ret = _cdns_xfer_msg(cdns, msg, cmd, i * CDNS_MCP_CMD_LEN,
-			msg->len % CDNS_MCP_CMD_LEN, false);
+			     msg->len % CDNS_MCP_CMD_LEN, false);
 
 exit:
 	return ret;
@@ -428,7 +428,7 @@ EXPORT_SYMBOL(cdns_xfer_msg);
 
 enum sdw_command_response
 cdns_xfer_msg_defer(struct sdw_bus *bus,
-		struct sdw_msg *msg, struct sdw_defer *defer)
+		    struct sdw_msg *msg, struct sdw_defer *defer)
 {
 	struct sdw_cdns *cdns = bus_to_cdns(bus);
 	int cmd = 0, ret;
@@ -483,7 +483,7 @@ static void cdns_read_response(struct sdw_cdns *cdns)
 }
 
 static int cdns_update_slave_status(struct sdw_cdns *cdns,
-					u32 slave0, u32 slave1)
+				    u32 slave0, u32 slave1)
 {
 	enum sdw_slave_status status[SDW_MAX_DEVICES + 1];
 	bool is_slave = false;
@@ -526,8 +526,8 @@ static int cdns_update_slave_status(struct sdw_cdns *cdns,
 		/* first check if Slave reported multiple status */
 		if (set_status > 1) {
 			dev_warn(cdns->dev,
-					"Slave reported multiple Status: %d\n",
-					status[i]);
+				 "Slave reported multiple Status: %d\n",
+				 status[i]);
 			/*
 			 * TODO: we need to reread the status here by
 			 * issuing a PING cmd
@@ -566,7 +566,7 @@ irqreturn_t sdw_cdns_irq(int irq, void *dev_id)
 
 		if (cdns->defer) {
 			cdns_fill_msg_resp(cdns, cdns->defer->msg,
-					cdns->defer->length, 0);
+					   cdns->defer->length, 0);
 			complete(&cdns->defer->complete);
 			cdns->defer = NULL;
 		} else
@@ -592,7 +592,7 @@ irqreturn_t sdw_cdns_irq(int irq, void *dev_id)
 	if (int_status & CDNS_MCP_INT_SLAVE_MASK) {
 		/* Mask the Slave interrupt and wake thread */
 		cdns_updatel(cdns, CDNS_MCP_INTMASK,
-				CDNS_MCP_INT_SLAVE_MASK, 0);
+			     CDNS_MCP_INT_SLAVE_MASK, 0);
 
 		int_status &= ~CDNS_MCP_INT_SLAVE_MASK;
 		ret = IRQ_WAKE_THREAD;
@@ -625,7 +625,7 @@ irqreturn_t sdw_cdns_thread(int irq, void *dev_id)
 	/* clear and unmask Slave interrupt now */
 	cdns_writel(cdns, CDNS_MCP_INTSTAT, CDNS_MCP_INT_SLAVE_MASK);
 	cdns_updatel(cdns, CDNS_MCP_INTMASK,
-			CDNS_MCP_INT_SLAVE_MASK, CDNS_MCP_INT_SLAVE_MASK);
+		     CDNS_MCP_INT_SLAVE_MASK, CDNS_MCP_INT_SLAVE_MASK);
 
 	return IRQ_HANDLED;
 }
@@ -639,9 +639,9 @@ static int _cdns_enable_interrupt(struct sdw_cdns *cdns)
 	u32 mask;
 
 	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK0,
-				CDNS_MCP_SLAVE_INTMASK0_MASK);
+		    CDNS_MCP_SLAVE_INTMASK0_MASK);
 	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1,
-				CDNS_MCP_SLAVE_INTMASK1_MASK);
+		    CDNS_MCP_SLAVE_INTMASK1_MASK);
 
 	mask = CDNS_MCP_INT_SLAVE_RSVD | CDNS_MCP_INT_SLAVE_ALERT |
 		CDNS_MCP_INT_SLAVE_ATTACH | CDNS_MCP_INT_SLAVE_NATTACH |
@@ -663,7 +663,7 @@ int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
 
 	_cdns_enable_interrupt(cdns);
 	ret = cdns_clear_bit(cdns, CDNS_MCP_CONFIG_UPDATE,
-			CDNS_MCP_CONFIG_UPDATE_BIT);
+			     CDNS_MCP_CONFIG_UPDATE_BIT);
 	if (ret < 0)
 		dev_err(cdns->dev, "Config update timedout");
 
@@ -672,8 +672,8 @@ int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
 EXPORT_SYMBOL(sdw_cdns_enable_interrupt);
 
 static int cdns_allocate_pdi(struct sdw_cdns *cdns,
-			struct sdw_cdns_pdi **stream,
-			u32 num, u32 pdi_offset)
+			     struct sdw_cdns_pdi **stream,
+			     u32 num, u32 pdi_offset)
 {
 	struct sdw_cdns_pdi *pdi;
 	int i;
@@ -701,7 +701,7 @@ static int cdns_allocate_pdi(struct sdw_cdns *cdns,
  * @config: Stream configurations
  */
 int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
-			struct sdw_cdns_stream_config config)
+		      struct sdw_cdns_stream_config config)
 {
 	struct sdw_cdns_streams *stream;
 	int offset, i, ret;
@@ -770,7 +770,7 @@ int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
 	cdns->num_ports += stream->num_pdi;
 
 	cdns->ports = devm_kcalloc(cdns->dev, cdns->num_ports,
-				sizeof(*cdns->ports), GFP_KERNEL);
+				   sizeof(*cdns->ports), GFP_KERNEL);
 	if (!cdns->ports) {
 		ret = -ENOMEM;
 		return ret;
@@ -796,7 +796,7 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
 
 	/* Exit clock stop */
 	ret = cdns_clear_bit(cdns, CDNS_MCP_CONTROL,
-			CDNS_MCP_CONTROL_CLK_STOP_CLR);
+			     CDNS_MCP_CONTROL_CLK_STOP_CLR);
 	if (ret < 0) {
 		dev_err(cdns->dev, "Couldn't exit from clock stop\n");
 		return ret;
@@ -816,7 +816,7 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
 
 	/* Set cmd accept mode */
 	cdns_updatel(cdns, CDNS_MCP_CONTROL, CDNS_MCP_CONTROL_CMD_ACCEPT,
-					CDNS_MCP_CONTROL_CMD_ACCEPT);
+		     CDNS_MCP_CONTROL_CMD_ACCEPT);
 
 	/* Configure mcp config */
 	val = cdns_readl(cdns, CDNS_MCP_CONFIG);
@@ -873,7 +873,7 @@ int cdns_bus_conf(struct sdw_bus *bus, struct sdw_bus_params *params)
 EXPORT_SYMBOL(cdns_bus_conf);
 
 static int cdns_port_params(struct sdw_bus *bus,
-		struct sdw_port_params *p_params, unsigned int bank)
+			    struct sdw_port_params *p_params, unsigned int bank)
 {
 	struct sdw_cdns *cdns = bus_to_cdns(bus);
 	int dpn_config = 0, dpn_config_off;
@@ -898,8 +898,8 @@ static int cdns_port_params(struct sdw_bus *bus,
 }
 
 static int cdns_transport_params(struct sdw_bus *bus,
-			struct sdw_transport_params *t_params,
-			enum sdw_reg_bank bank)
+				 struct sdw_transport_params *t_params,
+				 enum sdw_reg_bank bank)
 {
 	struct sdw_cdns *cdns = bus_to_cdns(bus);
 	int dpn_offsetctrl = 0, dpn_offsetctrl_off;
@@ -952,7 +952,7 @@ static int cdns_transport_params(struct sdw_bus *bus,
 }
 
 static int cdns_port_enable(struct sdw_bus *bus,
-		struct sdw_enable_ch *enable_ch, unsigned int bank)
+			    struct sdw_enable_ch *enable_ch, unsigned int bank)
 {
 	struct sdw_cdns *cdns = bus_to_cdns(bus);
 	int dpn_chnen_off, ch_mask;
@@ -988,7 +988,7 @@ int sdw_cdns_probe(struct sdw_cdns *cdns)
 EXPORT_SYMBOL(sdw_cdns_probe);
 
 int cdns_set_sdw_stream(struct snd_soc_dai *dai,
-		void *stream, bool pcm, int direction)
+			void *stream, bool pcm, int direction)
 {
 	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
 	struct sdw_cdns_dma_data *dma;
@@ -1026,7 +1026,8 @@ EXPORT_SYMBOL(cdns_set_sdw_stream);
  * Find and return a free PDI for a given PDI array
  */
 static struct sdw_cdns_pdi *cdns_find_pdi(struct sdw_cdns *cdns,
-		unsigned int num, struct sdw_cdns_pdi *pdi)
+					  unsigned int num,
+					  struct sdw_cdns_pdi *pdi)
 {
 	int i;
 
@@ -1050,8 +1051,8 @@ static struct sdw_cdns_pdi *cdns_find_pdi(struct sdw_cdns *cdns,
  * @pdi: PDI to be used
  */
 void sdw_cdns_config_stream(struct sdw_cdns *cdns,
-				struct sdw_cdns_port *port,
-				u32 ch, u32 dir, struct sdw_cdns_pdi *pdi)
+			    struct sdw_cdns_port *port,
+			    u32 ch, u32 dir, struct sdw_cdns_pdi *pdi)
 {
 	u32 offset, val = 0;
 
@@ -1076,8 +1077,8 @@ EXPORT_SYMBOL(sdw_cdns_config_stream);
  * @ch_count: Channel count
  */
 static int cdns_get_num_pdi(struct sdw_cdns *cdns,
-		struct sdw_cdns_pdi *pdi,
-		unsigned int num, u32 ch_count)
+			    struct sdw_cdns_pdi *pdi,
+			    unsigned int num, u32 ch_count)
 {
 	int i, pdis = 0;
 
@@ -1139,8 +1140,8 @@ EXPORT_SYMBOL(sdw_cdns_get_stream);
  * @dir: Data direction
  */
 int sdw_cdns_alloc_stream(struct sdw_cdns *cdns,
-			struct sdw_cdns_streams *stream,
-			struct sdw_cdns_port *port, u32 ch, u32 dir)
+			  struct sdw_cdns_streams *stream,
+			  struct sdw_cdns_port *port, u32 ch, u32 dir)
 {
 	struct sdw_cdns_pdi *pdi = NULL;
 
@@ -1167,7 +1168,7 @@ int sdw_cdns_alloc_stream(struct sdw_cdns *cdns,
 EXPORT_SYMBOL(sdw_cdns_alloc_stream);
 
 void sdw_cdns_shutdown(struct snd_pcm_substream *substream,
-					struct snd_soc_dai *dai)
+		       struct snd_soc_dai *dai)
 {
 	struct sdw_cdns_dma_data *dma;
 
-- 
2.17.1

