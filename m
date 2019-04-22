Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A810C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0C42190C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962504;
	bh=koNLR2dhJfOSYWAq2CenrOWJITwrlpU5L5ctqozZLcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0+SJ/zLZ/N4sKY4bd5GD6neLr0+tOJlOL55lNr+WOu0PUi7hAZgGT+2qy/MzZ7f86
	 TsPSLhe3ic8cjkYCkyzlpjIdBbz+d0XGkQ//MrIrJHGIRYMrvdXJ+89ct0KPgFIpOa
	 qaqCk1gOqlYs2/IMY1hiijvRBV7DBSO0X48tqqTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbfDVTsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:48:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730500AbfDVTsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:48:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81A1121902;
        Mon, 22 Apr 2019 19:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962499;
        bh=koNLR2dhJfOSYWAq2CenrOWJITwrlpU5L5ctqozZLcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dLR0tMhMrgXtwTsNfR1Abf4kWVoThCSJgTsCJQ04G2hy2JI+08CzSW6s8mWmOpv8e
         LE1/652Im8ak4ck3PmXzC9N0USZCLw9JJzdgQRbEVmsp783Z9HFOqB4J0+sRDb5CsP
         7SvjBrRlfHLJlBP5YfYcQrFfSPvxZ25IyjSkV8g8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Harini Katakam <harini.katakam@xilinx.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 22/43] net: macb: Add null check for PCLK and HCLK
Date:   Mon, 22 Apr 2019 15:47:06 -0400
Message-Id: <20190422194727.12495-22-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194727.12495-1-sashal@kernel.org>
References: <20190422194727.12495-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harini Katakam <harini.katakam@xilinx.com>

[ Upstream commit cd5afa91f078c0787be0a62b5ef90301c00b0271 ]

Both PCLK and HCLK are "required" clocks according to macb devicetree
documentation. There is a chance that devm_clk_get doesn't return a
negative error but just a NULL clock structure instead. In such a case
the driver proceeds as usual and uses pclk value 0 to calculate MDC
divisor which is incorrect. Hence fix the same in clock initialization.

Signed-off-by: Harini Katakam <harini.katakam@xilinx.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 9046993947cc..2287749de087 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2817,14 +2817,20 @@ static int macb_clk_init(struct platform_device *pdev, struct clk **pclk,
 		*hclk = devm_clk_get(&pdev->dev, "hclk");
 	}
 
-	if (IS_ERR(*pclk)) {
+	if (IS_ERR_OR_NULL(*pclk)) {
 		err = PTR_ERR(*pclk);
+		if (!err)
+			err = -ENODEV;
+
 		dev_err(&pdev->dev, "failed to get macb_clk (%u)\n", err);
 		return err;
 	}
 
-	if (IS_ERR(*hclk)) {
+	if (IS_ERR_OR_NULL(*hclk)) {
 		err = PTR_ERR(*hclk);
+		if (!err)
+			err = -ENODEV;
+
 		dev_err(&pdev->dev, "failed to get hclk (%u)\n", err);
 		return err;
 	}
-- 
2.19.1

