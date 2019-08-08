Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E928AC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B588C2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565291540;
	bh=c2Igk6UtaX5oNKCxUGV6GFvxDUsT6dELgHlujMAeG4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oZNRz2dyjZZZs+ztlfs/yBM2iVDHUffCaELmQIP0WEy95Q5EhJddC5r9Dcp/orQrS
	 PlnlJuFoYNP3Nr8YtZT718963w0ipz97DhQ4aiUH9LKMKtpD0tNQvzUhz9Ieb9yhca
	 xdD0C2WqynTX1K06i5E586IbEUpKRElVtWradI/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405460AbfHHTLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:11:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405084AbfHHTLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:11:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5631A21743;
        Thu,  8 Aug 2019 19:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565291475;
        bh=c2Igk6UtaX5oNKCxUGV6GFvxDUsT6dELgHlujMAeG4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BNDetbUFoQosbA3vFp5umB8L4PMmhVVRYvyuYsHojaRFsGFCbDNGA9kUFaaOmpsHt
         X+JCaxgV2cU3SkvWMtam7yzrOHOV8tJOXZziDOKALt5WLngVyDhVixoDdeST+xCImq
         6yr3zbmGtZ7hxuJnZPrGyI4ApkvxpcoHOX49efTI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sebastian Parschauer <s.parschauer@gmx.de>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.14 07/33] HID: Add quirk for HP X1200 PIXART OEM mouse
Date:   Thu,  8 Aug 2019 21:05:14 +0200
Message-Id: <20190808190453.930236428@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808190453.582417307@linuxfoundation.org>
References: <20190808190453.582417307@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Parschauer <s.parschauer@gmx.de>

commit 49869d2ea9eecc105a10724c1abf035151a3c4e2 upstream.

The PixArt OEM mice are known for disconnecting every minute in
runlevel 1 or 3 if they are not always polled. So add quirk
ALWAYS_POLL for this one as well.

Jonathan Teh (@jonathan-teh) reported and tested the quirk.
Reference: https://github.com/sriemer/fix-linux-mouse/issues/15

Signed-off-by: Sebastian Parschauer <s.parschauer@gmx.de>
CC: stable@vger.kernel.org
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/hid/hid-ids.h           |    1 +
 drivers/hid/usbhid/hid-quirks.c |    1 +
 2 files changed, 2 insertions(+)

--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -537,6 +537,7 @@
 #define USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0B4A	0x0b4a
 #define USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE		0x134a
 #define USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_094A	0x094a
+#define USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_0641	0x0641
 
 #define USB_VENDOR_ID_HUION		0x256c
 #define USB_DEVICE_ID_HUION_TABLET	0x006e
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -100,6 +100,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0B4A, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_094A, HID_QUIRK_ALWAYS_POLL },
+	{ USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_0641, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_IDEACOM, USB_DEVICE_ID_IDEACOM_IDC6680, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_C007, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_C077, HID_QUIRK_ALWAYS_POLL },


