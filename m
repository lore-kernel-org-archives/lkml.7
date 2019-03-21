Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07B9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2846218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZhSs7/MT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfCUWNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:13:51 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55132 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfCUWNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:13:50 -0400
Received: by mail-it1-f196.google.com with SMTP id w18so706665itj.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 15:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NUWsnACMDkvaSnvBUp2t3uShuUsUTF8b8h50BINNBME=;
        b=ZhSs7/MTZ5wE2cTNqb6zvjI1beycJbcIIVFnpe1CcbwIl9YhgYNY9cE485CHDO/p3F
         xy9RMjUm+v2xbks77ela4DZ92iTFEG7p37D0UbEnotCzwL0qRY6u+X+Mbc2HQs3SNkU1
         ar0WHNRY1FyiycRgl7n84Z4reHRdzXc4Qp4s0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NUWsnACMDkvaSnvBUp2t3uShuUsUTF8b8h50BINNBME=;
        b=UihUrY5vPxICJ2Zwbr0nWwxJ+aaOLhLIDeomiUH7+0ZvDUSbMebJVJV4giCXxWKS1h
         9QJI/xFyqmnZ0+DITp9mqjGcsYo+5rpXtB9KQ8xc2yfVthzmFGZeXl4VIZJ3olo9Mecy
         D39T1bVtvvrwumv3dXQozocopRl+VslNNGfjv2J8yBn/0SMAeodiVDhk7l1uqVJufac6
         hB1H3BXPFVYfO/kTNPksxCIAeHk2Rr4igGz3xyykVOdevemWiEP+VSw13Bl4zbgqB+YW
         OGEWZGl/mUHLJIBe50n6oZLkj9hNhnRcm6HSeNH/iONAJptkOGIRdaK/qnmOEgYjax2m
         0YtA==
X-Gm-Message-State: APjAAAUYLff0DhiA8wlkECoGq95DWmByIsVNvoDUvgNirH0ttdDHF6L7
        /t4ymTh+s7jUKTYGsMxV1I2l+Q==
X-Google-Smtp-Source: APXvYqzJOQlHrHF8Ucd6Fab8j3RWrl5S4m1/L28IWZ0RMxkmaenn8JnFShCMOn6b3OQ+H2X6Y2u1Dg==
X-Received: by 2002:a24:908:: with SMTP id 8mr559261itm.155.1553206429758;
        Thu, 21 Mar 2019 15:13:49 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:8140:8e3f:aea5:bcdf])
        by smtp.gmail.com with ESMTPSA id o129sm582093ito.0.2019.03.21.15.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 15:13:49 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        linux-leds@vger.kernel.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org, sjg@google.com,
        groeck@google.com, dtor@google.com,
        Nick Crews <ncrews@chromium.org>
Subject: [PATCH 1/3] platform/chrome: wilco_ec: Split core and mailbox into separate modules
Date:   Thu, 21 Mar 2019 16:13:32 -0600
Message-Id: <20190321221334.240059-1-ncrews@chromium.org>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was bad design to lump the mailbox interface to the Wilco EC into the
same module as the code module, which loads all the subdrivers:
- This required the sub-drivers to depend on the core, which doesn't
really make sense, they should just depend on the mailbox interface.
- It caused problems with circular dependencies: An upcoming keyboard
backlight driver depends on the mailbox interface, which in the old
architecture makes it also depend on the core driver. However, the core
driver should be able to detect whether or not the keyboard
backlight is available, so the core module depends on the backlight
driver. This created a circular dependency.

By splitting up the mailbox interface and core driver into separate
modules, it fixes both of these problems.

Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 drivers/platform/chrome/wilco_ec/Makefile  | 6 ++++--
 drivers/platform/chrome/wilco_ec/core.c    | 2 +-
 drivers/platform/chrome/wilco_ec/mailbox.c | 6 ++++++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/wilco_ec/Makefile b/drivers/platform/chrome/wilco_ec/Makefile
index 063e7fb4ea17..9706aeb20ccb 100644
--- a/drivers/platform/chrome/wilco_ec/Makefile
+++ b/drivers/platform/chrome/wilco_ec/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
-wilco_ec-objs				:= core.o mailbox.o
-obj-$(CONFIG_WILCO_EC)			+= wilco_ec.o
+wilco_ec_mailbox-objs			:= mailbox.o
+obj-$(CONFIG_WILCO_EC)			+= wilco_ec_mailbox.o
+wilco_ec_core-objs			:= core.o
+obj-$(CONFIG_WILCO_EC)			+= wilco_ec_core.o
 wilco_ec_debugfs-objs			:= debugfs.o
 obj-$(CONFIG_WILCO_EC_DEBUGFS)		+= wilco_ec_debugfs.o
diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
index 05e1e2be1c91..ece30874f35f 100644
--- a/drivers/platform/chrome/wilco_ec/core.c
+++ b/drivers/platform/chrome/wilco_ec/core.c
@@ -20,7 +20,7 @@
 
 #include "../cros_ec_lpc_mec.h"
 
-#define DRV_NAME "wilco-ec"
+#define DRV_NAME "wilco-ec-core"
 
 static struct resource *wilco_get_resource(struct platform_device *pdev,
 					   int index)
diff --git a/drivers/platform/chrome/wilco_ec/mailbox.c b/drivers/platform/chrome/wilco_ec/mailbox.c
index 14355668ddfa..ca6b92ce7e6d 100644
--- a/drivers/platform/chrome/wilco_ec/mailbox.c
+++ b/drivers/platform/chrome/wilco_ec/mailbox.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/io.h>
+#include <linux/module.h>
 #include <linux/platform_data/wilco-ec.h>
 #include <linux/platform_device.h>
 
@@ -235,3 +236,8 @@ int wilco_ec_mailbox(struct wilco_ec_device *ec, struct wilco_ec_message *msg)
 
 }
 EXPORT_SYMBOL_GPL(wilco_ec_mailbox);
+
+MODULE_AUTHOR("Nick Crews <ncrews@chromium.org>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("ChromeOS Wilco Embedded Controller mailbox interface");
+MODULE_ALIAS("platform:wilco-ec-mailbox");
-- 
2.20.1

