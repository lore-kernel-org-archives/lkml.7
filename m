Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80587C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 23:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF9120721
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 23:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfLIXzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 18:55:50 -0500
Received: from mga02.intel.com ([134.134.136.20]:13468 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727627AbfLIXzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 18:55:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 15:55:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,297,1571727600"; 
   d="scan'208";a="210273701"
Received: from bbower-mobl.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.65.172])
  by fmsmga008.fm.intel.com with ESMTP; 09 Dec 2019 15:55:46 -0800
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
Subject: [PATCH v4 11/11] soundwire: intel: add clock stop quirks
Date:   Mon,  9 Dec 2019 17:55:19 -0600
Message-Id: <20191209235520.18727-12-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191209235520.18727-1-pierre-louis.bossart@linux.intel.com>
References: <20191209235520.18727-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to power rail dependencies, the SoundWire Master driver cannot
make decisions on its own when entering pm runtime suspend.

Add quirk mask for each link, so that the SOF parent driver can inform
the SoundWire master driver of the desired behavior:
a) leave clock on
b) power-off instead of clock stop
c) power-off if all devices cannot generate wakes
d) force bus reset on clock restart

Note that for now the interface with the SOF driver relies on a single
mask for all links. If needed, the interface might be modified at a
later point to provide more freedom. The code at the lower level does
not assume any commonality between links.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/linux/soundwire/sdw_intel.h | 37 +++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 4336bc8e3d83..9976db392faf 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -57,6 +57,40 @@ struct sdw_intel_acpi_info {
 
 struct sdw_intel_link_res;
 
+/* Intel clock-stop/pm_runtime quirk definitions */
+
+/*
+ * Force the clock to remain on during pm_runtime suspend. This might
+ * be needed if Slave devices do not have an alternate clock source or
+ * if the latency requirements are very strict.
+ */
+#define SDW_INTEL_CLK_STOP_NOT_ALLOWED		BIT(0)
+
+/*
+ * Stop the bus during pm_runtime suspend. If set, a complete bus
+ * reset and re-enumeration will be performed when the bus
+ * restarts. This mode shall not be used if Slave devices can generate
+ * in-band wakes.
+ */
+#define SDW_INTEL_CLK_STOP_TEARDOWN		BIT(1)
+
+/*
+ * Stop the bus during pm_suspend if Slaves are not wake capable
+ * (e.g. speaker amplifiers). The clock-stop mode is typically
+ * slightly higher power than when the IP is completely powered-off.
+ */
+#define SDW_INTEL_CLK_STOP_WAKE_CAPABLE_ONLY	BIT(2)
+
+/*
+ * Require a bus reset (and complete re-enumeration) when exiting
+ * clock stop modes. This may be needed if the controller power was
+ * turned off and all context lost. This quirk shall not be used if a
+ * Slave device needs to remain enumerated and keep its context,
+ * e.g. to provide the reasons for the wake, report acoustic events or
+ * pass a history buffer.
+ */
+#define SDW_INTEL_CLK_STOP_BUS_RESET		BIT(3)
+
 /**
  * struct sdw_intel_ctx - context allocated by the controller
  * driver probe
@@ -95,6 +129,8 @@ struct sdw_intel_ctx {
  * @link_mask: bit-wise mask listing links selected by the DSP driver
  * This mask may be a subset of the one reported by the controller since
  * machine-specific quirks are handled in the DSP driver.
+ * @clock_stop_quirks: mask array of possible behaviors requested by the
+ * DSP driver. The quirks are common for all links for now.
  */
 struct sdw_intel_res {
 	int count;
@@ -105,6 +141,7 @@ struct sdw_intel_res {
 	const struct sdw_intel_ops *ops;
 	struct device *dev;
 	u32 link_mask;
+	u32 clock_stop_quirks;
 };
 
 /*
-- 
2.20.1

