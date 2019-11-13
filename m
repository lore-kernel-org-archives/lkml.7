Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CA8C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B6321783
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573610750;
	bh=sVtcO+U1juXAv6eN2pXeaR+Df+VAxnRnido9Jj2MtyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RVze1tgIqwORb1UcjR2xVgtIqC4z0WLDOLhCid4J9376xk2/YmYil8Rr9wFgUHeoU
	 E5ArAorYsEvktNcmY2j/mMfpFTuQu1mw1Sjd6+ob90ETHVUcohFUrHzzDJO4eQ9IpJ
	 7YgCM4nKtVpjzIZjUpKJlUGti8wTAzYFfFvEDI6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730604AbfKMCFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:05:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:57366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730754AbfKMCB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 21:01:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A351C2247F;
        Wed, 13 Nov 2019 02:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610487;
        bh=sVtcO+U1juXAv6eN2pXeaR+Df+VAxnRnido9Jj2MtyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kx4fivb9d/iUh4xwxZaUId03ADa9IGgjRQDy+goZPv8DmH5GLN9TVPj6qNg7kD6vw
         fpNbRkZ63jtAVHM+37ADLZx6j0gdOCvw2NlmYGni35RHjs8tmQNiB3bGckSFSsF/vM
         1Bg6W+tU6hBMopsOP2c6iIXrbsdIT+P0VvuqWZZs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Huibin Hong <huibin.hong@rock-chips.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 4.9 67/68] spi: rockchip: initialize dma_slave_config properly
Date:   Tue, 12 Nov 2019 20:59:31 -0500
Message-Id: <20191113015932.12655-67-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015932.12655-1-sashal@kernel.org>
References: <20191113015932.12655-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huibin Hong <huibin.hong@rock-chips.com>

[ Upstream commit dd8fd2cbc73f8650f651da71fc61a6e4f30c1566 ]

The rxconf and txconf structs are allocated on the
stack, so make sure we zero them before filling out
the relevant fields.

Signed-off-by: Huibin Hong <huibin.hong@rock-chips.com>
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-rockchip.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 0f89c2169c244..3a94f465e8e05 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -443,6 +443,9 @@ static int rockchip_spi_prepare_dma(struct rockchip_spi *rs)
 	struct dma_slave_config rxconf, txconf;
 	struct dma_async_tx_descriptor *rxdesc, *txdesc;
 
+	memset(&rxconf, 0, sizeof(rxconf));
+	memset(&txconf, 0, sizeof(txconf));
+
 	spin_lock_irqsave(&rs->lock, flags);
 	rs->state &= ~RXBUSY;
 	rs->state &= ~TXBUSY;
-- 
2.20.1

