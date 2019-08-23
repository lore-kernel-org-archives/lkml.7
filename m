Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEFCC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86F02070B
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393273AbfHWIxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:53:32 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:40112 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393130AbfHWIxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:53:32 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x7N8rRxc020367, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x7N8rRxc020367
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 23 Aug 2019 16:53:27 +0800
Received: from fc30.localdomain (172.21.177.138) by RTITCASV01.realtek.com.tw
 (172.21.6.18) with Microsoft SMTP Server id 14.3.468.0; Fri, 23 Aug 2019
 16:53:26 +0800
From:   Hayes Wang <hayeswang@realtek.com>
To:     <netdev@vger.kernel.org>
CC:     <nic_swsd@realtek.com>, <linux-kernel@vger.kernel.org>,
        <jslaby@suse.cz>, Hayes Wang <hayeswang@realtek.com>
Subject: [PATCH net 2/2] r8152: avoid using napi_disable after netif_napi_del.
Date:   Fri, 23 Aug 2019 16:53:02 +0800
Message-ID: <1394712342-15778-316-Taiwan-albertk@realtek.com>
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <1394712342-15778-314-Taiwan-albertk@realtek.com>
References: <1394712342-15778-314-Taiwan-albertk@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.177.138]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exchange netif_napi_del() and unregister_netdev() in rtl8152_disconnect()
to avoid using napi_disable() after netif_napi_del().

Signed-off-by: Hayes Wang <hayeswang@realtek.com>
---
 drivers/net/usb/r8152.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 690a24d1ef82..29390eda5251 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -5364,8 +5364,8 @@ static void rtl8152_disconnect(struct usb_interface *intf)
 	if (tp) {
 		rtl_set_unplug(tp);
 
-		netif_napi_del(&tp->napi);
 		unregister_netdev(tp->netdev);
+		netif_napi_del(&tp->napi);
 		cancel_delayed_work_sync(&tp->hw_phy_work);
 		tp->rtl_ops.unload(tp);
 		free_netdev(tp->netdev);
-- 
2.21.0

