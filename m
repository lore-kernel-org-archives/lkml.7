Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDA4C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 07:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4569020640
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 07:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfJBHHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 03:07:50 -0400
Received: from smtp.cellavision.se ([84.19.140.14]:30622 "EHLO
        smtp.cellavision.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfJBHHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 03:07:50 -0400
Received: from DRCELLEX03.cellavision.se (172.16.169.12) by
 DRCELLEX03.cellavision.se (172.16.169.12) with Microsoft SMTP Server (TLS) id
 15.0.1044.25; Wed, 2 Oct 2019 09:07:46 +0200
Received: from ITG-CEL-24768.cellavision.se (10.230.0.148) by
 DRCELLEX03.cellavision.se (172.16.169.12) with Microsoft SMTP Server id
 15.0.1044.25 via Frontend Transport; Wed, 2 Oct 2019 09:07:46 +0200
From:   Hans Andersson <haan@cellavision.se>
To:     <mcoquelin.stm32@gmail.com>
CC:     <peppe.cavallaro@st.com>, <alexandre.torgue@st.com>,
        <joabreu@synopsys.com>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Hans Andersson <hans.andersson@cellavision.se>
Subject: [PATCH] net: stmmac: Read user ID muliple times if needed.
Date:   Wed, 2 Oct 2019 09:07:21 +0200
Message-ID: <20191002070721.9916-1-haan@cellavision.se>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Andersson <hans.andersson@cellavision.se>

When we read user ID / Synopsys ID we might still be in reset,
so read muliple times if needed.

Signed-off-by: Hans Andersson <hans.andersson@cellavision.se>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 6c61b75..3347164 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -10,7 +10,16 @@
 
 static u32 stmmac_get_id(struct stmmac_priv *priv, u32 id_reg)
 {
-	u32 reg = readl(priv->ioaddr + id_reg);
+	u32 reg;
+	int i;
+
+	/* We might still be in reset when we read, */
+	/* so read multiple times if needed. */
+	for (i = 0; i < 10; i++) {
+		reg = readl(priv->ioaddr + id_reg);
+		if (reg)
+			break;
+	}
 
 	if (!reg) {
 		dev_info(priv->device, "Version ID not available\n");
-- 
2.17.1

