Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3E6C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D27520643
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355983;
	bh=hWpCYJnZ0xRaIpoF5DKbOYYo0tprIlxdDZn1tyIyqUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XvUO5NyiyjdLO/AbLgL+OpZ8zOF+olGDe2rPHIeNNl+m+kcuSpusfEq/JMRAsnjFE
	 lXbjGgzVs9aYWqdgBtmMWdSa1pLoDe4kf1VQJqWGcglWCbi0iNwK+gk4wNR3MsLWYc
	 ph+Z0SzjWKhn5SeyTHz47q1FtLJrY19mHZmdfZEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbfDOTKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:10:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729549AbfDOTKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:10:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 865B521903;
        Mon, 15 Apr 2019 19:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355414;
        bh=hWpCYJnZ0xRaIpoF5DKbOYYo0tprIlxdDZn1tyIyqUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xNGhwphufbHLUjFT8yHl5shtNsDo5WcSZUOXX14176IPV7rvp1QU+Qj6NiWBVX5E0
         PnBD2caufPOutz+bEpiV+85Ksgqk15Gx1Ok+QevIbgXQ3imcClbqv9v8EUXol4K7EA
         gFSMlbtP5ngWmnsseg2SEMSrNpVZBky+PQHS7ftU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gavi Teitz <gavi@mellanox.com>,
        Roi Dayan <roid@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 026/117] net/mlx5e: Fix error handling when refreshing TIRs
Date:   Mon, 15 Apr 2019 20:59:56 +0200
Message-Id: <20190415183746.217952944@linuxfoundation.org>
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

[ Upstream commit bc87a0036826a37b43489b029af8143bd07c6cca ]

Previously, a false positive would be caught if the TIRs list is
empty, since the err value was initialized to -ENOMEM, and was only
updated if a TIR is refreshed. This is resolved by initializing the
err value to zero.

Fixes: b676f653896a ("net/mlx5e: Refactor refresh TIRs")
Signed-off-by: Gavi Teitz <gavi@mellanox.com>
Reviewed-by: Roi Dayan <roid@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
index 3078491cc0d0..8100786f6fb5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
@@ -141,15 +141,17 @@ int mlx5e_refresh_tirs(struct mlx5e_priv *priv, bool enable_uc_lb)
 {
 	struct mlx5_core_dev *mdev = priv->mdev;
 	struct mlx5e_tir *tir;
-	int err  = -ENOMEM;
+	int err  = 0;
 	u32 tirn = 0;
 	int inlen;
 	void *in;
 
 	inlen = MLX5_ST_SZ_BYTES(modify_tir_in);
 	in = kvzalloc(inlen, GFP_KERNEL);
-	if (!in)
+	if (!in) {
+		err = -ENOMEM;
 		goto out;
+	}
 
 	if (enable_uc_lb)
 		MLX5_SET(modify_tir_in, in, ctx.self_lb_block,
-- 
2.19.1



