Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA17C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 06:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4CA24683
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 06:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfLSGQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 01:16:56 -0500
Received: from ybironout2a.netvigator.com ([210.87.250.75]:8674 "EHLO
        ybironout2a.netvigator.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726294AbfLSGQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 01:16:56 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AuAABZFftd/5YXxstlGwEBAQEBAQEFA?=
 =?us-ascii?q?QEBEQEBAwMBAQGBaQUBAQELAYIhgUEgEhoQpByFEoUogXsJAQEBOwIBAYMtgRO?=
 =?us-ascii?q?CHSQ1CA4CEAEBBAEBAQIBBQRthGtYhVY2UigIgSFbgkcBgnYGriMzGgKKM4E2A?=
 =?us-ascii?q?Yc/hFkUBj+BQYFHgihzh22CSgSXU5c2CoI1lhQCGY5qA4tjAS2ELaRBggACNYF?=
 =?us-ascii?q?YgQWBWQqBRFAYjHMBNxcVjhs0M4EEkAAB?=
X-IronPort-AV: E=Sophos;i="5.69,330,1571673600"; 
   d="scan'208";a="171344086"
Received: from unknown (HELO ybironoah04.netvigator.com) ([203.198.23.150])
  by ybironout2v1.netvigator.com with ESMTP; 19 Dec 2019 14:16:52 +0800
Received: from unknown (HELO rhel76.localdomain) ([42.200.157.25])
  by ybironoah04.netvigator.com with ESMTP; 19 Dec 2019 14:16:52 +0800
From:   "Chan Shu Tak, Alex" <alexchan@task.com.hk>
Cc:     "Chan Shu Tak, Alex" <alexchan@task.com.hk>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] llc2: Fix return statement of llc_stat_ev_rx_null_dsap_xid_c (and _test_c)
Date:   Thu, 19 Dec 2019 14:16:18 +0800
Message-Id: <1576736179-7129-1-git-send-email-alexchan@task.com.hk>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chan Shu Tak, Alex" <alexchan@task.com.hk>

When a frame with NULL DSAP is received, llc_station_rcv is called.
In turn, llc_stat_ev_rx_null_dsap_xid_c is called to check if it is a NULL
XID frame. The return statement of llc_stat_ev_rx_null_dsap_xid_c returns 1
when the incoming frame is not a NULL XID frame and 0 otherwise. Hence, a
NULL XID response is returned unexpectedly, e.g. when the incoming frame is
a NULL TEST command.

To fix the error, simply remove the conditional operator.

A similar error in llc_stat_ev_rx_null_dsap_test_c is also fixed.

Signed-off-by: Chan Shu Tak, Alex <alexchan@task.com.hk>
---
 net/llc/llc_station.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/llc/llc_station.c b/net/llc/llc_station.c
index 204a835..c29170e 100644
--- a/net/llc/llc_station.c
+++ b/net/llc/llc_station.c
@@ -32,7 +32,7 @@ static int llc_stat_ev_rx_null_dsap_xid_c(struct sk_buff *skb)
 	return LLC_PDU_IS_CMD(pdu) &&			/* command PDU */
 	       LLC_PDU_TYPE_IS_U(pdu) &&		/* U type PDU */
 	       LLC_U_PDU_CMD(pdu) == LLC_1_PDU_CMD_XID &&
-	       !pdu->dsap ? 0 : 1;			/* NULL DSAP value */
+	       !pdu->dsap;				/* NULL DSAP value */
 }
 
 static int llc_stat_ev_rx_null_dsap_test_c(struct sk_buff *skb)
@@ -42,7 +42,7 @@ static int llc_stat_ev_rx_null_dsap_test_c(struct sk_buff *skb)
 	return LLC_PDU_IS_CMD(pdu) &&			/* command PDU */
 	       LLC_PDU_TYPE_IS_U(pdu) &&		/* U type PDU */
 	       LLC_U_PDU_CMD(pdu) == LLC_1_PDU_CMD_TEST &&
-	       !pdu->dsap ? 0 : 1;			/* NULL DSAP */
+	       !pdu->dsap;				/* NULL DSAP */
 }
 
 static int llc_station_ac_send_xid_r(struct sk_buff *skb)
-- 
1.8.3.1

