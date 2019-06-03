Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35A0C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9BB225763
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="MaKfWbk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfFCINh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 04:13:37 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:56792 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfFCINc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:13:32 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x538Cdoq002048;
        Mon, 3 Jun 2019 17:12:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x538Cdoq002048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1559549561;
        bh=Yy6xaRVBbLuyh41FBcaoTVAl8eAfN9twm28AUEdXycQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MaKfWbk+u3wpVWJQJUa2yLnFBc1y42PpgtLUsd2euIuj4urVlPr7CF3pDUiVLQCfm
         cbghzAtofe1v71Lq3ofmfw0qnkxkiXQKGk5mGwn7i4uEAgWVVFhYLdhFjGeRHcL1ur
         lLrv45psTRB+gbNt6QpZmN25e2h++gW5cnhzbhTFNJvxKosyVvru1UC9SUsynILwR+
         9oEkSV/CyB2TQCjp7vJ8bnzEXO7sZIfTkbNGM9UHd3ACIO5UIyt8aZkvbKRmN++WD2
         Er2T6UQhUw8yCG3IpINybHJn5qvZ2sdf8WY1y4a7g/Jy2q/rESAvpyp4PG62512ngZ
         DUL73jw+4r9gA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     arm@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 1/2] memory: move jedec_ddr_data.c from lib/ to drivers/memory/
Date:   Mon,  3 Jun 2019 17:12:32 +0900
Message-Id: <20190603081233.17394-2-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603081233.17394-1-yamada.masahiro@socionext.com>
References: <20190603081233.17394-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

jedec_ddr_data.c exports 3 symbols, and all of them are only
referenced from drivers/memory/{emif.c,of_memory.c}

drivers/memory/ is a better location than lib/.

I removed the Kconfig prompt "JEDEC DDR data" because it is only
select'ed by TI_EMIF, and there is no other user. There is no good
reason in making it a user-configurable CONFIG option.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/memory/Kconfig                   | 8 ++++++++
 drivers/memory/Makefile                  | 1 +
 {lib => drivers/memory}/jedec_ddr_data.c | 0
 lib/Kconfig                              | 8 --------
 lib/Makefile                             | 2 --
 5 files changed, 9 insertions(+), 10 deletions(-)
 rename {lib => drivers/memory}/jedec_ddr_data.c (100%)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 392ad4f5c570..477f0f130e5b 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -8,6 +8,14 @@ menuconfig MEMORY
 
 if MEMORY
 
+config DDR
+	bool
+	help
+	  Data from JEDEC specs for DDR SDRAM memories,
+	  particularly the AC timing parameters and addressing
+	  information. This data is useful for drivers handling
+	  DDR SDRAM controllers.
+
 config ARM_PL172_MPMC
 	tristate "ARM PL172 MPMC driver"
 	depends on ARM_AMBA && OF
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index 91ae4eb0e913..9d5c409a1591 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -3,6 +3,7 @@
 # Makefile for memory devices
 #
 
+obj-$(CONFIG_DDR)		+= jedec_ddr_data.o
 ifeq ($(CONFIG_DDR),y)
 obj-$(CONFIG_OF)		+= of_memory.o
 endif
diff --git a/lib/jedec_ddr_data.c b/drivers/memory/jedec_ddr_data.c
similarity index 100%
rename from lib/jedec_ddr_data.c
rename to drivers/memory/jedec_ddr_data.c
diff --git a/lib/Kconfig b/lib/Kconfig
index 90623a0e1942..e09b3e081a53 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -531,14 +531,6 @@ config LRU_CACHE
 config CLZ_TAB
 	bool
 
-config DDR
-	bool "JEDEC DDR data"
-	help
-	  Data from JEDEC specs for DDR SDRAM memories,
-	  particularly the AC timing parameters and addressing
-	  information. This data is useful for drivers handling
-	  DDR SDRAM controllers.
-
 config IRQ_POLL
 	bool "IRQ polling library"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index fb7697031a79..cb66bc9c5b2f 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -206,8 +206,6 @@ obj-$(CONFIG_SIGNATURE) += digsig.o
 
 lib-$(CONFIG_CLZ_TAB) += clz_tab.o
 
-obj-$(CONFIG_DDR) += jedec_ddr_data.o
-
 obj-$(CONFIG_GENERIC_STRNCPY_FROM_USER) += strncpy_from_user.o
 obj-$(CONFIG_GENERIC_STRNLEN_USER) += strnlen_user.o
 
-- 
2.17.1

