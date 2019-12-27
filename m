Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB923C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6A72465A
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577468713;
	bh=VsnUzWIb1/B0uf77UUDZCgonYD6BYjIo8K8Xeu6Q+RU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fdCoJx0Niy0ljqsBRVrrnfOzbbgF/b2gcOvgRmZsiGy9Y9VTK9LcNVfUsp6nWlDuR
	 ORHJsTdfuWgLOBY145hIfA3/1DA2h2vbo/uQ6u4K9/6vALv5jZWs48gIxmIPendQ1q
	 t1Sk3c/hMREy0onbX9fBWfOeOQ4uQlWMZAAMa5o4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbfL0RpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:45:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:43570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728659AbfL0RpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:45:06 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABE2B24650;
        Fri, 27 Dec 2019 17:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468705;
        bh=VsnUzWIb1/B0uf77UUDZCgonYD6BYjIo8K8Xeu6Q+RU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JI5LbRJepwYqB2MGgorAAEZUf79UDhIn2T95IXail98rG/HXyLqn4Kd1Xl15Se+w8
         SstvGe3VtwGs3QmwNzwIzK5DRT1yyMM4/MuODItJNS4p1sFBWNhtJW7SVAYhxCClkl
         KkweooLO6wIZuXlFemDxyUhscO3Volk418hKiqwI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 61/84] net: gemini: Fix memory leak in gmac_setup_txqs
Date:   Fri, 27 Dec 2019 12:43:29 -0500
Message-Id: <20191227174352.6264-61-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174352.6264-1-sashal@kernel.org>
References: <20191227174352.6264-1-sashal@kernel.org>
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
index 4af78de0e077..01a212097836 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -577,6 +577,8 @@ static int gmac_setup_txqs(struct net_device *netdev)
 
 	if (port->txq_dma_base & ~DMA_Q_BASE_MASK) {
 		dev_warn(geth->dev, "TX queue base is not aligned\n");
+		dma_free_coherent(geth->dev, len * sizeof(*desc_ring),
+				  desc_ring, port->txq_dma_base);
 		kfree(skb_tab);
 		return -ENOMEM;
 	}
-- 
2.20.1

