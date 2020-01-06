Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B303C00523
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 03:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A5621734
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 03:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578280177;
	bh=xHb/l1cvNs4OtUnPX8KlTG+ZY0RxRjIS8lEPUdRsFp4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ku7PZcsYJu+R8Gj2ZJQc5qhbDJK9J+cuFIvARuDPJZ8XAU+n6+Pp1djGmka2hRInA
	 jcAoNdOWjW/m3DL8TJcftx53jgi2humHkLyXONXEt4u+ZQZIA22wCtvUsqbQfTEtmt
	 jWFj04RmSURdSmIm98ZajHrbHED7d51DC/GGk7AU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgAFDJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 22:09:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:33758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbgAFDJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 22:09:34 -0500
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ECE121582;
        Mon,  6 Jan 2020 03:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578280174;
        bh=xHb/l1cvNs4OtUnPX8KlTG+ZY0RxRjIS8lEPUdRsFp4=;
        h=From:To:Cc:Subject:Date:From;
        b=ioZ57txjBXqosSU9+Ua4EgHyFFQfvl4lq5y80vmH/+c9SxRuX1WgaS/CW2TXJt5NL
         prb5JK5IJD55HfssQNZ54rTSF5XrkpnkfdaJjyAuHeEd8rxtG/HcM6hJbsqUxrwGS3
         Vgk0yz4WaQlt0kYEXbE6rwxdNmV5MUYe5p7Bh6pc=
Received: by wens.tw (Postfix, from userid 1000)
        id 34AEB5FCEC; Mon,  6 Jan 2020 11:09:32 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH netdev] net: stmmac: dwmac-sunxi: Allow all RGMII modes
Date:   Mon,  6 Jan 2020 11:09:22 +0800
Message-Id: <20200106030922.19721-1-wens@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Allow all the RGMII modes to be used. This would allow us to represent
the hardware better in the device tree with RGMII_ID where in most
cases the PHY's internal delay for both RX and TX are used.

Fixes: af0bd4e9ba80 ("net: stmmac: sunxi platform extensions for GMAC in Allwinner A20 SoC's")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Maybe CC stable so future device trees can be used with stable kernels?
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
index 26353ef616b8..7d40760e9ba8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
@@ -44,7 +44,7 @@ static int sun7i_gmac_init(struct platform_device *pdev, void *priv)
 	 * rate, which then uses the auto-reparenting feature of the
 	 * clock driver, and enabling/disabling the clock.
 	 */
-	if (gmac->interface == PHY_INTERFACE_MODE_RGMII) {
+	if (phy_interface_mode_is_rgmii(gmac->interface)) {
 		clk_set_rate(gmac->tx_clk, SUN7I_GMAC_GMII_RGMII_RATE);
 		clk_prepare_enable(gmac->tx_clk);
 		gmac->clk_enabled = 1;
-- 
2.24.1

