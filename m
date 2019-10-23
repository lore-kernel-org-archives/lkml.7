Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA24CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF53F2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405012AbfJWLWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 07:22:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:63104 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404834AbfJWLWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:22:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 04:22:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; 
   d="scan'208";a="223150895"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 23 Oct 2019 04:22:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id B0393631; Wed, 23 Oct 2019 14:21:55 +0300 (EEST)
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
Subject: [PATCH 17/25] thunderbolt: Do not start firmware unless asked by the user
Date:   Wed, 23 Oct 2019 14:21:46 +0300
Message-Id: <20191023112154.64235-18-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191023112154.64235-1-mika.westerberg@linux.intel.com>
References: <20191023112154.64235-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since now we can do pretty much the same thing in the software
connection manager than the firmware would do, there is no point
starting it by default. Instead we can just continue using the software
connection manager.

Make it possible for user to switch between the two by adding a module
pararameter (start_icm) which is by default false. Having this ability
to enable the firmware may be useful at least when debugging possible
issues with the software connection manager implementation.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/icm.c | 23 +++++++++++++++++++----
 drivers/thunderbolt/tb.c  |  4 ----
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 78480b782045..13e88109742e 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -11,6 +11,7 @@
 
 #include <linux/delay.h>
 #include <linux/mutex.h>
+#include <linux/moduleparam.h>
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_data/x86/apple.h>
@@ -43,6 +44,10 @@
 #define ICM_APPROVE_TIMEOUT		10000	/* ms */
 #define ICM_MAX_LINK			4
 
+static bool start_icm;
+module_param(start_icm, bool, 0444);
+MODULE_PARM_DESC(start_icm, "start ICM firmware if it is not running (default: false)");
+
 /**
  * struct icm - Internal connection manager private data
  * @request_lock: Makes sure only one message is send to ICM at time
@@ -350,6 +355,14 @@ static void icm_veto_end(struct tb *tb)
 	}
 }
 
+static bool icm_firmware_running(const struct tb_nhi *nhi)
+{
+	u32 val;
+
+	val = ioread32(nhi->iobase + REG_FW_STS);
+	return !!(val & REG_FW_STS_ICM_EN);
+}
+
 static bool icm_fr_is_supported(struct tb *tb)
 {
 	return !x86_apple_machine;
@@ -1381,9 +1394,12 @@ static bool icm_ar_is_supported(struct tb *tb)
 	/*
 	 * Starting from Alpine Ridge we can use ICM on Apple machines
 	 * as well. We just need to reset and re-enable it first.
+	 * However, only start it if explicitly asked by the user.
 	 */
-	if (!x86_apple_machine)
+	if (icm_firmware_running(tb->nhi))
 		return true;
+	if (!start_icm)
+		return false;
 
 	/*
 	 * Find the upstream PCIe port in case we need to do reset
@@ -1736,8 +1752,7 @@ static int icm_firmware_start(struct tb *tb, struct tb_nhi *nhi)
 	u32 val;
 
 	/* Check if the ICM firmware is already running */
-	val = ioread32(nhi->iobase + REG_FW_STS);
-	if (val & REG_FW_STS_ICM_EN)
+	if (icm_firmware_running(nhi))
 		return 0;
 
 	dev_dbg(&nhi->pdev->dev, "starting ICM firmware\n");
@@ -2244,7 +2259,7 @@ struct tb *icm_probe(struct tb_nhi *nhi)
 
 	case PCI_DEVICE_ID_INTEL_ICL_NHI0:
 	case PCI_DEVICE_ID_INTEL_ICL_NHI1:
-		icm->is_supported = icm_ar_is_supported;
+		icm->is_supported = icm_fr_is_supported;
 		icm->driver_ready = icm_icl_driver_ready;
 		icm->set_uuid = icm_icl_set_uuid;
 		icm->device_connected = icm_icl_device_connected;
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index bb763a5cf103..ea8727f769d6 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -9,7 +9,6 @@
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
-#include <linux/platform_data/x86/apple.h>
 
 #include "tb.h"
 #include "tb_regs.h"
@@ -990,9 +989,6 @@ struct tb *tb_probe(struct tb_nhi *nhi)
 	struct tb_cm *tcm;
 	struct tb *tb;
 
-	if (!x86_apple_machine)
-		return NULL;
-
 	tb = tb_domain_alloc(nhi, sizeof(*tcm));
 	if (!tb)
 		return NULL;
-- 
2.23.0

