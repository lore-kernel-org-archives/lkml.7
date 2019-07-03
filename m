Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FCCC5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCECA2187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfGCHNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 03:13:23 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:53762 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfGCHNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 03:13:23 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x637DKYn012691, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x637DKYn012691
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 3 Jul 2019 15:13:21 +0800
Received: from fc30.localdomain (172.21.177.138) by RTITCASV01.realtek.com.tw
 (172.21.6.18) with Microsoft SMTP Server id 14.3.439.0; Wed, 3 Jul 2019
 15:13:19 +0800
From:   Hayes Wang <hayeswang@realtek.com>
To:     <netdev@vger.kernel.org>
CC:     <nic_swsd@realtek.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, Hayes Wang <hayeswang@realtek.com>
Subject: [PATCH net] r8152: move calling r8153b_rx_agg_chg_indicate()
Date:   Wed, 3 Jul 2019 15:11:56 +0800
Message-ID: <1394712342-15778-287-albertk@realtek.com>
X-Mailer: Microsoft Office Outlook 11
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.177.138]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

r8153b_rx_agg_chg_indicate() needs to be called after enabling TX/RX and
before calling rxdy_gated_en(tp, false). Otherwise, the change of the
settings of RX aggregation wouldn't work.

Besides, adjust rtl8152_set_coalesce() for the same reason. If
rx_coalesce_usecs is changed, restart TX/RX to let the setting work.

Signed-off-by: Hayes Wang <hayeswang@realtek.com>
---
 drivers/net/usb/r8152.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 101d1325f3f1..e887ac86fbef 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -2367,6 +2367,12 @@ static int rtl_stop_rx(struct r8152 *tp)
 	return 0;
 }
 
+static inline void r8153b_rx_agg_chg_indicate(struct r8152 *tp)
+{
+	ocp_write_byte(tp, MCU_TYPE_USB, USB_UPT_RXDMA_OWN,
+		       OWN_UPDATE | OWN_CLEAR);
+}
+
 static int rtl_enable(struct r8152 *tp)
 {
 	u32 ocp_data;
@@ -2377,6 +2383,15 @@ static int rtl_enable(struct r8152 *tp)
 	ocp_data |= CR_RE | CR_TE;
 	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CR, ocp_data);
 
+	switch (tp->version) {
+	case RTL_VER_08:
+	case RTL_VER_09:
+		r8153b_rx_agg_chg_indicate(tp);
+		break;
+	default:
+		break;
+	}
+
 	rxdy_gated_en(tp, false);
 
 	return 0;
@@ -2393,12 +2408,6 @@ static int rtl8152_enable(struct r8152 *tp)
 	return rtl_enable(tp);
 }
 
-static inline void r8153b_rx_agg_chg_indicate(struct r8152 *tp)
-{
-	ocp_write_byte(tp, MCU_TYPE_USB, USB_UPT_RXDMA_OWN,
-		       OWN_UPDATE | OWN_CLEAR);
-}
-
 static void r8153_set_rx_early_timeout(struct r8152 *tp)
 {
 	u32 ocp_data = tp->coalesce / 8;
@@ -2421,7 +2430,6 @@ static void r8153_set_rx_early_timeout(struct r8152 *tp)
 			       128 / 8);
 		ocp_write_word(tp, MCU_TYPE_USB, USB_RX_EXTRA_AGGR_TMR,
 			       ocp_data);
-		r8153b_rx_agg_chg_indicate(tp);
 		break;
 
 	default:
@@ -2445,7 +2453,6 @@ static void r8153_set_rx_early_size(struct r8152 *tp)
 	case RTL_VER_09:
 		ocp_write_word(tp, MCU_TYPE_USB, USB_RX_EARLY_SIZE,
 			       ocp_data / 8);
-		r8153b_rx_agg_chg_indicate(tp);
 		break;
 	default:
 		WARN_ON_ONCE(1);
@@ -4919,8 +4926,17 @@ static int rtl8152_set_coalesce(struct net_device *netdev,
 	if (tp->coalesce != coalesce->rx_coalesce_usecs) {
 		tp->coalesce = coalesce->rx_coalesce_usecs;
 
-		if (netif_running(tp->netdev) && netif_carrier_ok(netdev))
-			r8153_set_rx_early_timeout(tp);
+		if (netif_running(netdev) && netif_carrier_ok(netdev)) {
+			netif_stop_queue(netdev);
+			napi_disable(&tp->napi);
+			tp->rtl_ops.disable(tp);
+			tp->rtl_ops.enable(tp);
+			rtl_start_rx(tp);
+			clear_bit(RTL8152_SET_RX_MODE, &tp->flags);
+			_rtl8152_set_rx_mode(netdev);
+			napi_enable(&tp->napi);
+			netif_wake_queue(netdev);
+		}
 	}
 
 	mutex_unlock(&tp->control);
-- 
2.21.0

