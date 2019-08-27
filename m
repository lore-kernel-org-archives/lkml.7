Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD163C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E138206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbfH0MsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:48:14 -0400
Received: from ml01.weidahitech.com ([61.222.87.235]:2740 "EHLO
        ml01.weidahitech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfH0MsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:48:14 -0400
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Aug 2019 08:48:13 EDT
Received: from mail02.WHT.local (mail02.wht.local [192.168.10.16])
        by ml01.weidahitech.com (8.13.8/8.13.8) with ESMTP id x7RCduGf024010;
        Tue, 27 Aug 2019 20:39:56 +0800
Received: from x-Veriton-M4620G.WHT.local (192.168.10.88) by MAIL02.WHT.local
 (192.168.10.16) with Microsoft SMTP Server id 14.2.347.0; Tue, 27 Aug 2019
 20:39:58 +0800
From:   <hn.chen@weidahitech.com>
To:     <linux-input@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <dmitry.torokhov@gmail.com>,
        <hn.chen@weidahitech.com>
Subject: [PATCH] Input: modify quirks of i2c-hid driver for weida's devices
Date:   Tue, 27 Aug 2019 20:47:16 +0800
Message-ID: <1566910036-10516-1-git-send-email-hn.chen@weidahitech.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: HungNien Chen <hn.chen@weidahitech.com>

This 'SET_PWR_WAKEUP_DEV' quirk only works for weida's devices with pid
0xC300 & 0xC301. Some weida's devices with other pids also need this quirk
now. Use 'HID_ANY_ID' instead of 0xC300 to make all of weida's devices can be
fixed on the power on issue. This modification should be safe since devices
without power on issue will send the power on command only once.

Signed-off-by: HungNien Chen <hn.chen@weidahitech.com>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 90164fe..2a7c6e3 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -169,9 +169,7 @@ struct i2c_hid {
 	__u16 idProduct;
 	__u32 quirks;
 } i2c_hid_quirks[] = {
-	{ USB_VENDOR_ID_WEIDA, USB_DEVICE_ID_WEIDA_8752,
-		I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV },
-	{ USB_VENDOR_ID_WEIDA, USB_DEVICE_ID_WEIDA_8755,
+	{ USB_VENDOR_ID_WEIDA, HID_ANY_ID,
 		I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV },
 	{ I2C_VENDOR_ID_HANTICK, I2C_PRODUCT_ID_HANTICK_5288,
 		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET |
-- 
1.9.1

