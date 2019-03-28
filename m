Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C06CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC102173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfC1Mgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:36:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:9515 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727134AbfC1Mgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:36:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 05:36:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="286671440"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 28 Mar 2019 05:36:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 67DA08E9; Thu, 28 Mar 2019 14:36:34 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        Mario.Limonciello@dell.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        netdev@vger.kernel.org
Subject: [PATCH v3 14/36] thunderbolt: Rename tunnel_pci to tunnel
Date:   Thu, 28 Mar 2019 15:36:11 +0300
Message-Id: <20190328123633.42882-15-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
References: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to tunnel non-PCIe traffic as well rename tunnel_pci.[ch] to
tunnel.[ch] to reflect this fact. No functional changes.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/Makefile                   | 2 +-
 drivers/thunderbolt/tb.c                       | 2 +-
 drivers/thunderbolt/{tunnel_pci.c => tunnel.c} | 4 ++--
 drivers/thunderbolt/{tunnel_pci.h => tunnel.h} | 6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)
 rename drivers/thunderbolt/{tunnel_pci.c => tunnel.c} (98%)
 rename drivers/thunderbolt/{tunnel_pci.h => tunnel.h} (87%)

diff --git a/drivers/thunderbolt/Makefile b/drivers/thunderbolt/Makefile
index 8531f15d3b3c..833bdee3cec7 100644
--- a/drivers/thunderbolt/Makefile
+++ b/drivers/thunderbolt/Makefile
@@ -1,3 +1,3 @@
 obj-${CONFIG_THUNDERBOLT} := thunderbolt.o
-thunderbolt-objs := nhi.o ctl.o tb.o switch.o cap.o path.o tunnel_pci.o eeprom.o
+thunderbolt-objs := nhi.o ctl.o tb.o switch.o cap.o path.o tunnel.o eeprom.o
 thunderbolt-objs += domain.o dma_port.o icm.o property.o xdomain.o lc.o
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index e71530d0af65..8de43a2ab205 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -12,7 +12,7 @@
 
 #include "tb.h"
 #include "tb_regs.h"
-#include "tunnel_pci.h"
+#include "tunnel.h"
 
 /**
  * struct tb_cm - Simple Thunderbolt connection manager
diff --git a/drivers/thunderbolt/tunnel_pci.c b/drivers/thunderbolt/tunnel.c
similarity index 98%
rename from drivers/thunderbolt/tunnel_pci.c
rename to drivers/thunderbolt/tunnel.c
index 2de4edccbd6d..1e470564e99d 100644
--- a/drivers/thunderbolt/tunnel_pci.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Thunderbolt Cactus Ridge driver - PCIe tunnel
+ * Thunderbolt Cactus Ridge driver - Tunneling support
  *
  * Copyright (c) 2014 Andreas Noever <andreas.noever@gmail.com>
  */
@@ -8,7 +8,7 @@
 #include <linux/slab.h>
 #include <linux/list.h>
 
-#include "tunnel_pci.h"
+#include "tunnel.h"
 #include "tb.h"
 
 #define __TB_TUNNEL_PRINT(level, tunnel, fmt, arg...)                   \
diff --git a/drivers/thunderbolt/tunnel_pci.h b/drivers/thunderbolt/tunnel.h
similarity index 87%
rename from drivers/thunderbolt/tunnel_pci.h
rename to drivers/thunderbolt/tunnel.h
index f9b65fa1fd4d..dff0f27d6ab5 100644
--- a/drivers/thunderbolt/tunnel_pci.h
+++ b/drivers/thunderbolt/tunnel.h
@@ -1,12 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Thunderbolt Cactus Ridge driver - PCIe tunnel
+ * Thunderbolt Cactus Ridge driver - Tunneling support
  *
  * Copyright (c) 2014 Andreas Noever <andreas.noever@gmail.com>
  */
 
-#ifndef TB_PCI_H_
-#define TB_PCI_H_
+#ifndef TB_TUNNEL_H_
+#define TB_TUNNEL_H_
 
 #include "tb.h"
 
-- 
2.20.1

