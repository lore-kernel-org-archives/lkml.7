Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CA5C0650F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 00:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52E4216B7
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 00:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731468AbfHFAzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 20:55:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:35801 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731384AbfHFAzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 20:55:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 17:55:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="198153229"
Received: from sahluwal-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.252.202.215])
  by fmsmga004.fm.intel.com with ESMTP; 05 Aug 2019 17:55:49 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, Blauciak@vger.kernel.org,
        Slawomir <slawomir.blauciak@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 14/17] soundwire: intel: handle disabled links
Date:   Mon,  5 Aug 2019 19:55:19 -0500
Message-Id: <20190806005522.22642-15-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
References: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On most hardware platforms, SoundWire interfaces are pin-muxed with
other interfaces (typically DMIC or I2S) and the status of each link
needs to be checked at boot time.

For Intel platforms, the BIOS provides a menu to enable/disable the
links separately, and the information is provided to the OS with an
Intel-specific _DSD property. The same capability will be added to
revisions of the MIPI DisCo specification.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c     | 26 ++++++++++++++++++++++----
 include/linux/soundwire/sdw.h |  2 ++
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 3f876642cb7f..e702187c0609 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -90,6 +90,8 @@
 #define SDW_ALH_STRMZCFG_DMAT		GENMASK(7, 0)
 #define SDW_ALH_STRMZCFG_CHN		GENMASK(19, 16)
 
+#define SDW_INTEL_QUIRK_MASK_BUS_DISABLE	BIT(1)
+
 enum intel_pdi_type {
 	INTEL_PDI_IN = 0,
 	INTEL_PDI_OUT = 1,
@@ -914,7 +916,7 @@ static int sdw_master_read_intel_prop(struct sdw_bus *bus)
 	struct sdw_master_prop *prop = &bus->prop;
 	struct fwnode_handle *link;
 	char name[32];
-	int nval, i;
+	u32 quirk_mask;
 
 	/* Find master handle */
 	snprintf(name, sizeof(name),
@@ -929,6 +931,14 @@ static int sdw_master_read_intel_prop(struct sdw_bus *bus)
 	fwnode_property_read_u32(link,
 				 "intel-sdw-ip-clock",
 				 &prop->mclk_freq);
+
+	fwnode_property_read_u32(link,
+				 "intel-quirk-mask",
+				 &quirk_mask);
+
+	if (quirk_mask & SDW_INTEL_QUIRK_MASK_BUS_DISABLE)
+		prop->hw_disabled = true;
+
 	return 0;
 }
 
@@ -989,6 +999,12 @@ static int intel_probe(struct platform_device *pdev)
 		goto err_master_reg;
 	}
 
+	if (sdw->cdns.bus.prop.hw_disabled) {
+		dev_info(&pdev->dev, "SoundWire master %d is disabled, ignoring\n",
+			 sdw->cdns.bus.link_id);
+		return 0;
+	}
+
 	/* Initialize shim and controller */
 	intel_link_power_up(sdw);
 	intel_shim_init(sdw);
@@ -1042,9 +1058,11 @@ static int intel_remove(struct platform_device *pdev)
 
 	sdw = platform_get_drvdata(pdev);
 
-	intel_debugfs_exit(sdw);
-	free_irq(sdw->res->irq, sdw);
-	snd_soc_unregister_component(sdw->cdns.dev);
+	if (!sdw->cdns.bus.prop.hw_disabled) {
+		intel_debugfs_exit(sdw);
+		free_irq(sdw->res->irq, sdw);
+		snd_soc_unregister_component(sdw->cdns.dev);
+	}
 	sdw_delete_bus_master(&sdw->cdns.bus);
 
 	return 0;
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index b6acc436ac80..a3c7448d5817 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -380,6 +380,7 @@ struct sdw_slave_prop {
  * @err_threshold: Number of times that software may retry sending a single
  * command
  * @mclk_freq: clock reference passed to SoundWire Master, in Hz.
+ * @hw_disabled: if true, the Master is not functional, typically due to pin-mux
  */
 struct sdw_master_prop {
 	u32 revision;
@@ -395,6 +396,7 @@ struct sdw_master_prop {
 	bool dynamic_frame;
 	u32 err_threshold;
 	u32 mclk_freq;
+	bool hw_disabled;
 };
 
 int sdw_master_read_prop(struct sdw_bus *bus);
-- 
2.20.1

