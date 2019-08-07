Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B16EC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E498B22BED
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Mj6XwyKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387746AbfHGIE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:04:26 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:33628 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727673AbfHGID2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:03:28 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C0010C0C9D;
        Wed,  7 Aug 2019 08:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1565165008; bh=Qxwoph4ddCKg0VtmbodiUMUPm3P937Jz58/B5VZy51c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Mj6XwyKNj24Z6Kridfjx5/QQfaaY+Fap78Ii8bdyLVZLBC1GPbpQpZ3oWH02nGNzs
         zvOysU0HZFBBgap8kPn/s2i4qm6F2TaMC6E9/cTrcxDohFaNhM5xxjMAGZveMPBXRb
         hj/XzaYxXHICDDogobg4PeWM8FaKY8SMwan4DM9HxiJD3aSGfMnNb5lph9tFDq5VSy
         nCYM5UUsxMJ1A8jSZykIWUg/AZq9X9rikhDUrnBA3HkI4b0/CwVOeAxigyYs2RlPf3
         vhEneBXsXJfrQSoG2glMuK2rxOcF8ckQ9+el9PpWAcueVCpv8OR4TEmxwzfbtRqakc
         rvmluhr/UMggg==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 7B898A006D;
        Wed,  7 Aug 2019 08:03:26 +0000 (UTC)
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     netdev@vger.kernel.org
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 05/10] net: stmmac: selftests: Add RSS test
Date:   Wed,  7 Aug 2019 10:03:13 +0200
Message-Id: <18d992a538cf6935fad5d12fcebb3be076f0b498.1565164729.git.joabreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1565164729.git.joabreu@synopsys.com>
References: <cover.1565164729.git.joabreu@synopsys.com>
In-Reply-To: <cover.1565164729.git.joabreu@synopsys.com>
References: <cover.1565164729.git.joabreu@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a test for RSS in the stmmac selftests.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>

---
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Jose Abreu <joabreu@synopsys.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 .../net/ethernet/stmicro/stmmac/stmmac_selftests.c    | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index a97b1ea76438..83b775a8cedc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -700,6 +700,21 @@ static int stmmac_test_flowctrl(struct stmmac_priv *priv)
 	return ret;
 }
 
+static int stmmac_test_rss(struct stmmac_priv *priv)
+{
+	struct stmmac_packet_attrs attr = { };
+
+	if (!priv->dma_cap.rssen || !priv->rss.enable)
+		return -EOPNOTSUPP;
+
+	attr.dst = priv->dev->dev_addr;
+	attr.exp_hash = true;
+	attr.sport = 0x321;
+	attr.dport = 0x123;
+
+	return __stmmac_test_loopback(priv, &attr);
+}
+
 #define STMMAC_LOOPBACK_NONE	0
 #define STMMAC_LOOPBACK_MAC	1
 #define STMMAC_LOOPBACK_PHY	2
@@ -745,6 +760,10 @@ static const struct stmmac_test {
 		.name = "Flow Control         ",
 		.lb = STMMAC_LOOPBACK_PHY,
 		.fn = stmmac_test_flowctrl,
+	}, {
+		.name = "RSS                  ",
+		.lb = STMMAC_LOOPBACK_PHY,
+		.fn = stmmac_test_rss,
 	},
 };
 
-- 
2.7.4

