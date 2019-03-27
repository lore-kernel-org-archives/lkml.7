Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BFCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2A82147C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553709743;
	bh=8qsd/tU7LetcFuJXtIb9HGoPsBkv8zC+V1SiWrrKWuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JFUzh8i/IizFtDCoMlWHl1zmi8GQep3Hb6DT3QK7bq5ExxBKpol85aUtTmYGNT+LF
	 RysvRJ8wsnwxH1xTh5VC2K6n56CkRG+rUXxMgnD/TlbVmoJkRpRSHrwyStl9wzkOd3
	 vu6+65XzLq2B+QGhCyhdBC/NKZ9eGDjCKr8jt6MM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbfC0SCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:02:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730032AbfC0SCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:02:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52FAF21773;
        Wed, 27 Mar 2019 18:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709739;
        bh=8qsd/tU7LetcFuJXtIb9HGoPsBkv8zC+V1SiWrrKWuU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H/STqAiuZFSMI/ElbGyC8wd2KRv/Fc94duXR3OhyilyVSU5PkSANaDSTlsXUKCZ7E
         T1etINtH06CCiSzA8v6MSKpA7uh9fFHWgKq+Hnxr+YeEibztQdhWrDBXIJmGbOMsrO
         l8hJCzG40OdK2Lz9JbiXWlHKdXRonXg3kf7Sh0v0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        Eli Cohen <eli@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 014/262] net/mlx5: Avoid panic when setting vport mac, getting vport config
Date:   Wed, 27 Mar 2019 13:57:49 -0400
Message-Id: <20190327180158.10245-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
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
index 3e8ed5586821..13c48883ed61 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1812,7 +1812,7 @@ int mlx5_eswitch_set_vport_mac(struct mlx5_eswitch *esw,
 	u64 node_guid;
 	int err = 0;
 
-	if (!MLX5_CAP_GEN(esw->dev, vport_group_manager))
+	if (!esw || !MLX5_CAP_GEN(esw->dev, vport_group_manager))
 		return -EPERM;
 	if (!LEGAL_VPORT(esw, vport) || is_multicast_ether_addr(mac))
 		return -EINVAL;
@@ -1886,7 +1886,7 @@ int mlx5_eswitch_get_vport_config(struct mlx5_eswitch *esw,
 {
 	struct mlx5_vport *evport;
 
-	if (!MLX5_CAP_GEN(esw->dev, vport_group_manager))
+	if (!esw || !MLX5_CAP_GEN(esw->dev, vport_group_manager))
 		return -EPERM;
 	if (!LEGAL_VPORT(esw, vport))
 		return -EINVAL;
-- 
2.19.1

