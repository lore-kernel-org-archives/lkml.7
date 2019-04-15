Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53260C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203A7218DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355487;
	bh=1xYG1DeYgCGZvMjf9kNs8VXkuz10BAv12z3nMR4joDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dbqVwbBStYGxRFQGlWgJaUwO0cHV5rDmvkyHceMnXma4KpskaMsVWCgkGpdwVABs/
	 RzRIqLY/xuYBql2YUucNKyT3ZWomc6f1yVLr3pxLQpXjjSOjOqIOgF+1P6qQKaCsNE
	 gHbj2ejsddhPr2WMey90L/SbpUuYgYQF7fsoPG1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbfDOTLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:11:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731178AbfDOTLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:11:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10DD320880;
        Mon, 15 Apr 2019 19:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355480;
        bh=1xYG1DeYgCGZvMjf9kNs8VXkuz10BAv12z3nMR4joDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tZwegvas6Ukfm6hMRHhzQdLJITvOTVd4CtQBMY6lFqAWOYWAM5oxOcvb6oLG126Vk
         BxKhHv0rvs1LWTbIv2ZfLrmZc17Cna1Gj9DUiHnuBFybsQ7vEI7rn7LV6k8JUZo1iB
         zM++avKur2KTqKfPqwCdNEgJ+xwl9+TLT9QGDdDU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuval Avnery <yuvalav@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 027/117] net/mlx5e: Add a lock on tir list
Date:   Mon, 15 Apr 2019 20:59:57 +0200
Message-Id: <20190415183746.268932938@linuxfoundation.org>
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

[ Upstream commit 80a2a9026b24c6bd34b8d58256973e22270bedec ]

Refresh tirs is looping over a global list of tirs while netdevs are
adding and removing tirs from that list. That is why a lock is
required.

Fixes: 724b2aa15126 ("net/mlx5e: TIRs management refactoring")
Signed-off-by: Yuval Avnery <yuvalav@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_common.c | 7 +++++++
 include/linux/mlx5/driver.h                         | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
index 8100786f6fb5..1539cf3de5dc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
@@ -45,7 +45,9 @@ int mlx5e_create_tir(struct mlx5_core_dev *mdev,
 	if (err)
 		return err;
 
+	mutex_lock(&mdev->mlx5e_res.td.list_lock);
 	list_add(&tir->list, &mdev->mlx5e_res.td.tirs_list);
+	mutex_unlock(&mdev->mlx5e_res.td.list_lock);
 
 	return 0;
 }
@@ -53,8 +55,10 @@ int mlx5e_create_tir(struct mlx5_core_dev *mdev,
 void mlx5e_destroy_tir(struct mlx5_core_dev *mdev,
 		       struct mlx5e_tir *tir)
 {
+	mutex_lock(&mdev->mlx5e_res.td.list_lock);
 	mlx5_core_destroy_tir(mdev, tir->tirn);
 	list_del(&tir->list);
+	mutex_unlock(&mdev->mlx5e_res.td.list_lock);
 }
 
 static int mlx5e_create_mkey(struct mlx5_core_dev *mdev, u32 pdn,
@@ -114,6 +118,7 @@ int mlx5e_create_mdev_resources(struct mlx5_core_dev *mdev)
 	}
 
 	INIT_LIST_HEAD(&mdev->mlx5e_res.td.tirs_list);
+	mutex_init(&mdev->mlx5e_res.td.list_lock);
 
 	return 0;
 
@@ -159,6 +164,7 @@ int mlx5e_refresh_tirs(struct mlx5e_priv *priv, bool enable_uc_lb)
 
 	MLX5_SET(modify_tir_in, in, bitmask.self_lb_en, 1);
 
+	mutex_lock(&mdev->mlx5e_res.td.list_lock);
 	list_for_each_entry(tir, &mdev->mlx5e_res.td.tirs_list, list) {
 		tirn = tir->tirn;
 		err = mlx5_core_modify_tir(mdev, tirn, in, inlen);
@@ -170,6 +176,7 @@ int mlx5e_refresh_tirs(struct mlx5e_priv *priv, bool enable_uc_lb)
 	kvfree(in);
 	if (err)
 		netdev_err(priv->netdev, "refresh tir(0x%x) failed, %d\n", tirn, err);
+	mutex_unlock(&mdev->mlx5e_res.td.list_lock);
 
 	return err;
 }
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 54299251d40d..4f001619f854 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -591,6 +591,8 @@ enum mlx5_pagefault_type_flags {
 };
 
 struct mlx5_td {
+	/* protects tirs list changes while tirs refresh */
+	struct mutex     list_lock;
 	struct list_head tirs_list;
 	u32              tdn;
 };
-- 
2.19.1



