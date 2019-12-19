Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125F8C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30C724672
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576780545;
	bh=qGW1AnRfHulQuoxOcJ1quQ3TEjBJS6JUQMxrNU41tGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kMYtUwZUf5u6JsQfHu0gxjQzw4LbEpogYI5ibaPlsQxkaDnQUZsitqyCVYb4A1obU
	 OMu4krZDelXdzCElmPa+62pYdk5jZQdybhILvUAo/tfDOVxCfIEvDuLPs7PA7cRIau
	 qE0Op6K37tb5iIHtbBHNAzkNvDXY29/xMMQcToNs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfLSSfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:35:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:52374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbfLSSfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:35:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2C9624679;
        Thu, 19 Dec 2019 18:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780542;
        bh=qGW1AnRfHulQuoxOcJ1quQ3TEjBJS6JUQMxrNU41tGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OcxQ0ZO4zYH7gE3YUn36QYBJbZXLmMtdbtam8IZ5DHFTakWFWdF7dPOJH+uq3IdKw
         XwE2jgBThriX/5jU26+wxNF4N7j3HOSPV1g94Ke1VZc7AecJQX0IRIwAfc4r9vH3We
         HOFlCwLr7AOWpjRs784fgviV1SFZhoHT4iUn/wGo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Finley Xiao <finley.xiao@rock-chips.com>,
        Johan Jonker <jbx9999@hotmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 017/162] clk: rockchip: fix rk3188 sclk_smc gate data
Date:   Thu, 19 Dec 2019 19:32:05 +0100
Message-Id: <20191219183207.397022772@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183150.477687052@linuxfoundation.org>
References: <20191219183150.477687052@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finley Xiao <finley.xiao@rock-chips.com>

[ Upstream commit a9f0c0e563717b9f63b3bb1c4a7c2df436a206d9 ]

Fix sclk_smc gate data.
Change variable order, flags come before the register address.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
Signed-off-by: Johan Jonker <jbx9999@hotmail.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/rockchip/clk-rk3188.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index fe728f8dcbe43..986a558c361d6 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -360,8 +360,8 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 	 * Clock-Architecture Diagram 4
 	 */
 
-	GATE(SCLK_SMC, "sclk_smc", "hclk_peri",
-			RK2928_CLKGATE_CON(2), 4, 0, GFLAGS),
+	GATE(SCLK_SMC, "sclk_smc", "hclk_peri", 0,
+			RK2928_CLKGATE_CON(2), 4, GFLAGS),
 
 	COMPOSITE_NOMUX(SCLK_SPI0, "sclk_spi0", "pclk_peri", 0,
 			RK2928_CLKSEL_CON(25), 0, 7, DFLAGS,
-- 
2.20.1



