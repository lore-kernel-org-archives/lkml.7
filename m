Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8728C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894E0204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963096;
	bh=S9yDMk8052FYpstZD2e5kcxu4O9PNIbfCY6y3jtg6jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YgUJf85doSCRcshYrGE536qf5R3zQLdVkrE1wN4y5hdHWdfKmpefIP3cORMbRLQcp
	 VQedF/aqyMyoicG8hGY3AXVhquLF0yWQLnoL5W6zG+hpmze88es9SKrJ4j3fZ031nt
	 EVqajeVmMBOqM4Wx942wNeCXu6MZtxq6iJtomK6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbfDVT6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:58:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730528AbfDVTsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:48:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDF5621919;
        Mon, 22 Apr 2019 19:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962504;
        bh=S9yDMk8052FYpstZD2e5kcxu4O9PNIbfCY6y3jtg6jc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a1+DN9ANA5fij/r12A6wULIo8lhwRlYvRWQFkQdC6SU0OboF/jHfjJ9f3Y0PUE8yJ
         x0ZbBHGI6zFCKG4y7M3hlJCEzbmR5JrfdG6tYdFaJfbbdSMXCHxh3pPCn5u92SqDgV
         kqlqMTUurwwsXSlL1Ydqk3cOaM9AWcC44TiNq/qA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Yang <wen.yang99@zte.com.cn>,
        Anirudha Sarangi <anirudh@xilinx.com>,
        John Linn <John.Linn@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 26/43] net: xilinx: fix possible object reference leak
Date:   Mon, 22 Apr 2019 15:47:10 -0400
Message-Id: <20190422194727.12495-26-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194727.12495-1-sashal@kernel.org>
References: <20190422194727.12495-1-sashal@kernel.org>
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
index e74e1e897864..d46dc8cd1670 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1575,12 +1575,14 @@ static int axienet_probe(struct platform_device *pdev)
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

