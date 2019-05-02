Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5F6C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F762081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556811415;
	bh=XOoIZXUcB+RNeucMSb7LWkOxPRIBwr4WRUQ5danWtXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GBwxGyBoodQe6yYfdAfB/3f0tAClCTFxbCMVfvSCYZV7toOSyV9ihdKuyX2W04QMY
	 /GVNt1w6hQ0MJG4JR0R6ETXwUEEWXzhUqVFDEAuwScvGPEhHP61l9QqLRe4ija0G91
	 DLyRLqjokX/+fC3SlsZF4pxR2zX8Ls397UoVi4M4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbfEBPgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:36:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727496AbfEBPal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:30:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 261D52081C;
        Thu,  2 May 2019 15:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556811040;
        bh=XOoIZXUcB+RNeucMSb7LWkOxPRIBwr4WRUQ5danWtXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CHeKYdJvmSkO+mZRlJIfTkBCFpqA0pSbbs6n9B4p7n4DM3VaG/s2G59DFMDR36BQ6
         RjarvneJxrZ8uAWOQ2POAj+ZvICztsuqCt3cBSAgYgWzavf1QMZEFNpYr19hFovKYF
         92bdjROjsX356aR274riD406fvfxR7cyfH9I85Fo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Harini Katakam <harini.katakam@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 5.0 051/101] net: macb: Add null check for PCLK and HCLK
Date:   Thu,  2 May 2019 17:20:53 +0200
Message-Id: <20190502143343.099947781@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143339.434882399@linuxfoundation.org>
References: <20190502143339.434882399@linuxfoundation.org>
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



