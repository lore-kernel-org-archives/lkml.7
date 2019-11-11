Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D021DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A247204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498849;
	bh=H5SJbvDpEOwO7KBrhjXFUAzkdL5m+cNmgK1kxcmnaJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l7srw8d+5ljWIrjSb8MnDcLHRPRte//DFB7FSfNk2jox+bzqzHQIadgkmCSytRMni
	 Aw7QT0TO1NjW5QznF9+IsJVSOvkZhtzFE4oJWdxEZz44pJwsDNP0r1FQuDXLlEGnVp
	 0IdVF+7gg0RKiI+JD93TsiDAcqwEM9MOYTKa0d8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbfKKTAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 14:00:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:47710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728765AbfKKSxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:53:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DB3320818;
        Mon, 11 Nov 2019 18:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498383;
        bh=H5SJbvDpEOwO7KBrhjXFUAzkdL5m+cNmgK1kxcmnaJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BZvthkYCqkH29yvK8Gi78loS7xg53FxknFVkC6k5iC/8MqYKC8F9nhsFRxLwrQS6r
         2uAOhcN0qXg2m22iqP5WxMQ62a3rrF+gKD01wHnpV2tYnYG5nKFc+6L/hlANr3ex7O
         5q/3P3pzqovAmOiNKCaTCVYWWMPPCeKyNLsv0zxQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 103/193] IB/core: Use rdma_read_gid_l2_fields to compare GID L2 fields
Date:   Mon, 11 Nov 2019 19:28:05 +0100
Message-Id: <20191111181508.733193150@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181459.850623879@linuxfoundation.org>
References: <20191111181459.850623879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

[ Upstream commit 777a8b32bc0f9bb25848a025f72a9febc30d9033 ]

Current code tries to derive VLAN ID and compares it with GID
attribute for matching entry. This raw search fails on macvlan
netdevice as its not a VLAN device, but its an upper device of a VLAN
netdevice.

Due to this limitation, incoming QP1 packets fail to match in the
GID table. Such packets are dropped.

Hence, to support it, use the existing rdma_read_gid_l2_fields()
that takes care of diffferent device types.

Fixes: dbf727de7440 ("IB/core: Use GID table in AH creation and dmac resolution")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Link: https://lore.kernel.org/r/20191002121750.17313-1-leon@kernel.org
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/verbs.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 92349bf37589f..5b1dc11a72838 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -662,16 +662,17 @@ static bool find_gid_index(const union ib_gid *gid,
 			   void *context)
 {
 	struct find_gid_index_context *ctx = context;
+	u16 vlan_id = 0xffff;
+	int ret;
 
 	if (ctx->gid_type != gid_attr->gid_type)
 		return false;
 
-	if ((!!(ctx->vlan_id != 0xffff) == !is_vlan_dev(gid_attr->ndev)) ||
-	    (is_vlan_dev(gid_attr->ndev) &&
-	     vlan_dev_vlan_id(gid_attr->ndev) != ctx->vlan_id))
+	ret = rdma_read_gid_l2_fields(gid_attr, &vlan_id, NULL);
+	if (ret)
 		return false;
 
-	return true;
+	return ctx->vlan_id == vlan_id;
 }
 
 static const struct ib_gid_attr *
-- 
2.20.1



