Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8A5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2672C2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414048;
	bh=kLJco1phXiCRn4BjWT1axPOkmjFfheCa+lCfaTZo2V0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wacKMFXPnN4SUhCj+ptopOtLkI8w3bHxnMtw4OqHcq8yo32vqP5cquZ36M8ZXzV1v
	 MXSlubDW2dCzsJBA6Tfn+aCKZS4r5aMKxKAEiB8A60oKl/2Blqr1jQHXC2ZTNOFdiR
	 h5vz95u09GuvwEzU5bHq7rAh7WnQbfuv0W36Ai94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbfCLSH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:07:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbfCLRMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:21 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3C4521841;
        Tue, 12 Mar 2019 17:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410741;
        bh=kLJco1phXiCRn4BjWT1axPOkmjFfheCa+lCfaTZo2V0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dWx7WZG5yVDw0d6IU/9TEQkynlOiVWpAkc2JMH5Jxdt4M7BvVzfZ1ziyHH9G2F1zM
         V5+2a/jmbqClv0jItEEbW45DRrS0FIU1qIbZT59rjkTshVG5aTPb2Ky1zicpr/DmCb
         +wj47nMcltzmqJg7L6w3nv7uklbJuHrRKoIgmNA8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 035/171] net: stmmac: dwmac-rk: fix error handling in rk_gmac_powerup()
Date:   Tue, 12 Mar 2019 10:06:55 -0700
Message-Id: <20190312170351.076907192@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
index 7b923362ee55..3b174eae77c1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1342,8 +1342,10 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
 	}
 
 	ret = phy_power_on(bsp_priv, true);
-	if (ret)
+	if (ret) {
+		gmac_clk_enable(bsp_priv, false);
 		return ret;
+	}
 
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
-- 
2.19.1



