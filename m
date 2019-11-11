Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE9BC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601042184C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498671;
	bh=ft2LN6sxaEL+8IXj42ft2Jj8GwRyf4ZeA3bdcoIl+E4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jKEKgrsF7eZSRIt687fCUcHfLPpO7tKFXAH0FlHH700ZWjIMAn3jrSkPqGrYJhl5x
	 joUrO9cOLjxh6IYa8nYg5V1mGzaB/+ICQVzoG+gmk8XN1JwP3fAMjfyC8GYpUJZkW+
	 c9oNA/BduUUaUJQj+riBkmgANa1Nxp0plO0R6Q9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730641AbfKKS5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:57:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:57680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730875AbfKKS5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:57:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD40B222C1;
        Mon, 11 Nov 2019 18:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498666;
        bh=ft2LN6sxaEL+8IXj42ft2Jj8GwRyf4ZeA3bdcoIl+E4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GAR0e+NpFEPFTzp9Rxnoaj3V49hgjuzZyQJJ0mcHPyD6MggxyCmhQFPSzUtpggINg
         FEwjRPEdao5BNFmwsQhcMh2SB92HgAtH79t2JfwKSzcMQGoYteeMY0uYFlqAUmOEKL
         wd356vMyKR7tVy8ehBYmZUjp7rnz5jfxx5Dj1tvQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 184/193] net: ethernet: arc: add the missed clk_disable_unprepare
Date:   Mon, 11 Nov 2019 19:29:26 +0100
Message-Id: <20191111181514.671516170@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181459.850623879@linuxfoundation.org>
References: <20191111181459.850623879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

[ Upstream commit 4202e219edd6cc164c042e16fa327525410705ae ]

The remove misses to disable and unprepare priv->macclk like what is done
when probe fails.
Add the missed call in remove.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/arc/emac_rockchip.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/arc/emac_rockchip.c b/drivers/net/ethernet/arc/emac_rockchip.c
index 42d2e1b02c440..664d664e09250 100644
--- a/drivers/net/ethernet/arc/emac_rockchip.c
+++ b/drivers/net/ethernet/arc/emac_rockchip.c
@@ -256,6 +256,9 @@ static int emac_rockchip_remove(struct platform_device *pdev)
 	if (priv->regulator)
 		regulator_disable(priv->regulator);
 
+	if (priv->soc_data->need_div_macclk)
+		clk_disable_unprepare(priv->macclk);
+
 	free_netdev(ndev);
 	return err;
 }
-- 
2.20.1



