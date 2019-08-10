Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB73CC433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 08:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11E2208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 08:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="rbBhPbLY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfHJInR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 04:43:17 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:51135 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbfHJImy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 04:42:54 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 465FvS227HzdZ;
        Sat, 10 Aug 2019 10:41:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1565426484; bh=ucy/eq5e3I+UH8thi9U0vC1tf6qDt2LerPIZ0VRyHks=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=rbBhPbLYVMMC+571D9/JZun6gMeJDKgVMXdqgLwpjeFJMqxVux34zD0kUyoX65VyM
         fEB3uZsnEAF8fdnAVqu28oE/n80iDlEGmc7mhw240EqCUmveq1TU+VhFLrbu9Q5zSY
         BB0J+Gh5MS+2h89EDfreEh/vMXOvLVFwBmCqjE7Azva7YtQd2Ycb/n3j/pF4akpicj
         bJPwtjpHSv97/TW5d6seiSB+USWuKhH7GCrT4akdJpbFaUwlWOX7QkwvuaCV3qFyGw
         Fwu5qwOJcEVAxrdyiPuTFJZ+LrvclZhqMepq8FJ/UW8en0B2r8NYeMiMLTwjFp9t9l
         Q0bfgKRLAVb9Q==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.3 at mail
Date:   Sat, 10 Aug 2019 10:42:52 +0200
Message-Id: <b0db0a00179bad410dfb51ad8e413fb0fd3e6a25.1565426370.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1565426370.git.mirq-linux@rere.qmqm.pl>
References: <cover.1565426370.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v6 6/7] usb: gadget: legacy/serial: allow dynamic removal
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     linux-usb@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Legacy serial USB gadget is still useful as an early console,
before userspace is up. Later it could be replaced with proper
configfs-configured composite gadget - that use case is enabled
by this patch.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

---
  v6: rebased on balbi/testing/next
  v5: no changes
  v4: initial revision, new in the patchset

---
 drivers/usb/gadget/legacy/serial.c | 49 +++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/legacy/serial.c b/drivers/usb/gadget/legacy/serial.c
index de30d7628eef..da44f89f5e73 100644
--- a/drivers/usb/gadget/legacy/serial.c
+++ b/drivers/usb/gadget/legacy/serial.c
@@ -97,6 +97,36 @@ static unsigned n_ports = 1;
 module_param(n_ports, uint, 0);
 MODULE_PARM_DESC(n_ports, "number of ports to create, default=1");
 
+static bool enable = true;
+
+static int switch_gserial_enable(bool do_enable);
+
+static int enable_set(const char *s, const struct kernel_param *kp)
+{
+	bool do_enable;
+	int ret;
+
+	if (!s)	/* called for no-arg enable == default */
+		return 0;
+
+	ret = strtobool(s, &do_enable);
+	if (ret || enable == do_enable)
+		return ret;
+
+	ret = switch_gserial_enable(do_enable);
+	if (!ret)
+		enable = do_enable;
+
+	return ret;
+}
+
+static const struct kernel_param_ops enable_ops = {
+	.set = enable_set,
+	.get = param_get_bool,
+};
+
+module_param_cb(enable, &enable_ops, &enable, 0644);
+
 /*-------------------------------------------------------------------------*/
 
 static struct usb_configuration serial_config_driver = {
@@ -240,6 +270,19 @@ static struct usb_composite_driver gserial_driver = {
 	.unbind		= gs_unbind,
 };
 
+static int switch_gserial_enable(bool do_enable)
+{
+	if (!serial_config_driver.label)
+		/* init() was not called, yet */
+		return 0;
+
+	if (do_enable)
+		return usb_composite_probe(&gserial_driver);
+
+	usb_composite_unregister(&gserial_driver);
+	return 0;
+}
+
 static int __init init(void)
 {
 	/* We *could* export two configs; that'd be much cleaner...
@@ -266,12 +309,16 @@ static int __init init(void)
 	}
 	strings_dev[STRING_DESCRIPTION_IDX].s = serial_config_driver.label;
 
+	if (!enable)
+		return 0;
+
 	return usb_composite_probe(&gserial_driver);
 }
 module_init(init);
 
 static void __exit cleanup(void)
 {
-	usb_composite_unregister(&gserial_driver);
+	if (enable)
+		usb_composite_unregister(&gserial_driver);
 }
 module_exit(cleanup);
-- 
2.20.1

