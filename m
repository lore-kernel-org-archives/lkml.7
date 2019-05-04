Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55D6C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 01:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD222081C
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 01:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfEDBAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 21:00:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:20914 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbfEDBAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 21:00:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 18:00:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,427,1549958400"; 
   d="scan'208";a="148114217"
Received: from jlwhitty-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.28.45])
  by fmsmga007.fm.intel.com with ESMTP; 03 May 2019 18:00:49 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [RFC PATCH 3/7] ABI: testing: Add description of soundwire master sysfs files
Date:   Fri,  3 May 2019 20:00:26 -0500
Message-Id: <20190504010030.29233-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The description is directly derived from the MIPI DisCo specification.

Credits: this patch is based on an earlier internal contribution by
Vinod Koul, Sanyog Kale, Shreyas Nc and Hardik Shah.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 .../ABI/testing/sysfs-bus-soundwire-master    | 21 +++++++++++++++++++
 drivers/soundwire/sysfs.c                     |  1 +
 2 files changed, 22 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-soundwire-master

diff --git a/Documentation/ABI/testing/sysfs-bus-soundwire-master b/Documentation/ABI/testing/sysfs-bus-soundwire-master
new file mode 100644
index 000000000000..69cadf31049d
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-soundwire-master
@@ -0,0 +1,21 @@
+What:		/sys/bus/soundwire/devices/sdw-master-N/revision
+		/sys/bus/soundwire/devices/sdw-master-N/clk_stop_modes
+		/sys/bus/soundwire/devices/sdw-master-N/clk_freq
+		/sys/bus/soundwire/devices/sdw-master-N/clk_gears
+		/sys/bus/soundwire/devices/sdw-master-N/default_col
+		/sys/bus/soundwire/devices/sdw-master-N/default_frame_rate
+		/sys/bus/soundwire/devices/sdw-master-N/default_row
+		/sys/bus/soundwire/devices/sdw-master-N/dynamic_shape
+		/sys/bus/soundwire/devices/sdw-master-N/err_threshold
+		/sys/bus/soundwire/devices/sdw-master-N/max_clk_freq
+
+Date:		May 2019
+
+Contact:	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
+
+Description:	SoundWire Master-N DisCo properties.
+		These properties are defined by MIPI DisCo Specification
+		for SoundWire. They define various properties of the Master
+		and are used by the bus to configure the Master. clk_stop_modes
+		is a bitmask for simplifications and combines the
+		clock-stop-mode0 and clock-stop-mode1 properties.
diff --git a/drivers/soundwire/sysfs.c b/drivers/soundwire/sysfs.c
index 734e2c8bc5cd..c2e5b7ad42fb 100644
--- a/drivers/soundwire/sysfs.c
+++ b/drivers/soundwire/sysfs.c
@@ -31,6 +31,7 @@ struct sdw_master_sysfs {
  *      |---- clk_gears
  *      |---- default_row
  *      |---- default_col
+ *      |---- default_frame_shape
  *      |---- dynamic_shape
  *      |---- err_threshold
  */
-- 
2.17.1

