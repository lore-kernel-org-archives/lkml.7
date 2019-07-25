Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25965C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00276206DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfGYXl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 19:41:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:51808 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727300AbfGYXlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 19:41:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 16:41:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,308,1559545200"; 
   d="scan'208";a="369874711"
Received: from amrutaku-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.255.230.75])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jul 2019 16:41:21 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [RFC PATCH 15/40] soundwire: cadence_master: handle multiple status reports per Slave
Date:   Thu, 25 Jul 2019 18:40:07 -0500
Message-Id: <20190725234032.21152-16-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a Slave reports multiple status in the sticky bits, find the
latest configuration from the mirror of the PING frame status and
update the status directly.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 34 ++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 889fa2cd49ae..25d5c7267c15 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -643,13 +643,35 @@ static int cdns_update_slave_status(struct sdw_cdns *cdns,
 
 		/* first check if Slave reported multiple status */
 		if (set_status > 1) {
+			u32 val;
+
 			dev_warn_ratelimited(cdns->dev,
-					     "Slave reported multiple Status: %d\n",
-					     mask);
-			/*
-			 * TODO: we need to reread the status here by
-			 * issuing a PING cmd
-			 */
+					     "Slave %d reported multiple Status: %d\n",
+					     i, mask);
+
+			/* re-check latest status extracted from PING commands */
+			val = cdns_readl(cdns, CDNS_MCP_SLAVE_STAT);
+			val >>= (i * 2);
+
+			switch (val & 0x3) {
+			case 0:
+				status[i] = SDW_SLAVE_UNATTACHED;
+				break;
+			case 1:
+				status[i] = SDW_SLAVE_ATTACHED;
+				break;
+			case 2:
+				status[i] = SDW_SLAVE_ALERT;
+				break;
+			default:
+				status[i] = SDW_SLAVE_RESERVED;
+				break;
+			}
+
+			dev_warn_ratelimited(cdns->dev,
+					     "Slave %d status updated to %d\n",
+					     i, status[i]);
+
 		}
 	}
 
-- 
2.20.1

