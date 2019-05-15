Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33024C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E8820818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="J8N5T92J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfEOPE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 11:04:29 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:43647 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfEOPEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 11:04:23 -0400
Received: from grover.flets-west.jp (softbank126125154139.bbtec.net [126.125.154.139]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x4FF488S014964;
        Thu, 16 May 2019 00:04:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x4FF488S014964
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557932648;
        bh=u9dXgGIsSlr/2UJfZm4Hi8PQBr56poeSbRgpr/KP1sc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J8N5T92J5aYJbYx1PB3wAD1wutBLjTXl2mu+Rz24c3UpWk0LZ1E3ZS2nS4ixlTYu0
         XLZlnU/y9btpPKAG3D2drBKiU9URyd9OpvkqzNGbS0IBFALRUkWhKDA4bOIhyYEK6w
         5jRzJdV6BVrM8uWCix8WitP2sNvCv+OfCt3b+7zLdh8QfnnXR1AgPZQXB1Ll51uKX7
         HY8TL9wxXpC5gngryyFd12KL8FlENWlD3Ya7cAdVlnr6WQWMeMU5T1proDMFKm0LbQ
         Ca3oPbwIVD3nArtT2aGJTwGLXeHErNSG8SafL0WGHX5ap2ea7IGgcIVQcGvRuOHqBH
         /oXNiXnFZfsWQ==
X-Nifty-SrcIP: [126.125.154.139]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] memory: move jedec_ddr_data.c from lib/ to drivers/memory/
Date:   Thu, 16 May 2019 00:04:05 +0900
Message-Id: <1557932646-29752-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557932646-29752-1-git-send-email-yamada.masahiro@socionext.com>
References: <1557932646-29752-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

jedec_ddr_data.c exports the lpddr2_jedec_* symbols, and all of them
are only referenced from drivers/memory/{emif.c,of_memory.c}

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
index 2d91b00..fa17b3e 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -7,6 +7,14 @@ menuconfig MEMORY
 
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
index 91ae4eb..9d5c409 100644
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
index 3577609..473f937 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -530,14 +530,6 @@ config LRU_CACHE
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
index fb76970..cb66bc9 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -206,8 +206,6 @@ obj-$(CONFIG_SIGNATURE) += digsig.o
 
 lib-$(CONFIG_CLZ_TAB) += clz_tab.o
 
-obj-$(CONFIG_DDR) += jedec_ddr_data.o
-
 obj-$(CONFIG_GENERIC_STRNCPY_FROM_USER) += strncpy_from_user.o
 obj-$(CONFIG_GENERIC_STRNLEN_USER) += strnlen_user.o
 
-- 
2.7.4

