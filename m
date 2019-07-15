Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A8AC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 214C42086C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563200981;
	bh=DreiOdjm8WobQPPBowLREl4dmfasObT6DeaO0QurAKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aNwBqEcn7WL/TSMAlYshcUoalORquvSmTJVblsBuAp1xqTe+1rTta/hUvjhL1uTpb
	 ++H1RY6c5n7kFgZe2V8slXIS5NoPDwmzbb5I37+1ZNzs+9cZjxwP+jJawxrZtYiD0V
	 ZZ3VcrsDIHpLwoHGUDj5gfnly1mBUu4O/tYY3Nvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391155AbfGOO3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:29:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731218AbfGOO3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:29:32 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F850216C4;
        Mon, 15 Jul 2019 14:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563200971;
        bh=DreiOdjm8WobQPPBowLREl4dmfasObT6DeaO0QurAKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DM/VxyJZslaNb6+KIKXq3zR5LydyUSe2ovfZ+R/ukW2Eyo6ti5xPq+XCyjZihhAv4
         xmgzN206+pSC1US7Rhe2linc1lbdNLOiXcP8WBsoeclg7sPMMutkdBVK9y4WjxnMqr
         8Apt4OxMQvhHRrm5lUVrKvR36MclWx8rlsh0XZHg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 014/105] net: stmmac: dwmac1000: Clear unused address entries
Date:   Mon, 15 Jul 2019 10:27:08 -0400
Message-Id: <20190715142839.9896-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715142839.9896-1-sashal@kernel.org>
References: <20190715142839.9896-1-sashal@kernel.org>
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
index 540d21786a43..08dd6a06ac58 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -217,6 +217,12 @@ static void dwmac1000_set_filter(struct mac_device_info *hw,
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

