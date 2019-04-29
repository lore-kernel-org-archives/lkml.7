Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFE5C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D784720656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfD2OkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:40:01 -0400
Received: from gateway23.websitewelcome.com ([192.185.50.185]:11259 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728276AbfD2OkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:40:01 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 4D30319CA8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 09:40:00 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id L7RohwssLYTGML7Roh1z3J; Mon, 29 Apr 2019 09:40:00 -0500
X-Authority-Reason: nr=8
Received: from [189.250.54.97] (port=50000 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hL7Rm-000tKB-Vr; Mon, 29 Apr 2019 09:39:59 -0500
Date:   Mon, 29 Apr 2019 09:39:57 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] usbip: vhci_hcd: Mark expected switch fall-through
Message-ID: <20190429143957.GA6725@embeddedor>
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
X-Source-IP: 189.250.54.97
X-Source-L: No
X-Exim-ID: 1hL7Rm-000tKB-Vr
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.54.97]:50000
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warning:

In file included from drivers/usb/usbip/vhci_hcd.c:15:
drivers/usb/usbip/vhci_hcd.c: In function ‘vhci_hub_control’:
drivers/usb/usbip/usbip_common.h:63:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (flag & usbip_debug_flag)  \
      ^
drivers/usb/usbip/usbip_common.h:77:2: note: in expansion of macro ‘usbip_dbg_with_flag’
  usbip_dbg_with_flag(usbip_debug_vhci_rh, fmt , ##args)
  ^~~~~~~~~~~~~~~~~~~
drivers/usb/usbip/vhci_hcd.c:509:4: note: in expansion of macro ‘usbip_dbg_vhci_rh’
    usbip_dbg_vhci_rh(
    ^~~~~~~~~~~~~~~~~
drivers/usb/usbip/vhci_hcd.c:511:3: note: here
   case USB_PORT_FEAT_U2_TIMEOUT:
   ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/usb/usbip/vhci_hcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 667d9c0ec905..000ab7225717 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -508,6 +508,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 		case USB_PORT_FEAT_U1_TIMEOUT:
 			usbip_dbg_vhci_rh(
 				" SetPortFeature: USB_PORT_FEAT_U1_TIMEOUT\n");
+			/* Fall through */
 		case USB_PORT_FEAT_U2_TIMEOUT:
 			usbip_dbg_vhci_rh(
 				" SetPortFeature: USB_PORT_FEAT_U2_TIMEOUT\n");
-- 
2.21.0

