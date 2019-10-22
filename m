Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E90DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 23:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC3C20700
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 23:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389834AbfJVXs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 19:48:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:55767 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389812AbfJVXsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 19:48:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 16:48:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,218,1569308400"; 
   d="scan'208";a="399211311"
Received: from srajamoh-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.20.203])
  by fmsmga006.fm.intel.com with ESMTP; 22 Oct 2019 16:48:48 -0700
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
Subject: [PATCH 3/3] soundwire: ignore uniqueID when irrelevant
Date:   Tue, 22 Oct 2019 18:48:08 -0500
Message-Id: <20191022234808.17432-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022234808.17432-1-pierre-louis.bossart@linux.intel.com>
References: <20191022234808.17432-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uniqueID is useful when there are two or more devices of the same
type (identical manufacturer ID, part ID) on the same link.

When there is a single device of a given type on a link, its uniqueID
is irrelevant. It's not uncommon on actual platforms to see variations
of the uniqueID, or differences between devID registers and ACPI _ADR
fields.

This patch suggests a filter on startup to identify 'single' devices
and tag them accordingly. The uniqueID is then not used for the probe,
and the device name omits the uniqueID as well.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c   |  7 +++---
 drivers/soundwire/slave.c | 52 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index fc53dbe57f85..be5d437058ed 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -422,10 +422,11 @@ static struct sdw_slave *sdw_get_slave(struct sdw_bus *bus, int i)
 
 static int sdw_compare_devid(struct sdw_slave *slave, struct sdw_slave_id id)
 {
-	if (slave->id.unique_id != id.unique_id ||
-	    slave->id.mfg_id != id.mfg_id ||
+	if (slave->id.mfg_id != id.mfg_id ||
 	    slave->id.part_id != id.part_id ||
-	    slave->id.class_id != id.class_id)
+	    slave->id.class_id != id.class_id ||
+	    (slave->id.unique_id != SDW_IGNORED_UNIQUE_ID &&
+	     slave->id.unique_id != id.unique_id))
 		return -ENODEV;
 
 	return 0;
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index 5dbc76772d21..19919975bb6d 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -29,10 +29,17 @@ static int sdw_slave_add(struct sdw_bus *bus,
 	slave->dev.parent = bus->dev;
 	slave->dev.fwnode = fwnode;
 
-	/* name shall be sdw:link:mfg:part:class:unique */
-	dev_set_name(&slave->dev, "sdw:%x:%x:%x:%x:%x",
-		     bus->link_id, id->mfg_id, id->part_id,
-		     id->class_id, id->unique_id);
+	if (id->unique_id == SDW_IGNORED_UNIQUE_ID) {
+		/* name shall be sdw:link:mfg:part:class */
+		dev_set_name(&slave->dev, "sdw:%x:%x:%x:%x",
+			     bus->link_id, id->mfg_id, id->part_id,
+			     id->class_id);
+	} else {
+		/* name shall be sdw:link:mfg:part:class:unique */
+		dev_set_name(&slave->dev, "sdw:%x:%x:%x:%x:%x",
+			     bus->link_id, id->mfg_id, id->part_id,
+			     id->class_id, id->unique_id);
+	}
 
 	slave->dev.release = sdw_slave_release;
 	slave->dev.bus = &sdw_bus_type;
@@ -103,6 +110,7 @@ static bool find_slave(struct sdw_bus *bus,
 int sdw_acpi_find_slaves(struct sdw_bus *bus)
 {
 	struct acpi_device *adev, *parent;
+	struct acpi_device *adev2, *parent2;
 
 	parent = ACPI_COMPANION(bus->dev);
 	if (!parent) {
@@ -112,10 +120,46 @@ int sdw_acpi_find_slaves(struct sdw_bus *bus)
 
 	list_for_each_entry(adev, &parent->children, node) {
 		struct sdw_slave_id id;
+		struct sdw_slave_id id2;
+		bool ignore_unique_id = true;
 
 		if (!find_slave(bus, adev, &id))
 			continue;
 
+		/* brute-force O(N^2) search for duplicates */
+		parent2 = parent;
+		list_for_each_entry(adev2, &parent2->children, node) {
+
+			if (adev == adev2)
+				continue;
+
+			if (!find_slave(bus, adev2, &id2))
+				continue;
+
+			if (id.sdw_version != id2.sdw_version ||
+			    id.mfg_id != id2.mfg_id ||
+			    id.part_id != id2.part_id ||
+			    id.class_id != id2.class_id)
+				continue;
+
+			if (id.unique_id != id2.unique_id) {
+				dev_dbg(bus->dev,
+					"Valid unique IDs %x %x for Slave mfg %x part %d\n",
+					id.unique_id, id2.unique_id,
+					id.mfg_id, id.part_id);
+				ignore_unique_id = false;
+			} else {
+				dev_err(bus->dev,
+					"Invalid unique IDs %x %x for Slave mfg %x part %d\n",
+					id.unique_id, id2.unique_id,
+					id.mfg_id, id.part_id);
+				return -ENODEV;
+			}
+		}
+
+		if (ignore_unique_id)
+			id.unique_id = SDW_IGNORED_UNIQUE_ID;
+
 		/*
 		 * don't error check for sdw_slave_add as we want to continue
 		 * adding Slaves
-- 
2.20.1

