Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F26C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96652087F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfH3GJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 02:09:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:19448 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfH3GJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:09:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 23:09:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,445,1559545200"; 
   d="scan'208";a="172141707"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga007.jf.intel.com with ESMTP; 29 Aug 2019 23:09:54 -0700
From:   Bard liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        Blauciak@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soundwire: bus: set initial value to port_status
Date:   Fri, 30 Aug 2019 02:11:35 +0800
Message-Id: <20190829181135.16049-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bard Liao <yung-chuan.liao@linux.intel.com>

port_status[port_num] are assigned for each port_num in some if
conditions. So some of the port_status may not be initialized.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index f6a1e4b4813d..33f41b3e642e 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -835,7 +835,7 @@ static int sdw_handle_port_interrupt(struct sdw_slave *slave,
 static int sdw_handle_slave_alerts(struct sdw_slave *slave)
 {
 	struct sdw_slave_intr_status slave_intr;
-	u8 clear = 0, bit, port_status[15];
+	u8 clear = 0, bit, port_status[15] = {0};
 	int port_num, stat, ret, count = 0;
 	unsigned long port;
 	bool slave_notify = false;
-- 
2.17.1

