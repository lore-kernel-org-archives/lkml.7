Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0B1C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7AD204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573611415;
	bh=QpPlVOH8XrovDhe/giG6zh7Ap7H68BvM/SfG639B8S8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Pl9xFgD9hUeaY4ghOftqm/smGcvWNly/4+g2a5H+VGHtD4YUfS5tjmP9u5a1C43HB
	 YBCc7Qr399w0dAZUKgKgyf887q8JyFvBTes6u+LuZ5MfV4AT90DgLBtdz/B2ycAGzS
	 NQ4zwyigWczcsIumBujqJ3EswJxII7QPyfpeW+YI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbfKMB4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:56:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:47938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728227AbfKMBz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:55:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3798F2245D;
        Wed, 13 Nov 2019 01:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610158;
        bh=QpPlVOH8XrovDhe/giG6zh7Ap7H68BvM/SfG639B8S8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bZOk3xHc/X5d7ILqffD2mpzCjE+vTJj2nJlMZam/93rE0iR+fAZ8CMbHgfZGbfSmD
         j1feuHGcDr972lhJyuiMKNDp5v+aZ81tXENho//xY2Eqt/FaJAz+zysjQnQ2A3SqET
         BomrkcoKo8PHVwAKDkL7pvRPoiJHr1vxzfYOZNVo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ido Schimmel <idosch@mellanox.com>,
        Petr Machata <petrm@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 201/209] mlxsw: spectrum_switchdev: Check notification relevance based on upper device
Date:   Tue, 12 Nov 2019 20:50:17 -0500
Message-Id: <20191113015025.9685-201-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit 5050f6ae253ad1307af3486c26fc4f94287078b7 ]

VxLAN FDB updates are sent with the VxLAN device which is not our upper
and will therefore be ignored by current code.

Solve this by checking whether the upper device (bridge) is our upper.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index a4f237f815d1a..8d556eb37b7aa 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -2324,8 +2324,15 @@ static int mlxsw_sp_switchdev_event(struct notifier_block *unused,
 	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
 	struct mlxsw_sp_switchdev_event_work *switchdev_work;
 	struct switchdev_notifier_fdb_info *fdb_info = ptr;
+	struct net_device *br_dev;
 
-	if (!mlxsw_sp_port_dev_lower_find_rcu(dev))
+	/* Tunnel devices are not our uppers, so check their master instead */
+	br_dev = netdev_master_upper_dev_get_rcu(dev);
+	if (!br_dev)
+		return NOTIFY_DONE;
+	if (!netif_is_bridge_master(br_dev))
+		return NOTIFY_DONE;
+	if (!mlxsw_sp_port_dev_lower_find_rcu(br_dev))
 		return NOTIFY_DONE;
 
 	switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
-- 
2.20.1

