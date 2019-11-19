Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A34FC43141
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CFC20672
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574143593;
	bh=5jKDS4f6adCK47ipLVZiaAL1ffsI2Sc6gz7VkiAQEZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C5ioDNFWWoZSgkCd1aji+gJiDy0zmTSgyBZ8/Jf6CG57nHf2xcrGTW89TM065ZvbR
	 CSUi3yEvZyM4ZFZ4L03oT4G16KFQH/61asME/W3zyeLmzKQ+3f6M9tE56wKq9KoN53
	 qv/Ox9N0srbARa71w18WQNr0iA8R05rDJRu0P6x8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbfKSFed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:34:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:55240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729675AbfKSFea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:34:30 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E352214DE;
        Tue, 19 Nov 2019 05:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141670;
        bh=5jKDS4f6adCK47ipLVZiaAL1ffsI2Sc6gz7VkiAQEZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bhvp9gNbWapS4gvlcuyh6tWQL0hhuXh1F/Jp391yuQgzGxu6aFDF6vMoAbGML8+Gp
         /U7bWAWkzYGHvqWUGLcYxx0mWMWJliTsig+qQAOVNuLQJpvilYNhBrN3LhSmFPXNsr
         jJVUWq2gaJ7qXLpZm6mluDHb44LNh+QgY1v0wHQo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 241/422] net: socionext: Fix two sleep-in-atomic-context bugs in ave_rxfifo_reset()
Date:   Tue, 19 Nov 2019 06:17:18 +0100
Message-Id: <20191119051414.641566074@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



