Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A76EC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED62A20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="iP1qjJVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfDHHz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:55:56 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:33256 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfDHHzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:55:55 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x387sSoq029620;
        Mon, 8 Apr 2019 16:54:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x387sSoq029620
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554710071;
        bh=21BpN95DMwJTYOiDMBwmLoA8rj/R3QI1Ndwk58+low8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iP1qjJVTbhp99sVhWetMewoMVd5Wf/JSh4CPKsNRA6MzjgJydWXchsXVlIOq/rgth
         5Vb8UPC9wMlcHDADTD1qkR4BtJrqZW6Mvy5PeU3bwteZogrzHkmPlrL85sLhkzu2Yk
         rEEpDMnZFFbUVxW8DRxiyd5EL+E368lve/lPXNea0QVEqLY49lX0DIwEN+ZvHGmzYt
         fCMPmxErFUTA+ZgmduGYJiMEibNudAl/kHVcEA0fmiXgi9hExb3ibQJEYk7PG7XcWE
         ZwLW0h8lueYNwsN/D1DYDL4GEnr1SZHpJTuqa0CWntnuTQJ/py3RldXarOyfCxYDd5
         RlxPfnY4BWYDA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     arm@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ARM: omap2: move platform-specific asm-offset.h to arch/arm/mach-omap2
Date:   Mon,  8 Apr 2019 16:54:27 +0900
Message-Id: <20190408075427.6052-3-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190408075427.6052-1-yamada.masahiro@socionext.com>
References: <20190408075427.6052-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<generated/ti-pm-asm-offsets.h> is only generated and included
by arch/arm/mach-omap2/, so it does not need to reside in the
globally visible include/generated/.

I moved and renamed it to arch/arm/mach-omap2/pm-asm-offsets.h
since the prefix 'omap2-' is just redundant in mach-omap2/.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Can this be applied to ARM-SOC tree in a series?
(with Ack from the platform sub-maintainer.)

ti-pm-asm-offsets.h does not need to reside in include/generated/,
but you may ask "Why must it get out of include/generated/?"

My main motivation is to avoid a race condition in the currently
proposed patch:

https://lore.kernel.org/patchwork/patch/1052763/

This patch tries to embed some build artifacts into the kernel.

If arch/arm/mach-omap2/ and kernel/ are built at the same time,
it may embed a truncated file.


 arch/arm/mach-omap2/.gitignore  | 1 +
 arch/arm/mach-omap2/Makefile    | 5 +++--
 arch/arm/mach-omap2/sleep33xx.S | 2 +-
 arch/arm/mach-omap2/sleep43xx.S | 2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-omap2/.gitignore

diff --git a/arch/arm/mach-omap2/.gitignore b/arch/arm/mach-omap2/.gitignore
new file mode 100644
index 000000000000..79a8d6ea7152
--- /dev/null
+++ b/arch/arm/mach-omap2/.gitignore
@@ -0,0 +1 @@
+pm-asm-offsets.h
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 85d1b13c9215..26baeb6477af 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -236,9 +236,10 @@ obj-y					+= omap_phy_internal.o
 
 obj-$(CONFIG_MACH_OMAP2_TUSB6010)	+= usb-tusb6010.o
 
-include/generated/ti-pm-asm-offsets.h: arch/arm/mach-omap2/pm-asm-offsets.s FORCE
+$(obj)/pm-asm-offsets.h: $(obj)/pm-asm-offsets.s FORCE
 	$(call filechk,offsets,__TI_PM_ASM_OFFSETS_H__)
 
-$(obj)/sleep33xx.o $(obj)/sleep43xx.o: include/generated/ti-pm-asm-offsets.h
+$(obj)/sleep33xx.o $(obj)/sleep43xx.o: $(obj)/pm-asm-offsets.h
 
 targets += pm-asm-offsets.s
+clean-files += pm-asm-offsets.h
diff --git a/arch/arm/mach-omap2/sleep33xx.S b/arch/arm/mach-omap2/sleep33xx.S
index 47a816468cdb..a003769121aa 100644
--- a/arch/arm/mach-omap2/sleep33xx.S
+++ b/arch/arm/mach-omap2/sleep33xx.S
@@ -6,7 +6,6 @@
  *	Dave Gerlach, Vaibhav Bedia
  */
 
-#include <generated/ti-pm-asm-offsets.h>
 #include <linux/linkage.h>
 #include <linux/platform_data/pm33xx.h>
 #include <linux/ti-emif-sram.h>
@@ -15,6 +14,7 @@
 
 #include "iomap.h"
 #include "cm33xx.h"
+#include "pm-asm-offsets.h"
 
 #define AM33XX_CM_CLKCTRL_MODULESTATE_DISABLED			0x00030000
 #define AM33XX_CM_CLKCTRL_MODULEMODE_DISABLE			0x0003
diff --git a/arch/arm/mach-omap2/sleep43xx.S b/arch/arm/mach-omap2/sleep43xx.S
index 5b9343b58fc7..aa288f361c5e 100644
--- a/arch/arm/mach-omap2/sleep43xx.S
+++ b/arch/arm/mach-omap2/sleep43xx.S
@@ -6,7 +6,6 @@
  *	Dave Gerlach, Vaibhav Bedia
  */
 
-#include <generated/ti-pm-asm-offsets.h>
 #include <linux/linkage.h>
 #include <linux/ti-emif-sram.h>
 #include <linux/platform_data/pm33xx.h>
@@ -19,6 +18,7 @@
 #include "iomap.h"
 #include "omap-secure.h"
 #include "omap44xx.h"
+#include "pm-asm-offsets.h"
 #include "prm33xx.h"
 #include "prcm43xx.h"
 
-- 
2.17.1

