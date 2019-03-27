Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B61C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7895205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712922;
	bh=Av8FVbQD9mdECx5npEmWuDHGXtnvPbZyKyG9vCWTED0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A5k6oxa1m6hLjHXHzzyR2BjijQp8CjSX5EQDU8kzI77DR9I9Ow9nnMw74S4r/WKE5
	 jDCUxK/awF13cx+NAS92jO6tOr5al5dUzCBM8u2ZNQYjkkBK6NoZBrjGMI3hZYPpI6
	 vpr8JkA6M2nNbJd4IE7jWL1UZtEHgdTg57THhdTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390554AbfC0SzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:55:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389524AbfC0SQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:16:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B173D2087C;
        Wed, 27 Mar 2019 18:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710598;
        bh=Av8FVbQD9mdECx5npEmWuDHGXtnvPbZyKyG9vCWTED0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YcsjLdnmW+oS8qgKdVTYobEsLtnYyRo2UcuaveB8ng/wyghRuh9eGkBZNR3Nsudoz
         jPtSz8Fl7RkxnZ3jkfT0EYwOGb7wixg0uGGAwEfRF3+pYlDYN/6hnQ6DCDm6NslLg2
         7Ztjo6NCOaKBGrX2Hqc5A8onwS1+thSJ5xasb7NQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        Eli Cohen <eli@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 007/123] net/mlx5: Avoid panic when setting vport mac, getting vport config
Date:   Wed, 27 Mar 2019 14:14:31 -0400
Message-Id: <20190327181628.15899-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tonghao Zhang <xiangxia.m.yue@gmail.com>

[ Upstream commit 6e77c413e8e73d0f36b5358b601389d75ec4451c ]

If we try to set VFs mac address on a VF (not PF) net device,
the kernel will be crash. The commands are show as below:

$ echo 2 > /sys/class/net/$MLX_PF0/device/sriov_numvfs
$ ip link set $MLX_VF0 vf 0 mac 00:11:22:33:44:00

[exception RIP: mlx5_eswitch_set_vport_mac+41]
[ffffb8b7079e3688] do_setlink at ffffffff8f67f85b
[ffffb8b7079e37a8] __rtnl_newlink at ffffffff8f683778
[ffffb8b7079e3b68] rtnl_newlink at ffffffff8f683a63
[ffffb8b7079e3b90] rtnetlink_rcv_msg at ffffffff8f67d812
[ffffb8b7079e3c10] netlink_rcv_skb at ffffffff8f6b88ab
[ffffb8b7079e3c60] netlink_unicast at ffffffff8f6b808f
[ffffb8b7079e3ca0] netlink_sendmsg at ffffffff8f6b8412
[ffffb8b7079e3d18] sock_sendmsg at ffffffff8f6452f6
[ffffb8b7079e3d30] ___sys_sendmsg at ffffffff8f645860
[ffffb8b7079e3eb0] __sys_sendmsg at ffffffff8f647a38
[ffffb8b7079e3f38] do_syscall_64 at ffffffff8f00401b
[ffffb8b7079e3f50] entry_SYSCALL_64_after_hwframe at ffffffff8f80008c

and

[exception RIP: mlx5_eswitch_get_vport_config+12]
[ffffa70607e57678] mlx5e_get_vf_config at ffffffffc03c7f8f [mlx5_core]
[ffffa70607e57688] do_setlink at ffffffffbc67fa59
[ffffa70607e577a8] __rtnl_newlink at ffffffffbc683778
[ffffa70607e57b68] rtnl_newlink at ffffffffbc683a63
[ffffa70607e57b90] rtnetlink_rcv_msg at ffffffffbc67d812
[ffffa70607e57c10] netlink_rcv_skb at ffffffffbc6b88ab
[ffffa70607e57c60] netlink_unicast at ffffffffbc6b808f
[ffffa70607e57ca0] netlink_sendmsg at ffffffffbc6b8412
[ffffa70607e57d18] sock_sendmsg at ffffffffbc6452f6
[ffffa70607e57d30] ___sys_sendmsg at ffffffffbc645860
[ffffa70607e57eb0] __sys_sendmsg at ffffffffbc647a38
[ffffa70607e57f38] do_syscall_64 at ffffffffbc00401b
[ffffa70607e57f50] entry_SYSCALL_64_after_hwframe at ffffffffbc80008c

Fixes: a8d70a054a718 ("net/mlx5: E-Switch, Disallow vlan/spoofcheck setup if not being esw manager")
Cc: Eli Cohen <eli@mellanox.com>
Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Reviewed-by: Roi Dayan <roid@mellanox.com>
Acked-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 2aec0c021b6c..d2914116af8e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1719,7 +1719,7 @@ int mlx5_eswitch_set_vport_mac(struct mlx5_eswitch *esw,
 	u64 node_guid;
 	int err = 0;
 
-	if (!MLX5_CAP_GEN(esw->dev, vport_group_manager))
+	if (!esw || !MLX5_CAP_GEN(esw->dev, vport_group_manager))
 		return -EPERM;
 	if (!LEGAL_VPORT(esw, vport) || is_multicast_ether_addr(mac))
 		return -EINVAL;
@@ -1793,7 +1793,7 @@ int mlx5_eswitch_get_vport_config(struct mlx5_eswitch *esw,
 {
 	struct mlx5_vport *evport;
 
-	if (!MLX5_CAP_GEN(esw->dev, vport_group_manager))
+	if (!esw || !MLX5_CAP_GEN(esw->dev, vport_group_manager))
 		return -EPERM;
 	if (!LEGAL_VPORT(esw, vport))
 		return -EINVAL;
-- 
2.19.1

