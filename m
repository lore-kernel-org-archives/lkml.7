Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7ABFC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F4620657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7KdH6+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfCJSbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:31:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33622 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfCJS3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:29:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id i8so2695059wrm.0;
        Sun, 10 Mar 2019 11:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gIZNPWwo2YMvg9dV6bXiemRQGdAdQXtMcVtJ6lRG4u4=;
        b=X7KdH6+9xH6B7MVldVH/5SLcnjRianPUsRCnEkRmRlgSJJixg5S4PGQI3NHR4wB4fl
         Rd+hK4ms42U5n0q3CJ/n4pm3oT8QdoD/uhull1gc2WICYQQ5zIS+BpkrEXYdS6ajVb5V
         oBEB3xUQwcmZq/F6/v+wpLj+I+UfVmR1ixQtBGbAECsalbnz4yf3WZKzPI+gmjeWOXsv
         Usbq/xWW1vny65dLuOLajWmDidyMn7JTZ0qk/UvxqaXqU019CSTcjEwsqaoRuuF5/kum
         aYDF9HDq9JpcG9U19DwFriX8464/yq3I25hZHtDMvfF6B+4NrSAi7WvJxLxeeOmRSdi7
         JATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gIZNPWwo2YMvg9dV6bXiemRQGdAdQXtMcVtJ6lRG4u4=;
        b=NXLriWEGLFZVzODFyMNPzSRRTyYdnszY64Y7eJq5zVWJ0G+jHFUNkNgvuEKPuAEoNg
         NS5xZtTv5Vzxr8NGerYp7/0P/WENm5V8gjrFCi49mabm1qSWWFCy72NRgzh8h9KZLjuq
         ZYo0K7kkcv0t8DSMXGmnxsMI7S2irD0HSHxZZVgRCIr3aNweUhDlHkyBPh9SE9SUaWTI
         6PdDVE1I6qHRDfXaFX0x2kF3RQ4Aw/kWb8KFJm4b2EUHkFwe7vYlihuJ74uQHmyB5nLv
         GghOplwzMme+C7RyA6Zp5uc5wrbnCKkHdA5x1cGp4uINgTaKZ8XGK64hrhh8ly6Qrixx
         Oc0Q==
X-Gm-Message-State: APjAAAUgI3y7j5uPqNNlcMmHjf/VH2bX6/pvmX2w9rjqstokqE1sG33M
        bXQLs4qxEVuyG/dn8tkgAehd1gok
X-Google-Smtp-Source: APXvYqxiOvo66yoezckkxNP3zzHAyDyWQNoVqXz9SngRCqyHBRaGgTXUoAz1vRpdXg2ipHJXM7SKyQ==
X-Received: by 2002:adf:e58f:: with SMTP id l15mr17294371wrm.309.1552242540556;
        Sun, 10 Mar 2019 11:29:00 -0700 (PDT)
Received: from myhost.home (bgt124.neoplus.adsl.tpnet.pl. [83.28.83.124])
        by smtp.gmail.com with ESMTPSA id h13sm5807469wrt.89.2019.03.10.11.28.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:29:00 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
Subject: [PATCH 03/25] dt-bindings: leds: Add LED_FUNCTION definitions
Date:   Sun, 10 Mar 2019 19:28:14 +0100
Message-Id: <20190310182836.20841-4-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
References: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add common LED function definitions for use in Device Tree.
The function names were extracted from existing dts files
after eliminating oddities.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>
Cc: Daniel Mack <daniel@zonque.org>
Cc: Dan Murphy <dmurphy@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Oleh Kravchenko <oleg@kaa.org.ua>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Simon Shields <simon@lineageos.org>
---
 include/dt-bindings/leds/common.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
index e171d0a6beb2..ffcd46317307 100644
--- a/include/dt-bindings/leds/common.h
+++ b/include/dt-bindings/leds/common.h
@@ -19,4 +19,42 @@
 #define LEDS_BOOST_ADAPTIVE	1
 #define LEDS_BOOST_FIXED	2
 
+/* Standard LED functions */
+#define LED_FUNCTION_ACTIVITY "activity"
+#define LED_FUNCTION_ADSL "adsl"
+#define LED_FUNCTION_ALARM "alarm"
+#define LED_FUNCTION_BACKLIGHT "backlight"
+#define LED_FUNCTION_BLUETOOTH "bluetooth"
+#define LED_FUNCTION_BOOT "boot"
+#define LED_FUNCTION_CHRG "chrg"
+#define LED_FUNCTION_DEBUG "debug"
+#define LED_FUNCTION_DISK "disk"
+#define LED_FUNCTION_DISK_READ "disk-read"
+#define LED_FUNCTION_DISK_WRITE "disk-write"
+#define LED_FUNCTION_FAULT "fault"
+#define LED_FUNCTION_FLASH "flash"
+#define LED_FUNCTION_HDDERR "hdderr"
+#define LED_FUNCTION_HEARTBEAT "heartbeat"
+#define LED_FUNCTION_INDICATOR "indicator"
+#define LED_FUNCTION_INFO "info"
+#define LED_FUNCTION_INTERNET "internet"
+#define LED_FUNCTION_LAN "lan"
+#define LED_FUNCTION_MMC "mmc"
+#define LED_FUNCTION_NAND "nand"
+#define LED_FUNCTION_ON "on"
+#define LED_FUNCTION_PROGRAMMING "programming"
+#define LED_FUNCTION_PWR "pwr"
+#define LED_FUNCTION_RX "rx"
+#define LED_FUNCTION_SD "sd"
+#define LED_FUNCTION_SLEEP "sleep"
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

