Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7625AC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4590E20656
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573240717;
	bh=YqVh++c4I01qw7lvB34jnSbqIY8dIZc2BfxZLXMqMtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tr9baFlU1Cy3VNrjYCyEQNflzsgUm1LDDiQHB1zUd5NCHvgwvj099NrNgDsKkFPa6
	 4fKwla3fyS7ww5+vae42OVZD5fcgichxyLPHTGS8YIbCJQ0aH2Uw865E/58XeC0wfH
	 k5jLpW68Iqr+LQww/42uX8VhLCKrSwk1cax91QCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731936AbfKHTSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:18:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:57240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389589AbfKHTAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:00:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 227F0224D7;
        Fri,  8 Nov 2019 18:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239542;
        bh=YqVh++c4I01qw7lvB34jnSbqIY8dIZc2BfxZLXMqMtI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kM9PC2j1W1Hv6oTOB7bXR8dfoPTqvsFxVf2ohDDi6kyi1i7/dMxqgAPxXQ8cQ4yHl
         SWIT+R4AclkWi//nqFvy4tig7eE4aUMy8R5VUNKlHIs6witcU3pkmEeRBR7u7/7Anr
         Rt+43diQjl523+IVuvR/EGObtIV3cI4N9mjY04xg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kazutoshi Noguchi <noguchi.kazutosi@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 39/62] r8152: add device id for Lenovo ThinkPad USB-C Dock Gen 2
Date:   Fri,  8 Nov 2019 19:50:27 +0100
Message-Id: <20191108174747.994853885@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174719.228826381@linuxfoundation.org>
References: <20191108174719.228826381@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kazutoshi Noguchi <noguchi.kazutosi@gmail.com>

[ Upstream commit b3060531979422d5bb18d80226f978910284dc70 ]

This device is sold as 'ThinkPad USB-C Dock Gen 2 (40AS)'.
Chipset is RTL8153 and works with r8152.
Without this, the generic cdc_ether grabs the device, and the device jam
connected networks up when the machine suspends.

Signed-off-by: Kazutoshi Noguchi <noguchi.kazutosi@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/cdc_ether.c |    7 +++++++
 drivers/net/usb/r8152.c     |    1 +
 2 files changed, 8 insertions(+)

--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -800,6 +800,13 @@ static const struct usb_device_id	produc
 	.driver_info = 0,
 },
 
+/* ThinkPad USB-C Dock Gen 2 (based on Realtek RTL8153) */
+{
+	USB_DEVICE_AND_INTERFACE_INFO(LENOVO_VENDOR_ID, 0xa387, USB_CLASS_COMM,
+			USB_CDC_SUBCLASS_ETHERNET, USB_CDC_PROTO_NONE),
+	.driver_info = 0,
+},
+
 /* NVIDIA Tegra USB 3.0 Ethernet Adapters (based on Realtek RTL8153) */
 {
 	USB_DEVICE_AND_INTERFACE_INFO(NVIDIA_VENDOR_ID, 0x09ff, USB_CLASS_COMM,
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -5324,6 +5324,7 @@ static const struct usb_device_id rtl815
 	{REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x7205)},
 	{REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x720c)},
 	{REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x7214)},
+	{REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0xa387)},
 	{REALTEK_USB_DEVICE(VENDOR_ID_LINKSYS, 0x0041)},
 	{REALTEK_USB_DEVICE(VENDOR_ID_NVIDIA,  0x09ff)},
 	{REALTEK_USB_DEVICE(VENDOR_ID_TPLINK,  0x0601)},


