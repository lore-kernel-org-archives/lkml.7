Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCFEC00523
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 03:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88ABC217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 03:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578280189;
	bh=bUleWiSui0OeFOKynscfUZWPrYZMG7BHsBIGW0ViyGI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ferHTEhpFMG6GJtIvwvfM++GJMV/xd7dTpvmSRQ4w1hA0HhQyeTA0o4+NP15he6Hl
	 XIH+RjU9MVoos8ZwsKgR+axVKKj3QWBr48h3zrelWO/GSFB0h+Tkx9X/08N4a+yyR3
	 hJdsZmPyM1Rv28eviMTbeGw6w6Mh5b9PHrz9yViI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgAFDJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 22:09:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:34028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbgAFDJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 22:09:48 -0500
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 572D321582;
        Mon,  6 Jan 2020 03:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578280187;
        bh=bUleWiSui0OeFOKynscfUZWPrYZMG7BHsBIGW0ViyGI=;
        h=From:To:Cc:Subject:Date:From;
        b=OlmUl5r/Uqc8ayGPJj9filxnOVwlb0Sk0xcEdvgck8Zi/ONUlE+KjbRDDyygis0N8
         Ts+Fr1oCrb78cPPGrHPTdoJRA4A5FZgYPYy3Th7WO+CCcZlPwctxoPe3lg9vp3baXj
         8GMytWb9Z6I23+QwRK3ZMpbTr3voAI8yn3pZktwI=
Received: by wens.tw (Postfix, from userid 1000)
        id E92845FCEC; Mon,  6 Jan 2020 11:09:45 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH netdev] net: stmmac: dwmac-sun8i: Allow all RGMII modes
Date:   Mon,  6 Jan 2020 11:09:45 +0800
Message-Id: <20200106030945.19774-1-wens@kernel.org>
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

Fixes: 9f93ac8d4085 ("net-next: stmmac: Add dwmac-sun8i")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Maybe CC stable so future device trees can be used with stable kernels?
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 1c8d84ed8410..01b484cb177e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -957,6 +957,9 @@ static int sun8i_dwmac_set_syscon(struct stmmac_priv *priv)
 		/* default */
 		break;
 	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
 		reg |= SYSCON_EPIT | SYSCON_ETCS_INT_GMII;
 		break;
 	case PHY_INTERFACE_MODE_RMII:
-- 
2.24.1

