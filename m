Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A076CC0650F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 00:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE36214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 00:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731509AbfHFA4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 20:56:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:35804 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731449AbfHFAzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 20:55:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 17:55:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="198153241"
Received: from sahluwal-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.252.202.215])
  by fmsmga004.fm.intel.com with ESMTP; 05 Aug 2019 17:55:52 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, Blauciak@vger.kernel.org,
        Slawomir <slawomir.blauciak@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 16/17] soundwire: cadence_master: add kernel parameter to override interrupt mask
Date:   Mon,  5 Aug 2019 19:55:21 -0500
Message-Id: <20190806005522.22642-17-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
References: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code has a set of defaults which may not be relevant in all cases,
add kernel parameter as a helper - mostly for early board bring-up.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index fb198a806efd..4ab3174cbb04 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -20,6 +20,10 @@
 #include "bus.h"
 #include "cadence_master.h"
 
+static int interrupt_mask;
+module_param_named(cnds_mcp_int_mask, interrupt_mask, int, 0444);
+MODULE_PARM_DESC(cdns_mcp_int_mask, "Cadence MCP IntMask");
+
 #define CDNS_MCP_CONFIG				0x0
 
 #define CDNS_MCP_CONFIG_MCMD_RETRY		GENMASK(27, 24)
@@ -762,6 +766,9 @@ static int _cdns_enable_interrupt(struct sdw_cdns *cdns)
 	 */
 	mask |= CDNS_MCP_INT_IRQ;
 
+	if (interrupt_mask) /* parameter override */
+		mask = interrupt_mask;
+
 	cdns_writel(cdns, CDNS_MCP_INTMASK, mask);
 
 	return 0;
-- 
2.20.1

