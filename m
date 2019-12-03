Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911A5C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C132053B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575414023;
	bh=LmedBlooJS4Ip1d13aVO/3ke7q3y0dYzPnxwEwWhXYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GfkPgc/t2xD7qiS9aQ05BmkaCQh0LjameMfARKWyziUsZC5MjeegvE5FhSvDz+xMO
	 FyFHtgXmTscvU+YxQodNqlYPP5nn8kJQx39QJTs1uDENDbezj+RN2KMLMywpwIFSN3
	 4TNJpGICzTc50MMXWddZAltW2FKcThuX5HuHV0K4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbfLCXAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 18:00:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:53920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729690AbfLCW5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:57:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2B8120866;
        Tue,  3 Dec 2019 22:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413873;
        bh=LmedBlooJS4Ip1d13aVO/3ke7q3y0dYzPnxwEwWhXYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VXwg2MPzboTMOt0MUnLffbMGKABRSW5eg+9NnIl6pJ3BKpBuAzItuUfH3MLTpH6ch
         R1c8M7xOYZvhckINWmmdxriiDw0j6D/19rOWkv1Hd5KoD0Adj3l/BavoASdm9s4gd7
         g+Cgv9cyX1GxYWWJKnf+cMH+9zz/a64CKMu7u5RY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 293/321] net: macb: add missed tasklet_kill
Date:   Tue,  3 Dec 2019 23:35:59 +0100
Message-Id: <20191203223442.398680797@linuxfoundation.org>
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

[ Upstream commit 61183b056b49e2937ff92a1424291ba36a6f6d05 ]

This driver forgets to kill tasklet in remove.
Add the call to fix it.

Fixes: 032dc41ba6e2 ("net: macb: Handle HRESP error")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/cadence/macb_main.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4192,6 +4192,7 @@ static int macb_remove(struct platform_d
 		mdiobus_free(bp->mii_bus);
 
 		unregister_netdev(dev);
+		tasklet_kill(&bp->hresp_err_tasklet);
 		clk_disable_unprepare(bp->tx_clk);
 		clk_disable_unprepare(bp->hclk);
 		clk_disable_unprepare(bp->pclk);


