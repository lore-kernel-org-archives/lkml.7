Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9812EC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA3720862
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482979;
	bh=dbyZp+xybfQ+kEBZ9QafyIkcBlBHcHxTME3B22Hds74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MHA111Kp//9lycbLOBmxproyXZwly3RXlbpxKlwR3myJ0IoipZBkbdy1Z7jWy03BO
	 RH4weGaeUbIOFoxx9Q/385GEjA1n+mdWRwhyXzOQdggwPwFRw5F1AETlceZk6yrgOF
	 cTBEvjHor1ak2Pz44Akx4+QRRVjBOaV3/1p/0vro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbfLDSJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:09:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:35416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731076AbfLDSJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:09:33 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5453320674;
        Wed,  4 Dec 2019 18:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482972;
        bh=dbyZp+xybfQ+kEBZ9QafyIkcBlBHcHxTME3B22Hds74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=14y6ceWTOafVBSuoOEIKtisyiFjYdm7BmowtppvT2Rr5VXg4yO5888LD266NIJPON
         lCKkU5wEDtfOvpY+Rtx8cV68pg/CcBxtA8f+R56Cu+4GICkVp9uluKSK6v2zGaGk5w
         pLjkwtX3XBOjN6p7oXbvtpeTo/qjlOOglpL9wD34=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH 4.14 209/209] net: fec: fix clock count mis-match
Date:   Wed,  4 Dec 2019 18:57:01 +0100
Message-Id: <20191204175337.873317389@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

commit a31eda65ba210741b598044d045480494d0ed52a upstream.

pm_runtime_put_autosuspend in probe will call runtime suspend to
disable clks automatically if CONFIG_PM is defined. (If CONFIG_PM
is not defined, its implementation will be empty, then runtime
suspend will not be called.)

Therefore, we can call pm_runtime_get_sync to runtime resume it
first to enable clks, which matches the runtime suspend. (Only when
CONFIG_PM is defined, otherwise pm_runtime_get_sync will also be
empty, then runtime resume will not be called.)

Then it is fine to disable clks without causing clock count mis-match.

Fixes: c43eab3eddb4 ("net: fec: add missed clk_disable_unprepare in remove")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Acked-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/freescale/fec_main.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3565,6 +3565,11 @@ fec_drv_remove(struct platform_device *p
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	struct device_node *np = pdev->dev.of_node;
+	int ret;
+
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0)
+		return ret;
 
 	cancel_work_sync(&fep->tx_timeout_work);
 	fec_ptp_stop(pdev);
@@ -3572,15 +3577,17 @@ fec_drv_remove(struct platform_device *p
 	fec_enet_mii_remove(fep);
 	if (fep->reg_phy)
 		regulator_disable(fep->reg_phy);
-	pm_runtime_put(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
-	clk_disable_unprepare(fep->clk_ahb);
-	clk_disable_unprepare(fep->clk_ipg);
+
 	if (of_phy_is_fixed_link(np))
 		of_phy_deregister_fixed_link(np);
 	of_node_put(fep->phy_node);
 	free_netdev(ndev);
 
+	clk_disable_unprepare(fep->clk_ahb);
+	clk_disable_unprepare(fep->clk_ipg);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
 	return 0;
 }
 


