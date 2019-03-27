Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12062C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1522087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733016AbfC0IpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:45:09 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:39185 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732906AbfC0IpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:45:06 -0400
X-Originating-IP: 90.88.32.136
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 8B7204000E;
        Wed, 27 Mar 2019 08:45:02 +0000 (UTC)
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
Subject: [PATCH net-next 12/18] net: mvpp2: cls: Move C2 read/write helpers around
Date:   Wed, 27 Mar 2019 09:44:16 +0100
Message-Id: <20190327084422.4209-13-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327084422.4209-1-maxime.chevallier@bootlin.com>
References: <20190327084422.4209-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move C2 read/write helpers higher in the file to ease future work that
rely on these helpers

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../net/ethernet/marvell/mvpp2/mvpp2_cls.c    | 82 +++++++++----------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index 335714e1bbea..52dc6693cf31 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -492,6 +492,47 @@ static void mvpp2_cls_flow_lkp_init(struct mvpp2 *priv,
 	mvpp2_cls_lookup_write(priv, &le);
 }
 
+static void mvpp2_cls_c2_write(struct mvpp2 *priv,
+			       struct mvpp2_cls_c2_entry *c2)
+{
+	mvpp2_write(priv, MVPP22_CLS_C2_TCAM_IDX, c2->index);
+
+	mvpp2_write(priv, MVPP22_CLS_C2_ACT, c2->act);
+
+	mvpp2_write(priv, MVPP22_CLS_C2_ATTR0, c2->attr[0]);
+	mvpp2_write(priv, MVPP22_CLS_C2_ATTR1, c2->attr[1]);
+	mvpp2_write(priv, MVPP22_CLS_C2_ATTR2, c2->attr[2]);
+	mvpp2_write(priv, MVPP22_CLS_C2_ATTR3, c2->attr[3]);
+
+	mvpp2_write(priv, MVPP22_CLS_C2_TCAM_DATA0, c2->tcam[0]);
+	mvpp2_write(priv, MVPP22_CLS_C2_TCAM_DATA1, c2->tcam[1]);
+	mvpp2_write(priv, MVPP22_CLS_C2_TCAM_DATA2, c2->tcam[2]);
+	mvpp2_write(priv, MVPP22_CLS_C2_TCAM_DATA3, c2->tcam[3]);
+	/* Writing TCAM_DATA4 flushes writes to TCAM_DATA0-4 and INV to HW */
+	mvpp2_write(priv, MVPP22_CLS_C2_TCAM_DATA4, c2->tcam[4]);
+}
+
+void mvpp2_cls_c2_read(struct mvpp2 *priv, int index,
+		       struct mvpp2_cls_c2_entry *c2)
+{
+	mvpp2_write(priv, MVPP22_CLS_C2_TCAM_IDX, index);
+
+	c2->index = index;
+
+	c2->tcam[0] = mvpp2_read(priv, MVPP22_CLS_C2_TCAM_DATA0);
+	c2->tcam[1] = mvpp2_read(priv, MVPP22_CLS_C2_TCAM_DATA1);
+	c2->tcam[2] = mvpp2_read(priv, MVPP22_CLS_C2_TCAM_DATA2);
+	c2->tcam[3] = mvpp2_read(priv, MVPP22_CLS_C2_TCAM_DATA3);
+	c2->tcam[4] = mvpp2_read(priv, MVPP22_CLS_C2_TCAM_DATA4);
+
+	c2->act = mvpp2_read(priv, MVPP22_CLS_C2_ACT);
+
+	c2->attr[0] = mvpp2_read(priv, MVPP22_CLS_C2_ATTR0);
+	c2->attr[1] = mvpp2_read(priv, MVPP22_CLS_C2_ATTR1);
+	c2->attr[2] = mvpp2_read(priv, MVPP22_CLS_C2_ATTR2);
+	c2->attr[3] = mvpp2_read(priv, MVPP22_CLS_C2_ATTR3);
+}
+
 /* Initialize the flow table entries for the given flow */
 static void mvpp2_cls_flow_init(struct mvpp2 *priv,
 				const struct mvpp2_cls_flow *flow)
@@ -743,47 +784,6 @@ static void mvpp2_cls_port_init_flows(struct mvpp2 *priv)
 	}
 }
 
-static void mvpp2_cls_c2_write(struct mvpp2 *priv,
-			       struct mvpp2_cls_c2_entry *c2)
-{
-	mvpp2_write(priv, MVPP22_CLS_C2_TCAM_IDX, c2->index);
-
-	mvpp2_write(priv, MVPP22_CLS_C2_ACT, c2->act);
-
-	mvpp2_write(priv, MVPP22_CLS_C2_ATTR0, c2->attr[0]);
-	mvpp2_write(priv, MVPP22_CLS_C2_ATTR1, c2->attr[1]);
-	mvpp2_write(priv, MVPP22_CLS_C2_ATTR2, c2->attr[2]);
-	mvpp2_write(priv, MVPP22_CLS_C2_ATTR3, c2->attr[3]);
-
-	mvpp2_write(priv, MVPP22_CLS_C2_TCAM_DATA0, c2->tcam[0]);
-	mvpp2_write(priv, MVPP22_CLS_C2_TCAM_DATA1, c2->tcam[1]);
-	mvpp2_write(priv, MVPP22_CLS_C2_TCAM_DATA2, c2->tcam[2]);
-	mvpp2_write(priv, MVPP22_CLS_C2_TCAM_DATA3, c2->tcam[3]);
-	/* Writing TCAM_DATA4 flushes writes to TCAM_DATA0-4 and INV to HW */
-	mvpp2_write(priv, MVPP22_CLS_C2_TCAM_DATA4, c2->tcam[4]);
-}
-
-void mvpp2_cls_c2_read(struct mvpp2 *priv, int index,
-		       struct mvpp2_cls_c2_entry *c2)
-{
-	mvpp2_write(priv, MVPP22_CLS_C2_TCAM_IDX, index);
-
-	c2->index = index;
-
-	c2->tcam[0] = mvpp2_read(priv, MVPP22_CLS_C2_TCAM_DATA0);
-	c2->tcam[1] = mvpp2_read(priv, MVPP22_CLS_C2_TCAM_DATA1);
-	c2->tcam[2] = mvpp2_read(priv, MVPP22_CLS_C2_TCAM_DATA2);
-	c2->tcam[3] = mvpp2_read(priv, MVPP22_CLS_C2_TCAM_DATA3);
-	c2->tcam[4] = mvpp2_read(priv, MVPP22_CLS_C2_TCAM_DATA4);
-
-	c2->act = mvpp2_read(priv, MVPP22_CLS_C2_ACT);
-
-	c2->attr[0] = mvpp2_read(priv, MVPP22_CLS_C2_ATTR0);
-	c2->attr[1] = mvpp2_read(priv, MVPP22_CLS_C2_ATTR1);
-	c2->attr[2] = mvpp2_read(priv, MVPP22_CLS_C2_ATTR2);
-	c2->attr[3] = mvpp2_read(priv, MVPP22_CLS_C2_ATTR3);
-}
-
 static void mvpp2_port_c2_cls_init(struct mvpp2_port *port)
 {
 	struct mvpp2_cls_c2_entry c2;
-- 
2.20.1

