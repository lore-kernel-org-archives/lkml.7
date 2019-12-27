Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA1AC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A46F222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577468626;
	bh=OZUr5Cjv1zABO9ans+RYHATrdhV6+Iz8cCMaXuqXCPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=idRpGybI2w/W9bM7zL+ihl5h7KUQLqqfvgRJwkrDiXqqEeDCtBW/2WfvgW+l1f4JP
	 54hSz2+jAmsEuJur3vjWXkEE26E9/QpzXiyQ+c6GGeZMkXfdHZrfRFpNnfs3uHVEw5
	 DcgKDMVlTYv1O6RLMPiAGBZQKcfc5TFFjMldhP/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfL0Rnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:43:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:41036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727761AbfL0Rna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:43:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 009BD222C2;
        Fri, 27 Dec 2019 17:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468609;
        bh=OZUr5Cjv1zABO9ans+RYHATrdhV6+Iz8cCMaXuqXCPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pFdPpMHTYhw0OCZ4sFSGfXHbDEZbMrBb8tnenig7iYxadOZQHO6MlgUkoAKc6gA8z
         3L/LoGm4qgjQsXuInVuZHE+katDY0AMRSlNAuAem9cmBJZPl9g6ZA8hLkmJ3If/CQP
         MfyG5XTChIQXhIBU9E3Z3J1WyLab+vvuky2a26hU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 129/187] net: gemini: Fix memory leak in gmac_setup_txqs
Date:   Fri, 27 Dec 2019 12:39:57 -0500
Message-Id: <20191227174055.4923-129-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174055.4923-1-sashal@kernel.org>
References: <20191227174055.4923-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit f37f710353677639bc5d37ee785335994adf2529 ]

In the implementation of gmac_setup_txqs() the allocated desc_ring is
leaked if TX queue base is not aligned. Release it via
dma_free_coherent.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index a8f4c69252ff..2814b96751b4 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -576,6 +576,8 @@ static int gmac_setup_txqs(struct net_device *netdev)
 
 	if (port->txq_dma_base & ~DMA_Q_BASE_MASK) {
 		dev_warn(geth->dev, "TX queue base is not aligned\n");
+		dma_free_coherent(geth->dev, len * sizeof(*desc_ring),
+				  desc_ring, port->txq_dma_base);
 		kfree(skb_tab);
 		return -ENOMEM;
 	}
-- 
2.20.1

