Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DD4C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8017B20835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9nfmrx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392191AbfDXR6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:58:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37576 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388525AbfDXR62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:58:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id 8so9707655pfr.4;
        Wed, 24 Apr 2019 10:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=/xDhSicF8xawoGp/6Nqhl26HBrv+qJ+TJrCqTKo/J4M=;
        b=B9nfmrx7RcEBmUBfjhefWEKnT7QLO7+X838eLVdOfaR6AxrAJTl1YhlxkwW5DYr27m
         D0V1QGMF5W4Sow3axB3Swc06JxxEh7Kk9YD6QXSKhy+LuiKVdvwuuq2Rb3J+MUvCuj1x
         KEHV5cDRWteAWbFB4g8fqMutwySFvF7BNh6FsbPCGYAlCCtFPXUqhCXS86+RaYa3KwWC
         viWAylt6He9V1ZA6fmBE6lACwUw3HnZjFsn4UBW0UMew26OIMyqjtQjdqf/gjQf6WsIz
         6TyPhHtEQs/n9AxiOz6TRki1SndiLCOwpRTt7iEKLAjCHp8enp2wliwSYlbKLpqK4Vny
         3qyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=/xDhSicF8xawoGp/6Nqhl26HBrv+qJ+TJrCqTKo/J4M=;
        b=PEdVcjgOodFgFYv2tscJq8tJX1PsyNqgOh6MAFUQEojWWKUbFK9lN/g6Y7O4p6Ho+M
         cydYrmrH6Dmf2x7mVPLq746jVFNpBqR/x589WwBPpSOcQ5UWtGpxSke6kyWDOqtlcbYU
         wfTmqvungVOF/JExJk95SQwh43wDh5UuBX11YYKy1e7Nl0JSQIRaiWGn/UhRAAv1jznU
         fp4tqhMremIYQVXMPao9mvDWBH5U/Nlmr9uTLIiCmGjD12VHNCcg6RSTn17+nvEVIAcu
         VNY0Bla4I3nABoQ2Jt18z8YiuRrEtzfBZ3KKXsNnhVy7ecpDb9cMghxQMK/dMKwjPlic
         2KsA==
X-Gm-Message-State: APjAAAXgPDYbMF0txKmFGpLkuhRUJqCOJC5sJyQ+82QCVJLZLNLL3WtL
        0SpeBcIwDhodwaqSfVdI13I=
X-Google-Smtp-Source: APXvYqwkQTpbtpxW+mebTAeRrqwoJmvhZ8KE4drOCh5UtDIg4DEG5bGgSUvd7wWUTgykoEc3ABgEZw==
X-Received: by 2002:aa7:9aaa:: with SMTP id x10mr8262039pfi.225.1556128707935;
        Wed, 24 Apr 2019 10:58:27 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o9sm12735822pgh.68.2019.04.24.10.58.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 10:58:26 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] usbnet: ipheth: Simplify device detection
Date:   Wed, 24 Apr 2019 10:58:24 -0700
Message-Id: <1556128704-10831-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All Apple products use the same protocol for tethering over USB.
To simplify the code and make it future proof, use
USB_VENDOR_AND_INTERFACE_INFO() instead of
USB_DEVICE_AND_INTERFACE_INFO() to automatically detect and support
all existing and future Apple products using the same interface.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Tested with various iPads and iPhones up to X. iPhone 6 and later
up to and including X all use product ID 0x12a8, so this patch is
not strictly required, but it does simplify the code.

 drivers/net/usb/ipheth.c | 58 +++---------------------------------------------
 1 file changed, 3 insertions(+), 55 deletions(-)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 3d8a70d3ea9b..a01a71a7e48d 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -54,17 +54,6 @@
 #include <linux/workqueue.h>
 
 #define USB_VENDOR_APPLE        0x05ac
-#define USB_PRODUCT_IPHONE      0x1290
-#define USB_PRODUCT_IPHONE_3G   0x1292
-#define USB_PRODUCT_IPHONE_3GS  0x1294
-#define USB_PRODUCT_IPHONE_4	0x1297
-#define USB_PRODUCT_IPAD 0x129a
-#define USB_PRODUCT_IPAD_2	0x12a2
-#define USB_PRODUCT_IPAD_3	0x12a6
-#define USB_PRODUCT_IPAD_MINI    0x12ab
-#define USB_PRODUCT_IPHONE_4_VZW 0x129c
-#define USB_PRODUCT_IPHONE_4S	0x12a0
-#define USB_PRODUCT_IPHONE_5	0x12a8
 
 #define IPHETH_USBINTF_CLASS    255
 #define IPHETH_USBINTF_SUBCLASS 253
@@ -88,50 +77,9 @@
 #define IPHETH_CARRIER_ON       0x04
 
 static const struct usb_device_id ipheth_table[] = {
-	{ USB_DEVICE_AND_INTERFACE_INFO(
-		USB_VENDOR_APPLE, USB_PRODUCT_IPHONE,
-		IPHETH_USBINTF_CLASS, IPHETH_USBINTF_SUBCLASS,
-		IPHETH_USBINTF_PROTO) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(
-		USB_VENDOR_APPLE, USB_PRODUCT_IPHONE_3G,
-		IPHETH_USBINTF_CLASS, IPHETH_USBINTF_SUBCLASS,
-		IPHETH_USBINTF_PROTO) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(
-		USB_VENDOR_APPLE, USB_PRODUCT_IPHONE_3GS,
-		IPHETH_USBINTF_CLASS, IPHETH_USBINTF_SUBCLASS,
-		IPHETH_USBINTF_PROTO) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(
-		USB_VENDOR_APPLE, USB_PRODUCT_IPHONE_4,
-		IPHETH_USBINTF_CLASS, IPHETH_USBINTF_SUBCLASS,
-		IPHETH_USBINTF_PROTO) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(
-		USB_VENDOR_APPLE, USB_PRODUCT_IPAD,
-		IPHETH_USBINTF_CLASS, IPHETH_USBINTF_SUBCLASS,
-		IPHETH_USBINTF_PROTO) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(
-		USB_VENDOR_APPLE, USB_PRODUCT_IPAD_2,
-		IPHETH_USBINTF_CLASS, IPHETH_USBINTF_SUBCLASS,
-		IPHETH_USBINTF_PROTO) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(
-		USB_VENDOR_APPLE, USB_PRODUCT_IPAD_3,
-		IPHETH_USBINTF_CLASS, IPHETH_USBINTF_SUBCLASS,
-		IPHETH_USBINTF_PROTO) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(
-		USB_VENDOR_APPLE, USB_PRODUCT_IPAD_MINI,
-		IPHETH_USBINTF_CLASS, IPHETH_USBINTF_SUBCLASS,
-		IPHETH_USBINTF_PROTO) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(
-		USB_VENDOR_APPLE, USB_PRODUCT_IPHONE_4_VZW,
-		IPHETH_USBINTF_CLASS, IPHETH_USBINTF_SUBCLASS,
-		IPHETH_USBINTF_PROTO) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(
-		USB_VENDOR_APPLE, USB_PRODUCT_IPHONE_4S,
-		IPHETH_USBINTF_CLASS, IPHETH_USBINTF_SUBCLASS,
-		IPHETH_USBINTF_PROTO) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(
-		USB_VENDOR_APPLE, USB_PRODUCT_IPHONE_5,
-		IPHETH_USBINTF_CLASS, IPHETH_USBINTF_SUBCLASS,
-		IPHETH_USBINTF_PROTO) },
+	{ USB_VENDOR_AND_INTERFACE_INFO(USB_VENDOR_APPLE, IPHETH_USBINTF_CLASS,
+					IPHETH_USBINTF_SUBCLASS,
+					IPHETH_USBINTF_PROTO) },
 	{ }
 };
 MODULE_DEVICE_TABLE(usb, ipheth_table);
-- 
2.7.4

