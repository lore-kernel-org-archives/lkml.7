Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88198C10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513AA2177E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368403;
	bh=noFfUhlMIdtVeBNa5bp6KMBaIRSZes/Er45bjVXRVwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=blnbCozbrkMBxqtHraXbR5YEY0mItyoLx+gRPCQYab0yJO084r97LBPIf+PhENrnd
	 2x2vaOtFSEnn3muzaLDAkeFm9WF1F/p1qwtgy8GkbDcNhLkInMziU8dgZ1L1Qo4spe
	 INnomPP3BexYMdOcoaAzOMZZsx1F2fnRoSRc4Tqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731181AbfDDJAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:00:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731167AbfDDI77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:59:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0285A2147C;
        Thu,  4 Apr 2019 08:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368398;
        bh=noFfUhlMIdtVeBNa5bp6KMBaIRSZes/Er45bjVXRVwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m4fmZc1H0qbF+7l/qfzSpLAJBdG0YJj364eajGZfYZBlDPHPPsxYv4qSO7StO0nHC
         8DXhPBU+1JwthXVW4YU8Xl5YH20KMNhxL/T5wdCk/LwwNbviLCanRo4I0OSAm9iwKr
         vmJ64p3+v31C4pO2n3J0NggcryhciWEylA+b8GjY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mohamad Haj Yahia <mohamad@mellanox.com>,
        Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        Roi Dayan <roid@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 010/187] net/mlx5: Avoid panic when setting vport rate
Date:   Thu,  4 Apr 2019 10:45:47 +0200
Message-Id: <20190404084603.599651593@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index d6706475a3ba..886a4a77c47f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -2044,19 +2044,24 @@ static int normalize_vports_min_rate(struct mlx5_eswitch *esw, u32 divider)
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



