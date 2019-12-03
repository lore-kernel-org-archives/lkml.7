Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45255C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD3320848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413173;
	bh=SxMYTWTwvv690PHEkEgFWJ16AdvsYYbagNIxxDy1FOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eLqyGJ+w2ule01Zh5aJF77MDO4rCBOLES0Em3wO3ZcvwNKYtJEVXx+fA7zwe6n87+
	 z9JvZXy8YyxyCJcFw1/3LwNhLfDeIxJvx6sBXa3sYf86gAXOhk8LmLFpD0cqBhcDHa
	 QvpJBvDWv8lRnQ8Bd3APgLpU1r22kzIi/2+c5LBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbfLCWqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:46:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:35434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728593AbfLCWqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:46:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36BAF20803;
        Tue,  3 Dec 2019 22:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413167;
        bh=SxMYTWTwvv690PHEkEgFWJ16AdvsYYbagNIxxDy1FOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=luG5rskfxOfJlA5lMzhVsp+DyIi8gE1NyBPtxHpzrkKBaL7pghTho6iZ2rIU7X1a2
         BPA+P1r/lg0mlEJ2k6yKWOjJBIlqh+grazGUv7UvvAoRBNi1moWNWyOydkLFvPEr15
         wYxS+cVApXIlhCSAI5q6TKIF41F3ZMHtoI+LfL4s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 024/321] net: fec: add missed clk_disable_unprepare in remove
Date:   Tue,  3 Dec 2019 23:31:30 +0100
Message-Id: <20191203223428.376628375@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
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
index 4cf80de4c471c..1c62a102a223c 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3606,6 +3606,8 @@ fec_drv_remove(struct platform_device *pdev)
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



