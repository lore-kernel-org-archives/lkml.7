Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09D9C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F38218C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368919;
	bh=fzsf8mEBolxOqBBeSI4ftzhD+dkt108qq2I/neccbZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=icv/JjcRp0wfJj+B+A6zqY4mTLuhRiJY7PEfi9kglk3bqSMrY9VPd+hqj558Fz2iK
	 I1suESg5XLr2d2lk99ACJgmrhpPhxe7APqqcrldabed6z06dlt4Q4Z97a/k0T1aPv/
	 u/FehLclNvN/dbjDLZVrT+YhU6PvVIQepmwwKnDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732684AbfDDJIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:08:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732673AbfDDJIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:08:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDF9521741;
        Thu,  4 Apr 2019 09:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368914;
        bh=fzsf8mEBolxOqBBeSI4ftzhD+dkt108qq2I/neccbZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dlGD0Ie0EVK5zy2o7arCOGy/kvfPL58ybk0+keMwL9ZNKTc7rJ1RJq8nKJ6EEs4uG
         p0qsps/3DseewR2VMu8WZE/FwNe31xdBiQPM1XTtRuYOsHZ9Y6z8uGeAkO8E3qqau4
         9kzm5DSzLvVNTCZSNS52jGV9bQbFCtuDLDap41uw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eli Cohen <eli@mellanox.com>,
        Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        Roi Dayan <roid@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 012/246] net/mlx5: Avoid panic when setting vport mac, getting vport config
Date:   Thu,  4 Apr 2019 10:45:12 +0200
Message-Id: <20190404084619.631622903@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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



