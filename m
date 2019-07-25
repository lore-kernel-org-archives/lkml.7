Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55D4C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85AA229F9
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfGYXlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 19:41:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:51850 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727512AbfGYXlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 19:41:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 16:41:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,308,1559545200"; 
   d="scan'208";a="369874812"
Received: from amrutaku-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.255.230.75])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jul 2019 16:41:44 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [RFC PATCH 29/40] soundwire: intel_init: add kernel module parameter to filter out links
Date:   Thu, 25 Jul 2019 18:40:21 -0500
Message-Id: <20190725234032.21152-30-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware and ACPI info may report the presence of links that are
not physically enabled (e.g. due to pin-muxing or hardware reworks),
which in turn can result in errors being thrown. This shouldn't be the
case for production devices but will happen a lot on development
devices - even more so when they expose a connector.

Add a module parameter to filter out such links, e.g. adding the
following config to a file in /etc/modprobe.d will select the second
and third links only.

options soundwire_intel_init sdw_link_mask=0x6

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel_init.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 70637a0383d2..6ae8bb13f907 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -22,6 +22,10 @@
 #define SDW_LINK_BASE		0x30000
 #define SDW_LINK_SIZE		0x10000
 
+static int link_mask;
+module_param_named(sdw_link_mask, link_mask, int, 0444);
+MODULE_PARM_DESC(sdw_link_mask, "Intel link mask (one bit per link)");
+
 struct sdw_link_data {
 	struct sdw_intel_link_res res;
 	struct platform_device *pdev;
@@ -83,6 +87,9 @@ static struct sdw_intel_ctx
 	caps = ioread32(res->mmio_base + SDW_SHIM_BASE + SDW_SHIM_LCAP);
 	caps &= GENMASK(2, 0);
 
+	dev_dbg(&adev->dev, "SoundWire links: BIOS count %d hardware caps %d\n",
+		count, caps);
+
 	/* Check HW supported vs property value and use min of two */
 	count = min_t(u8, caps, count);
 
@@ -111,6 +118,13 @@ static struct sdw_intel_ctx
 
 	/* Create SDW Master devices */
 	for (i = 0; i < count; i++) {
+		if (link_mask && !(link_mask & BIT(i))) {
+			dev_dbg(&adev->dev,
+				"Link %d masked, will not be enabled\n", i);
+			link++;
+			continue;
+		}
+
 		link->res.irq = res->irq;
 		link->res.registers = res->mmio_base + SDW_LINK_BASE
 					+ (SDW_LINK_SIZE * i);
-- 
2.20.1

