Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD5DC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3382084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388617AbfCAO2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:28:36 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:54376 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728229AbfCAO2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:28:36 -0500
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 61EB015632; Fri,  1 Mar 2019 14:28:34 +0000 (GMT)
From:   Mans Rullgard <mans@mansr.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: core: make default autosuspend delay configurable
Date:   Fri,  1 Mar 2019 14:26:46 +0000
Message-Id: <20190301142646.30831-1-mans@mansr.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the default autosuspend delay configurable at build time.
This is useful for systems that require a non-standard value as
it avoids relying on the command line being properly set.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/usb/core/Kconfig | 8 ++++++++
 drivers/usb/core/usb.c   | 4 ++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
index 4d75d9a80001..38ed837538c4 100644
--- a/drivers/usb/core/Kconfig
+++ b/drivers/usb/core/Kconfig
@@ -90,3 +90,11 @@ config USB_LEDS_TRIGGER_USBPORT
 	  This driver allows LEDs to be controlled by USB events. Enabling this
 	  trigger allows specifying list of USB ports that should turn on LED
 	  when some USB device gets connected.
+
+config USB_AUTOSUSPEND_DELAY
+	int "Default autosuspend delay"
+	depends on USB
+	default 2
+	help
+	  The default autosuspend delay in seconds.  Can be overridden
+	  with the usbcore.autosuspend command line or module parameter.
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 4ebfbd737905..52e749386c1c 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -65,8 +65,8 @@ int usb_disabled(void)
 EXPORT_SYMBOL_GPL(usb_disabled);
 
 #ifdef	CONFIG_PM
-static int usb_autosuspend_delay = 2;		/* Default delay value,
-						 * in seconds */
+/* Default delay value, in seconds */
+static int usb_autosuspend_delay = CONFIG_USB_AUTOSUSPEND_DELAY;
 module_param_named(autosuspend, usb_autosuspend_delay, int, 0644);
 MODULE_PARM_DESC(autosuspend, "default autosuspend delay");
 
-- 
2.20.1

