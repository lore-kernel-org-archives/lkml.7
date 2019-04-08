Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F548C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9B7208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="rT06vdNy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfDHH4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:56:00 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:33396 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfDHH4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:56:00 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x387sSop029620;
        Mon, 8 Apr 2019 16:54:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x387sSop029620
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554710070;
        bh=J+Os6G/U5M9lW5V8kWbPPhrXmHnKe19y0jvJ6jloN00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rT06vdNyrdn7znL3cXw6x0XFCnUgkyNZWQ06k0sstLrLVDWWL3BGFb3r/MpMpO/z2
         VUer1uE0G1UwVanCyjainepmkd0jA3VGVx6NDjVmO2965ywWxxnS+N+t+VkHMF59nx
         PK5c5hlcnIzqHIosyP+utGyf21hJe769h6OGI4g/Nw6J2fQUzEajiDPuT4ksGSp63Q
         uoeAIOXi/mlsnbe6at4sMAGjE4sK+CvWJGuYk8HHUhh0fMWfMVs74YgFptwOUuVLg5
         MQb8d23o27qtGmIFc+t3aLC2DaMHIH92uOAHCErNx9RBBNwwYUawsJbS7qtAQGFUn8
         BupfC2daeXg+w==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     arm@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 2/3] ARM: at91: move platform-specific asm-offset.h to arch/arm/mach-at91
Date:   Mon,  8 Apr 2019 16:54:26 +0900
Message-Id: <20190408075427.6052-2-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190408075427.6052-1-yamada.masahiro@socionext.com>
References: <20190408075427.6052-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<generated/at91_pm_data-offsets.h> is only generated and included
by arch/arm/mach-at91/, so it does not need to reside in the
globally visible include/generated/.

I moved and renamed it to arch/arm/mach-at91/pm_data-offsets.h
since the prefix 'at91_' is just redundant in mach-at91/.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Can this be applied to ARM-SOC tree in a series?
(with Ack from the platform sub-maintainer.)

at91_pm_data-offsets.h header does not need to reside in
include/generated/, but you may ask
"Why must it get out of include/generated/?"

My main motivation is to avoid a race condition in the currently
proposed patch:

https://lore.kernel.org/patchwork/patch/1052763/

This patch tries to embed some build artifacts into the kernel.

If arch/arm/mach-at91/ and kernel/ are built at the same time,
it may embed a truncated file.


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
index bfe1c4d06901..a31c1b20f3fa 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -14,7 +14,7 @@
 #include <linux/linkage.h>
 #include <linux/clk/at91_pmc.h>
 #include "pm.h"
-#include "generated/at91_pm_data-offsets.h"
+#include "pm_data-offsets.h"
 
 #define	SRAMC_SELF_FRESH_ACTIVE		0x01
 #define	SRAMC_SELF_FRESH_EXIT		0x00
-- 
2.17.1

