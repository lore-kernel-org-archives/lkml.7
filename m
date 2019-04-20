Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779ABC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 11:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0CC20850
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 11:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSQDJpee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbfDTLh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 07:37:59 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39608 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfDTLh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 07:37:58 -0400
Received: by mail-pl1-f194.google.com with SMTP id e92so1927646plb.6
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 04:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3020UUccBrg127CsNRYXb+mKxuRCUYyY6IZkq6qugwo=;
        b=GSQDJpee/iBNBkoq2UFZuA1kBZEwwdn1ge1Tw0rtuxVc469vlZRGU2KTmXjrW76coo
         90PPXQYyUOyCkWy0jPQRz1L3YdjVUN4IubLSrJVoqjI5xcUzZbWkx0YlddrbP/01z2tU
         r5G8FvoKwoTEj3M7QJY4fY+xW7gLpfPLUruxynZhLQtZdE1PuuClvLDbnzaR7TN1KWGa
         aEZpQ4fX8ZlJdFnaCgliBCB6ye41qp0JBQNJTSsC9AtjjNCIQTJjKQtUY5rwxkCcH2JF
         YxIrzTl/8xE1U4Ey+QxLaHHIQzCtPYMnuppepDoc5M3eaCgyboA8XpXWkzHgImnhGGBk
         lXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3020UUccBrg127CsNRYXb+mKxuRCUYyY6IZkq6qugwo=;
        b=Vpob6Dc1yGM+u7i2orxRGQ2dSCHvXlrGWLNjhTS5J9jRMB2sV8Nyhd+h6q2cL3hvY8
         CyMFzHVWPE5/QSw5orZ5ReBoe4BleLe0IEiDW65p2gnk++Eb2cC3IL6GMEa9ziQfcPnB
         nhvZhCxwGUCyiq23+DlV1Dp9Go96dAQUh6x7n1rqvzy6Hvnc64Fh7OUS9M1QW8vXNZN2
         n+YJKFxGCTsPr5dRQnEjssCWkQceJoB76YJIkMoC2uRHTHLzswWae7Bj/6oVrl6UAU7t
         QDBUSW7PYA3CbxuHSoRfw1VlXCSR1Ww8VaUGsHfAas4Cf3pqLbQ/SG2bc7KSTWMuYLA/
         TG0w==
X-Gm-Message-State: APjAAAWp/Yqi9t/xPEay6M9OkgjDQe3Wf3OYMnWgw8YPZ+nee8tZZy23
        m8rKhDaUxPsFTesMlvCNPPQ=
X-Google-Smtp-Source: APXvYqziPSPuMDAKp7dEcHfOA9zHeZ/x2DKYM8Pl577KRlh/ectxYmugRVu3qIYrwZoFm/iXZ0kVAg==
X-Received: by 2002:a17:902:22f:: with SMTP id 44mr9079854plc.175.1555760277844;
        Sat, 20 Apr 2019 04:37:57 -0700 (PDT)
Received: from localhost.localdomain ([117.204.45.231])
        by smtp.gmail.com with ESMTPSA id i1sm17407669pgc.63.2019.04.20.04.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 04:37:57 -0700 (PDT)
From:   MosesChristopher <moseschristopherb@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        florian.c.schilhabel@googlemail.com, insafonov@gmail.com,
        hdegoede@redhat.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Moses Christopher <moseschristopherb@gmail.com>
Subject: [PATCH] staging: rtl8*: use help instead of ---help--- in Kconfig
Date:   Sat, 20 Apr 2019 11:37:31 +0000
Message-Id: <20190420113731.26160-1-moseschristopherb@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moses Christopher <moseschristopherb@gmail.com>

  - Resolve the following warning from the Kconfig,
    "WARNING: prefer 'help' over '---help---' for new help texts"

Signed-off-by: Moses Christopher <moseschristopherb@gmail.com>
---
 drivers/staging/rtl8188eu/Kconfig | 4 ++--
 drivers/staging/rtl8192e/Kconfig  | 8 ++++----
 drivers/staging/rtl8712/Kconfig   | 4 ++--
 drivers/staging/rtl8723bs/Kconfig | 2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8188eu/Kconfig b/drivers/staging/rtl8188eu/Kconfig
index ff7832798a77..3f8c655856bf 100644
--- a/drivers/staging/rtl8188eu/Kconfig
+++ b/drivers/staging/rtl8188eu/Kconfig
@@ -7,7 +7,7 @@ config R8188EU
 	select LIB80211
 	select LIB80211_CRYPT_WEP
 	select LIB80211_CRYPT_CCMP
-	---help---
+	help
 	This option adds the Realtek RTL8188EU USB device such as TP-Link TL-WN725N.
 	If built as a module, it will be called r8188eu.
 
@@ -16,7 +16,7 @@ if R8188EU
 config 88EU_AP_MODE
 	bool "Realtek RTL8188EU AP mode"
 	default y
-	---help---
+	help
 	This option enables Access Point mode. Unless you know that your system
 	will never be used as an AP, or the target system has limited memory,
 	"Y" should be selected.
diff --git a/drivers/staging/rtl8192e/Kconfig b/drivers/staging/rtl8192e/Kconfig
index 4602a47cdb4a..aa571c12678f 100644
--- a/drivers/staging/rtl8192e/Kconfig
+++ b/drivers/staging/rtl8192e/Kconfig
@@ -3,7 +3,7 @@ config RTLLIB
 	depends on WLAN && m
 	default n
 	select LIB80211
-	---help---
+	help
 	  If you have a wireless card that uses rtllib, say
 	  Y. Currently the only card is the rtl8192e.
 
@@ -16,7 +16,7 @@ config RTLLIB_CRYPTO_CCMP
 	depends on RTLLIB
 	select CRYPTO_AES
 	default y
-	---help---
+	help
 	  CCMP crypto driver for rtllib.
 
 	  If you enabled RTLLIB, you want this.
@@ -27,7 +27,7 @@ config RTLLIB_CRYPTO_TKIP
 	select CRYPTO_ARC4
 	select CRYPTO_MICHAEL_MIC
 	default y
-	---help---
+	help
 	  TKIP crypto driver for rtllib.
 
 	  If you enabled RTLLIB, you want this.
@@ -37,7 +37,7 @@ config RTLLIB_CRYPTO_WEP
 	select CRYPTO_ARC4
 	depends on RTLLIB
 	default y
-	---help---
+	help
 	  TKIP crypto driver for rtllib.
 
 	  If you enabled RTLLIB, you want this.
diff --git a/drivers/staging/rtl8712/Kconfig b/drivers/staging/rtl8712/Kconfig
index f160eee52f09..b377d90742db 100644
--- a/drivers/staging/rtl8712/Kconfig
+++ b/drivers/staging/rtl8712/Kconfig
@@ -4,14 +4,14 @@ config R8712U
 	select WIRELESS_EXT
 	select WEXT_PRIV
 	select FW_LOADER
-	---help---
+	help
 	This option adds the Realtek RTL8712 USB device such as the D-Link DWA-130.
 	If built as a module, it will be called r8712u.
 
 config R8712_TX_AGGR
 	bool "Realtek RTL8712U Transmit Aggregation code"
 	depends on R8712U && BROKEN
-	---help---
+	help
 	This option provides transmit aggregation for the Realtek RTL8712 USB device.
 
 
diff --git a/drivers/staging/rtl8723bs/Kconfig b/drivers/staging/rtl8723bs/Kconfig
index deae0427ba6c..41ad6ed24860 100644
--- a/drivers/staging/rtl8723bs/Kconfig
+++ b/drivers/staging/rtl8723bs/Kconfig
@@ -4,7 +4,7 @@ config RTL8723BS
 	depends on m
 	select WIRELESS_EXT
 	select WEXT_PRIV
-	---help---
+	help
 	This option enables support for RTL8723BS SDIO drivers, such as
 	the wifi found on the 1st gen Intel Compute Stick, the CHIP
 	and many other Intel Atom and ARM based devices.
-- 
2.11.0

