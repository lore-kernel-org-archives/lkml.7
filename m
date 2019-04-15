Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9CDC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1188C218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354940;
	bh=3yWYOwreFO92pDVxkitrs5bZGuj50+jPlbUkRd0HWTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1De76XW5CLpbAWJsAcT+py93WazftjPOiop4QpnmSByei8V6kgG2zC9AKn1tfN+La
	 fr1/mtZTb8RD1Kya4LA5lvYyA1VUN1wjf3883HIsf1x//cs1vl97P/LbWp9EshKZDS
	 xBYVE+QshE5cNLwG2HZpxUfCEya+hCROhQOFFtWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfDOTCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:02:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:32968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728620AbfDOTCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:02:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0BED2087C;
        Mon, 15 Apr 2019 19:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354935;
        bh=3yWYOwreFO92pDVxkitrs5bZGuj50+jPlbUkRd0HWTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tuka1qc8XEKMATX3P0OiO0v2Wso1Gs/xC6FGUC+Zo0naGhRw9odYQviYF5RWu+Ucy
         x5q4UGeSqpC0oD16twjMKudFhDWnR4iH8C8oT2XMf2ZqZfJdTKvanGdw9idalae0t+
         WNyv4nG226Ko5b+YClkepCatW92e7qpuclFFNPWg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Shalom Toledo <shalomt@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.14 20/69] net/mlx5: Decrease default mr cache size
Date:   Mon, 15 Apr 2019 20:58:38 +0200
Message-Id: <20190415183730.306217040@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183726.036654568@linuxfoundation.org>
References: <20190415183726.036654568@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Artemy Kovalyov <artemyko@mellanox.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c |   20 --------------------
 1 file changed, 20 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -155,26 +155,6 @@ static struct mlx5_profile profile[] = {
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
 


