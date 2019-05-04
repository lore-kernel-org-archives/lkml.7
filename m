Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D864C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 00:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B432081C
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 00:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfEDA3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 20:29:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:11134 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbfEDA3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 20:29:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 17:29:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,427,1549958400"; 
   d="scan'208";a="170430439"
Received: from jlwhitty-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.28.45])
  by fmsmga001.fm.intel.com with ESMTP; 03 May 2019 17:29:41 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 3/8] soundwire: mipi_disco: expose sdw_slave_read_dpn as symbol
Date:   Fri,  3 May 2019 19:29:21 -0500
Message-Id: <20190504002926.28815-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504002926.28815-1-pierre-louis.bossart@linux.intel.com>
References: <20190504002926.28815-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sdw_slave_read_dpn was so far a static function, which prevented
codec drivers from using it. Expose as non-static function and add symbol

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/mipi_disco.c | 7 ++++---
 include/linux/soundwire/sdw.h  | 3 +++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/mipi_disco.c b/drivers/soundwire/mipi_disco.c
index 6df68584c963..4995554bd6b6 100644
--- a/drivers/soundwire/mipi_disco.c
+++ b/drivers/soundwire/mipi_disco.c
@@ -161,9 +161,9 @@ static int sdw_slave_read_dp0(struct sdw_slave *slave,
 	return 0;
 }
 
-static int sdw_slave_read_dpn(struct sdw_slave *slave,
-			      struct sdw_dpn_prop *dpn, int count, int ports,
-			      char *type)
+int sdw_slave_read_dpn(struct sdw_slave *slave,
+		       struct sdw_dpn_prop *dpn, int count, int ports,
+		       char *type)
 {
 	struct fwnode_handle *node;
 	u32 bit, i = 0;
@@ -283,6 +283,7 @@ static int sdw_slave_read_dpn(struct sdw_slave *slave,
 
 	return 0;
 }
+EXPORT_SYMBOL(sdw_slave_read_dpn);
 
 /**
  * sdw_slave_read_prop() - Read Slave properties
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 35662d9c2c62..04a45225e248 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -345,6 +345,9 @@ struct sdw_master_prop {
 
 int sdw_master_read_prop(struct sdw_bus *bus);
 int sdw_slave_read_prop(struct sdw_slave *slave);
+int sdw_slave_read_dpn(struct sdw_slave *slave,
+		       struct sdw_dpn_prop *dpn, int count, int ports,
+		       char *type);
 
 /*
  * SDW Slave Structures and APIs
-- 
2.17.1

