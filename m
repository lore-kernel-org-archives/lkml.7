Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60893C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34552249CF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559640784;
	bh=fv30zCd+ya4eAbJ4qBlKi6F+W7utOftCbI5ndSkbhZo=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=WsyH81CMyvJCOusFI55YvuxgmXg1mk8bmfE34nvQhV2wJYzyJQNepel4ls7QhbrXo
	 mwccoRnBHA3SydW+tbdZpQUmaXMqre0KJ320S+ELpCY/ZL/IEkzxddSdGTmh0tqwzb
	 oj6tImskiKRs2yJtp4WBBl2zsN8Fo3m3X5/lWXoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbfFDJdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 05:33:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbfFDJdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 05:33:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDA46249CF;
        Tue,  4 Jun 2019 09:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559640780;
        bh=fv30zCd+ya4eAbJ4qBlKi6F+W7utOftCbI5ndSkbhZo=;
        h=Date:From:To:Cc:Subject:From;
        b=opKQBg1EmjmuiDNAy8aOnEBCvJP3Ac5iFVNmMiAYHI80Eiwt8JcsTxSJtKzOpmazr
         kIh/7ratqm4vMuGT7y34esEVCWWub0gyxE03Q0QLX0ZY0agYtaWXFjboWzPdQY9SeD
         P75Ocf07Mw2YSeXlHqhoW0TUmwyAqqREHqZNluLE=
Date:   Tue, 4 Jun 2019 11:32:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] USB: move usb debugfs directory creation to the usb common
 core
Message-ID: <20190604093258.GB30054@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB gadget subsystem wants to use the USB debugfs root directory, so
move it to the common "core" USB code so that it is properly initialized
and removed as needed.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---

This should be the "correct" version of this, Chunfeng, can you test
this to verify it works for you?


diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index 18f5dcf58b0d..3b5e4263ffef 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -15,6 +15,7 @@
 #include <linux/usb/of.h>
 #include <linux/usb/otg.h>
 #include <linux/of_platform.h>
+#include <linux/debugfs.h>
 
 static const char *const ep_type_names[] = {
 	[USB_ENDPOINT_XFER_CONTROL] = "ctrl",
@@ -291,4 +292,21 @@ struct device *usb_of_get_companion_dev(struct device *dev)
 EXPORT_SYMBOL_GPL(usb_of_get_companion_dev);
 #endif
 
+struct dentry *usb_debug_root;
+EXPORT_SYMBOL_GPL(usb_debug_root);
+
+static int usb_common_init(void)
+{
+	usb_debug_root = debugfs_create_dir("usb", NULL);
+	return 0;
+}
+
+static void usb_common_exit(void)
+{
+	debugfs_remove_recursive(usb_debug_root);
+}
+
+module_init(usb_common_init);
+module_exit(usb_common_exit);
+
 MODULE_LICENSE("GPL");
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 7fcb9f782931..f3d6b1ab80cb 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -1185,19 +1185,17 @@ static struct notifier_block usb_bus_nb = {
 	.notifier_call = usb_bus_notify,
 };
 
-struct dentry *usb_debug_root;
-EXPORT_SYMBOL_GPL(usb_debug_root);
+static struct dentry *usb_devices_root;
 
 static void usb_debugfs_init(void)
 {
-	usb_debug_root = debugfs_create_dir("usb", NULL);
-	debugfs_create_file("devices", 0444, usb_debug_root, NULL,
-			    &usbfs_devices_fops);
+	usb_devices_root = debugfs_create_file("devices", 0444, usb_debug_root,
+					       NULL, &usbfs_devices_fops);
 }
 
 static void usb_debugfs_cleanup(void)
 {
-	debugfs_remove_recursive(usb_debug_root);
+	debugfs_remove_recursive(usb_devices_root);
 }
 
 /*
