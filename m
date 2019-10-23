Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFBBCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5E82064A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404858AbfJWLWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 07:22:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:29695 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404734AbfJWLWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:22:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 04:22:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; 
   d="scan'208";a="399359456"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 23 Oct 2019 04:22:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 781865F6; Wed, 23 Oct 2019 14:21:55 +0300 (EEST)
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
Subject: [PATCH 12/25] thunderbolt: Expand controller name in tb_switch_is_xy()
Date:   Wed, 23 Oct 2019 14:21:41 +0300
Message-Id: <20191023112154.64235-13-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191023112154.64235-1-mika.westerberg@linux.intel.com>
References: <20191023112154.64235-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a casual reader tb_switch_is_cr() does not tell much so instead
spell out the full controller name in the function name. For example
tb_switch_is_cr() becomes tb_switch_is_cactus_ridge() which is easier
to understand.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/cap.c | 6 +++---
 drivers/thunderbolt/tb.c  | 4 ++--
 drivers/thunderbolt/tb.h  | 8 ++++----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/thunderbolt/cap.c b/drivers/thunderbolt/cap.c
index 8bf8e031f0bc..fdd77bb4628d 100644
--- a/drivers/thunderbolt/cap.c
+++ b/drivers/thunderbolt/cap.c
@@ -33,9 +33,9 @@ static int tb_port_enable_tmu(struct tb_port *port, bool enable)
 	 * Legacy devices need to have TMU access enabled before port
 	 * space can be fully accessed.
 	 */
-	if (tb_switch_is_lr(sw))
+	if (tb_switch_is_light_ridge(sw))
 		offset = 0x26;
-	else if (tb_switch_is_er(sw))
+	else if (tb_switch_is_eagle_ridge(sw))
 		offset = 0x2a;
 	else
 		return 0;
@@ -60,7 +60,7 @@ static void tb_port_dummy_read(struct tb_port *port)
 	 * reading stale data on next read perform one dummy read after
 	 * port capabilities are walked.
 	 */
-	if (tb_switch_is_lr(port->sw)) {
+	if (tb_switch_is_light_ridge(port->sw)) {
 		u32 dummy;
 
 		tb_port_read(port, &dummy, TB_CFG_PORT, 0, 1);
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index f2ce6adc1f48..e8e2d20cf4c6 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -342,9 +342,9 @@ static struct tb_port *tb_find_pcie_down(struct tb_switch *sw,
 		 * Hard-coded Thunderbolt port to PCIe down port mapping
 		 * per controller.
 		 */
-		if (tb_switch_is_cr(sw))
+		if (tb_switch_is_cactus_ridge(sw))
 			index = !phy_port ? 6 : 7;
-		else if (tb_switch_is_fr(sw))
+		else if (tb_switch_is_falcon_ridge(sw))
 			index = !phy_port ? 6 : 8;
 		else
 			goto out;
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 16d529983004..a6f1fa0d4771 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -576,17 +576,17 @@ static inline struct tb_switch *tb_switch_parent(struct tb_switch *sw)
 	return tb_to_switch(sw->dev.parent);
 }
 
-static inline bool tb_switch_is_lr(const struct tb_switch *sw)
+static inline bool tb_switch_is_light_ridge(const struct tb_switch *sw)
 {
 	return sw->config.device_id == PCI_DEVICE_ID_INTEL_LIGHT_RIDGE;
 }
 
-static inline bool tb_switch_is_er(const struct tb_switch *sw)
+static inline bool tb_switch_is_eagle_ridge(const struct tb_switch *sw)
 {
 	return sw->config.device_id == PCI_DEVICE_ID_INTEL_EAGLE_RIDGE;
 }
 
-static inline bool tb_switch_is_cr(const struct tb_switch *sw)
+static inline bool tb_switch_is_cactus_ridge(const struct tb_switch *sw)
 {
 	switch (sw->config.device_id) {
 	case PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_2C:
@@ -597,7 +597,7 @@ static inline bool tb_switch_is_cr(const struct tb_switch *sw)
 	}
 }
 
-static inline bool tb_switch_is_fr(const struct tb_switch *sw)
+static inline bool tb_switch_is_falcon_ridge(const struct tb_switch *sw)
 {
 	switch (sw->config.device_id) {
 	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_BRIDGE:
-- 
2.23.0

