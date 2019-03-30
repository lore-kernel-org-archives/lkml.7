Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BECC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F26218D3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907378;
	bh=XWF2Fe6yQsugIDi/8L60akH428ygsQRMhj1rSBClftY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SvsEp0/xEFa4LsQ/JlDGMgx8CUYVmGjnNkDMhvRP/GEnbs3rXgzbM1V97Ck0+xdQo
	 KtmvxexP8pJOwYjoXCK7wecnbwXvqiWvMLuzziIEK+QmLaNlM8wRaSdl7zigfh0TMh
	 BOBzxIDutcRKpDVDO3dIuX7EAhwWfpN1aiAErjzs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731920AbfC3A4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:56:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731399AbfC3A4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:56:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 998152064A;
        Sat, 30 Mar 2019 00:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907366;
        bh=XWF2Fe6yQsugIDi/8L60akH428ygsQRMhj1rSBClftY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aw6JvAinICCJSngDMRGOQIHcKzAcrepEvlzpn20qISPSGw2PdT8fwGqtL7rT/wzp0
         kbT2rxrp5JxZBSv3WglXI3MDhklyM5P1O+25pKUJL5WeIVwzdh6ZGf5ZJSBK9T7PNl
         r/lQgfRdXNluTzXytxhmYnzi6k3LjQ0M9c5H0ZJk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 07/27] IB/mlx4: Fix race condition between catas error reset and aliasguid flows
Date:   Fri, 29 Mar 2019 20:55:33 -0400
Message-Id: <20190330005555.28087-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005555.28087-1-sashal@kernel.org>
References: <20190330005555.28087-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jack Morgenstein <jackm@dev.mellanox.co.il>

[ Upstream commit 587443e7773e150ae29e643ee8f41a1eed226565 ]

Code review revealed a race condition which could allow the catas error
flow to interrupt the alias guid query post mechanism at random points.
Thiis is fixed by doing cancel_delayed_work_sync() instead of
cancel_delayed_work() during the alias guid mechanism destroy flow.

Fixes: a0c64a17aba8 ("mlx4: Add alias_guid mechanism")
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx4/alias_GUID.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/alias_GUID.c b/drivers/infiniband/hw/mlx4/alias_GUID.c
index 5e9939045852..ec138845a474 100644
--- a/drivers/infiniband/hw/mlx4/alias_GUID.c
+++ b/drivers/infiniband/hw/mlx4/alias_GUID.c
@@ -805,8 +805,8 @@ void mlx4_ib_destroy_alias_guid_service(struct mlx4_ib_dev *dev)
 	unsigned long flags;
 
 	for (i = 0 ; i < dev->num_ports; i++) {
-		cancel_delayed_work(&dev->sriov.alias_guid.ports_guid[i].alias_guid_work);
 		det = &sriov->alias_guid.ports_guid[i];
+		cancel_delayed_work_sync(&det->alias_guid_work);
 		spin_lock_irqsave(&sriov->alias_guid.ag_work_lock, flags);
 		while (!list_empty(&det->cb_list)) {
 			cb_ctx = list_entry(det->cb_list.next,
-- 
2.19.1

