Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51ACFC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E402205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370414;
	bh=m6fNp5E/5E/lByp/5eVL2CeHBabpIXAkQCKl47afle8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pQ31WPDb1r+egn3sQnpNj0j1NgjS48Kzqy//K6OdZB5cJWsyFayfQ6OjZ/qD5ZBNE
	 qvXiHri/ec7Abyt9Jx/CiV78ZN4YqI4flUosx+qi+GNPO+XgmmsAHNU37Xcij+gVJk
	 TC76B3ZwWGrhnopAhmC/EwrZCPNCbKjhnwxuoJPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731321AbfDDJdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:33:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732153AbfDDJIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:08:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D94F72177E;
        Thu,  4 Apr 2019 09:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368889;
        bh=m6fNp5E/5E/lByp/5eVL2CeHBabpIXAkQCKl47afle8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hvMGaOFTWpkxg87tU5oMyCIBkzOtZYEs0IXmovDDVjMbwstMcPB3RDwnZW8iN45JK
         a5NRg0EAkUEzVJ8uZqwyEE42YH9WBy/CW7sCelg2HQhlwhx9jdzdpfJD26gqIH/4ne
         PGQfCtYrbTFkRbFcao2sj7jAKqg3ngEWlj2qcMx0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mohamad Haj Yahia <mohamad@mellanox.com>,
        Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        Roi Dayan <roid@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 011/246] net/mlx5: Avoid panic when setting vport rate
Date:   Thu,  4 Apr 2019 10:45:11 +0200
Message-Id: <20190404084619.601820265@linuxfoundation.org>
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
index 5b492b67f4e1..3e8ed5586821 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -2059,19 +2059,24 @@ static int normalize_vports_min_rate(struct mlx5_eswitch *esw, u32 divider)
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



