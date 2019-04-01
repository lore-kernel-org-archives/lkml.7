Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD15C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EDEC2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141790;
	bh=21LRm3NerPILIkkQc64ZX98BXnneWRbmWcJSeMiZr3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jx/fOCZA/+0pj+rZ7cv/xCLArFVa1MhEwY5pmO+ozhHoA7vpmeF6lpVhm46u6XvNP
	 W7Twng0KPwIaCKqoEc9G5rKYghdMVWS1HQgJDo6AybsmtncLdMalGSeP73bkmhqJMW
	 kkqdKmzYwrfXEP5tysk6KPey7xxeEvtrDa2MifL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730715AbfDAROL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:14:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730364AbfDAROB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:14:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EB6D21909;
        Mon,  1 Apr 2019 17:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138267;
        bh=21LRm3NerPILIkkQc64ZX98BXnneWRbmWcJSeMiZr3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WSTUABBrvWNJqK9TrxGOAId9qrO1BK2xLmUp339VxldRKvVDMXxE6HkY8unLct5a9
         GXLbUIuhFcgsXFu3jL1bkn9Yd9XH2eGoAsXPnorkWVJtWUi+QJVZtQxwMOU1JDe4Nu
         BBkWVnmLffTeZss6m0ModzLizOU3R73/9XHCPEi8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dmitry Bezrukov <dmitry.bezrukov@aquantia.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 017/146] net: usb: aqc111: Extend HWID table by QNAP device
Date:   Mon,  1 Apr 2019 19:00:29 +0200
Message-Id: <20190401170050.037630424@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Bezrukov <dmitry.bezrukov@aquantia.com>

[ Upstream commit b7ebee2f95fb0fa2862d5ed2de707f872c311393 ]

New device of QNAP based on aqc111u
Add this ID to blacklist of cdc_ether driver as well

Signed-off-by: Dmitry Bezrukov <dmitry.bezrukov@aquantia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/aqc111.c    |   15 +++++++++++++++
 drivers/net/usb/cdc_ether.c |    8 ++++++++
 2 files changed, 23 insertions(+)

--- a/drivers/net/usb/aqc111.c
+++ b/drivers/net/usb/aqc111.c
@@ -1301,6 +1301,20 @@ static const struct driver_info trendnet
 	.tx_fixup	= aqc111_tx_fixup,
 };
 
+static const struct driver_info qnap_info = {
+	.description	= "QNAP QNA-UC5G1T USB to 5GbE Adapter",
+	.bind		= aqc111_bind,
+	.unbind		= aqc111_unbind,
+	.status		= aqc111_status,
+	.link_reset	= aqc111_link_reset,
+	.reset		= aqc111_reset,
+	.stop		= aqc111_stop,
+	.flags		= FLAG_ETHER | FLAG_FRAMING_AX |
+			  FLAG_AVOID_UNLINK_URBS | FLAG_MULTI_PACKET,
+	.rx_fixup	= aqc111_rx_fixup,
+	.tx_fixup	= aqc111_tx_fixup,
+};
+
 static int aqc111_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct usbnet *dev = usb_get_intfdata(intf);
@@ -1455,6 +1469,7 @@ static const struct usb_device_id produc
 	{AQC111_USB_ETH_DEV(0x0b95, 0x2790, asix111_info)},
 	{AQC111_USB_ETH_DEV(0x0b95, 0x2791, asix112_info)},
 	{AQC111_USB_ETH_DEV(0x20f4, 0xe05a, trendnet_info)},
+	{AQC111_USB_ETH_DEV(0x1c04, 0x0015, qnap_info)},
 	{ },/* END */
 };
 MODULE_DEVICE_TABLE(usb, products);
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -851,6 +851,14 @@ static const struct usb_device_id	produc
 	.driver_info = 0,
 },
 
+/* QNAP QNA-UC5G1T USB to 5GbE Adapter (based on AQC111U) */
+{
+	USB_DEVICE_AND_INTERFACE_INFO(0x1c04, 0x0015, USB_CLASS_COMM,
+				      USB_CDC_SUBCLASS_ETHERNET,
+				      USB_CDC_PROTO_NONE),
+	.driver_info = 0,
+},
+
 /* WHITELIST!!!
  *
  * CDC Ether uses two interfaces, not necessarily consecutive.


