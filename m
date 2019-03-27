Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE21C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853BB2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732659AbfC0Iot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:44:49 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:58415 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732541AbfC0Ior (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:44:47 -0400
X-Originating-IP: 90.88.32.136
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id BE6934000E;
        Wed, 27 Mar 2019 08:44:42 +0000 (UTC)
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
Subject: [PATCH net-next 04/18] net: mvpp2: cls: use Lookup Type in classification engines
Date:   Wed, 27 Mar 2019 09:44:08 +0100
Message-Id: <20190327084422.4209-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327084422.4209-1-maxime.chevallier@bootlin.com>
References: <20190327084422.4209-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PPv2 classifier allows to perform multiple lookups on the same
engine when classifying a packet. These lookups can match similar parts
of a packet header, but perform different actions upon matching. To
differentiate these types of lookups, it's possible to specify a Lookup
Type in the flow table entries, which will be part of the key for the
lookup engines.

This commit introduces the use of Lookup Types for C2 matches. Since for
now we only perform C2 lookups to enable RSS, we only need one Lookup
Type.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h     |  2 ++
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c | 12 ++++++++++++
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h |  7 +++++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index ff0f4c503f53..1356fc4fbccb 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -101,6 +101,7 @@
 #define MVPP2_CLS_FLOW_TBL1_REG			0x1828
 #define     MVPP2_CLS_FLOW_TBL1_N_FIELDS_MASK	0x7
 #define     MVPP2_CLS_FLOW_TBL1_N_FIELDS(x)	(x)
+#define     MVPP2_CLS_FLOW_TBL1_LU_TYPE(lu)	(((lu) & 0x3f) << 3)
 #define     MVPP2_CLS_FLOW_TBL1_PRIO_MASK	0x3f
 #define     MVPP2_CLS_FLOW_TBL1_PRIO(x)		((x) << 9)
 #define     MVPP2_CLS_FLOW_TBL1_SEQ_MASK	0x7
@@ -123,6 +124,7 @@
 #define MVPP22_CLS_C2_TCAM_DATA2		0x1b18
 #define MVPP22_CLS_C2_TCAM_DATA3		0x1b1c
 #define MVPP22_CLS_C2_TCAM_DATA4		0x1b20
+#define     MVPP22_CLS_C2_LU_TYPE(lu)		((lu) & 0x3f)
 #define     MVPP22_CLS_C2_PORT_ID(port)		((port) << 8)
 #define MVPP22_CLS_C2_HIT_CTR			0x1b50
 #define MVPP22_CLS_C2_ACT			0x1b60
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index cd2fbb6eaa3a..9e3b9036b75a 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -454,6 +454,13 @@ static void mvpp2_cls_flow_port_add(struct mvpp2_cls_flow_entry *fe,
 	fe->data[0] |= MVPP2_CLS_FLOW_TBL0_PORT_ID(port);
 }
 
+static void mvpp2_cls_flow_lu_type_set(struct mvpp2_cls_flow_entry *fe,
+				       u8 lu_type)
+{
+	fe->data[1] &= ~MVPP2_CLS_FLOW_TBL1_LU_TYPE(MVPP2_CLS_LU_TYPE_MASK);
+	fe->data[1] |= MVPP2_CLS_FLOW_TBL1_LU_TYPE(lu_type);
+}
+
 /* Initialize the parser entry for the given flow */
 static void mvpp2_cls_flow_prs_init(struct mvpp2 *priv,
 				    struct mvpp2_cls_flow *flow)
@@ -500,6 +507,7 @@ static void mvpp2_cls_flow_init(struct mvpp2 *priv, struct mvpp2_cls_flow *flow)
 	mvpp2_cls_flow_last_set(&fe, 0);
 	mvpp2_cls_flow_pri_set(&fe, 0);
 	mvpp2_cls_flow_seq_set(&fe, MVPP2_CLS_FLOW_SEQ_FIRST1);
+	mvpp2_cls_flow_lu_type_set(&fe, MVPP2_CLS_LU_ALL);
 
 	/* Add all ports */
 	for (i = 0; i < MVPP2_MAX_PORTS; i++)
@@ -794,6 +802,10 @@ static void mvpp2_port_c2_cls_init(struct mvpp2_port *port)
 	c2.tcam[4] = MVPP22_CLS_C2_PORT_ID(pmap);
 	c2.tcam[4] |= MVPP22_CLS_C2_TCAM_EN(MVPP22_CLS_C2_PORT_ID(pmap));
 
+	/* Match on Lookup Type */
+	c2.tcam[4] |= MVPP22_CLS_C2_TCAM_EN(MVPP22_CLS_C2_LU_TYPE(MVPP2_CLS_LU_TYPE_MASK));
+	c2.tcam[4] |= MVPP22_CLS_C2_LU_TYPE(MVPP2_CLS_LU_ALL);
+
 	/* Update RSS status after matching this entry */
 	c2.act = MVPP22_CLS_C2_ACT_RSS_EN(MVPP22_C2_UPD_LOCK);
 
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
index c1424f90cbaf..9ffbb4f4675d 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
@@ -162,6 +162,13 @@ enum mvpp2_prs_flow {
 	MVPP2_FL_LAST,
 };
 
+enum mvpp2_cls_lu_type {
+	MVPP2_CLS_LU_ALL = 0,
+};
+
+/* LU Type defined for all engines, and specified in the flow table */
+#define MVPP2_CLS_LU_TYPE_MASK			0x3f
+
 struct mvpp2_cls_flow {
 	/* The L2-L4 traffic flow type */
 	int flow_type;
-- 
2.20.1

