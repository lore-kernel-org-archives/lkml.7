Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EADEC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C27120578
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567103050;
	bh=ui0X0IpgiHCNlLnHuOQmNBQikGn7U/h3HqEeFUTRqWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b5gvzzyI/BFgCch7B3cgIy6ru0wfKw7UH9AKUzrVWmzczbtXtWdTz37hbsP6pzY1V
	 V0Dq29N579bd/+BAPK5BQeYg1zQP8urBxyslIwbMhXzCnH+pqu3a+pipj7psfFOGgV
	 hHyuTlSBOcZshtCdETUv8jpc/7/X5i8gYN2w1ywY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbfH2SYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:24:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728464AbfH2SQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:16:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 448D823404;
        Thu, 29 Aug 2019 18:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102598;
        bh=ui0X0IpgiHCNlLnHuOQmNBQikGn7U/h3HqEeFUTRqWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=09VIwfI3Rd6D0wg/Mzc6QKRx/RQ6YFBGySHQlFmCUg5EkiZ+jl/hOz1z5xGXJloFH
         bIMEEDQ3dc90Wu01jzjInrz4Dob0aIPmXc9X2JbyETKhHD4dYb5QDjz4w1Ri2ov8R1
         5jmvv+ulxEKn++LP6hP710NTku20NC/H2uKC0oVo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anton Eidelman <anton@lightbitslabs.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 34/45] nvme-multipath: fix possible I/O hang when paths are updated
Date:   Thu, 29 Aug 2019 14:15:34 -0400
Message-Id: <20190829181547.8280-34-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181547.8280-1-sashal@kernel.org>
References: <20190829181547.8280-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Eidelman <anton@lightbitslabs.com>

[ Upstream commit 504db087aaccdb32af61539916409f7dca31ceb5 ]

nvme_state_set_live() making a path available triggers requeue_work
in order to resubmit requests that ended up on requeue_list when no
paths were available.

This requeue_work may race with concurrent nvme_ns_head_make_request()
that do not observe the live path yet.
Such concurrent requests may by made by either:
- New IO submission.
- Requeue_work triggered by nvme_failover_req() or another ana_work.

A race may cause requeue_work capture the state of requeue_list before
more requests get onto the list. These requests will stay on the list
forever unless requeue_work is triggered again.

In order to prevent such race, nvme_state_set_live() should
synchronize_srcu(&head->srcu) before triggering the requeue_work and
prevent nvme_ns_head_make_request referencing an old snapshot of the
path list.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/multipath.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a11e210d173e4..9e24ef3bd0f29 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -293,6 +293,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 				 "failed to create id group.\n");
 	}
 
+	synchronize_srcu(&ns->head->srcu);
 	kblockd_schedule_work(&ns->head->requeue_work);
 }
 
-- 
2.20.1

