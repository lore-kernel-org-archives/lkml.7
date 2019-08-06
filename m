Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08784C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF692147A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="yXqqCcOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbfHFHQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 03:16:15 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:60555 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731557AbfHFHQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 03:16:15 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x767EoCg021608;
        Tue, 6 Aug 2019 16:14:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x767EoCg021608
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1565075691;
        bh=+mlBUCXHsidXtFOd1DNKqTKqGc6xPzMnTouLyTrJQGI=;
        h=From:To:Cc:Subject:Date:From;
        b=yXqqCcOwHDMXQENKIFxguyqODzU3zeRh7DtTXGezMGCdQZ+PLvI9oKyL/RLkyuBUZ
         whHcA/2NiNTCUnVTQXSrU5GuXHchfmox8ZlGY4V8tl3lyV5v2xOl6XHhTZ91f57LK6
         HJKZQjVIraBtu1zHRWFBQ2BpMi1h4BmpfzfQjBQ7mLgQTTI0wEuMr0D9r7qQlsA2+f
         vpNdh89MlePLSOBXTr9vShBXJdFIxyvaY74uD1xxqzT12PwfydLRYAInSWNYYGgH57
         B8reW4nwbTdSRQ+ujfBb3OsFvVAaKUu9tB17+02trcKGdT74hua3nZS1+k+C+DGSDm
         nX3F9VnkC0umQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Willy Tarreau <willy@haproxy.com>
Subject: [PATCH 1/2] auxdisplay: charlcd: move charlcd.h to drivers/auxdisplay
Date:   Tue,  6 Aug 2019 16:14:44 +0900
Message-Id: <20190806071445.13705-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This header is included in drivers/auxdisplay/. Make it a local header.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/auxdisplay/charlcd.c                   | 2 +-
 {include/misc => drivers/auxdisplay}/charlcd.h | 0
 drivers/auxdisplay/hd44780.c                   | 3 +--
 drivers/auxdisplay/panel.c                     | 2 +-
 4 files changed, 3 insertions(+), 4 deletions(-)
 rename {include/misc => drivers/auxdisplay}/charlcd.h (100%)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 92745efefb54..bef6b85778b6 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -20,7 +20,7 @@
 
 #include <generated/utsrelease.h>
 
-#include <misc/charlcd.h>
+#include "charlcd.h"
 
 #define LCD_MINOR		156
 
diff --git a/include/misc/charlcd.h b/drivers/auxdisplay/charlcd.h
similarity index 100%
rename from include/misc/charlcd.h
rename to drivers/auxdisplay/charlcd.h
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index ab15b64707ad..bcbe13092327 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -14,8 +14,7 @@
 #include <linux/property.h>
 #include <linux/slab.h>
 
-#include <misc/charlcd.h>
-
+#include "charlcd.h"
 
 enum hd44780_pin {
 	/* Order does matter due to writing to GPIO array subsets! */
diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index e06de63497cf..f8ff18ba6889 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -55,7 +55,7 @@
 #include <linux/io.h>
 #include <linux/uaccess.h>
 
-#include <misc/charlcd.h>
+#include "charlcd.h"
 
 #define KEYPAD_MINOR		185
 
-- 
2.17.1

