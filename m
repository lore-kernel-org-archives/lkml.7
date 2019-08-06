Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7652C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 00:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9956216B7
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 00:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbfHFAzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 20:55:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:35775 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731268AbfHFAzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 20:55:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 17:55:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="198153140"
Received: from sahluwal-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.252.202.215])
  by fmsmga004.fm.intel.com with ESMTP; 05 Aug 2019 17:55:34 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, Blauciak@vger.kernel.org,
        Slawomir <slawomir.blauciak@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 05/17] soundwire: export helpers to find row and column values
Date:   Mon,  5 Aug 2019 19:55:10 -0500
Message-Id: <20190806005522.22642-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
References: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a prefix for common tables and export 2 helpers to set the frame
shapes based on row/col values.

These changes simplify bandwidth allocation algorithms as well as the
Cadence parts which all need to convert from frame shape to indices
used by the standard. These helpers are used in the following patch.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.h    |  7 +++++--
 drivers/soundwire/stream.c | 14 ++++++++------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index 648436a995a3..89e74adf96fa 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -73,8 +73,11 @@ struct sdw_msg {
 
 #define SDW_DOUBLE_RATE_FACTOR		2
 
-extern int rows[SDW_FRAME_ROWS];
-extern int cols[SDW_FRAME_COLS];
+extern int sdw_rows[SDW_FRAME_ROWS];
+extern int sdw_cols[SDW_FRAME_COLS];
+
+int sdw_find_row_index(int row);
+int sdw_find_col_index(int col);
 
 /**
  * sdw_port_runtime: Runtime port parameters for Master or Slave
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index a0476755a459..53f5e790fcd7 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -21,37 +21,39 @@
  * The rows are arranged as per the array index value programmed
  * in register. The index 15 has dummy value 0 in order to fill hole.
  */
-int rows[SDW_FRAME_ROWS] = {48, 50, 60, 64, 75, 80, 125, 147,
+int sdw_rows[SDW_FRAME_ROWS] = {48, 50, 60, 64, 75, 80, 125, 147,
 			96, 100, 120, 128, 150, 160, 250, 0,
 			192, 200, 240, 256, 72, 144, 90, 180};
 
-int cols[SDW_FRAME_COLS] = {2, 4, 6, 8, 10, 12, 14, 16};
+int sdw_cols[SDW_FRAME_COLS] = {2, 4, 6, 8, 10, 12, 14, 16};
 
-static int sdw_find_col_index(int col)
+int sdw_find_col_index(int col)
 {
 	int i;
 
 	for (i = 0; i < SDW_FRAME_COLS; i++) {
-		if (cols[i] == col)
+		if (sdw_cols[i] == col)
 			return i;
 	}
 
 	pr_warn("Requested column not found, selecting lowest column no: 2\n");
 	return 0;
 }
+EXPORT_SYMBOL(sdw_find_col_index);
 
-static int sdw_find_row_index(int row)
+int sdw_find_row_index(int row)
 {
 	int i;
 
 	for (i = 0; i < SDW_FRAME_ROWS; i++) {
-		if (rows[i] == row)
+		if (sdw_rows[i] == row)
 			return i;
 	}
 
 	pr_warn("Requested row not found, selecting lowest row no: 48\n");
 	return 0;
 }
+EXPORT_SYMBOL(sdw_find_row_index);
 
 static int _sdw_program_slave_port_params(struct sdw_bus *bus,
 					  struct sdw_slave *slave,
-- 
2.20.1

