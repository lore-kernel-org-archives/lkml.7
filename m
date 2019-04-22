Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6EEC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DECA3204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963754;
	bh=d3aVzVOZCiHSVip17vUI78pTlExo1cGf3iqgelxIjuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sOciqCwfGZmF72BT46ajTQgDF0M/eaIV9QDlRVs+NnW/giLtEXkjYRINJSTmw+KAj
	 BN2YL1CN+j0Y+LikMOvCV2TMGuGxvAP355R1euFqklLPjQWwBJhg7ks+GoRB9HSgE2
	 7UcnTN9mYpdubmb6yOU60JIfS1MoDwVticFpBd5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732510AbfDVUJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:09:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729235AbfDVTnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:43:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0BC8218B0;
        Mon, 22 Apr 2019 19:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962224;
        bh=d3aVzVOZCiHSVip17vUI78pTlExo1cGf3iqgelxIjuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kDcJEaE+5VX/oy7wRywamcAZrEkCB5G7SiXXLgcH75cJZt8uWPDDM89Y+WjU+X6Uk
         lInQfYOAJYgfaT5QWEdC5+1nQo8YL23r14/otoQGdNHNT+YN9SBjYEC3TZ4H7bYMJ3
         Yh8rXOvt30mxuo4JXDTMZK6cos+M5FaEnZ6m2kq8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Harini Katakam <harini.katakam@xilinx.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 46/98] net: macb: Add null check for PCLK and HCLK
Date:   Mon, 22 Apr 2019 15:41:13 -0400
Message-Id: <20190422194205.10404-46-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
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
index 2b2882615e8b..6cbe515bfdeb 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3318,14 +3318,20 @@ static int macb_clk_init(struct platform_device *pdev, struct clk **pclk,
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

