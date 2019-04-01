Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A18C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EDB121929
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138609;
	bh=89a0K0uxiqHAsv3pc9WD2GQyBnCslsKIW2O7fSpYCrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RWaz+GYmj9oSHChI6xMLLLf3rhZuBjS/VdHEVXLCUbSdKP3X0F+gC8BFoUtOJbQuJ
	 czNMWe/X2x8Kofa7tN1BR2qAKKUE3sZCxX/1ZOIJN3+xv5B5WZrfxWx2YvBaNg0m+y
	 FsAB2rzyOSMhW0p3pJANVHFQ3FVF/SrGa+vODpyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfDARKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:10:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729121AbfDARKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:10:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5A7A206B8;
        Mon,  1 Apr 2019 17:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138605;
        bh=89a0K0uxiqHAsv3pc9WD2GQyBnCslsKIW2O7fSpYCrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ku9GgZlkHVpjN7QtBVJCWC7XX58tF7urJYXBLZX3sL7k3WHvkQMyFhUZzV0oLiD0+
         +Dn26ZG4dt2C4NUyu5lHdVR48zqC1vjJ2tDtp1pcINAdciiRzuWKXAsNKqXZh6rxxO
         8lNyGyJq2osK3EeqxOZyb+1/31ZpEwC2eCSPwVI0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5.0 114/146] usb: mtu3: fix EXTCON dependency
Date:   Mon,  1 Apr 2019 19:02:06 +0200
Message-Id: <20190401170058.109012069@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

commit 3d54d10c6afed34fd45b852bf76f55e8da31d8ef upstream.

When EXTCON is a loadable module, mtu3 fails to link as built-in:

drivers/usb/mtu3/mtu3_plat.o: In function `mtu3_probe':
mtu3_plat.c:(.text+0x690): undefined reference to `extcon_get_edev_by_phandle'

Add a Kconfig dependency to force mtu3 also to be a loadable module
if extconn is, but still allow it to be built without extcon.

Fixes: d0ed062a8b75 ("usb: mtu3: dual-role mode support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/mtu3/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/mtu3/Kconfig
+++ b/drivers/usb/mtu3/Kconfig
@@ -4,6 +4,7 @@ config USB_MTU3
 	tristate "MediaTek USB3 Dual Role controller"
 	depends on USB || USB_GADGET
 	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on EXTCON || !EXTCON
 	select USB_XHCI_MTK if USB_SUPPORT && USB_XHCI_HCD
 	help
 	  Say Y or M here if your system runs on MediaTek SoCs with


