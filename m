Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA39C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1EF24679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576780963;
	bh=aqIbJSkhCpwjI614QJ8BVlhuPCOqXLLV7TjjBUWAqzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EZZzxyjrI9NC8gxxdTm9Ej1K2jC7dBnz+NvgZt9ypZy1t2iMYR+tGJWQ4sGzrQxtT
	 N1wPjwK86RJupQogQ9AKueK6ZBlYibe8PkQW4MCnV8vzkhMWB6IpOl4jc3LxKOJlN6
	 2btQFKCXHBJh8pDQV3J9cUy6G5Muq/12ZwrqHyhU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfLSSmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:42:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:33882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728160AbfLSSmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:42:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23CB5206D7;
        Thu, 19 Dec 2019 18:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780955;
        bh=aqIbJSkhCpwjI614QJ8BVlhuPCOqXLLV7TjjBUWAqzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lq3uvGSE+ROvjUCfAFlOGY59KXckjBDsaY34GEQ1cwGtXgjqDlwMzimhzmlusSeXd
         ixxwkx5M4cMJR0MMmjPe2YIjXJiMuKZk4yhLV/abwHzo/hoKZNSpZqLo0FKMEEd7y0
         4A7o85jpNoqMRSlu6/KWrsIQ/EuKhQPZlX7lhLHQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Finley Xiao <finley.xiao@rock-chips.com>,
        Johan Jonker <jbx9999@hotmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 023/199] clk: rockchip: fix rk3188 sclk_smc gate data
Date:   Thu, 19 Dec 2019 19:31:45 +0100
Message-Id: <20191219183216.093123995@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183214.629503389@linuxfoundation.org>
References: <20191219183214.629503389@linuxfoundation.org>
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
index 523378d1396e8..a4c49906acf2c 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -390,8 +390,8 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
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



