Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B106FC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85AC121655
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573353628;
	bh=5jKDS4f6adCK47ipLVZiaAL1ffsI2Sc6gz7VkiAQEZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b5hCrLfYLAQeHpUBVzK9BrSYw8QTCvazoh5YvSKRaNaDUZ6ODypcrqy2cZiFsptoa
	 jFaeA3LmVUXm9yJpeulnbLuLGyujPGiuTESXLg1Woc4Uej/xtF2Soet8SHd1ArISko
	 9vfgrEEbdRx0M6wCCkaybk3GkY5USK1oq8QkpFLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfKJCk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:40:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:33270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbfKJCkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:40:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D659D214E0;
        Sun, 10 Nov 2019 02:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353622;
        bh=5jKDS4f6adCK47ipLVZiaAL1ffsI2Sc6gz7VkiAQEZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fuNV6S7B3PZ3UFd4wCL9Sfn1Q0ewkTT9q8AZ3iBQDbXG/giCTQESQez1/yIWTXK23
         //X4PcYOXADO/SCf7fvA2nW3I5OXpFneudErsfj+HuYmXuJ/d6RmJCW+V2YIhZABYZ
         BnCItkMLGPpPJDk+5bpQ5mY531o9IN3v/X8esA40=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 007/191] net: socionext: Fix two sleep-in-atomic-context bugs in ave_rxfifo_reset()
Date:   Sat,  9 Nov 2019 21:37:09 -0500
Message-Id: <20191110024013.29782-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>

[ Upstream commit 0020f5c807ef67954d9210eea0ba17a6134cdf7d ]

The driver may sleep with holding a spinlock.
The function call paths (from bottom to top) in Linux-4.17 are:

[FUNC] usleep_range
drivers/net/ethernet/socionext/sni_ave.c, 892:
	usleep_range in ave_rxfifo_reset
drivers/net/ethernet/socionext/sni_ave.c, 932:
	ave_rxfifo_reset in ave_irq_handler

[FUNC] usleep_range
drivers/net/ethernet/socionext/sni_ave.c, 888:
	usleep_range in ave_rxfifo_reset
drivers/net/ethernet/socionext/sni_ave.c, 932:
	ave_rxfifo_reset in ave_irq_handler

To fix these bugs, usleep_range() is replaced with udelay().

These bugs are found by my static analysis tool DSAC.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/socionext/sni_ave.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
index f27d67a4d3045..09d25b87cf7c0 100644
--- a/drivers/net/ethernet/socionext/sni_ave.c
+++ b/drivers/net/ethernet/socionext/sni_ave.c
@@ -906,11 +906,11 @@ static void ave_rxfifo_reset(struct net_device *ndev)
 
 	/* assert reset */
 	writel(AVE_GRR_RXFFR, priv->base + AVE_GRR);
-	usleep_range(40, 50);
+	udelay(50);
 
 	/* negate reset */
 	writel(0, priv->base + AVE_GRR);
-	usleep_range(10, 20);
+	udelay(20);
 
 	/* negate interrupt status */
 	writel(AVE_GI_RXOVF, priv->base + AVE_GISR);
-- 
2.20.1

