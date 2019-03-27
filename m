Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC2DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A362087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfC0IpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:45:23 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:57935 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733143AbfC0IpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:45:21 -0400
X-Originating-IP: 90.88.32.136
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id AC3224001C;
        Wed, 27 Mar 2019 08:45:17 +0000 (UTC)
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
Subject: [PATCH net-next 18/18] net: mvpp2: cls: Rework C2 engine macros
Date:   Wed, 27 Mar 2019 09:44:22 +0100
Message-Id: <20190327084422.4209-19-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327084422.4209-1-maxime.chevallier@bootlin.com>
References: <20190327084422.4209-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The C2 classification engine has a 256 entry TCAM, used for ternary
matches on an 8 byte Header Extracted Key. For now, we compute the
various indices for classification and RSS that use this engine thanks
to a set of macros.

This commit mainly renames the macros used to make it clear that they
should be used with the C2 engine, but also make use of the full 256
entries in the engine. For now, the C2 entries are only used for RSS.

These entries are put at the end of the TCAM range, in case we want to
add higher priority matches later on.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../net/ethernet/marvell/mvpp2/mvpp2_cls.h    | 28 +++++--------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
index bb3ea84c2888..96304ffc5d49 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
@@ -108,28 +108,14 @@ struct mvpp2_cls_c2_entry {
 };
 
 /* Classifier C2 engine entries */
-#define MVPP22_CLS_C2_RSS_ENTRY(port)	(port)
-#define MVPP22_CLS_C2_N_ENTRIES		MVPP2_MAX_PORTS
+#define MVPP22_CLS_C2_N_ENTRIES		256
 
-/* RSS flow entries in the flow table. We have 2 entries per port for RSS.
- *
- * The first performs a lookup using the C2 TCAM engine, to tag the
- * packet for software forwarding (needed for RSS), enable or disable RSS, and
- * assign the default rx queue.
- *
- * The second configures the hash generation, by specifying which fields of the
- * packet header are used to generate the hash, and specifies the relevant hash
- * engine to use.
- */
-#define MVPP22_RSS_FLOW_C2_OFFS		0
-#define MVPP22_RSS_FLOW_HASH_OFFS	1
-#define MVPP22_RSS_FLOW_SIZE		(MVPP22_RSS_FLOW_HASH_OFFS + 1)
-
-#define MVPP22_RSS_FLOW_C2(port)	((port) * MVPP22_RSS_FLOW_SIZE + \
-					 MVPP22_RSS_FLOW_C2_OFFS)
-#define MVPP22_RSS_FLOW_HASH(port)	((port) * MVPP22_RSS_FLOW_SIZE + \
-					 MVPP22_RSS_FLOW_HASH_OFFS)
-#define MVPP22_RSS_FLOW_FIRST(port)	MVPP22_RSS_FLOW_C2(port)
+/* Number of per-port dedicated entries in the C2 TCAM */
+#define MVPP22_CLS_C2_PORT_RANGE	8
+
+#define MVPP22_CLS_C2_PORT_FIRST(p)	(MVPP22_CLS_C2_N_ENTRIES - \
+					((p) * MVPP22_CLS_C2_PORT_RANGE))
+#define MVPP22_CLS_C2_RSS_ENTRY(p)	(MVPP22_CLS_C2_PORT_FIRST(p) - 1)
 
 /* Packet flow ID */
 enum mvpp2_prs_flow {
-- 
2.20.1

