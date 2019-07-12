Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69945C742BB
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348592080A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562935290;
	bh=S8OJE4dmMOXk0Hedyoghw3G15wcBYwwVaW9O18Idrg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jpxEFT7jTYVYKdDjV+1ld9YPuhjrzFxhY+NEF4/to4hdxnokSEumKjxmAVACVI/5N
	 L9pdYzzEND65FUAeUGFPvKTQH/fE2Sfm+nRAfwDnBUP5KP0MrOUzwCphNqrRb5Lw6D
	 hwxBbySadDIxm8m/taSICKbnpof7bKVbF8KLkmNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbfGLMYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:24:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbfGLMX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:23:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E2862166E;
        Fri, 12 Jul 2019 12:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934236;
        bh=S8OJE4dmMOXk0Hedyoghw3G15wcBYwwVaW9O18Idrg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rj90+PlYO68Te+W4/2rO0Uf6yTw9Evyq+T3yj0xz54fNpuwx2mR2pakLCOvtaSFI2
         pzqjBZsnfShsqv1rPGmzC3hGQ6CC0RSfeEoFHQ7eVs7LXGyOOIt17TgBYD2gyz/iFG
         dc3doFfiOmfCZ9TIMvxpBt3MXvlEq9YTivK4QK7E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sebastian Parschauer <s.parschauer@gmx.de>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.19 80/91] HID: Add another Primax PIXART OEM mouse quirk
Date:   Fri, 12 Jul 2019 14:19:23 +0200
Message-Id: <20190712121626.083727374@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121621.422224300@linuxfoundation.org>
References: <20190712121621.422224300@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Parschauer <s.parschauer@gmx.de>

commit 4c12954965fdf33d8ae3883c1931fc29ca023cfb upstream.

The PixArt OEM mice are known for disconnecting every minute in
runlevel 1 or 3 if they are not always polled. So add quirk
ALWAYS_POLL for this Alienware branded Primax mouse as well.

Daniel Schepler (@dschepler) reported and tested the quirk.
Reference: https://github.com/sriemer/fix-linux-mouse/issues/15

Signed-off-by: Sebastian Parschauer <s.parschauer@gmx.de>
CC: stable@vger.kernel.org
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-ids.h    |    1 +
 drivers/hid/hid-quirks.c |    1 +
 2 files changed, 2 insertions(+)

--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1212,6 +1212,7 @@
 #define USB_DEVICE_ID_PRIMAX_KEYBOARD	0x4e05
 #define USB_DEVICE_ID_PRIMAX_REZEL	0x4e72
 #define USB_DEVICE_ID_PRIMAX_PIXART_MOUSE_4D0F	0x4d0f
+#define USB_DEVICE_ID_PRIMAX_PIXART_MOUSE_4D65	0x4d65
 #define USB_DEVICE_ID_PRIMAX_PIXART_MOUSE_4E22	0x4e22
 
 
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -131,6 +131,7 @@ static const struct hid_device_id hid_qu
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_USB_OPTICAL_MOUSE), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_MOUSE_4D22), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_PIXART_MOUSE_4D0F), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_PIXART_MOUSE_4D65), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_PIXART_MOUSE_4E22), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PRODIGE, USB_DEVICE_ID_PRODIGE_CORDLESS), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3001), HID_QUIRK_NOGET },


