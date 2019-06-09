Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CEEC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F1B2070B
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099136;
	bh=jlmm+uNC1TnX0UeYFe/dky9+1HbJUhs2EOBbUH01oME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eAmhqmvlgAfyOrssujBKX7TiDHw0BtS+A7eIRk++C++RIiejq3zUkuCFxnLxGcIbg
	 3YMLOqXN1hlusEyyID2z4LAV0s7oMiJbdbyhywECZR+21W3CFg8hBk6U5+lW2w5bMY
	 WfsUWVtvUmqzx+hUBql5e/BFOZaygQK18bzxA71Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732169AbfFIQwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:52:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732154AbfFIQwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:52:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 043FC205ED;
        Sun,  9 Jun 2019 16:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099133;
        bh=jlmm+uNC1TnX0UeYFe/dky9+1HbJUhs2EOBbUH01oME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ne4HONOWGOy4JL9A1ekR9j4CRGFxqWwSwkW7AINnFoVjFASLCmwyBTqCbqgcmu1eL
         NC+Lo9+/zn+K1J+AlnJmorgDdDRkv5tsPl9qwWTqW54yXhEujMDMtOcBtQeB0QjeO9
         dit6/RjHLfTi0B+mGGcvo6PdCDiuMIU6BzBs9iyw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>,
        Fugang Duan <fugang.duan@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 03/83] net: fec: fix the clk mismatch in failed_reset path
Date:   Sun,  9 Jun 2019 18:41:33 +0200
Message-Id: <20190609164128.000385686@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.843327870@linuxfoundation.org>
References: <20190609164127.843327870@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Duan <fugang.duan@nxp.com>

[ Upstream commit ce8d24f9a5965a58c588f9342689702a1024433c ]

Fix the clk mismatch in the error path "failed_reset" because
below error path will disable clk_ahb and clk_ipg directly, it
should use pm_runtime_put_noidle() instead of pm_runtime_put()
to avoid to call runtime resume callback.

Reported-by: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
Tested-by: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/fec_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3508,7 +3508,7 @@ failed_init:
 	if (fep->reg_phy)
 		regulator_disable(fep->reg_phy);
 failed_reset:
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 failed_regulator:
 failed_clk_ipg:


