Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8377DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549692082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733230AbfC0Ipj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:45:39 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:39807 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733076AbfC0IpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:45:19 -0400
X-Originating-IP: 90.88.32.136
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 2BCA240002;
        Wed, 27 Mar 2019 08:45:14 +0000 (UTC)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 17/18] net: mvpp2: cls: Initialize lookup priorities for all entries in the flow
Date:   Wed, 27 Mar 2019 09:44:21 +0100
Message-Id: <20190327084422.4209-18-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327084422.4209-1-maxime.chevallier@bootlin.com>
References: <20190327084422.4209-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When classifying a packet pertaining to a given flow, the classifier
will issue multiple lookup commands until it finds one with the 'last'
bit set. It expects all prorities to be assign continuously (although
not necessarily in an ordered fashion) from 0 to the number of lookups.

We can initialize this once, and make sure unused lookups are given an
empty port map. This avoids having to maintain priorities and the
information of which lookup is the last.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../net/ethernet/marvell/mvpp2/mvpp2_cls.c    | 37 ++++++++++++-------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index 7a889a925714..1087974d3b98 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -544,16 +544,27 @@ static void mvpp2_cls_flow_init(struct mvpp2 *priv,
 				const struct mvpp2_cls_flow *flow)
 {
 	struct mvpp2_cls_flow_entry fe;
-	int i;
+	int i, pri = 0;
+
+	/* Assign default values to all entries in the flow */
+	for (i = MVPP2_CLS_FLT_FIRST(flow->flow_id);
+	     i <= MVPP2_CLS_FLT_LAST(flow->flow_id); i++) {
+		memset(&fe, 0, sizeof(fe));
+		fe.index = i;
+		mvpp2_cls_flow_pri_set(&fe, pri++);
 
-	/* C2 lookup */
-	memset(&fe, 0, sizeof(fe));
-	fe.index = MVPP2_CLS_FLT_C2_RSS_ENTRY(flow->flow_id);
+		if (i == MVPP2_CLS_FLT_LAST(flow->flow_id))
+			mvpp2_cls_flow_last_set(&fe, 1);
+
+		mvpp2_cls_flow_write(priv, &fe);
+	}
+
+	/* RSS config C2 lookup */
+	mvpp2_cls_flow_read(priv, MVPP2_CLS_FLT_C2_RSS_ENTRY(flow->flow_id),
+			    &fe);
 
 	mvpp2_cls_flow_eng_set(&fe, MVPP22_CLS_ENGINE_C2);
 	mvpp2_cls_flow_port_id_sel(&fe, true);
-	mvpp2_cls_flow_last_set(&fe, 0);
-	mvpp2_cls_flow_pri_set(&fe, 0);
 	mvpp2_cls_flow_lu_type_set(&fe, MVPP2_CLS_LU_ALL);
 
 	/* Add all ports */
@@ -564,19 +575,19 @@ static void mvpp2_cls_flow_init(struct mvpp2 *priv,
 
 	/* C3Hx lookups */
 	for (i = 0; i < MVPP2_MAX_PORTS; i++) {
-		memset(&fe, 0, sizeof(fe));
-		fe.index = MVPP2_CLS_FLT_HASH_ENTRY(i, flow->flow_id);
+		mvpp2_cls_flow_read(priv,
+				    MVPP2_CLS_FLT_HASH_ENTRY(i, flow->flow_id),
+				    &fe);
 
+		/* Set a default engine. Will be overwritten when setting the
+		 * real HEK parameters
+		 */
+		mvpp2_cls_flow_eng_set(&fe, MVPP22_CLS_ENGINE_C3HA);
 		mvpp2_cls_flow_port_id_sel(&fe, true);
-		mvpp2_cls_flow_pri_set(&fe, i + 1);
 		mvpp2_cls_flow_port_add(&fe, BIT(i));
 
 		mvpp2_cls_flow_write(priv, &fe);
 	}
-
-	/* Update the last entry */
-	mvpp2_cls_flow_last_set(&fe, 1);
-	mvpp2_cls_flow_write(priv, &fe);
 }
 
 /* Adds a field to the Header Extracted Key generation parameters*/
-- 
2.20.1

