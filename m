Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3116CC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A0A21D7D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576518714;
	bh=TxoSz7TkwdnUjXZt9RTN9BUnzEUrIDKj8I2WYqaDgJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OL+b2WouPb562spqBcN0KzZz8CPH7svtHapWIRzvljKdG0yv/YdnFXYEW27Q3VZS+
	 MPt/++JrTgjbq+UPJOVra5/9FeeBT2Du68ViWWQ7b+X/nYZxnwB5L3WqM6AU4XXTr8
	 2EcmWFotHcqGKVjFu+YrYjUN1ck+5Jy7C5yEH55Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfLPRvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:51:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:42486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727191AbfLPRvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:51:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AD8C206EC;
        Mon, 16 Dec 2019 17:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518709;
        bh=TxoSz7TkwdnUjXZt9RTN9BUnzEUrIDKj8I2WYqaDgJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IVUzK+EmU7rUsFR3RtCmEJx+R28MJBQACDk5TniCXx4gzWAUnYAYU61roSIaHJPVx
         aNyy7wVY4QF2noPXk3WIEhv5xoreCvBQhtL3cq7jfE+Fa9mXcC0Vnq4vCAl/Fro5Jt
         kGc+6IMaP3+bp/hUKdPBXuFWPzm+yr7Ipc0X/w0o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 035/267] clk: rockchip: fix rk3188 sclk_mac_lbtest parameter ordering
Date:   Mon, 16 Dec 2019 18:46:01 +0100
Message-Id: <20191216174852.861227360@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko@sntech.de>

[ Upstream commit ac8cb53829a6ba119082e067f5bc8fab3611ce6a ]

Similar to commit a9f0c0e56371 ("clk: rockchip: fix rk3188 sclk_smc
gate data") there is one other gate clock in the rk3188 clock driver
with a similar wrong ordering, the sclk_mac_lbtest. So fix it as well.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/rockchip/clk-rk3188.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index 022fecc9bcdf9..8cdfcd77e3ad9 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -362,8 +362,8 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 			RK2928_CLKGATE_CON(2), 5, GFLAGS),
 	MUX(SCLK_MAC, "sclk_macref", mux_sclk_macref_p, CLK_SET_RATE_PARENT,
 			RK2928_CLKSEL_CON(21), 4, 1, MFLAGS),
-	GATE(0, "sclk_mac_lbtest", "sclk_macref",
-			RK2928_CLKGATE_CON(2), 12, 0, GFLAGS),
+	GATE(0, "sclk_mac_lbtest", "sclk_macref", 0,
+			RK2928_CLKGATE_CON(2), 12, GFLAGS),
 
 	COMPOSITE(0, "hsadc_src", mux_pll_src_gpll_cpll_p, 0,
 			RK2928_CLKSEL_CON(22), 0, 1, MFLAGS, 8, 8, DFLAGS,
-- 
2.20.1



