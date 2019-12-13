Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DD2C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 05:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E6322527
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 05:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732038AbfLMFEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 00:04:36 -0500
Received: from mga04.intel.com ([192.55.52.120]:58713 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731993AbfLMFE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 00:04:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 21:04:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,308,1571727600"; 
   d="scan'208";a="208340729"
Received: from vbagrodi-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.130.70])
  by orsmga008.jf.intel.com with ESMTP; 12 Dec 2019 21:04:26 -0800
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
Subject: [PATCH v4 07/15] soundwire: slave: move uevent handling to slave
Date:   Thu, 12 Dec 2019 23:04:01 -0600
Message-Id: <20191213050409.12776-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213050409.12776-1-pierre-louis.bossart@linux.intel.com>
References: <20191213050409.12776-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the code deals with uevents at the bus level, but we only care
for Slave events

Suggested-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.h      | 2 ++
 drivers/soundwire/bus_type.c | 3 +--
 drivers/soundwire/slave.c    | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index cb482da914da..be01a5f3d00b 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -6,6 +6,8 @@
 
 #define DEFAULT_BANK_SWITCH_TIMEOUT 3000
 
+int sdw_uevent(struct device *dev, struct kobj_uevent_env *env);
+
 #if IS_ENABLED(CONFIG_ACPI)
 int sdw_acpi_find_slaves(struct sdw_bus *bus);
 #else
diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index bbdedce5eb26..5c18c21545b5 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -47,7 +47,7 @@ int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size)
 			slave->id.mfg_id, slave->id.part_id);
 }
 
-static int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
+int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	struct sdw_slave *slave;
 	char modalias[32];
@@ -71,7 +71,6 @@ static int sdw_uevent(struct device *dev, struct kobj_uevent_env *env)
 struct bus_type sdw_bus_type = {
 	.name = "soundwire",
 	.match = sdw_bus_match,
-	.uevent = sdw_uevent,
 };
 EXPORT_SYMBOL_GPL(sdw_bus_type);
 
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index c87267f12a3b..014c3ece1f17 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -17,6 +17,7 @@ static void sdw_slave_release(struct device *dev)
 struct device_type sdw_slave_type = {
 	.name =		"sdw_slave",
 	.release =	sdw_slave_release,
+	.uevent = sdw_uevent,
 };
 
 static int sdw_slave_add(struct sdw_bus *bus,
-- 
2.20.1

