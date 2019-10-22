Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF11CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 23:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2382075A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 23:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389808AbfJVXsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 19:48:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:55767 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732393AbfJVXsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 19:48:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 16:48:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,218,1569308400"; 
   d="scan'208";a="399211295"
Received: from srajamoh-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.20.203])
  by fmsmga006.fm.intel.com with ESMTP; 22 Oct 2019 16:48:43 -0700
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
Subject: [PATCH 1/3] soundwire: remove bitfield for unique_id, use u8
Date:   Tue, 22 Oct 2019 18:48:06 -0500
Message-Id: <20191022234808.17432-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022234808.17432-1-pierre-louis.bossart@linux.intel.com>
References: <20191022234808.17432-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no good reason why the unique_id needs to be stored as 4
bits. The code will work without changes with a u8 since all values
are already filtered while parsing the ACPI tables and Slave devID
registers.

Use u8 representation. This will allow us to encode a
"IGNORE_UNIQUE_ID" value to account for firmware/BIOS creativity.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 688b40e65c89..28745b9ba279 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -403,6 +403,8 @@ int sdw_slave_read_prop(struct sdw_slave *slave);
  * SDW Slave Structures and APIs
  */
 
+#define SDW_IGNORED_UNIQUE_ID 0xFF
+
 /**
  * struct sdw_slave_id - Slave ID
  * @mfg_id: MIPI Manufacturer ID
@@ -418,7 +420,7 @@ struct sdw_slave_id {
 	__u16 mfg_id;
 	__u16 part_id;
 	__u8 class_id;
-	__u8 unique_id:4;
+	__u8 unique_id;
 	__u8 sdw_version:4;
 };
 
-- 
2.20.1

