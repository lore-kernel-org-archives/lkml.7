Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58C7CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 23:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1DD620700
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 23:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389824AbfJVXsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 19:48:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:55767 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732393AbfJVXss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 19:48:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 16:48:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,218,1569308400"; 
   d="scan'208";a="399211306"
Received: from srajamoh-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.20.203])
  by fmsmga006.fm.intel.com with ESMTP; 22 Oct 2019 16:48:46 -0700
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
Subject: [PATCH 2/3] soundwire: slave: add helper to extract slave ID
Date:   Tue, 22 Oct 2019 18:48:07 -0500
Message-Id: <20191022234808.17432-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022234808.17432-1-pierre-louis.bossart@linux.intel.com>
References: <20191022234808.17432-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the loop with a helper. The only functionality change is that
we continue the loop even with an ACPI error.

Follow-up patches will build on this change.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/slave.c | 50 ++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index 6473fa602f82..5dbc76772d21 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -64,6 +64,36 @@ static int sdw_slave_add(struct sdw_bus *bus,
 }
 
 #if IS_ENABLED(CONFIG_ACPI)
+
+static bool find_slave(struct sdw_bus *bus,
+		       struct acpi_device *adev,
+		       struct sdw_slave_id *id)
+{
+	unsigned long long addr;
+	unsigned int link_id;
+	acpi_status status;
+
+	status = acpi_evaluate_integer(adev->handle,
+				       METHOD_NAME__ADR, NULL, &addr);
+
+	if (ACPI_FAILURE(status)) {
+		dev_err(bus->dev, "_ADR resolution failed: %x\n",
+			status);
+		return false;
+	}
+
+	/* Extract link id from ADR, Bit 51 to 48 (included) */
+	link_id = (addr >> 48) & GENMASK(3, 0);
+
+	/* Check for link_id match */
+	if (link_id != bus->link_id)
+		return false;
+
+	sdw_extract_slave_id(bus, addr, id);
+
+	return true;
+}
+
 /*
  * sdw_acpi_find_slaves() - Find Slave devices in Master ACPI node
  * @bus: SDW bus instance
@@ -81,29 +111,11 @@ int sdw_acpi_find_slaves(struct sdw_bus *bus)
 	}
 
 	list_for_each_entry(adev, &parent->children, node) {
-		unsigned long long addr;
 		struct sdw_slave_id id;
-		unsigned int link_id;
-		acpi_status status;
-
-		status = acpi_evaluate_integer(adev->handle,
-					       METHOD_NAME__ADR, NULL, &addr);
-
-		if (ACPI_FAILURE(status)) {
-			dev_err(bus->dev, "_ADR resolution failed: %x\n",
-				status);
-			return status;
-		}
 
-		/* Extract link id from ADR, Bit 51 to 48 (included) */
-		link_id = (addr >> 48) & GENMASK(3, 0);
-
-		/* Check for link_id match */
-		if (link_id != bus->link_id)
+		if (!find_slave(bus, adev, &id))
 			continue;
 
-		sdw_extract_slave_id(bus, addr, &id);
-
 		/*
 		 * don't error check for sdw_slave_add as we want to continue
 		 * adding Slaves
-- 
2.20.1

