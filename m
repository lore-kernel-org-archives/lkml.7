Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B45FC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B3C2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354145;
	bh=6SBP+UepJ6h5naaSQnb5iAg08fqNy6u3wMbzA4kOzJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bbm8K4zwlg499HuOrQGHx8k0ck4rr1UujBI7CxxSWJGjU335Chq6kvlafHCsNALPG
	 5TD0h8TP+XyORRpNmfwRDVGO8LzZmDOFxmUjYV00nK8WSAYqE9rg/soe4MqdWzt+wb
	 D1wtrd4DSq/3bD1TFDy5PrOpdusD6EICI9p0jl5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbfDOStE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:49:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728973AbfDOSro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:47:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 715A92087C;
        Mon, 15 Apr 2019 18:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354063;
        bh=6SBP+UepJ6h5naaSQnb5iAg08fqNy6u3wMbzA4kOzJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o8PHjf9tnhvSNIF4y+YDF70N2hEIsZTMdG9QXSeVnv9oT8ZmzXdBlscp4lHDamwY4
         2IMwaWfvRcSCQMovCNjp9qlfbAs9h9dpyxEP1aSFViSZu1+4mCWeBIoKhwFfnS0qyd
         V6GaPBq5yCPvAkG7qsqqDg2LyH0/0XInYgYWI/xY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuval Avnery <yuvalav@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.9 59/76] net/mlx5e: Add a lock on tir list
Date:   Mon, 15 Apr 2019 20:44:23 +0200
Message-Id: <20190415183724.736253909@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
References: <20190415183707.712011689@linuxfoundation.org>
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
 
@@ -151,6 +156,7 @@ int mlx5e_refresh_tirs_self_loopback_ena
 
 	MLX5_SET(modify_tir_in, in, bitmask.self_lb_en, 1);
 
+	mutex_lock(&mdev->mlx5e_res.td.list_lock);
 	list_for_each_entry(tir, &mdev->mlx5e_res.td.tirs_list, list) {
 		err = mlx5_core_modify_tir(mdev, tir->tirn, in, inlen);
 		if (err)
@@ -159,6 +165,7 @@ int mlx5e_refresh_tirs_self_loopback_ena
 
 out:
 	kvfree(in);
+	mutex_unlock(&mdev->mlx5e_res.td.list_lock);
 
 	return err;
 }
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -578,6 +578,8 @@ enum mlx5_pci_status {
 };
 
 struct mlx5_td {
+	/* protects tirs list changes while tirs refresh */
+	struct mutex     list_lock;
 	struct list_head tirs_list;
 	u32              tdn;
 };


