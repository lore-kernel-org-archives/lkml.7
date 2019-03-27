Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A772C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED43E2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710603;
	bh=njuQRNXT+2fbG7yYGEmsBKfcZdq9dAPSx+Jt2Lphc0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XqDm4EsvvxjZtAOvmdvbf5lhxl/2H9f9RxsgIs8oAuMMRj2e+H2Zxd88p7CncR+p4
	 vf5PEeSMB1EcsvG0EStNxnDl5rPh9X4fsQ0u+EMtVjGFUoUQMhgx/TlnkzE6cwXH1u
	 KWjhZMAUcdgEKntQ9q+pZAyc/Pk9wFILxy5tPnjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390120AbfC0SQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:16:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390099AbfC0SQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:16:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C4E72082F;
        Wed, 27 Mar 2019 18:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710597;
        bh=njuQRNXT+2fbG7yYGEmsBKfcZdq9dAPSx+Jt2Lphc0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MQlBabh0qFAe1ot+29h/x5G8oE2pyLZumd2itDhHFtP2e3S7+flxsI7AfPJ0nB+kJ
         X/OuFai9qJdZWEJR6I5C56vH0Z/CliUoFV926FvZNLhnQxvtjdgx0hwLxukkgMZloz
         AGDb+mPqwyEmPQcMZpnXEte0n53d5t6AUs+Ck90U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        Mohamad Haj Yahia <mohamad@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 006/123] net/mlx5: Avoid panic when setting vport rate
Date:   Wed, 27 Mar 2019 14:14:30 -0400
Message-Id: <20190327181628.15899-6-sashal@kernel.org>
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

[ Upstream commit 24319258660a84dd77f4be026a55b10a12524919 ]

If we try to set VFs rate on a VF (not PF) net device, the kernel
will be crash. The commands are show as below:

$ echo 2 > /sys/class/net/$MLX_PF0/device/sriov_numvfs
$ ip link set $MLX_VF0 vf 0 max_tx_rate 2 min_tx_rate 1

If not applied the first patch ("net/mlx5: Avoid panic when setting
vport mac, getting vport config"), the command:

$ ip link set $MLX_VF0 vf 0 rate 100

can also crash the kernel.

[ 1650.006388] RIP: 0010:mlx5_eswitch_set_vport_rate+0x1f/0x260 [mlx5_core]
[ 1650.007092]  do_setlink+0x982/0xd20
[ 1650.007129]  __rtnl_newlink+0x528/0x7d0
[ 1650.007374]  rtnl_newlink+0x43/0x60
[ 1650.007407]  rtnetlink_rcv_msg+0x2a2/0x320
[ 1650.007484]  netlink_rcv_skb+0xcb/0x100
[ 1650.007519]  netlink_unicast+0x17f/0x230
[ 1650.007554]  netlink_sendmsg+0x2d2/0x3d0
[ 1650.007592]  sock_sendmsg+0x36/0x50
[ 1650.007625]  ___sys_sendmsg+0x280/0x2a0
[ 1650.007963]  __sys_sendmsg+0x58/0xa0
[ 1650.007998]  do_syscall_64+0x5b/0x180
[ 1650.009438]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: c9497c98901c ("net/mlx5: Add support for setting VF min rate")
Cc: Mohamad Haj Yahia <mohamad@mellanox.com>
Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Reviewed-by: Roi Dayan <roid@mellanox.com>
Acked-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 2f93e6e9dc9e..2aec0c021b6c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1966,19 +1966,24 @@ static int normalize_vports_min_rate(struct mlx5_eswitch *esw, u32 divider)
 int mlx5_eswitch_set_vport_rate(struct mlx5_eswitch *esw, int vport,
 				u32 max_rate, u32 min_rate)
 {
-	u32 fw_max_bw_share = MLX5_CAP_QOS(esw->dev, max_tsar_bw_share);
-	bool min_rate_supported = MLX5_CAP_QOS(esw->dev, esw_bw_share) &&
-					fw_max_bw_share >= MLX5_MIN_BW_SHARE;
-	bool max_rate_supported = MLX5_CAP_QOS(esw->dev, esw_rate_limit);
 	struct mlx5_vport *evport;
+	u32 fw_max_bw_share;
 	u32 previous_min_rate;
 	u32 divider;
+	bool min_rate_supported;
+	bool max_rate_supported;
 	int err = 0;
 
 	if (!ESW_ALLOWED(esw))
 		return -EPERM;
 	if (!LEGAL_VPORT(esw, vport))
 		return -EINVAL;
+
+	fw_max_bw_share = MLX5_CAP_QOS(esw->dev, max_tsar_bw_share);
+	min_rate_supported = MLX5_CAP_QOS(esw->dev, esw_bw_share) &&
+				fw_max_bw_share >= MLX5_MIN_BW_SHARE;
+	max_rate_supported = MLX5_CAP_QOS(esw->dev, esw_rate_limit);
+
 	if ((min_rate && !min_rate_supported) || (max_rate && !max_rate_supported))
 		return -EOPNOTSUPP;
 
-- 
2.19.1

