Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B01C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB442075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbfC0Uf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 16:35:57 -0400
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:55302 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728922AbfC0Ufy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 16:35:54 -0400
Received: from localhost.localdomain (85-76-9-223-nat.elisa-mobile.fi [85.76.9.223])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id A81223009D;
        Wed, 27 Mar 2019 22:35:51 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     "David S. Miller" <davem@davemloft.net>,
        Jose Abreu <joabreu@synopsys.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH 6/6] net: stmmac: don't log oversized frames
Date:   Wed, 27 Mar 2019 22:35:40 +0200
Message-Id: <20190327203540.1884-7-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190327203540.1884-1-aaro.koskinen@iki.fi>
References: <20190327203540.1884-1-aaro.koskinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaro Koskinen <aaro.koskinen@nokia.com>

This is log is harmful as it can trigger multiple times per packet. Delete
it.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 drivers/net/ethernet/stmicro/stmmac/norm_desc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
index c55a9815b394..b7dd4e3c760d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
@@ -91,8 +91,6 @@ static int ndesc_get_rx_status(void *data, struct stmmac_extra_stats *x,
 		return dma_own;
 
 	if (unlikely(!(rdes0 & RDES0_LAST_DESCRIPTOR))) {
-		pr_warn("%s: Oversized frame spanned multiple buffers\n",
-			__func__);
 		stats->rx_length_errors++;
 		return discard_frame;
 	}
-- 
2.17.0

