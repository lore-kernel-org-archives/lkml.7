Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16007C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D380B217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuWdzXd0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387616AbfDQU50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:57:26 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46861 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfDQUzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:55:00 -0400
Received: by mail-lf1-f65.google.com with SMTP id k18so10987942lfj.13;
        Wed, 17 Apr 2019 13:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BQWsj5xs6VjdW3Cd+QyQB+bS+SHRP3jRiVxzu441k/U=;
        b=AuWdzXd04INhDowIv7LayEw7ENkTqOogrb6eiotiewm3Imi44mTMm0XUMnZiz+/JAJ
         BDyLnzn8Id7cuYhWRdMvvI4cIDCdYLVPkchQWTdI+Jm3pkVJhKJY9iFFjeiYIGQBoOr4
         2eMEAP/+uycaVDiPZfrv7ig+3cqOneplyQSdxBGknm+5IBj7WWZqO0FrNA/CV1hH+fFk
         t+OC2yLHbl5w31JzVVnKrLU7Rt1uaIPpEEU9AyKRf8n5y3i76bt4Lv5QLI9TBkrqm/+b
         bOMhP44/DW1pogA4euMw5Y42r8QB+RXU+BCp8t0iDhD5VFI0TYrJMAS0Aov7VHylExGm
         EHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BQWsj5xs6VjdW3Cd+QyQB+bS+SHRP3jRiVxzu441k/U=;
        b=VcGJdOmdrGJzZAEvFDExaF2GHgZh+riMa6L+mLWqEROUNfELpwo030ms2472bCdibk
         F0kWYmGPawAsgFBjiOJ0cdRFtHFmo0qicXEvqs+aSUCRJuSaB7qRyOgiQmb92VPIyYkQ
         HWj5c6ewkP1r1E0B/F4gdV+DvwkxKzBx1jQOLJB+Lwi4Bspv0QafTAb8A/YT32KOHeja
         O1AkAtlaDjDFj9klKKOAjbn+eBlry/bugp5CYMvYEKdyZu/UvMJvJibjShDhhdPNYi3f
         velPDR8/Db28fOrlQvr2X4WJE9GAeflmO4qivaa9i2OAxV6Xo0NtQsZrN9tJvRajXQqT
         DqqQ==
X-Gm-Message-State: APjAAAVrDmzzHgoaGrSlA2EN3ppxqKDSsCAyBOSD5CLUl7w9oFpaIWO3
        Hx+uqqHs1vb98ltoQ9XSJx3nTNIL
X-Google-Smtp-Source: APXvYqxuuk3YX2+/JTKaJfSeUJdU8WZ7OM8Mrs5BNA//46ielcz0C+Jv6pkTRMjqIJBZeoX3u9k3wA==
X-Received: by 2002:a19:6d1b:: with SMTP id i27mr1097479lfc.156.1555534497576;
        Wed, 17 Apr 2019 13:54:57 -0700 (PDT)
Received: from myhost.home (bfw35.neoplus.adsl.tpnet.pl. [83.28.60.35])
        by smtp.gmail.com with ESMTPSA id z206sm4342lfa.53.2019.04.17.13.54.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 13:54:56 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, dtor@google.com, linux@roeck-us.net,
        jacek.anaszewski@gmail.com, Baolin Wang <baolin.wang@linaro.org>,
        Dan Murphy <dmurphy@ti.com>, Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
Subject: [PATCH v4 03/26] dt-bindings: leds: Add LED_FUNCTION definitions
Date:   Wed, 17 Apr 2019 22:54:16 +0200
Message-Id: <20190417205439.17685-4-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial set of common LED function definitions.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Dan Murphy <dmurphy@ti.com>
Cc: Daniel Mack <daniel@zonque.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Oleh Kravchenko <oleg@kaa.org.ua>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Simon Shields <simon@lineageos.org>
---
 include/dt-bindings/leds/common.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
index e171d0a6beb2..da0539490cea 100644
--- a/include/dt-bindings/leds/common.h
+++ b/include/dt-bindings/leds/common.h
@@ -19,4 +19,41 @@
 #define LEDS_BOOST_ADAPTIVE	1
 #define LEDS_BOOST_FIXED	2
 
+/* Standard LED functions */
+#define LED_FUNCTION_ACTIVITY "activity"
+#define LED_FUNCTION_ALARM "alarm"
+#define LED_FUNCTION_BACKLIGHT "backlight"
+#define LED_FUNCTION_BLUETOOTH "bluetooth"
+#define LED_FUNCTION_BOOT "boot"
+#define LED_FUNCTION_CHARGE "charge"
+#define LED_FUNCTION_DEBUG "debug"
+#define LED_FUNCTION_DISK "disk"
+#define LED_FUNCTION_DISK_ERR "disk-err"
+#define LED_FUNCTION_DISK_READ "disk-read"
+#define LED_FUNCTION_DISK_WRITE "disk-write"
+#define LED_FUNCTION_FAULT "fault"
+#define LED_FUNCTION_FLASH "flash"
+#define LED_FUNCTION_HEARTBEAT "heartbeat"
+#define LED_FUNCTION_INDICATOR "indicator"
+#define LED_FUNCTION_KBD_BACKLIGHT "kbd_backlight"
+#define LED_FUNCTION_KEYBOARD "keyboard"
+#define LED_FUNCTION_KEYPAD "keypad"
+#define LED_FUNCTION_LAN "lan"
+#define LED_FUNCTION_MMC "mmc"
+#define LED_FUNCTION_NAND "nand"
+#define LED_FUNCTION_ON "on"
+#define LED_FUNCTION_PROGRAMMING "programming"
+#define LED_FUNCTION_POWER "power"
+#define LED_FUNCTION_RX "rx"
+#define LED_FUNCTION_SD "sd"
+#define LED_FUNCTION_STANDBY "standby"
+#define LED_FUNCTION_STATUS "status"
+#define LED_FUNCTION_TORCH "torch"
+#define LED_FUNCTION_TV "tv"
+#define LED_FUNCTION_TX "tx"
+#define LED_FUNCTION_USB "usb"
+#define LED_FUNCTION_WAN "wan"
+#define LED_FUNCTION_WLAN "wlan"
+#define LED_FUNCTION_WPS "wps"
+
 #endif /* __DT_BINDINGS_LEDS_H */
-- 
2.11.0

