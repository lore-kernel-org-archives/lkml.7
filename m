Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34872CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9262064A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404812AbfJWLWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 07:22:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:46941 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404628AbfJWLWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:22:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 04:21:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; 
   d="scan'208";a="209903772"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Oct 2019 04:21:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1ECA537B; Wed, 23 Oct 2019 14:21:55 +0300 (EEST)
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
Subject: [PATCH 03/25] thunderbolt: Log error if adding switch fails
Date:   Wed, 23 Oct 2019 14:21:32 +0300
Message-Id: <20191023112154.64235-4-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191023112154.64235-1-mika.westerberg@linux.intel.com>
References: <20191023112154.64235-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we fail to add a switch for some reason log an error instead of
keeping silent. This is useful for debugging.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/switch.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index f9efd670d032..fd7878020f70 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1775,21 +1775,25 @@ int tb_switch_add(struct tb_switch *sw)
 	 * configuration based mailbox.
 	 */
 	ret = tb_switch_add_dma_port(sw);
-	if (ret)
+	if (ret) {
+		dev_err(&sw->dev, "failed to add DMA port\n");
 		return ret;
+	}
 
 	if (!sw->safe_mode) {
 		/* read drom */
 		ret = tb_drom_read(sw);
 		if (ret) {
-			tb_sw_warn(sw, "tb_eeprom_read_rom failed\n");
+			dev_err(&sw->dev, "reading DROM failed\n");
 			return ret;
 		}
 		tb_sw_dbg(sw, "uid: %#llx\n", sw->uid);
 
 		ret = tb_switch_set_uuid(sw);
-		if (ret)
+		if (ret) {
+			dev_err(&sw->dev, "failed to set UUID\n");
 			return ret;
+		}
 
 		for (i = 0; i <= sw->config.max_port_number; i++) {
 			if (sw->ports[i].disabled) {
@@ -1797,14 +1801,18 @@ int tb_switch_add(struct tb_switch *sw)
 				continue;
 			}
 			ret = tb_init_port(&sw->ports[i]);
-			if (ret)
+			if (ret) {
+				dev_err(&sw->dev, "failed to initialize port %d\n", i);
 				return ret;
+			}
 		}
 	}
 
 	ret = device_add(&sw->dev);
-	if (ret)
+	if (ret) {
+		dev_err(&sw->dev, "failed to add device: %d\n", ret);
 		return ret;
+	}
 
 	if (tb_route(sw)) {
 		dev_info(&sw->dev, "new device found, vendor=%#x device=%#x\n",
@@ -1816,6 +1824,7 @@ int tb_switch_add(struct tb_switch *sw)
 
 	ret = tb_switch_nvm_add(sw);
 	if (ret) {
+		dev_err(&sw->dev, "failed to add NVM devices\n");
 		device_del(&sw->dev);
 		return ret;
 	}
-- 
2.23.0

