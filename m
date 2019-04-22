Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1FFC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 06:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECCA20857
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 06:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfDVG7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 02:59:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:2555 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfDVG7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 02:59:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Apr 2019 23:59:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,380,1549958400"; 
   d="scan'208";a="225548196"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by orsmga001.jf.intel.com with ESMTP; 21 Apr 2019 23:59:49 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 1/2] mei: hdcp: use own Kconfig file
Date:   Mon, 22 Apr 2019 09:51:06 +0300
Message-Id: <20190422065107.32050-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mei/hdcp module have its own Makefile
so naturally it should have associated Kconfig
in the same directory.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/Kconfig      | 10 +---------
 drivers/misc/mei/hdcp/Kconfig | 13 +++++++++++++
 2 files changed, 14 insertions(+), 9 deletions(-)
 create mode 100644 drivers/misc/mei/hdcp/Kconfig

diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig
index 132b07151f42..9d7b3719bfa0 100644
--- a/drivers/misc/mei/Kconfig
+++ b/drivers/misc/mei/Kconfig
@@ -46,12 +46,4 @@ config INTEL_MEI_TXE
 	  Supported SoCs:
 	  Intel Bay Trail
 
-config INTEL_MEI_HDCP
-	tristate "Intel HDCP2.2 services of ME Interface"
-	select INTEL_MEI_ME
-	depends on DRM_I915
-	help
-	  MEI Support for HDCP2.2 Services on Intel platforms.
-
-	  Enables the ME FW services required for HDCP2.2 support through
-	  I915 display driver of Intel.
+source "drivers/misc/mei/hdcp/Kconfig"
diff --git a/drivers/misc/mei/hdcp/Kconfig b/drivers/misc/mei/hdcp/Kconfig
new file mode 100644
index 000000000000..95b2d6d37f10
--- /dev/null
+++ b/drivers/misc/mei/hdcp/Kconfig
@@ -0,0 +1,13 @@
+
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019, Intel Corporation. All rights reserved.
+#
+config INTEL_MEI_HDCP
+	tristate "Intel HDCP2.2 services of ME Interface"
+	select INTEL_MEI_ME
+	depends on DRM_I915
+	help
+	  MEI Support for HDCP2.2 Services on Intel platforms.
+
+	  Enables the ME FW services required for HDCP2.2 support through
+	  I915 display driver of Intel.
-- 
2.20.1

