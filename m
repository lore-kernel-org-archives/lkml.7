Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94890C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 19:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7806E206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 19:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390988AbfIPTYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 15:24:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:33593 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388126AbfIPTYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 15:24:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 12:24:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,513,1559545200"; 
   d="scan'208";a="270291195"
Received: from jvhicko1-mobl2.amr.corp.intel.com (HELO localhost.localdomain) ([10.254.104.227])
  by orsmga001.jf.intel.com with ESMTP; 16 Sep 2019 12:23:58 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 5/6] soundwire: intel: don't filter out PDI0/1
Date:   Mon, 16 Sep 2019 14:23:47 -0500
Message-Id: <20190916192348.467-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916192348.467-1-pierre-louis.bossart@linux.intel.com>
References: <20190916192348.467-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PDI0/1 are reserved for Bulk and filtered out in the existing code.
That leads to endless confusions on whether the index is the raw or
corrected one. In addition we will need support for Bulk at some point
so it's just simpler to expose those PDIs and not use it for now than
try to be smart unless we have to remove the smarts.

This patch requires a topology change to use PDIs starting at offset 2
explicitly.

Note that there is a known discrepancy between hardware documentation
and what ALH stream works in practice, future fixes are likely.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 46ebd601a454..dfce2b8c5ad2 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -183,9 +183,6 @@ MODULE_PARM_DESC(cdns_mcp_int_mask, "Cadence MCP IntMask");
 #define CDNS_DEFAULT_SSP_INTERVAL		0x18
 #define CDNS_TX_TIMEOUT				2000
 
-#define CDNS_PCM_PDI_OFFSET			0x2
-#define CDNS_PDM_PDI_OFFSET			0x6
-
 #define CDNS_SCP_RX_FIFOLEVEL			0x2
 
 /*
@@ -295,11 +292,7 @@ static int cdns_reg_show(struct seq_file *s, void *data)
 	ret += scnprintf(buf + ret, RD_BUF - ret,
 			 "\nDPn B0 Registers\n");
 
-	/*
-	 * in sdw_cdns_pdi_init() we filter out the Bulk PDIs,
-	 * so the indices need to be corrected again
-	 */
-	num_ports = cdns->num_ports + CDNS_PCM_PDI_OFFSET;
+	num_ports = cdns->num_ports;
 
 	for (i = 0; i < num_ports; i++) {
 		ret += scnprintf(buf + ret, RD_BUF - ret,
@@ -908,11 +901,8 @@ int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
 	/* Allocate PDIs for PCMs */
 	stream = &cdns->pcm;
 
-	/* First two PDIs are reserved for bulk transfers */
-	if (stream->num_bd < CDNS_PCM_PDI_OFFSET)
-		return -EINVAL;
-	stream->num_bd -= CDNS_PCM_PDI_OFFSET;
-	offset = CDNS_PCM_PDI_OFFSET;
+	/* we allocate PDI0 and PDI1 which are used for Bulk */
+	offset = 0;
 
 	ret = cdns_allocate_pdi(cdns, &stream->bd,
 				stream->num_bd, offset);
@@ -930,6 +920,9 @@ int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
 
 	ret = cdns_allocate_pdi(cdns, &stream->out,
 				stream->num_out, offset);
+
+	offset += stream->num_out;
+
 	if (ret)
 		return ret;
 
@@ -939,7 +932,6 @@ int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
 
 	/* Allocate PDIs for PDMs */
 	stream = &cdns->pdm;
-	offset = CDNS_PDM_PDI_OFFSET;
 	ret = cdns_allocate_pdi(cdns, &stream->bd,
 				stream->num_bd, offset);
 	if (ret)
@@ -1236,12 +1228,13 @@ EXPORT_SYMBOL(cdns_set_sdw_stream);
  * Find and return a free PDI for a given PDI array
  */
 static struct sdw_cdns_pdi *cdns_find_pdi(struct sdw_cdns *cdns,
+					  unsigned int offset,
 					  unsigned int num,
 					  struct sdw_cdns_pdi *pdi)
 {
 	int i;
 
-	for (i = 0; i < num; i++) {
+	for (i = offset; i < num; i++) {
 		if (pdi[i].assigned)
 			continue;
 		pdi[i].assigned = true;
@@ -1291,13 +1284,13 @@ struct sdw_cdns_pdi *sdw_cdns_alloc_pdi(struct sdw_cdns *cdns,
 	struct sdw_cdns_pdi *pdi = NULL;
 
 	if (dir == SDW_DATA_DIR_RX)
-		pdi = cdns_find_pdi(cdns, stream->num_in, stream->in);
+		pdi = cdns_find_pdi(cdns, 0, stream->num_in, stream->in);
 	else
-		pdi = cdns_find_pdi(cdns, stream->num_out, stream->out);
+		pdi = cdns_find_pdi(cdns, 0, stream->num_out, stream->out);
 
 	/* check if we found a PDI, else find in bi-directional */
 	if (!pdi)
-		pdi = cdns_find_pdi(cdns, stream->num_bd, stream->bd);
+		pdi = cdns_find_pdi(cdns, 2, stream->num_bd, stream->bd);
 
 	if (pdi) {
 		pdi->l_ch_num = 0;
-- 
2.20.1

