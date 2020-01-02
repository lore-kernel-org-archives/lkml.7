Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1FEC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC4022314
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578005979;
	bh=IfML4e4Pge9lYgrZC+B6wORjvCiP6UI5i+2DhqWoIgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vHVh1F/iD4QJMLJoVT6xxgU5DnEJDQzs/v84oSpmCEeH/DrqL7Jrv4NtHKJw0IfOp
	 5iYzFLrQrEUGyqySrBVMJPbz45AziT1ys1tUq7tXmuYCOg9StQ1zQrr9el/+qYuKWV
	 Y4uBP8WnM8DQ5oNgIgJhXJ5DhJS9mZDzyoKczcSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgABWN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:13:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:53964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbgABWNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:13:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F12DE21D7D;
        Thu,  2 Jan 2020 22:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003232;
        bh=IfML4e4Pge9lYgrZC+B6wORjvCiP6UI5i+2DhqWoIgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dp8G+Jf0c/YKYa15bCxvc2jJAkr5UgGL6G/qP/IEsspk24ll6A6+ulhc241sI4aw1
         Xh+ByK6GxagBSZSKFKMyuM621vJxsBiL8fg84fTLKghBpc1+eD1O44kt1OTMo1Kaph
         8rXtesQWqfYZpaoZmxHpE7FvYzVFyXKn/KtkLG9I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jinke Fan <fanjinke@hygon.cn>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 075/191] HID: quirks: Add quirk for HP MSU1465 PIXART OEM mouse
Date:   Thu,  2 Jan 2020 23:05:57 +0100
Message-Id: <20200102215837.978064481@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102215829.911231638@linuxfoundation.org>
References: <20200102215829.911231638@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinke Fan <fanjinke@hygon.cn>

[ Upstream commit f1a0094cbbe97a5f8aca7bdc64bfe43ac9dc6879 ]

The PixArt OEM mouse disconnets/reconnects every minute on
Linux. All contents of dmesg are repetitive:

[ 1465.810014] usb 1-2.2: USB disconnect, device number 20
[ 1467.431509] usb 1-2.2: new low-speed USB device number 21 using xhci_hcd
[ 1467.654982] usb 1-2.2: New USB device found, idVendor=03f0,idProduct=1f4a, bcdDevice= 1.00
[ 1467.654985] usb 1-2.2: New USB device strings: Mfr=1, Product=2,SerialNumber=0
[ 1467.654987] usb 1-2.2: Product: HP USB Optical Mouse
[ 1467.654988] usb 1-2.2: Manufacturer: PixArt
[ 1467.699722] input: PixArt HP USB Optical Mouse as /devices/pci0000:00/0000:00:07.1/0000:05:00.3/usb1/1-2/1-2.2/1-2.2:1.0/0003:03F0:1F4A.0012/input/input19
[ 1467.700124] hid-generic 0003:03F0:1F4A.0012: input,hidraw0: USB HID v1.11 Mouse [PixArt HP USB Optical Mouse] on usb-0000:05:00.3-2.2/input0

So add HID_QUIRK_ALWAYS_POLL for this one as well.
Test the patch, the mouse is no longer disconnected and there are no
duplicate logs in dmesg.

Reference:
https://github.com/sriemer/fix-linux-mouse

Signed-off-by: Jinke Fan <fanjinke@hygon.cn>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h    | 1 +
 drivers/hid/hid-quirks.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 447e8db21174..00904537e17c 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -573,6 +573,7 @@
 #define USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_094A	0x094a
 #define USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_0941	0x0941
 #define USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_0641	0x0641
+#define USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_1f4a	0x1f4a
 
 #define USB_VENDOR_ID_HUION		0x256c
 #define USB_DEVICE_ID_HUION_TABLET	0x006e
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index c50bcd967d99..9a35af1e2662 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -94,6 +94,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_094A), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_0941), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_0641), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_1f4a), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_IDEACOM, USB_DEVICE_ID_IDEACOM_IDC6680), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_INNOMEDIA, USB_DEVICE_ID_INNEX_GENESIS_ATARI), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_EASYPEN_M610X), HID_QUIRK_MULTI_INPUT },
-- 
2.20.1



