Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640B5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE87214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411600;
	bh=ZCMPn74y+xtkxANTIeo5m/xp9nTKs1E1cuXFJRnQ7/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dN5sQiJABGxzNFKyKKcmHV4ccnd6s+RnnJFQVCaqdmciUZV+EBT2aeU+SJ+T64kQd
	 DUvaJ7RtQe2BH3+7wpbZIPKagcbWPP9OyH2pJXttho/s/x5Yte3CkGAjZ18O6D7xIB
	 OPjUUM7M+QxAiU/vIOxceqAXy2EotCvXa5SsIzvA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfCLR0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:26:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729719AbfCLRRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:42 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B532921741;
        Tue, 12 Mar 2019 17:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411061;
        bh=ZCMPn74y+xtkxANTIeo5m/xp9nTKs1E1cuXFJRnQ7/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uSDVo7M5gkpXOlNY0uBknwY98FLKZSjHHjgoiA08Tyf1UlFMCuD3q3b8szGNg+GuP
         Ud15GMHBy5gwmW6wJ10sB1zx3NTsUYEXXczmSOz4BvCpTJxxngMlJIDn0aV29yHhWA
         210YVttwlG03pBiKu4ndK9Y+mP4WW5X7hwxlGK/U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 50/96] net: stmmac: dwmac-rk: fix error handling in rk_gmac_powerup()
Date:   Tue, 12 Mar 2019 10:10:08 -0700
Message-Id: <20190312171038.327529721@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c69c29a1a0a8f68cd87e98ba4a5a79fb8ef2a58c ]

If phy_power_on() fails in rk_gmac_powerup(), clocks are left enabled.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index d80c88bd2bba..6e61bccc90b3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -877,8 +877,10 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
 	}
 
 	ret = phy_power_on(bsp_priv, true);
-	if (ret)
+	if (ret) {
+		gmac_clk_enable(bsp_priv, false);
 		return ret;
+	}
 
 	ret = gmac_clk_enable(bsp_priv, true);
 	if (ret)
-- 
2.19.1



