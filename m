Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417ACC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4A121783
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498569;
	bh=ygJQPBu2LlwrjY1MmWjJIX7q1jI3QH98eAB3vXm+lQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZeaJg7Te0j3kb4zpAsbNV2GVumRcRpvUU/U57Dzb5K6PkwES9437AwaRzLOVESBPy
	 eDGKSwSqaviTulku9M9+5L83/mJwgzn5sbhcxGtT4hXhyOpR8AZeR5B0RfMMAK2fe0
	 mlaYTZAMdKjAGpZusoKjrbNB1KpWYEkLo+xbmAbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbfKKS4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:56:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:54002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729325AbfKKS4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:56:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7830E20818;
        Mon, 11 Nov 2019 18:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498565;
        bh=ygJQPBu2LlwrjY1MmWjJIX7q1jI3QH98eAB3vXm+lQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OZli4X4ht8byxEYmoaTgExDFEuCLq6YF8YDbgOosDSDShZckCfF+05EhpEwrJayDa
         jTfRF2hj2S3vlwtFFYdA3DbfQrQkK6VRYqQW9eYGA4WaVw59dK6gJUAAkpF6VZ43Zy
         p3wc9TgvWKLlsX1kuJMiKV+ibZ3gNqa1D+2uExTM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        yuqi jin <jinyuqi@huawei.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 116/193] net: stmmac: Fix the problem of tso_xmit
Date:   Mon, 11 Nov 2019 19:28:18 +0100
Message-Id: <20191111181509.701697275@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181459.850623879@linuxfoundation.org>
References: <20191111181459.850623879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yuqi jin <jinyuqi@huawei.com>

[ Upstream commit 34c15202896d11e3974788daf9005a84ec45f7a2 ]

When the address width of DMA is greater than 32, the packet header occupies
a BD descriptor. The starting address of the data should be added to the
header length.

Fixes: a993db88d17d ("net: stmmac: Enable support for > 32 Bits addressing in XGMAC")
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Jose Abreu <joabreu@synopsys.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Signed-off-by: yuqi jin <jinyuqi@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index fe2d3029de5ea..ed0e694a08553 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2906,6 +2906,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	} else {
 		stmmac_set_desc_addr(priv, first, des);
 		tmp_pay_len = pay_len;
+		des += proto_hdr_len;
 	}
 
 	stmmac_tso_allocator(priv, des, tmp_pay_len, (nfrags == 0), queue);
-- 
2.20.1



