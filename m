Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A445C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E175F216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="hkSlPZxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbfG2WWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 18:22:06 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.38]:24212 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726327AbfG2WWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 18:22:06 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id C858F400C6447
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 17:22:05 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id sE1thiKqx2PzOsE1thoCGY; Mon, 29 Jul 2019 17:22:05 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xNIJpvv5u3a1as5uH9x/Q6ptS0OoU1xyUYc7XIdGD1I=; b=hkSlPZxF1QFiDjTINlQ8LVVtG3
        ZwijVBoTnjmrEboZPa0fv/BppGQu1M13l5+BjfUXc5E0+Rh+B0Cgd44xDafJpZX7C3XsVwzcRMqV4
        iIvPMb2Sk5OOVES07DTwZO9fs4/KowoGWBPFg+H5DaHqX1S1JaE+oyBt1dA9RUzDI7blTCneRucFO
        pRDCOnh4VNeOcPm6XKYmgh8+3Jvjz/2oagE7ujpTi2uAawJG3+Mee/1ONrfr8eo2MlTRhDeEoSFNZ
        9zi4G7WxdCqr51N87eWxrvWywMVXNDvkDKIAxZAd4VGicNGIFuqH9S131xQBNpKuc9V9CSAetBU1i
        3wHnUXyg==;
Received: from [187.192.11.120] (port=60858 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hsE1s-0021nZ-Jk; Mon, 29 Jul 2019 17:22:04 -0500
Date:   Mon, 29 Jul 2019 17:22:01 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] usb: host: ohci-tmio: Mark expected switch fall-throughs
Message-ID: <20190729222201.GA19408@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hsE1s-0021nZ-Jk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:60858
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 18
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warning (Building: arm):

drivers/usb/host/ohci-tmio.c: In function ‘tmio_stop_hc’:
./include/linux/device.h:1499:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
  _dev_err(dev, dev_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/usb/host/ohci-tmio.c:99:4: note: in expansion of macro ‘dev_err’
    dev_err(&dev->dev, "Unsupported amount of ports: %d\n", ohci->num_ports);
    ^~~~~~~
In file included from drivers/usb/host/ohci-hcd.c:1257:0:
drivers/usb/host/ohci-tmio.c:100:3: note: here
   case 3:
   ^~~~
drivers/usb/host/ohci-tmio.c:101:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
    pm |= CCR_PM_USBPW3;
       ^
drivers/usb/host/ohci-tmio.c:102:3: note: here
   case 2:
   ^~~~
drivers/usb/host/ohci-tmio.c:103:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
    pm |= CCR_PM_USBPW2;
       ^
drivers/usb/host/ohci-tmio.c:104:3: note: here
   case 1:
   ^~~~

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/usb/host/ohci-tmio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/ohci-tmio.c b/drivers/usb/host/ohci-tmio.c
index d5a293a707b6..fb6f5e9ae5c6 100644
--- a/drivers/usb/host/ohci-tmio.c
+++ b/drivers/usb/host/ohci-tmio.c
@@ -97,10 +97,13 @@ static void tmio_stop_hc(struct platform_device *dev)
 	switch (ohci->num_ports) {
 		default:
 			dev_err(&dev->dev, "Unsupported amount of ports: %d\n", ohci->num_ports);
+			/* fall through */
 		case 3:
 			pm |= CCR_PM_USBPW3;
+			/* fall through */
 		case 2:
 			pm |= CCR_PM_USBPW2;
+			/* fall through */
 		case 1:
 			pm |= CCR_PM_USBPW1;
 	}
-- 
2.22.0

