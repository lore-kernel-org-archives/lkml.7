Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BCFC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC44120880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355430;
	bh=ddEPkb7PkS4u48aS1aum227k0xsYown690wReFvfg0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uq28lgLSMzCSIEySiF1ngZaHtX29ifPZa4DagkwAE3J48suI+VJV9D847Odkk6pwq
	 tbh7SZTEnVKw1yCU9lFtBrjKn4pU1sKKjVAo6xCTbahplrrZMD3WLHIG6242x6hM0I
	 kWAA9HZVWnC0sFa69hSMMQk7EcKEQCydZ03J2Rso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbfDOTK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:10:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730093AbfDOTKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:10:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6055C20880;
        Mon, 15 Apr 2019 19:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355421;
        bh=ddEPkb7PkS4u48aS1aum227k0xsYown690wReFvfg0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nv0HmmVK/EpDOSaNsxuEQzQIRAloxmKz6rtCTYLDyZ/4r7pdSmZgHUpULhi+z8WrQ
         WLHvBoS3h17mKSkeYDaIuleUF040F3mjTAEAfY6GRjkUtfOT7mYdrcV/5VqR6iogMz
         PjZDHaqrLovG9SLvNZs1U5Sx8ZO7SecDDquqdOfI=
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
Subject: [PATCH 5.0 014/117] net/mlx5: Decrease default mr cache size
Date:   Mon, 15 Apr 2019 20:59:44 +0200
Message-Id: <20190415183745.623539384@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
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
index be81b319b0dc..694edd899322 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -163,26 +163,6 @@ static struct mlx5_profile profile[] = {
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



