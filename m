Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCD4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782FE2177E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368875;
	bh=PyrDwz0hkkUXA+e5ETo+rZfrkZul6uR7EOgFDLB5g2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0ia8zvsMf6g0HYl/Xx7OaOFwjKk3Jz6ebl2CSNk3zom02leWSw8NRe9pifyZXKog3
	 Ha+6rtnpsyqNvpn0RLuxnSaO+8Bpy03ZEaGEOzZPg6VsJstyUhBdjNXsDWw+mf850T
	 nOn+ygWuUKiLNcfWeqJ9Ydz1N/CPTCIMBZAHjfXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732580AbfDDJHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:07:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732545AbfDDJHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:07:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E75821741;
        Thu,  4 Apr 2019 09:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368866;
        bh=PyrDwz0hkkUXA+e5ETo+rZfrkZul6uR7EOgFDLB5g2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VRUQyMFkoDz+l3OMAfTI9BT1ACqGOOc/oUpcYr0mAWuOVzlAfndSl3o0swXmvCwiO
         IKQBZIBO+1Aw+qvm2f6QdwKKJEGKhhxqo/GWbt3jmsUOcmAHPnDM08yQB1AS4aTYhr
         72jjA5SLNXAlCnaQ1k8BTWP3U+Fgp0mUAQijp84Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>,
        James Smart <jsmart2021@gmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 003/246] nvme-fc: fix numa_node when dev is null
Date:   Thu,  4 Apr 2019 10:45:03 +0200
Message-Id: <20190404084619.364268848@linuxfoundation.org>
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

[ Upstream commit 06f3d71ea071b70e62bcc146cd9ff7ed1f9d4e43 ]

A recent change added a numa_node field to the nvme controller
and has the transport assign the node using dev_to_node().
However, fcloop registers with a NULL device struct, so the
dev_to_node() call oops.

Revise the assignment to assign no node when device struct is null.

Fixes: 103e515efa89b ("nvme: add a numa_node field to struct nvme_ctrl")
Reported-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Mike Snitzer <snitzer@redhat.com>
[hch: small coding style fixup]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 89accc76d71c..c37d5bbd72ab 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3018,7 +3018,10 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	ctrl->ctrl.opts = opts;
 	ctrl->ctrl.nr_reconnects = 0;
-	ctrl->ctrl.numa_node = dev_to_node(lport->dev);
+	if (lport->dev)
+		ctrl->ctrl.numa_node = dev_to_node(lport->dev);
+	else
+		ctrl->ctrl.numa_node = NUMA_NO_NODE;
 	INIT_LIST_HEAD(&ctrl->ctrl_list);
 	ctrl->lport = lport;
 	ctrl->rport = rport;
-- 
2.19.1



