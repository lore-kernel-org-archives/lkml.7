Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB58C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E9E2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733151AbfC0IpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:45:20 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:52115 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733035AbfC0IpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:45:16 -0400
X-Originating-IP: 90.88.32.136
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id C1A9040008;
        Wed, 27 Mar 2019 08:45:12 +0000 (UTC)
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
Subject: [PATCH net-next 16/18] net: mvpp2: cls: Invalidate all C2 entries except the ones we use
Date:   Wed, 27 Mar 2019 09:44:20 +0100
Message-Id: <20190327084422.4209-17-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327084422.4209-1-maxime.chevallier@bootlin.com>
References: <20190327084422.4209-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

C2 TCAM entries can be invalidated to avoid unwanted matches. Make sure
all entries are invalidated at init, then validate only the ones we use.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |  2 ++
 .../net/ethernet/marvell/mvpp2/mvpp2_cls.c    | 23 +++++++++++++++++++
 .../net/ethernet/marvell/mvpp2/mvpp2_cls.h    |  5 ++++
 3 files changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index 04d140218f45..67cce2736806 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -126,6 +126,8 @@
 #define MVPP22_CLS_C2_TCAM_DATA4		0x1b20
 #define     MVPP22_CLS_C2_LU_TYPE(lu)		((lu) & 0x3f)
 #define     MVPP22_CLS_C2_PORT_ID(port)		((port) << 8)
+#define MVPP22_CLS_C2_TCAM_INV			0x1b24
+#define     MVPP22_CLS_C2_TCAM_INV_BIT		BIT(31)
 #define MVPP22_CLS_C2_HIT_CTR			0x1b50
 #define MVPP22_CLS_C2_ACT			0x1b60
 #define     MVPP22_CLS_C2_ACT_RSS_EN(act)	(((act) & 0x3) << 19)
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index 482de582f994..7a889a925714 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -489,8 +489,16 @@ static void mvpp2_cls_flow_lkp_init(struct mvpp2 *priv,
 static void mvpp2_cls_c2_write(struct mvpp2 *priv,
 			       struct mvpp2_cls_c2_entry *c2)
 {
+	u32 val;
 	mvpp2_write(priv, MVPP22_CLS_C2_TCAM_IDX, c2->index);
 
+	val = mvpp2_read(priv, MVPP22_CLS_C2_TCAM_INV);
+	if (c2->valid)
+		val &= ~MVPP22_CLS_C2_TCAM_INV_BIT;
+	else
+		val |= MVPP22_CLS_C2_TCAM_INV_BIT;
+	mvpp2_write(priv, MVPP22_CLS_C2_TCAM_INV, val);
+
 	mvpp2_write(priv, MVPP22_CLS_C2_ACT, c2->act);
 
 	mvpp2_write(priv, MVPP22_CLS_C2_ATTR0, c2->attr[0]);
@@ -509,6 +517,7 @@ static void mvpp2_cls_c2_write(struct mvpp2 *priv,
 void mvpp2_cls_c2_read(struct mvpp2 *priv, int index,
 		       struct mvpp2_cls_c2_entry *c2)
 {
+	u32 val;
 	mvpp2_write(priv, MVPP22_CLS_C2_TCAM_IDX, index);
 
 	c2->index = index;
@@ -525,6 +534,9 @@ void mvpp2_cls_c2_read(struct mvpp2 *priv, int index,
 	c2->attr[1] = mvpp2_read(priv, MVPP22_CLS_C2_ATTR1);
 	c2->attr[2] = mvpp2_read(priv, MVPP22_CLS_C2_ATTR2);
 	c2->attr[3] = mvpp2_read(priv, MVPP22_CLS_C2_ATTR3);
+
+	val = mvpp2_read(priv, MVPP22_CLS_C2_TCAM_INV);
+	c2->valid = !(val & MVPP22_CLS_C2_TCAM_INV_BIT);
 }
 
 /* Initialize the flow table entries for the given flow */
@@ -807,6 +819,8 @@ static void mvpp2_port_c2_cls_init(struct mvpp2_port *port)
 	c2.attr[0] = MVPP22_CLS_C2_ATTR0_QHIGH(qh) |
 		      MVPP22_CLS_C2_ATTR0_QLOW(ql);
 
+	c2.valid = true;
+
 	mvpp2_cls_c2_write(port->priv, &c2);
 }
 
@@ -815,6 +829,7 @@ void mvpp2_cls_init(struct mvpp2 *priv)
 {
 	struct mvpp2_cls_lookup_entry le;
 	struct mvpp2_cls_flow_entry fe;
+	struct mvpp2_cls_c2_entry c2;
 	int index;
 
 	/* Enable classifier */
@@ -838,6 +853,14 @@ void mvpp2_cls_init(struct mvpp2 *priv)
 		mvpp2_cls_lookup_write(priv, &le);
 	}
 
+	/* Clear C2 TCAM engine table */
+	memset(&c2, 0, sizeof(c2));
+	c2.valid = false;
+	for (index = 0; index < MVPP22_CLS_C2_N_ENTRIES; index++) {
+		c2.index = index;
+		mvpp2_cls_c2_write(priv, &c2);
+	}
+
 	mvpp2_cls_port_init_flows(priv);
 }
 
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
index 36299b57599c..bb3ea84c2888 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
@@ -97,9 +97,14 @@ enum mvpp22_cls_c2_fwd_action {
 
 struct mvpp2_cls_c2_entry {
 	u32 index;
+	/* TCAM lookup key */
 	u32 tcam[MVPP2_CLS_C2_TCAM_WORDS];
+	/* Actions to perform upon TCAM match */
 	u32 act;
+	/* Attributes relative to the actions to perform */
 	u32 attr[MVPP2_CLS_C2_ATTR_WORDS];
+	/* Entry validity */
+	u8 valid;
 };
 
 /* Classifier C2 engine entries */
-- 
2.20.1

