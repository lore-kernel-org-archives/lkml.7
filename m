Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B23C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1852C20818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356277;
	bh=6Stq7zh5KcZncVK4wLYTrk+yqjKLYG5z3PTPnfeGVOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wA8x8PUi1qHoUdYH+a6Ib4HctguIjq5rvqgIqcN1K0PeJCHqbJAMf0jJ/4MeMjUv2
	 UiFZEUVYkq1TSpj951lGD4vqS/Wh/HHCyJ+/SHTjzdgzqrBDaR3scNC+IEILShtImc
	 2d3Kawt7k3epCqWpSkuRaOp94ilW9gn05mFnD8jg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbfDOTGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:06:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729421AbfDOTGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:06:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16CB9218A1;
        Mon, 15 Apr 2019 19:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355169;
        bh=6Stq7zh5KcZncVK4wLYTrk+yqjKLYG5z3PTPnfeGVOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tMkgkKzVdGugg2dsjY52j1fBGH2qSCg54gW2fviMyWXdeCXUpj9dwPz1KoUWSPw1b
         zP0o8k/9llwv21Y2Cty7GxDpzDyx554TPUxPXbWpBxPJzM+QkbJAjCKdMUuLui+45y
         wvgSbtlIU/07Q0jZO3fcy8B48ziKB9X5+hIh98YQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Shalom Toledo <shalomt@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 012/101] net/mlx5: Decrease default mr cache size
Date:   Mon, 15 Apr 2019 20:58:10 +0200
Message-Id: <20190415183741.017244743@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e8b26b2135dedc0284490bfeac06dfc4418d0105 ]

Delete initialization of high order entries in mr cache to decrease initial
memory footprint. When required, the administrator can populate the
entries with memory keys via the /sys interface.

This approach is very helpful to significantly reduce the per HW function
memory footprint in virtualization environments such as SRIOV.

Fixes: 9603b61de1ee ("mlx5: Move pci device handling from mlx5_ib to mlx5_core")
Signed-off-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Moni Shoua <monis@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Reported-by:  Shalom Toledo <shalomt@mellanox.com>
Acked-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/main.c    | 20 -------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 563ce3fedab4..0e820cf92f8a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -162,26 +162,6 @@ static struct mlx5_profile profile[] = {
 			.size	= 8,
 			.limit	= 4
 		},
-		.mr_cache[16]	= {
-			.size	= 8,
-			.limit	= 4
-		},
-		.mr_cache[17]	= {
-			.size	= 8,
-			.limit	= 4
-		},
-		.mr_cache[18]	= {
-			.size	= 8,
-			.limit	= 4
-		},
-		.mr_cache[19]	= {
-			.size	= 4,
-			.limit	= 2
-		},
-		.mr_cache[20]	= {
-			.size	= 4,
-			.limit	= 2
-		},
 	},
 };
 
-- 
2.19.1



