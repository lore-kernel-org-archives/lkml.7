Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CA0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7232075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732717AbfC0Iox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:44:53 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:33057 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732432AbfC0Ion (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:44:43 -0400
X-Originating-IP: 90.88.32.136
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 533B040010;
        Wed, 27 Mar 2019 08:44:40 +0000 (UTC)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Alan Winkowski <walan@marvell.com>
Subject: [PATCH net-next 03/18] net: mvpp2: cls: Start cls flow entries from beginning of table
Date:   Wed, 27 Mar 2019 09:44:07 +0100
Message-Id: <20190327084422.4209-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327084422.4209-1-maxime.chevallier@bootlin.com>
References: <20190327084422.4209-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Classifier flow table has 512 entries, that contains lookups
commands executed consecutively for every flow. Since we have 21
different flows, we have to carefully manage the flow table use.

As of today, the start index of a lookup sequence is computed
directly based in the flow->id. There are 8 reserved flow ids, from
0-7, which don't have any corresponding sequence in the flow table. We
can therefore ignore them when computing the index, and make so that the
first non-reserved flow point to the very beginning of the flow table.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Suggested-by: Alan Winkowski <walan@marvell.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
index 089f05f29891..c1424f90cbaf 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
@@ -179,9 +179,11 @@ struct mvpp2_cls_flow {
 #define MVPP2_N_FLOWS	52
 
 #define MVPP2_ENTRIES_PER_FLOW			(MVPP2_MAX_PORTS + 1)
-#define MVPP2_FLOW_C2_ENTRY(id)			((id) * MVPP2_ENTRIES_PER_FLOW)
-#define MVPP2_PORT_FLOW_HASH_ENTRY(port, id)	((id) * MVPP2_ENTRIES_PER_FLOW + \
-						(port) + 1)
+#define MVPP2_FLOW_C2_ENTRY(id)			((((id) - MVPP2_FL_START) * \
+						 MVPP2_ENTRIES_PER_FLOW) + 1)
+#define MVPP2_PORT_FLOW_HASH_ENTRY(port, id)	(MVPP2_FLOW_C2_ENTRY(id) + \
+						 1 + (port))
+
 struct mvpp2_cls_flow_entry {
 	u32 index;
 	u32 data[MVPP2_CLS_FLOWS_TBL_DATA_WORDS];
-- 
2.20.1

