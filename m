Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACE8C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB0D204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556812026;
	bh=nUB5IZFtHI+purIs8RbbHWZy1zApJU1NDmRUnwkVuMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KNei7xesIDw251A0HdQmxAQm+eLlcUVw49MO7hfa+1u1m9YrQiHMTO5MxiGOCs+tl
	 38XBhU7+UgT91Zrmrh98NVnYZvlDQR7VMANDlFOufmaVAD4DrGA0wk5KPc/AcQHEpT
	 WCAILwUAIEB072qOwrrqCRWWUMFu1Jn98GaFiwp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfEBPrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:47:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727337AbfEBPYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:24:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19D562085A;
        Thu,  2 May 2019 15:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810675;
        bh=nUB5IZFtHI+purIs8RbbHWZy1zApJU1NDmRUnwkVuMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b+TbuVcsw9/QaY83uYVGK/AQiUEbXONP63qGS7yMy3RMU3AjuMftZfhtkjuae+VCQ
         REPbL7cYQJQCJse14QOymWnCV3hLTydl2JdPCVxHg20OPzZBjkznaTpCez4Q/7jbwn
         jXZDmZIpwYJl/ohLjQTTVZf8fCXy+WTtsC6BPEiQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Harini Katakam <harini.katakam@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.14 29/49] net: macb: Add null check for PCLK and HCLK
Date:   Thu,  2 May 2019 17:21:06 +0200
Message-Id: <20190502143327.603851682@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143323.397051088@linuxfoundation.org>
References: <20190502143323.397051088@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



