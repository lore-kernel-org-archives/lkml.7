Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE8AC388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD9B21A4C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733291AbfJALj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:39:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:27909 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732568AbfJALik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:38:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 04:38:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="181663251"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 01 Oct 2019 04:38:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 3C8B0440; Tue,  1 Oct 2019 14:38:31 +0300 (EEST)
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
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 08/22] thunderbolt: Add downstream PCIe port mappings for Alpine and Titan Ridge
Date:   Tue,  1 Oct 2019 14:38:16 +0300
Message-Id: <20191001113830.13028-9-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
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
 drivers/thunderbolt/tb.c |  4 +++-
 drivers/thunderbolt/tb.h | 25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index dbbe9afb9fb7..704455a4f763 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -344,10 +344,12 @@ static struct tb_port *tb_find_pcie_down(struct tb_switch *sw,
 		 * Hard-coded Thunderbolt port to PCIe down port mapping
 		 * per controller.
 		 */
-		if (tb_switch_is_cr(sw))
+		if (tb_switch_is_cr(sw) || tb_switch_is_ar(sw))
 			index = !phy_port ? 6 : 7;
 		else if (tb_switch_is_fr(sw))
 			index = !phy_port ? 6 : 8;
+		else if (tb_switch_is_tr(sw))
+			index = !phy_port ? 8 : 9;
 		else
 			goto out;
 
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index e641dcebd50a..dbab06551eaa 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -632,6 +632,31 @@ static inline bool tb_switch_is_fr(const struct tb_switch *sw)
 	}
 }
 
+static inline bool tb_switch_is_ar(const struct tb_switch *sw)
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
+static inline bool tb_switch_is_tr(const struct tb_switch *sw)
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

