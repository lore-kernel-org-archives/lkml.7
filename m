Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993C8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68FBF20675
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127263;
	bh=WiBHy1XDhQ9OhFalEV3cJqNk8+TtWecaqYvrI3AQIbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QH66XnTTNX8Jr86rZqbXy1H1JPaDcnHdOtiScdy2ByvAyDfGkMj4AGtIEevLFTtEZ
	 6GZFQ+di55/IULdsolNP8w0s+OdGPw8t+QMzQh4nxsps+v//99Rate6DlgS3Q7ylsI
	 Gw+SdWmPs2pmBWg0lxvkrzlDZZqKLXH+RiH/QICk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391698AbfDXReV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:34:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391320AbfDXReT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:34:19 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3F8520675;
        Wed, 24 Apr 2019 17:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127258;
        bh=WiBHy1XDhQ9OhFalEV3cJqNk8+TtWecaqYvrI3AQIbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=onZJdkMA3QnY03fqw2rRjU48zL+4xtexd61qrjbpW4SjX0jLnA7CBuCzDEOQarOTm
         izAGW7b7bf1M9MybQVWW4WaoufWX4//n0UROk6JzdgGIS6FW8g5DBOym8u5NrFy63x
         fmJtO8DmquBViD+RO7vg8Oi4sP404XkcqF66kh30=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 006/115] net: fec: manage ahb clock in runtime pm
Date:   Wed, 24 Apr 2019 19:09:02 +0200
Message-Id: <20190424170925.307896309@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Duan <fugang.duan@nxp.com>

[ Upstream commit d7c3a206e6338e4ccdf030719dec028e26a521d5 ]

Some SOC like i.MX6SX clock have some limits:
- ahb clock should be disabled before ipg.
- ahb and ipg clocks are required for MAC MII bus.
So, move the ahb clock to runtime management together with
ipg clock.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/fec_main.c |   30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1840,13 +1840,9 @@ static int fec_enet_clk_enable(struct ne
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
@@ -1866,7 +1862,6 @@ static int fec_enet_clk_enable(struct ne
 
 		phy_reset_after_clk_enable(ndev->phydev);
 	} else {
-		clk_disable_unprepare(fep->clk_ahb);
 		clk_disable_unprepare(fep->clk_enet_out);
 		if (fep->clk_ptp) {
 			mutex_lock(&fep->ptp_clk_mutex);
@@ -1885,8 +1880,6 @@ failed_clk_ref:
 failed_clk_ptp:
 	if (fep->clk_enet_out)
 		clk_disable_unprepare(fep->clk_enet_out);
-failed_clk_enet_out:
-		clk_disable_unprepare(fep->clk_ahb);
 
 	return ret;
 }
@@ -3470,6 +3463,9 @@ fec_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(fep->clk_ipg);
 	if (ret)
 		goto failed_clk_ipg;
+	ret = clk_prepare_enable(fep->clk_ahb);
+	if (ret)
+		goto failed_clk_ahb;
 
 	fep->reg_phy = devm_regulator_get_optional(&pdev->dev, "phy");
 	if (!IS_ERR(fep->reg_phy)) {
@@ -3563,6 +3559,9 @@ failed_reset:
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 failed_regulator:
+	clk_disable_unprepare(fep->clk_ahb);
+failed_clk_ahb:
+	clk_disable_unprepare(fep->clk_ipg);
 failed_clk_ipg:
 	fec_enet_clk_enable(ndev, false);
 failed_clk:
@@ -3686,6 +3685,7 @@ static int __maybe_unused fec_runtime_su
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct fec_enet_private *fep = netdev_priv(ndev);
 
+	clk_disable_unprepare(fep->clk_ahb);
 	clk_disable_unprepare(fep->clk_ipg);
 
 	return 0;
@@ -3695,8 +3695,20 @@ static int __maybe_unused fec_runtime_re
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


