Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772ECC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41628206EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575412973;
	bh=ye6WqtFVNsd7Pv5UT85KvooansLZHK9SmOV6vn5/soQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lBHpLtMh8v9zczmijONrUb2YFKTSmovlhPZgx5nPtUa41KvZqpt6o0H0tEbJR+DdM
	 vKSM3xYXbJ1un+ZFxU4OKy4a3g9fI3B8HwEdzOBWbDh8e4n7cDWNPqj6aAV3BNr9Qt
	 p/I3W4XXKlMvRfnYXsM9RuK99HCPPC3nM8Dp4W5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbfLCWmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:42:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:57840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728343AbfLCWmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:42:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBF5B206EC;
        Tue,  3 Dec 2019 22:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412965;
        bh=ye6WqtFVNsd7Pv5UT85KvooansLZHK9SmOV6vn5/soQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NbcvgF3aR55P5DnRM/XVgBKHMzpPQ2oMXG1olxIPwOEliOYvo3rv18htpfQ0ruVTT
         CgmDsR67pPdi4pGOm6h9keEM6/VvPtHKEWYRrxoaw1n76l+UwT601Ln9g2gKk6/piu
         tKV5wZNRjm+PIO9bSqySHCRQCmvWyCT5gQ0Og1Oo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 045/135] net: fec: add missed clk_disable_unprepare in remove
Date:   Tue,  3 Dec 2019 23:34:45 +0100
Message-Id: <20191203213018.397598604@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203213005.828543156@linuxfoundation.org>
References: <20191203213005.828543156@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

[ Upstream commit c43eab3eddb4c6742ac20138659a9b701822b274 ]

This driver forgets to disable and unprepare clks when remove.
Add calls to clk_disable_unprepare to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fec_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index e5610a4da5390..9cb1d6ab19d5b 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3589,6 +3589,8 @@ fec_drv_remove(struct platform_device *pdev)
 		regulator_disable(fep->reg_phy);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	clk_disable_unprepare(fep->clk_ahb);
+	clk_disable_unprepare(fep->clk_ipg);
 	if (of_phy_is_fixed_link(np))
 		of_phy_deregister_fixed_link(np);
 	of_node_put(fep->phy_node);
-- 
2.20.1



