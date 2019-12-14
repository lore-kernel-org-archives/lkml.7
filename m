Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE501C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 16:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9A92073D
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 16:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfLNQiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 11:38:15 -0500
Received: from wbironout3b.netvigator.com ([210.87.247.19]:26687 "EHLO
        wbironout3b.netvigator.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725970AbfLNQiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 11:38:15 -0500
X-Greylist: delayed 612 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Dec 2019 11:38:14 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0B2AQBaDPVd/5YXxstlHQEBAQkBEQUFA?=
 =?us-ascii?q?YFsBgELAYIfgUEgEhoQqUSFKIF7CQEBATsCAQGDLYETghEkNgcOAhABAQQBAQE?=
 =?us-ascii?q?CAQUEbYRrWIVWNlIoCCZ7W4JHAYJ2Bq4VMxoCii+BNgGHPoRZFAY/gUGBR4Ioc?=
 =?us-ascii?q?4dtgkoEl06XLAqCNJYFAhmOZwOLXQEtqGSCBQoogViBBYFZCoFEUBGMegE3FxW?=
 =?us-ascii?q?OGzQzgQSOQAE?=
X-IronPort-AV: E=Sophos;i="5.69,314,1571673600"; 
   d="scan'208";a="166050022"
X-MGA-submission: =?us-ascii?q?MDH2+MYWhEouIgONWJx0B2GgW4V4ZZMtSpCgWZ?=
 =?us-ascii?q?A8ubt/KyG0peN16claqlItDctOXDjBJV4/jRWpexBJFV2hk3FWN/Mjun?=
 =?us-ascii?q?i0bskiibb9FLrlPFRj8stmuOl4nnrVMNti/K5Y1pndS36R6PukGNloU7?=
 =?us-ascii?q?HY?=
Received: from unknown (HELO ybironoah03.netvigator.com) ([203.198.23.150])
  by wbironout3v2.netvigator.com with ESMTP; 15 Dec 2019 00:27:58 +0800
Received: from unknown (HELO rhel76.localdomain) ([42.200.157.25])
  by ybironoah03.netvigator.com with ESMTP; 15 Dec 2019 00:27:58 +0800
From:   "Chan Shu Tak, Alex" <alexchan@task.com.hk>
Cc:     "Chan Shu Tak, Alex" <alexchan@task.com.hk>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] llc2: Reverse the true/false statements of the condition operator in llc_stat_ev_rx_null_dsap_xid_c and llc_stat_ev_rx_null_dsap_test_c.
Date:   Sun, 15 Dec 2019 00:26:58 +0800
Message-Id: <1576340820-4929-1-git-send-email-alexchan@task.com.hk>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chan Shu Tak, Alex" <alexchan@task.com.hk>

When a frame with NULL DSAP is received, llc_station_rcv is called.
In turn, llc_stat_ev_rx_null_dsap_xid_c is called to check if it is
a NULL XID frame. The original true statement returns 0 while the
false statement returns 1. As a result, an incoming NULL TEST frame
would trigger an XID response instead.

The same error is found in llc_stat_ev_rx_null_dsap_test_c and fixed.

Signed-off-by: Chan Shu Tak, Alex <alexchan@task.com.hk>
---
 net/llc/llc_station.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/llc/llc_station.c b/net/llc/llc_station.c
index 204a835..90955d7 100644
--- a/net/llc/llc_station.c
+++ b/net/llc/llc_station.c
@@ -32,7 +32,7 @@ static int llc_stat_ev_rx_null_dsap_xid_c(struct sk_buff *skb)
 	return LLC_PDU_IS_CMD(pdu) &&			/* command PDU */
 	       LLC_PDU_TYPE_IS_U(pdu) &&		/* U type PDU */
 	       LLC_U_PDU_CMD(pdu) == LLC_1_PDU_CMD_XID &&
-	       !pdu->dsap ? 0 : 1;			/* NULL DSAP value */
+	       !pdu->dsap ? 1 : 0;			/* NULL DSAP value */
 }
 
 static int llc_stat_ev_rx_null_dsap_test_c(struct sk_buff *skb)
@@ -42,7 +42,7 @@ static int llc_stat_ev_rx_null_dsap_test_c(struct sk_buff *skb)
 	return LLC_PDU_IS_CMD(pdu) &&			/* command PDU */
 	       LLC_PDU_TYPE_IS_U(pdu) &&		/* U type PDU */
 	       LLC_U_PDU_CMD(pdu) == LLC_1_PDU_CMD_TEST &&
-	       !pdu->dsap ? 0 : 1;			/* NULL DSAP */
+	       !pdu->dsap ? 1 : 0;			/* NULL DSAP */
 }
 
 static int llc_station_ac_send_xid_r(struct sk_buff *skb)
-- 
1.8.3.1

