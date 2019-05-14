Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D184C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 15:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DFC42086A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 15:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NEQbE2dj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfENPrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 11:47:17 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:35798 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726174AbfENPpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 11:45:41 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1CA92C015A;
        Tue, 14 May 2019 15:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557848732; bh=QXuU1N55lDRWr8n7bWP+fpVnXNv3cPhcRH92zhbwQ5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=NEQbE2djUKsjnhcvO9OhlAvc1KgbTIUdmidFZkk/bFdY3RmGZYf9jEfSzUszkKJcz
         1w5f+jf92rSs1HCeNwK1ZOV8ChgWcuknhN1TS+Ait+UxJmpXmCf56Rsuh8VChtFxaX
         T5MYOcnhRpbOih47ld9ZlyH+YgrpTyCxyOezD4qGvfak0V7kPS3kK0R4Xq9YOqhV5C
         XsGM9IrUaHvZwbASP5GEWxwuHqEAnN062AjvJpN2x85ToWoc2/Yojv8GlI42+6r+Ov
         zmTbrDf+ckwSWxtBZh6CMLq886eYo9cKU9hVr1WV1bv+ijeoyLEYSC34PeKkBXlIhy
         rebB7Yu3dxzuw==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 495B3A024A;
        Tue, 14 May 2019 15:45:41 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id B54693EA2E;
        Tue, 14 May 2019 17:45:39 +0200 (CEST)
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [RFC net-next v2 09/14] net: stmmac: dwmac4/5: Also pass control frames while in promisc mode
Date:   Tue, 14 May 2019 17:45:31 +0200
Message-Id: <3771b7468888ced0b0961138b50bd244dad91d9a.1557848472.git.joabreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1557848472.git.joabreu@synopsys.com>
References: <cover.1557848472.git.joabreu@synopsys.com>
In-Reply-To: <cover.1557848472.git.joabreu@synopsys.com>
References: <cover.1557848472.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order for the selftests to run the Flow Control selftest we need to
also pass pause frames to the stack.

Pass this type of frames while in promiscuous mode.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h      | 1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
index 3dddd7902b0f..c3cbca804bcd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
@@ -64,6 +64,7 @@
 #define GMAC_PACKET_FILTER_PR		BIT(0)
 #define GMAC_PACKET_FILTER_HMC		BIT(2)
 #define GMAC_PACKET_FILTER_PM		BIT(4)
+#define GMAC_PACKET_FILTER_PCF		BIT(7)
 
 #define GMAC_MAX_PERFECT_ADDRESSES	128
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 2f1a2a6f9b33..02a3a7e2db6e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -404,7 +404,7 @@ static void dwmac4_set_filter(struct mac_device_info *hw,
 	unsigned int value = 0;
 
 	if (dev->flags & IFF_PROMISC) {
-		value = GMAC_PACKET_FILTER_PR;
+		value = GMAC_PACKET_FILTER_PR | GMAC_PACKET_FILTER_PCF;
 	} else if ((dev->flags & IFF_ALLMULTI) ||
 			(netdev_mc_count(dev) > HASH_TABLE_SIZE)) {
 		/* Pass all multi */
-- 
2.7.4

