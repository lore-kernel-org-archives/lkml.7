Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC97DCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78A02064A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404868AbfJWLWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 07:22:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:54237 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404834AbfJWLWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:22:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 04:22:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; 
   d="scan'208";a="196748271"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 23 Oct 2019 04:22:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 8312F62B; Wed, 23 Oct 2019 14:21:55 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-usb@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Oliver Neukum <oneukum@suse.com>,
        Christian Kellner <ckellner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/25] thunderbolt: Add downstream PCIe port mappings for Alpine and Titan Ridge
Date:   Wed, 23 Oct 2019 14:21:42 +0300
Message-Id: <20191023112154.64235-14-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191023112154.64235-1-mika.westerberg@linux.intel.com>
References: <20191023112154.64235-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to keep PCIe hierarchies consistent across hotplugs, add
hard-coded PCIe downstream port to Thunderbolt port for Alpine Ridge and
Titan Ridge as well.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/tb.c |  5 ++++-
 drivers/thunderbolt/tb.h | 25 +++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index e8e2d20cf4c6..c24b577e049e 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -342,10 +342,13 @@ static struct tb_port *tb_find_pcie_down(struct tb_switch *sw,
 		 * Hard-coded Thunderbolt port to PCIe down port mapping
 		 * per controller.
 		 */
-		if (tb_switch_is_cactus_ridge(sw))
+		if (tb_switch_is_cactus_ridge(sw) ||
+		    tb_switch_is_alpine_ridge(sw))
 			index = !phy_port ? 6 : 7;
 		else if (tb_switch_is_falcon_ridge(sw))
 			index = !phy_port ? 6 : 8;
+		else if (tb_switch_is_titan_ridge(sw))
+			index = !phy_port ? 8 : 9;
 		else
 			goto out;
 
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index a6f1fa0d4771..3d7b2202d248 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -608,6 +608,31 @@ static inline bool tb_switch_is_falcon_ridge(const struct tb_switch *sw)
 	}
 }
 
+static inline bool tb_switch_is_alpine_ridge(const struct tb_switch *sw)
+{
+	switch (sw->config.device_id) {
+	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_BRIDGE:
+	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_LP_BRIDGE:
+	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_4C_BRIDGE:
+	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_2C_BRIDGE:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static inline bool tb_switch_is_titan_ridge(const struct tb_switch *sw)
+{
+	switch (sw->config.device_id) {
+	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_BRIDGE:
+	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_BRIDGE:
+	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_BRIDGE:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /**
  * tb_switch_is_icm() - Is the switch handled by ICM firmware
  * @sw: Switch to check
-- 
2.23.0

