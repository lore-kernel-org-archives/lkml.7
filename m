Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B7DC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B932147A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfFSOyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 10:54:18 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:49013 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfFSOyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 10:54:18 -0400
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-81-150.w90-88.abo.wanadoo.fr [90.88.23.150])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 7875A240003;
        Wed, 19 Jun 2019 14:54:10 +0000 (UTC)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, mw@semihalf.com,
        Alan Winkowski <walan@marvell.com>
Subject: [PATCH net] net: mvpp2: prs: Don't override the sign bit in SRAM parser shift
Date:   Wed, 19 Jun 2019 16:54:13 +0200
Message-Id: <20190619145413.21852-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Header Parser allows identifying various fields in the packet
headers, used for for various kind of filtering and classification
steps.

This is a re-entrant process, where the offset in the packet header
depends on the previous lookup results. This offset is represented in
the SRAM results of the TCAM, as a shift to be operated.

This shift can be negative in some cases, such as in IPv6 parsing.

This commit prevents overriding the sign bit when setting the shift
value, which could cause instabilities when parsing IPv6 flows.

Fixes: 3f518509dedc ("ethernet: Add new driver for Marvell Armada 375 network unit")
Suggested-by: Alan Winkowski <walan@marvell.com>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
index ae2240074d8e..5692c6087bbb 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
@@ -312,7 +312,8 @@ static void mvpp2_prs_sram_shift_set(struct mvpp2_prs_entry *pe, int shift,
 	}
 
 	/* Set value */
-	pe->sram[MVPP2_BIT_TO_WORD(MVPP2_PRS_SRAM_SHIFT_OFFS)] = shift & MVPP2_PRS_SRAM_SHIFT_MASK;
+	pe->sram[MVPP2_BIT_TO_WORD(MVPP2_PRS_SRAM_SHIFT_OFFS)] |=
+		shift & MVPP2_PRS_SRAM_SHIFT_MASK;
 
 	/* Reset and set operation */
 	mvpp2_prs_sram_bits_clear(pe, MVPP2_PRS_SRAM_OP_SEL_SHIFT_OFFS,
-- 
2.20.1

