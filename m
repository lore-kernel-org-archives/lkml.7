Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2856C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABD720880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355140;
	bh=471birNPpVUpM6Dyigla+QC/0KH3q4F/G7aSQFvIc+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0lCZbRhPtkchhQlYwS97c3nyITnRjd06/dR6vPh9q7HRqzeQJ/k5BOPGPSCUvc06C
	 w/KbzO7W7vFL/w6hFIDX/P7gruIWWxrVgAR8m6llg8h2E3BjaxV1v9/eHqUdaHVxsC
	 x8jwCOI7/HQDjgnPosk6GiD/+qogTPzvGo7pdWx4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbfDOTFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:05:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729724AbfDOTFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:05:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56677218EA;
        Mon, 15 Apr 2019 19:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355132;
        bh=471birNPpVUpM6Dyigla+QC/0KH3q4F/G7aSQFvIc+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dAYGSvw8jaAd9D/X9QAfWLviwFmFLI+S4ytW4Fn+wvQ3o4CjDTuHHGdH0UvAhYpmR
         X44Kfik+R/I9AftHu3Lx/oJzeuqEA0gH25xpewldCGDG2kyZ06l24J2lq4pxPOQ88C
         de65lWb2b/fb2Joq2g+QTbmfeW4c6H5M5MVETu9M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuval Avnery <yuvalav@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 025/101] net/mlx5e: Add a lock on tir list
Date:   Mon, 15 Apr 2019 20:58:23 +0200
Message-Id: <20190415183741.726681579@linuxfoundation.org>
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
index 1e28866e3924..124e4567a4ee 100644
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
index bbcfe2e5fd91..e8b92dee5a72 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -776,6 +776,8 @@ struct mlx5_pagefault {
 };
 
 struct mlx5_td {
+	/* protects tirs list changes while tirs refresh */
+	struct mutex     list_lock;
 	struct list_head tirs_list;
 	u32              tdn;
 };
-- 
2.19.1



