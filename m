Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C934C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6464E208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733079AbfC0IpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:45:13 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:37663 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733035AbfC0IpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:45:11 -0400
X-Originating-IP: 90.88.32.136
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id AF15940003;
        Wed, 27 Mar 2019 08:45:07 +0000 (UTC)
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
Subject: [PATCH net-next 14/18] net: mvpp2: cls: Don't use the sequence attribute for classification
Date:   Wed, 27 Mar 2019 09:44:18 +0100
Message-Id: <20190327084422.4209-15-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327084422.4209-1-maxime.chevallier@bootlin.com>
References: <20190327084422.4209-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The classifier allows to combine multiple lookups in one "sequence" that
is counted as a single lookup to an engine, with a single result.

We don't actually use that feature, so remove any places where we set
this field, so that the classifier doesn't try to interpret these
fields.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c | 10 ----------
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h |  8 --------
 2 files changed, 18 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index 533919982735..e50154e03141 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -429,12 +429,6 @@ static void mvpp2_cls_flow_port_id_sel(struct mvpp2_cls_flow_entry *fe,
 		fe->data[0] &= ~MVPP2_CLS_FLOW_TBL0_PORT_ID_SEL;
 }
 
-static void mvpp2_cls_flow_seq_set(struct mvpp2_cls_flow_entry *fe, u32 seq)
-{
-	fe->data[1] &= ~MVPP2_CLS_FLOW_TBL1_SEQ(MVPP2_CLS_FLOW_TBL1_SEQ_MASK);
-	fe->data[1] |= MVPP2_CLS_FLOW_TBL1_SEQ(seq);
-}
-
 static void mvpp2_cls_flow_last_set(struct mvpp2_cls_flow_entry *fe,
 				    bool is_last)
 {
@@ -548,7 +542,6 @@ static void mvpp2_cls_flow_init(struct mvpp2 *priv,
 	mvpp2_cls_flow_port_id_sel(&fe, true);
 	mvpp2_cls_flow_last_set(&fe, 0);
 	mvpp2_cls_flow_pri_set(&fe, 0);
-	mvpp2_cls_flow_seq_set(&fe, MVPP2_CLS_FLOW_SEQ_FIRST1);
 	mvpp2_cls_flow_lu_type_set(&fe, MVPP2_CLS_LU_ALL);
 
 	/* Add all ports */
@@ -564,7 +557,6 @@ static void mvpp2_cls_flow_init(struct mvpp2 *priv,
 
 		mvpp2_cls_flow_port_id_sel(&fe, true);
 		mvpp2_cls_flow_pri_set(&fe, i + 1);
-		mvpp2_cls_flow_seq_set(&fe, MVPP2_CLS_FLOW_SEQ_MIDDLE);
 		mvpp2_cls_flow_port_add(&fe, BIT(i));
 
 		mvpp2_cls_flow_write(priv, &fe);
@@ -572,8 +564,6 @@ static void mvpp2_cls_flow_init(struct mvpp2 *priv,
 
 	/* Update the last entry */
 	mvpp2_cls_flow_last_set(&fe, 1);
-	mvpp2_cls_flow_seq_set(&fe, MVPP2_CLS_FLOW_SEQ_LAST);
-
 	mvpp2_cls_flow_write(priv, &fe);
 }
 
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
index fa588b07d182..9a4796fc0219 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
@@ -71,14 +71,6 @@ enum mvpp2_cls_field_id {
 	MVPP22_CLS_FIELD_L4DIP = 0x1e,
 };
 
-enum mvpp2_cls_flow_seq {
-	MVPP2_CLS_FLOW_SEQ_NORMAL = 0,
-	MVPP2_CLS_FLOW_SEQ_FIRST1,
-	MVPP2_CLS_FLOW_SEQ_FIRST2,
-	MVPP2_CLS_FLOW_SEQ_LAST,
-	MVPP2_CLS_FLOW_SEQ_MIDDLE
-};
-
 /* Classifier C2 engine constants */
 #define MVPP22_CLS_C2_TCAM_EN(data)		((data) << 16)
 
-- 
2.20.1

