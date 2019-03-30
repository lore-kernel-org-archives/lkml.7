Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85ACC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7A52064A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553908281;
	bh=OsbLZOcBFn2vk0giBn3/IH8HyQvKr9nRZ0qt4BdiGJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V6SfRwLmXVk7qWbbiEG5JKUEPkmCaBkiHP07Wk0p+pYexfqc/1X1FcBCvuf+9Opmy
	 BU1hzavF77xNpm5scw4zIB6/aM6Z/BDbXDhCgyKD0Yhq2dfXNlbGN8i14gi7NER8nf
	 rt1gpTBWFOkLW/rArl7DVWrt6tDmtIU1O8VjqnDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730949AbfC3BLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:11:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730631AbfC3AvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:51:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E1FF218D0;
        Sat, 30 Mar 2019 00:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907066;
        bh=OsbLZOcBFn2vk0giBn3/IH8HyQvKr9nRZ0qt4BdiGJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kU9iOCUAmZw0qSbI6w2Xp7TQY1KIBM93qoTK105bAJvCjvpUR7zoed2HaRUaJH9Na
         i4n9qeLnhMeO0oqaGLGLLzkbW6ko7J+dMpKpRXxG+kv6WQfdM3jzxr0N7iA1tv3aIo
         bL9xgEZQ16vMSIUdIJhapLkJi86Gvl0bwzPN2Doc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 14/67] IB/mlx4: Fix race condition between catas error reset and aliasguid flows
Date:   Fri, 29 Mar 2019 20:49:54 -0400
Message-Id: <20190330005047.25998-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005047.25998-1-sashal@kernel.org>
References: <20190330005047.25998-1-sashal@kernel.org>
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
index 782499abcd98..2a0b59a4b6eb 100644
--- a/drivers/infiniband/hw/mlx4/alias_GUID.c
+++ b/drivers/infiniband/hw/mlx4/alias_GUID.c
@@ -804,8 +804,8 @@ void mlx4_ib_destroy_alias_guid_service(struct mlx4_ib_dev *dev)
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

