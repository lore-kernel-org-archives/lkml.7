Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA5CC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1049820881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="u1ihwE4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfEOPE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 11:04:26 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:43646 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfEOPEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 11:04:23 -0400
Received: from grover.flets-west.jp (softbank126125154139.bbtec.net [126.125.154.139]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x4FF488T014964;
        Thu, 16 May 2019 00:04:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x4FF488T014964
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557932649;
        bh=ITVoB4ARtru8MvDGlH7GHuPioR1vApBXy9yDov2equA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u1ihwE4en+5gK6+cbg2gHlR8n2Kqc2lvY2RubMwCn8WV9dsT9K4SYLSwIBPCnmoNt
         ypytTe5EEa6WYAEkid/YL+0qFbbImEBE6qoTqFcr94yxhDbuAgOg45Ojj/NTaaKCVW
         XuoCwo6c0GChF+i22gQEIKSeXEDdQemKp9p2VfnaVFxQvClcDWU9CWWlkL7XOVBQJr
         ckoP1iLXsc6rhir4l8sougeXH8+Aqkg8VouU4j4SVJz7l7c7L3VW1/HOfPPogo4zJ1
         Tp+8b47bEr2U6yo9Vwp0qqdWzRDWWhOuvHyV6FsYDEsd1GJY1p/0I/cngvdYTyfhuZ
         jABIOoo1Rnwlg==
X-Nifty-SrcIP: [126.125.154.139]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] memory: move jedec_ddr.h from include/memory to drivers/memory/
Date:   Thu, 16 May 2019 00:04:06 +0900
Message-Id: <1557932646-29752-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557932646-29752-1-git-send-email-yamada.masahiro@socionext.com>
References: <1557932646-29752-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that jedec_ddr_data.c was moved from lib/ to drivers/memory/,
<memory/jedec_ddr.h> is included only from drivers/memory/.

Make it a local header of drivers/memory/.

While I am here, I also changed #include <linux/module.h> to
<linux/export.h>. Because CONFIG_DDR is bool, jedec_ddr_data.c is
never compiled as a module.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/memory/emif.c                   | 3 ++-
 {include => drivers}/memory/jedec_ddr.h | 6 +++---
 drivers/memory/jedec_ddr_data.c         | 5 +++--
 drivers/memory/of_memory.c              | 3 ++-
 4 files changed, 10 insertions(+), 7 deletions(-)
 rename {include => drivers}/memory/jedec_ddr.h (97%)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 2f21444..32cad75 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -26,8 +26,9 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/pm.h>
-#include <memory/jedec_ddr.h>
+
 #include "emif.h"
+#include "jedec_ddr.h"
 #include "of_memory.h"
 
 /**
diff --git a/include/memory/jedec_ddr.h b/drivers/memory/jedec_ddr.h
similarity index 97%
rename from include/memory/jedec_ddr.h
rename to drivers/memory/jedec_ddr.h
index ddad0f8..a2094a9 100644
--- a/include/memory/jedec_ddr.h
+++ b/drivers/memory/jedec_ddr.h
@@ -9,8 +9,8 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#ifndef __LINUX_JEDEC_DDR_H
-#define __LINUX_JEDEC_DDR_H
+#ifndef __JEDEC_DDR_H
+#define __JEDEC_DDR_H
 
 #include <linux/types.h>
 
@@ -172,4 +172,4 @@ extern const struct lpddr2_timings
 	lpddr2_jedec_timings[NUM_DDR_TIMING_TABLE_ENTRIES];
 extern const struct lpddr2_min_tck lpddr2_jedec_min_tck;
 
-#endif /* __LINUX_JEDEC_DDR_H */
+#endif /* __JEDEC_DDR_H */
diff --git a/drivers/memory/jedec_ddr_data.c b/drivers/memory/jedec_ddr_data.c
index 6d2cbf1..1f9ca0f 100644
--- a/drivers/memory/jedec_ddr_data.c
+++ b/drivers/memory/jedec_ddr_data.c
@@ -10,8 +10,9 @@
  * published by the Free Software Foundation.
  */
 
-#include <memory/jedec_ddr.h>
-#include <linux/module.h>
+#include <linux/export.h>
+
+#include "jedec_ddr.h"
 
 /* LPDDR2 addressing details from JESD209-2 section 2.4 */
 const struct lpddr2_addressing
diff --git a/drivers/memory/of_memory.c b/drivers/memory/of_memory.c
index 2f5ed73..2190b8e 100644
--- a/drivers/memory/of_memory.c
+++ b/drivers/memory/of_memory.c
@@ -14,8 +14,9 @@
 #include <linux/list.h>
 #include <linux/of.h>
 #include <linux/gfp.h>
-#include <memory/jedec_ddr.h>
 #include <linux/export.h>
+
+#include "jedec_ddr.h"
 #include "of_memory.h"
 
 /**
-- 
2.7.4

