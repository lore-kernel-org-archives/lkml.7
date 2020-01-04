Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503B3C2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 16:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CEC2465A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 16:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578154936;
	bh=+ZiZCli7FfwQx1a58NZgwWc5ftFN4R8pGy8GPIxxOAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CSFfTN17i+H8Fh6grP+ax54rMQ8VIL5r6f/EHuNxLJMcBPYJGS/bKFrK6AN7JxvWa
	 2Vd7XkyQcHQmynnm49h3KJGbcgUxNe7MT9CI/KB0CYEQzt7tnBAv0LpjZvr0bBiqnA
	 9QvvHQ8p34tjRIe71oErtr9zRcO5FVZKG9xczfh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgADQWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 11:22:09 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:16404 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgADQWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 11:22:08 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 004GLdDP002506;
        Sun, 5 Jan 2020 01:21:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 004GLdDP002506
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1578154900;
        bh=uQKrLBOYgdFdcVp9fop+HlNYZJ0MosPKWndzy3BrPf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BYTorUDxystZm/sbdTyyqXpDOrUR7PIOW5+NWbBQHwhIR9C0TS4dmwTSNuunMCEdt
         H2Zm4lxEJEgm/xfPNhG/Xua9HnFKSMliCnC6QfGPLtZ6fVHPMbmNnHRoNKUXefuLmG
         d4SWMKkk7U+BLEm5t7SOEBlJBuqEVybxV974Dj4W4yg4G/KhXSQIOER7iEDXu5lzTH
         8oSEBmIZryXh5cATb5Jk7xE29XZ7U98VWbbP8jmf1SejA4MiVaAw+H0fm7EX35Djcz
         OU5LLo02IzxqqWAEwaiMUAsNA/6bBLhgU8uqiEyXn9FLNEY8vqzQ4ysQTC33JsOMtS
         YOKkjhnPEs03w==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] staging: rtl8192u: remove header include path to ieee80211/
Date:   Sun,  5 Jan 2020 01:21:35 +0900
Message-Id: <20200104162136.19170-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200104162136.19170-1-masahiroy@kernel.org>
References: <20200104162136.19170-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to add "ccflags-y += -I $(srctree)/$(src)/ieee80211"
just for including "dot11d.h".

Use the correct relative path for the #include "..." directive.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/staging/rtl8192u/Makefile      | 1 -
 drivers/staging/rtl8192u/r8192U_core.c | 2 +-
 drivers/staging/rtl8192u/r8192U_wx.c   | 2 +-
 drivers/staging/rtl8192u/r819xU_phy.c  | 2 +-
 4 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/Makefile b/drivers/staging/rtl8192u/Makefile
index dcd51bf4aed3..a7e5d3d91d9c 100644
--- a/drivers/staging/rtl8192u/Makefile
+++ b/drivers/staging/rtl8192u/Makefile
@@ -7,7 +7,6 @@ ccflags-y += -O2
 ccflags-y += -DCONFIG_FORCE_HARD_FLOAT=y
 ccflags-y += -DJACKSON_NEW_8187 -DJACKSON_NEW_RX
 ccflags-y += -DTHOMAS_BEACON -DTHOMAS_TASKLET -DTHOMAS_SKB -DTHOMAS_TURBO
-ccflags-y += -I $(srctree)/$(src)/ieee80211
 
 r8192u_usb-y := r8192U_core.o r8180_93cx6.o r8192U_wx.o		\
 		  r8190_rtl8256.o r819xU_phy.o r819xU_firmware.o	\
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 7e2cabd16e88..00fdcbf64b0b 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -60,7 +60,7 @@ double __extendsfdf2(float a)
 #include <linux/seq_file.h>
 /* FIXME: check if 2.6.7 is ok */
 
-#include "dot11d.h"
+#include "ieee80211/dot11d.h"
 /* set here to open your trace code. */
 u32 rt_global_debug_component = COMP_DOWN	|
 				COMP_SEC	|
diff --git a/drivers/staging/rtl8192u/r8192U_wx.c b/drivers/staging/rtl8192u/r8192U_wx.c
index 5822bb7984b9..0118edb0b9ab 100644
--- a/drivers/staging/rtl8192u/r8192U_wx.c
+++ b/drivers/staging/rtl8192u/r8192U_wx.c
@@ -23,7 +23,7 @@
 #include "r8192U.h"
 #include "r8192U_hw.h"
 
-#include "dot11d.h"
+#include "ieee80211/dot11d.h"
 #include "r8192U_wx.h"
 
 #define RATE_COUNT 12
diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index c04d8eca0cfb..555e52522be6 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -7,7 +7,7 @@
 #include "r8192U_dm.h"
 #include "r819xU_firmware_img.h"
 
-#include "dot11d.h"
+#include "ieee80211/dot11d.h"
 #include <linux/bitops.h>
 
 static u32 RF_CHANNEL_TABLE_ZEBRA[] = {
-- 
2.17.1

