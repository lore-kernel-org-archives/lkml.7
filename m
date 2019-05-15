Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CB0C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C933220881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557919439;
	bh=YpaRltusz5HUgRwQJezvHkc0zwN1UqsAkslKGnYyXT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZCWE/Dp0crCOXutg9KdbX0C0qhJnIpT7QUk5HoG1Hg/jpLum1MqN42Amd46QbDIgg
	 iJPFO3XMgtO3oNJB1ZfFtMg+sDCmyHLBZSAqExgomn3gTA5F+Elp7jvSp1Ys7k4gYK
	 vYuaKpQMXwIl6XWXOUvFRRqPnlmyZ5lbtpWX8LdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731747AbfEOLX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:23:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731733AbfEOLXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:23:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CA1320881;
        Wed, 15 May 2019 11:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919433;
        bh=YpaRltusz5HUgRwQJezvHkc0zwN1UqsAkslKGnYyXT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c0sVzK5MLjCUwIRzDeG8aX+u355JPBShZL6rY0iFT19Sw5TCEVwrKmnOk48M+I9yV
         47AM+RVngHgHhWPTVjlc/GYywL+S91HFeu3VDfDuAQd10hbOlsYFu+dgPtrUVURWGA
         nxFc3Od75gYNU5LGmRVP+UImSX8SJOgTX+9XjRW8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.19 072/113] net: fec: manage ahb clock in runtime pm
Date:   Wed, 15 May 2019 12:56:03 +0200
Message-Id: <20190515090658.997993148@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090652.640988966@linuxfoundation.org>
References: <20190515090652.640988966@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit d7c3a206e6338e4ccdf030719dec028e26a521d5 ]

Some SOC like i.MX6SX clock have some limits:
- ahb clock should be disabled before ipg.
- ahb and ipg clocks are required for MAC MII bus.
So, move the ahb clock to runtime management together with
ipg clock.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 30 ++++++++++++++++-------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 7b98bb75ba8ac..ad41ace0a27a5 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1850,13 +1850,9 @@ static int fec_enet_clk_enable(struct net_device *ndev, bool enable)
 	int ret;
 
 	if (enable) {
-		ret = clk_prepare_enable(fep->clk_ahb);
-		if (ret)
-			return ret;
-
 		ret = clk_prepare_enable(fep->clk_enet_out);
 		if (ret)
-			goto failed_clk_enet_out;
+			return ret;
 
 		if (fep->clk_ptp) {
 			mutex_lock(&fep->ptp_clk_mutex);
@@ -1876,7 +1872,6 @@ static int fec_enet_clk_enable(struct net_device *ndev, bool enable)
 
 		phy_reset_after_clk_enable(ndev->phydev);
 	} else {
-		clk_disable_unprepare(fep->clk_ahb);
 		clk_disable_unprepare(fep->clk_enet_out);
 		if (fep->clk_ptp) {
 			mutex_lock(&fep->ptp_clk_mutex);
@@ -1895,8 +1890,6 @@ static int fec_enet_clk_enable(struct net_device *ndev, bool enable)
 failed_clk_ptp:
 	if (fep->clk_enet_out)
 		clk_disable_unprepare(fep->clk_enet_out);
-failed_clk_enet_out:
-		clk_disable_unprepare(fep->clk_ahb);
 
 	return ret;
 }
@@ -3485,6 +3478,9 @@ fec_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(fep->clk_ipg);
 	if (ret)
 		goto failed_clk_ipg;
+	ret = clk_prepare_enable(fep->clk_ahb);
+	if (ret)
+		goto failed_clk_ahb;
 
 	fep->reg_phy = devm_regulator_get(&pdev->dev, "phy");
 	if (!IS_ERR(fep->reg_phy)) {
@@ -3578,6 +3574,9 @@ fec_probe(struct platform_device *pdev)
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 failed_regulator:
+	clk_disable_unprepare(fep->clk_ahb);
+failed_clk_ahb:
+	clk_disable_unprepare(fep->clk_ipg);
 failed_clk_ipg:
 	fec_enet_clk_enable(ndev, false);
 failed_clk:
@@ -3701,6 +3700,7 @@ static int __maybe_unused fec_runtime_suspend(struct device *dev)
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct fec_enet_private *fep = netdev_priv(ndev);
 
+	clk_disable_unprepare(fep->clk_ahb);
 	clk_disable_unprepare(fep->clk_ipg);
 
 	return 0;
@@ -3710,8 +3710,20 @@ static int __maybe_unused fec_runtime_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct fec_enet_private *fep = netdev_priv(ndev);
+	int ret;
 
-	return clk_prepare_enable(fep->clk_ipg);
+	ret = clk_prepare_enable(fep->clk_ahb);
+	if (ret)
+		return ret;
+	ret = clk_prepare_enable(fep->clk_ipg);
+	if (ret)
+		goto failed_clk_ipg;
+
+	return 0;
+
+failed_clk_ipg:
+	clk_disable_unprepare(fep->clk_ahb);
+	return ret;
 }
 
 static const struct dev_pm_ops fec_pm_ops = {
-- 
2.20.1



