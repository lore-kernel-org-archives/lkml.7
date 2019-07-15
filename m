Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFB8C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713DA2086C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563199393;
	bh=jHBoahBIMCEqzHHAdyXBu+NzeIwefRJZKUWcMn7yxDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wZwMOTABpir/UV0bRQwYTb0VGAC3chyECMvapIgwPjbheTz7OTb9Igf9p2htD0G7T
	 gDp/3c8QPlFo91MJRBCVs/9fuckpN4HdiwMOnpTaNSjmcq3Ax2V6f1v+p9ArSDQypo
	 vaaZ5v6Q0g3/fPABmmGavgYfgfNYwoWCAGh7JisQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387767AbfGOODM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:03:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387426AbfGOODK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:03:10 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22BCE2086C;
        Mon, 15 Jul 2019 14:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563199389;
        bh=jHBoahBIMCEqzHHAdyXBu+NzeIwefRJZKUWcMn7yxDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wZzyEudCObST4MvKQgt6V059Ls/1p8ZWnpm7WMj9DqDVmXm4jKf1RjpIcADsV9IWw
         2iTeYE3n4BXtBhFA4KtjMj1CGt6Xst6k3cKQGfZSwTW37unSmRak1aDERwCWV1zWqt
         blvKAmrUA3DtXyLpNxH8nXM0IpvCOIElJEyuOCCI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Josua Mayer <josua@solid-run.com>, Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 249/249] net: mvmdio: defer probe of orion-mdio if a clock is not ready
Date:   Mon, 15 Jul 2019 09:46:54 -0400
Message-Id: <20190715134655.4076-249-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134655.4076-1-sashal@kernel.org>
References: <20190715134655.4076-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josua Mayer <josua@solid-run.com>

[ Upstream commit 433a06d7d74e677c40b1148c70c48677ff62fb6b ]

Defer probing of the orion-mdio interface when getting a clock returns
EPROBE_DEFER. This avoids locking up the Armada 8k SoC when mdio is used
before all clocks have been enabled.

Signed-off-by: Josua Mayer <josua@solid-run.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/mvmdio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index c5dac6bd2be4..903836e334d8 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -321,6 +321,10 @@ static int orion_mdio_probe(struct platform_device *pdev)
 
 	for (i = 0; i < ARRAY_SIZE(dev->clk); i++) {
 		dev->clk[i] = of_clk_get(pdev->dev.of_node, i);
+		if (PTR_ERR(dev->clk[i]) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			goto out_clk;
+		}
 		if (IS_ERR(dev->clk[i]))
 			break;
 		clk_prepare_enable(dev->clk[i]);
@@ -362,6 +366,7 @@ static int orion_mdio_probe(struct platform_device *pdev)
 	if (dev->err_interrupt > 0)
 		writel(0, dev->regs + MVMDIO_ERR_INT_MASK);
 
+out_clk:
 	for (i = 0; i < ARRAY_SIZE(dev->clk); i++) {
 		if (IS_ERR(dev->clk[i]))
 			break;
-- 
2.20.1

