Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B295CC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801FA204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962926;
	bh=rwGrOwHSnew7NmvlM9kD2BDrn4R/GtgVlZUXFFvcwGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a9YiR3CD6yUq486tkVnlBIFF5SeFT9TPgZ7jrN7x1uEZprwJmRGibDzRi4DabAa48
	 pNURwtfEXsdl2UR4JHRb6yE17+4qhUlRxy4Ha6CrGtQqIVo8X5FGYkFyHGoyjmNEfa
	 esfcD7pdaMaOVFD49bgnbFtdgaGlzKpgXmi1cCKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731574AbfDVTzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:55:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730834AbfDVTt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:49:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D047C2177B;
        Mon, 22 Apr 2019 19:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962566;
        bh=rwGrOwHSnew7NmvlM9kD2BDrn4R/GtgVlZUXFFvcwGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U5QKWoiF9QygP07jV3gSmd0RkBjDNw9GK0aika7rLu+6y2EFRPxbaX6ulhXZxSoIx
         Nu1hyS3Pmn4oewB1v3m4IL9wNoL3cKlbY5aMHT9YJslg9vzosXsgD7iy334jFjcP1U
         fLvzqa01YlbHGPROXVCQBIbszhCP8sBZ3FTtKsYM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Yang <wen.yang99@zte.com.cn>,
        Anirudha Sarangi <anirudh@xilinx.com>,
        John Linn <John.Linn@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 18/29] net: xilinx: fix possible object reference leak
Date:   Mon, 22 Apr 2019 15:48:37 -0400
Message-Id: <20190422194848.13049-18-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194848.13049-1-sashal@kernel.org>
References: <20190422194848.13049-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wen.yang99@zte.com.cn>

[ Upstream commit fa3a419d2f674b431d38748cb58fb7da17ee8949 ]

The call to of_parse_phandle returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1624:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 1569, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Anirudha Sarangi <anirudh@xilinx.com>
Cc: John Linn <John.Linn@xilinx.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index c688d68c39aa..a8afc92cbfca 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1548,12 +1548,14 @@ static int axienet_probe(struct platform_device *pdev)
 	ret = of_address_to_resource(np, 0, &dmares);
 	if (ret) {
 		dev_err(&pdev->dev, "unable to get DMA resource\n");
+		of_node_put(np);
 		goto free_netdev;
 	}
 	lp->dma_regs = devm_ioremap_resource(&pdev->dev, &dmares);
 	if (IS_ERR(lp->dma_regs)) {
 		dev_err(&pdev->dev, "could not map DMA regs\n");
 		ret = PTR_ERR(lp->dma_regs);
+		of_node_put(np);
 		goto free_netdev;
 	}
 	lp->rx_irq = irq_of_parse_and_map(np, 1);
-- 
2.19.1

