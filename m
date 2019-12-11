Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C34C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF4A8208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077466;
	bh=pubCTkrCkhZj7X++vRS2rMOHfvdcsJt/QGAIfJPsMeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vT+O46KYjcKj66MHlHhC7rHeHpBD9QmQIzIxyJmx57BF+vs2HTF6q/dvWZI/UnM3H
	 L6ZPpNeOOrxBMx9mIjxxk4rlg2YxIDECOPKbTwgdcrBJpMi72lH7uwjwWrkY+VENsF
	 G1+qN8xFN+NinolViUeo3BnqA/6eYyYy+t7Lwdj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731406AbfLKPRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:17:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:45160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732047AbfLKPRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:17:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C96EC20663;
        Wed, 11 Dec 2019 15:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077460;
        bh=pubCTkrCkhZj7X++vRS2rMOHfvdcsJt/QGAIfJPsMeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I4NaaEzbh7lgE7I30q24Uv42DibxXQDbRjr5yWw44lRV8fMsIlfXfmsUYoCxt1/LX
         F4eiSLXvQDocgDA4b4NPY8uMMsFrbxyJqJPR1cgyucsvdJzgqZ8UmJd7SX2MGaExFz
         aVPltaJzxJ1lwVkMdB5dCDQ1faZWE9nW/u59ZdMs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Finley Xiao <finley.xiao@rock-chips.com>,
        Johan Jonker <jbx9999@hotmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 047/243] clk: rockchip: fix rk3188 sclk_smc gate data
Date:   Wed, 11 Dec 2019 16:03:29 +0100
Message-Id: <20191211150342.281836798@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
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
index 69fb3afc970fb..9a6ad5a4cdf06 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -391,8 +391,8 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
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



