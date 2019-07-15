Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6197C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8112A2086C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563202226;
	bh=jxyT0o8DtbEyQgkMxqbkf+7eZ7dbzsjSvzuHu3Qh1HA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GXbXhrhSHGbe8egrtfC95YyEBGTNslnxUNIzeXJ+rD1OJPgFzq41TGxAfijRgkIzj
	 Nqu4+klJY8sSUFrBUDXYuCh6zG4GNMcqkkozqXiPgZDjIHAwcUlHBbCs22hwAKbEmw
	 ghegQYgs0WS42gCbAfrbL1BOaP4aybCP0iQPzna0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404510AbfGOOqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:46:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404788AbfGOOqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:46:11 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BD2320651;
        Mon, 15 Jul 2019 14:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563201970;
        bh=jxyT0o8DtbEyQgkMxqbkf+7eZ7dbzsjSvzuHu3Qh1HA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rb5mRNV2qZAmw07F86HuAnkMWjTymHs+H54DOuRl1tzF10MiqWnto14Uv4iwUpPKq
         eKwyabQIt8nTjyUO5w23h51TLp/30sX4kZAl+ql3pPSjaTkDaQT2+57gwRusG5g5jR
         jYAimjUq4KGrytIZhwBJg4PRLKlQvYEwD4oXnLlU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 10/53] net: stmmac: dwmac1000: Clear unused address entries
Date:   Mon, 15 Jul 2019 10:44:52 -0400
Message-Id: <20190715144535.11636-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715144535.11636-1-sashal@kernel.org>
References: <20190715144535.11636-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>

[ Upstream commit 9463c445590091202659cdfdd44b236acadfbd84 ]

In case we don't use a given address entry we need to clear it because
it could contain previous values that are no longer valid.

Found out while running stmmac selftests.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
Cc: Joao Pinto <jpinto@synopsys.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index 371a669d69fd..1df84c8de9d7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -187,6 +187,12 @@ static void dwmac1000_set_filter(struct mac_device_info *hw,
 					    GMAC_ADDR_LOW(reg));
 			reg++;
 		}
+
+		while (reg <= perfect_addr_number) {
+			writel(0, ioaddr + GMAC_ADDR_HIGH(reg));
+			writel(0, ioaddr + GMAC_ADDR_LOW(reg));
+			reg++;
+		}
 	}
 
 #ifdef FRAME_FILTER_DEBUG
-- 
2.20.1

