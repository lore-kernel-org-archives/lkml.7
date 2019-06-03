Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA82C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73F825763
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="KqwWUkpS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfFCINc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 04:13:32 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:56807 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfFCINc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:13:32 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x538Cdor002048;
        Mon, 3 Jun 2019 17:12:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x538Cdor002048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1559549562;
        bh=p//No+hpKX3bBuChWljMBq7O7wxZpa31Ei+M+7TG65Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KqwWUkpSXMd92pSxF2HHBDB61ZSrRw+BjVwv+W5EF2BsU5V0Zx4yxckLK5wu6dE+n
         dRVMiWIZY96EGO5/vH0gbYT35oCsyXoUCY9Kpr42u8RlPCVh/3KJCKI2VhMnYaUxB1
         XZpxXl4kBtiC217nMC6Vl1Y7NxryhBrUASviXra3ycmubs32Bn9W232B6RWK+SIjgy
         7BzS3L/A4YZ9l2RU8rTu+NyCa6VVzQLfhojLBzhq3a5GQO4v8XAB6lfFWWkydl03do
         KSwEHwKwWDslw4Sx5OWy6HoRM40uKD+GrSika+cA1gZh3S07MZoQve2U9/ASMZmTGX
         fxSJlpmD2FtxA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     arm@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org,
        Santosh Shilimkar <ssantosh@kernel.org>
Subject: [RESEND PATCH 2/2] memory: move jedec_ddr.h from include/memory to drivers/memory/
Date:   Mon,  3 Jun 2019 17:12:33 +0900
Message-Id: <20190603081233.17394-3-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603081233.17394-1-yamada.masahiro@socionext.com>
References: <20190603081233.17394-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that jedec_ddr_data.c was moved from lib/ to drivers/memory/,
<memory/jedec_ddr.h> is included only from drivers/memory/.

Make it a local header of drivers/memory/.

The directory include/memory is now gone.

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
index 2f214440008c..32cad7540d78 100644
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
index ddad0f870e5d..a2094a9a588e 100644
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
index 6d2cbf1d567f..1f9ca0f23407 100644
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
index 12a61f558644..46539b27a3fb 100644
--- a/drivers/memory/of_memory.c
+++ b/drivers/memory/of_memory.c
@@ -10,8 +10,9 @@
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
2.17.1

