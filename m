Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BA7C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF504205ED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483498;
	bh=rcRyvgju8hmlOroBuuep8muOJXAYQmVth4qHPCzfps8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cYHWDY5BSgUOCY0sOzpMAINSSNB6xgBZ0A8ZTkgwu7xsW/XRAssl3VHDsrhOf0J5l
	 kzYpmkgxKKCE2QEUbA3HbNHlX28hVah2QHm3neJYuSNVpcKhqv3YvnJ/z1cta3Uh4P
	 DiFryhDR6QRrbZ9zOx6xF714BU8SJZ6UIjj1kFZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731384AbfLDSLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:11:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:39042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731375AbfLDSLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:11:05 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61E8F20865;
        Wed,  4 Dec 2019 18:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575483064;
        bh=rcRyvgju8hmlOroBuuep8muOJXAYQmVth4qHPCzfps8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sfY0t1Zj7G7X24RUj7XLbXGn3QhAEiuOIJh7UBzKeLso5MUbHbIRmUFaLE3wqnG7/
         0P/N0744gpnGypiQztATSAudqePPb1fLw0hlDWNfe19baq9ZOxP573PpLABrtABDTa
         khlDk/6mQgSzmy0/OgYVvyZKDszgpHRGJmBXWgd8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 006/125] net: fec: add missed clk_disable_unprepare in remove
Date:   Wed,  4 Dec 2019 18:55:11 +0100
Message-Id: <20191204175311.412894730@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175308.377746305@linuxfoundation.org>
References: <20191204175308.377746305@linuxfoundation.org>
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
index 92ea760c48226..f50ebabd8cc63 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3539,6 +3539,8 @@ fec_drv_remove(struct platform_device *pdev)
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



