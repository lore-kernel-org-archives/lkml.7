Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D80C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2206218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355002;
	bh=CD9aeoQYBzUegyoEVuQ8PxltnK7joKUEea7G6XiUeT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M3j/e7phoqZ644wEqDLNmmdPVFFQa0a8gYPMnF7EvpDWJ73UlabYiiCgcjaHq7/I0
	 qBNXY2vNOOcb/9JbbzxhbM76W/JQztaq5e4cFvGylhPgnaL/kQle+47mjkv2WN0kSd
	 FK0hWgPfVF2O+Avy1qLY7spOOb/UrShQWOQKv4Vg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbfDOTDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:03:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728218AbfDOTDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:03:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1105218A1;
        Mon, 15 Apr 2019 19:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354998;
        bh=CD9aeoQYBzUegyoEVuQ8PxltnK7joKUEea7G6XiUeT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v4MNQ5pCI/qBz4VNKcWxb+z79+PGhk+e6bdAwhiYBswUfzEcILTX7WhAfYcyjions
         cLuVAxvxYhgHJihurgrFhUZ0q93Nya0OjVYWRgq0O6Ne6OG01Y5jYPGDh3Op3Gv5Xt
         siO/O5nEattFcSvM2QOPIwBeYQBlTEs3HVL2Tck4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuval Avnery <yuvalav@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.14 29/69] net/mlx5e: Add a lock on tir list
Date:   Mon, 15 Apr 2019 20:58:47 +0200
Message-Id: <20190415183731.455738394@linuxfoundation.org>
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

From: Yuval Avnery <yuvalav@mellanox.com>

[ Upstream commit 80a2a9026b24c6bd34b8d58256973e22270bedec ]

Refresh tirs is looping over a global list of tirs while netdevs are
adding and removing tirs from that list. That is why a lock is
required.

Fixes: 724b2aa15126 ("net/mlx5e: TIRs management refactoring")
Signed-off-by: Yuval Avnery <yuvalav@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_common.c |    7 +++++++
 include/linux/mlx5/driver.h                         |    2 ++
 2 files changed, 9 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
@@ -45,7 +45,9 @@ int mlx5e_create_tir(struct mlx5_core_de
 	if (err)
 		return err;
 
+	mutex_lock(&mdev->mlx5e_res.td.list_lock);
 	list_add(&tir->list, &mdev->mlx5e_res.td.tirs_list);
+	mutex_unlock(&mdev->mlx5e_res.td.list_lock);
 
 	return 0;
 }
@@ -53,8 +55,10 @@ int mlx5e_create_tir(struct mlx5_core_de
 void mlx5e_destroy_tir(struct mlx5_core_dev *mdev,
 		       struct mlx5e_tir *tir)
 {
+	mutex_lock(&mdev->mlx5e_res.td.list_lock);
 	mlx5_core_destroy_tir(mdev, tir->tirn);
 	list_del(&tir->list);
+	mutex_unlock(&mdev->mlx5e_res.td.list_lock);
 }
 
 static int mlx5e_create_mkey(struct mlx5_core_dev *mdev, u32 pdn,
@@ -114,6 +118,7 @@ int mlx5e_create_mdev_resources(struct m
 	}
 
 	INIT_LIST_HEAD(&mdev->mlx5e_res.td.tirs_list);
+	mutex_init(&mdev->mlx5e_res.td.list_lock);
 
 	return 0;
 
@@ -158,6 +163,7 @@ int mlx5e_refresh_tirs(struct mlx5e_priv
 
 	MLX5_SET(modify_tir_in, in, bitmask.self_lb_en, 1);
 
+	mutex_lock(&mdev->mlx5e_res.td.list_lock);
 	list_for_each_entry(tir, &mdev->mlx5e_res.td.tirs_list, list) {
 		tirn = tir->tirn;
 		err = mlx5_core_modify_tir(mdev, tirn, in, inlen);
@@ -169,6 +175,7 @@ out:
 	kvfree(in);
 	if (err)
 		netdev_err(priv->netdev, "refresh tir(0x%x) failed, %d\n", tirn, err);
+	mutex_unlock(&mdev->mlx5e_res.td.list_lock);
 
 	return err;
 }
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -743,6 +743,8 @@ struct mlx5_pagefault {
 };
 
 struct mlx5_td {
+	/* protects tirs list changes while tirs refresh */
+	struct mutex     list_lock;
 	struct list_head tirs_list;
 	u32              tdn;
 };


