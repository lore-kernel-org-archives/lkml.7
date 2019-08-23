Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FCDC3A5A1
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A6021897
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="nCKjhe3p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403775AbfHWCpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 22:45:21 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:29997 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391306AbfHWCpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 22:45:20 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x7N2i1YP015237;
        Fri, 23 Aug 2019 11:44:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x7N2i1YP015237
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566528242;
        bh=RUQPvpeRirVgphhnQn/uX9bo3iR6wYuDL45CJSJJoug=;
        h=From:To:Cc:Subject:Date:From;
        b=nCKjhe3pKvSY21V/fQedzyEyJxixda6YkE/vIjR4gckiMxCR2Ri/HX7RmIyvBf2g5
         v+Wra+fyG/KES1p4LdTXY1GCqaUzcx3GDGAew8hVzH9tFfn6ekLFOGsjoMsjvR4ZAd
         7PjQ87z7iPsp/nnw94Izt8Z6bLGqTLHPcM1skMTCL5Hx2MGVE4836eraFocvVpkAP7
         Z1xj1Xf79DzUqiKvuODHuFbcY+NiUDSlq3/BiUUyIP9+GrNEvOafjDz45WBhUwXMwx
         TMM8RVgyCN6UIayVxau8Xk4Av/H/5+0PoiBrZSrbHbRBLDqNpqqBbrpGov0qVxFvrO
         /NQcwzyECOxGw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: at91: move platform-specific asm-offset.h to arch/arm/mach-at91
Date:   Fri, 23 Aug 2019 11:43:45 +0900
Message-Id: <20190823024346.591-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<generated/at91_pm_data-offsets.h> is only generated and included by
arch/arm/mach-at91/, so it does not need to reside in the globally
visible include/generated/.

I renamed it to arch/arm/mach-at91/pm_data-offsets.h since the prefix
'at91_' is just redundant in mach-at91/.

My main motivation of this change is to avoid the race condition for
the parallel build (-j) when CONFIG_IKHEADERS is enabled.

When it is enabled, all the headers under include/ are archived into
kernel/kheaders_data.tar.xz and exposed in the sysfs.

In the parallel build, we have no idea in which order files are built.

 - If at91_pm_data-offsets.h is built before kheaders_data.tar.xz,
   the header will be included in the archive. Probably nobody will
   use it, but it is harmless except that it will increase the archive
   size needlessly.

 - If kheaders_data.tar.xz is built before at91_pm_data-offsets.h,
   the header will not be included in the archive. However, in the next
   build, the archive will be re-generated to include the newly-found
   at91_pm_data-offsets.h. This is not nice from the build system point
   of view.

 - If at91_pm_data-offsets.h and kheaders_data.tar.xz are built at the
   same time, the corrupted header might be included in the archive,
   which does not look nice either.

This commit fixes the race.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-at91/.gitignore   | 1 +
 arch/arm/mach-at91/Makefile     | 5 +++--
 arch/arm/mach-at91/pm_suspend.S | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-at91/.gitignore

diff --git a/arch/arm/mach-at91/.gitignore b/arch/arm/mach-at91/.gitignore
new file mode 100644
index 000000000000..2ecd6f51c8a9
--- /dev/null
+++ b/arch/arm/mach-at91/.gitignore
@@ -0,0 +1 @@
+pm_data-offsets.h
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 31b61f0e1c07..de64301dcff2 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -19,9 +19,10 @@ ifeq ($(CONFIG_PM_DEBUG),y)
 CFLAGS_pm.o += -DDEBUG
 endif
 
-include/generated/at91_pm_data-offsets.h: arch/arm/mach-at91/pm_data-offsets.s FORCE
+$(obj)/pm_data-offsets.h: $(obj)/pm_data-offsets.s FORCE
 	$(call filechk,offsets,__PM_DATA_OFFSETS_H__)
 
-arch/arm/mach-at91/pm_suspend.o: include/generated/at91_pm_data-offsets.h
+$(obj)/pm_suspend.o: $(obj)/pm_data-offsets.h
 
 targets += pm_data-offsets.s
+clean-files += pm_data-offsets.h
diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index c751f047b116..ed57c879d4e1 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -10,7 +10,7 @@
 #include <linux/linkage.h>
 #include <linux/clk/at91_pmc.h>
 #include "pm.h"
-#include "generated/at91_pm_data-offsets.h"
+#include "pm_data-offsets.h"
 
 #define	SRAMC_SELF_FRESH_ACTIVE		0x01
 #define	SRAMC_SELF_FRESH_EXIT		0x00
-- 
2.17.1

