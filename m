Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69692C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7F921906
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732949AbfJALjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:39:06 -0400
Received: from mga12.intel.com ([192.55.52.136]:17385 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732685AbfJALin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:38:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 04:38:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="220968935"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 01 Oct 2019 04:38:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id D4A8577A; Tue,  1 Oct 2019 14:38:31 +0300 (EEST)
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
Subject: [RFC PATCH 22/22] thunderbolt: Do not start firmware unless asked by the user
Date:   Tue,  1 Oct 2019 14:38:30 +0300
Message-Id: <20191001113830.13028-23-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
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
 drivers/thunderbolt/icm.c | 14 +++++++++++---
 drivers/thunderbolt/tb.c  |  4 ----
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 9c9c6ea2b790..c4a2de0f2a44 100644
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
@@ -1353,13 +1358,16 @@ static bool icm_ar_is_supported(struct tb *tb)
 {
 	struct pci_dev *upstream_port;
 	struct icm *icm = tb_priv(tb);
+	u32 val;
 
 	/*
 	 * Starting from Alpine Ridge we can use ICM on Apple machines
 	 * as well. We just need to reset and re-enable it first.
+	 * However, only start it if explicitly asked by the user.
 	 */
-	if (!x86_apple_machine)
-		return true;
+	val = ioread32(tb->nhi->iobase + REG_FW_STS);
+	if (!(val & REG_FW_STS_ICM_EN) && !start_icm)
+		return false;
 
 	/*
 	 * Find the upstream PCIe port in case we need to do reset
@@ -2224,7 +2232,7 @@ struct tb *icm_probe(struct tb_nhi *nhi)
 
 	case PCI_DEVICE_ID_INTEL_ICL_NHI0:
 	case PCI_DEVICE_ID_INTEL_ICL_NHI1:
-		icm->is_supported = icm_ar_is_supported;
+		icm->is_supported = icm_fr_is_supported;
 		icm->driver_ready = icm_icl_driver_ready;
 		icm->set_uuid = icm_icl_set_uuid;
 		icm->device_connected = icm_icl_device_connected;
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 6c468ba96e9a..aebf2c10aa85 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -9,7 +9,6 @@
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
-#include <linux/platform_data/x86/apple.h>
 
 #include "tb.h"
 #include "tb_regs.h"
@@ -1117,9 +1116,6 @@ struct tb *tb_probe(struct tb_nhi *nhi)
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

