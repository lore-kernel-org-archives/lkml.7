Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123CAC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 04:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F642176D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 04:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfLQELq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 23:11:46 -0500
Received: from ybironout4.netvigator.com ([210.87.250.77]:63575 "EHLO
        ybironout4.netvigator.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfLQELq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 23:11:46 -0500
X-Greylist: delayed 612 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Dec 2019 23:11:44 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0DoBgDqUvhd/5YXxstkHgELHIFzC4Igg?=
 =?us-ascii?q?UEgEhoQlTuOeoUShSiBewkBAQE7AgEBgy2BEwKCFCQ1CA4CEAEBBAEBAQIBBQR?=
 =?us-ascii?q?thGtYhVYJBidSEBgIJgtXGVuCRwGCdgavfjMaAoo3gTaHP4RZFAY/gUGBR4Ioc?=
 =?us-ascii?q?4dtgkoEl1CXMQqCNJYIAhmOZwOLXi2oZoIAATaBWIEFgVkKgURQEY0yFxWOGzQ?=
 =?us-ascii?q?zgQSRZgE?=
X-IronPort-AV: E=Sophos;i="5.69,324,1571673600"; 
   d="scan'208";a="170931205"
Received: from unknown (HELO ybironoah03.netvigator.com) ([203.198.23.150])
  by ybironout4v1.netvigator.com with ESMTP; 17 Dec 2019 12:01:29 +0800
Received: from unknown (HELO rhel76.localdomain) ([42.200.157.25])
  by ybironoah03.netvigator.com with ESMTP; 17 Dec 2019 12:01:29 +0800
From:   "Chan Shu Tak, Alex" <alexchan@task.com.hk>
Cc:     "Chan Shu Tak, Alex" <alexchan@task.com.hk>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] llc2: Remove the condition operator in llc_stat_ev_rx_null_dsap_xid_c and llc_stat_ev_rx_null_dsap_test_c.
Date:   Tue, 17 Dec 2019 12:00:36 +0800
Message-Id: <1576555237-4037-1-git-send-email-alexchan@task.com.hk>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576340820-4929-1-git-send-email-alexchan@task.com.hk>
References: <1576340820-4929-1-git-send-email-alexchan@task.com.hk>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chan Shu Tak, Alex" <alexchan@task.com.hk>

When a frame with NULL DSAP is received, llc_station_rcv is called.
In turn, llc_stat_ev_rx_null_dsap_xid_c is called to check if it is a NULL
XID frame. The original condition operator returns 1 when the incoming
frame is not a NULL XID frame and 0 otherwise. As a result, an incoming
NULL TEST frame would trigger an XID response instead.

To fix the error, we just need to remove the condition operator.

The same error is found in llc_stat_ev_rx_null_dsap_test_c and fixed.

Signed-off-by: Chan Shu Tak, Alex <alexchan@task.com.hk>
---
 net/llc/llc_station.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/llc/llc_station.c b/net/llc/llc_station.c
index 90955d7..c29170e 100644
--- a/net/llc/llc_station.c
+++ b/net/llc/llc_station.c
@@ -32,7 +32,7 @@ static int llc_stat_ev_rx_null_dsap_xid_c(struct sk_buff *skb)
 	return LLC_PDU_IS_CMD(pdu) &&			/* command PDU */
 	       LLC_PDU_TYPE_IS_U(pdu) &&		/* U type PDU */
 	       LLC_U_PDU_CMD(pdu) == LLC_1_PDU_CMD_XID &&
-	       !pdu->dsap ? 1 : 0;			/* NULL DSAP value */
+	       !pdu->dsap;				/* NULL DSAP value */
 }
 
 static int llc_stat_ev_rx_null_dsap_test_c(struct sk_buff *skb)
@@ -42,7 +42,7 @@ static int llc_stat_ev_rx_null_dsap_test_c(struct sk_buff *skb)
 	return LLC_PDU_IS_CMD(pdu) &&			/* command PDU */
 	       LLC_PDU_TYPE_IS_U(pdu) &&		/* U type PDU */
 	       LLC_U_PDU_CMD(pdu) == LLC_1_PDU_CMD_TEST &&
-	       !pdu->dsap ? 1 : 0;			/* NULL DSAP */
+	       !pdu->dsap;				/* NULL DSAP */
 }
 
 static int llc_station_ac_send_xid_r(struct sk_buff *skb)
-- 
1.8.3.1

