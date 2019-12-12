Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534E5C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328A322527
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfLLBpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 20:45:42 -0500
Received: from mga02.intel.com ([134.134.136.20]:65192 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727724AbfLLBpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:45:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 17:45:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,303,1571727600"; 
   d="scan'208";a="296446128"
Received: from gjang-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.252.207.37])
  by orsmga001.jf.intel.com with ESMTP; 11 Dec 2019 17:45:28 -0800
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
Subject: [PATCH v5 10/11] soundwire: intel: add mutex for shared SHIM register access
Date:   Wed, 11 Dec 2019 19:45:06 -0600
Message-Id: <20191212014507.28050-11-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191212014507.28050-1-pierre-louis.bossart@linux.intel.com>
References: <20191212014507.28050-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the Intel SoundWire SHIM registers contain fields for
different links. Without protection, the master drivers for the
different links will access these shared registers, leading to invalid
configurations and timeouts (specifically when changing CPA/SPA
power-related registers and polling for the changes to be applied).

A mutex is added to make sure all rmw access to those registers are
serialized.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/linux/soundwire/sdw_intel.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 073121c49695..45fa6d93197f 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -71,6 +71,7 @@ struct sdw_intel_link_res;
  * @links: information for each link (controller-specific and kept
  * opaque here)
  * @link_list: list to handle interrupts across all links
+ * @shim_lock: mutex to handle concurrent rmw access to shared SHIM registers.
  */
 struct sdw_intel_ctx {
 	int count;
@@ -79,6 +80,7 @@ struct sdw_intel_ctx {
 	acpi_handle handle;
 	struct sdw_intel_link_res *links;
 	struct list_head link_list;
+	struct mutex shim_lock; /* lock for access to shared SHIM registers */
 };
 
 /**
-- 
2.20.1

