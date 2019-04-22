Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BA8C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8B5204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963237;
	bh=bHUgYP+U7nbcyYBqraeuudEMBgsZuclqOTqty8qukew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SAUe+lr5C4oKdx/WuHh1j/3TVFvI/YJvHn1bY9VVcDQby8ZY/KWXfjcmVUvoz0gtn
	 PfGk4fgZE6kDvoNxFLgCSd5gAT4KxGKEXC2ov1cY7fvreKe+gqWLB2yT/MK3alut0y
	 FK51bHHbeH+eShGrgPpCcDRu7J7zr4bGNoJHXFcA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731915AbfDVUAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:00:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:49962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730217AbfDVTrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:47:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6B9321906;
        Mon, 22 Apr 2019 19:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962434;
        bh=bHUgYP+U7nbcyYBqraeuudEMBgsZuclqOTqty8qukew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qOLtcF173dvG0TjnYgw8htkGKXLDNXTBgFev5+4nz2gWj1n+e4/wlZh96UP5AaOxE
         57fEsMjBG3Onc7HA5malVPjTtS7pD5nxo1v+TGUP2Ryrpzo2eN23m06aTXGf0CHfR6
         wrf8XmSgn5r3K2Q2R9i/koKeJVvjilc8CGlNHbcg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin George <marting@netapp.com>,
        Gargi Srinivas <sring@netapp.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 62/68] nvme-multipath: relax ANA state check
Date:   Mon, 22 Apr 2019 15:45:10 -0400
Message-Id: <20190422194516.11634-62-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194516.11634-1-sashal@kernel.org>
References: <20190422194516.11634-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin George <marting@netapp.com>

[ Upstream commit cc2278c413c3a06a93c23ee8722e4dd3d621de12 ]

When undergoing state transitions I/O might be requeued, hence
we should always call nvme_mpath_set_live() to schedule requeue_work
whenever the nvme device is live, independent on whether the
old state was live or not.

Signed-off-by: Martin George <marting@netapp.com>
Signed-off-by: Gargi Srinivas <sring@netapp.com>
Signed-off-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/nvme/host/multipath.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index da8f5ad30c71..260248fbb8fe 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -349,15 +349,12 @@ static inline bool nvme_state_is_live(enum nvme_ana_state state)
 static void nvme_update_ns_ana_state(struct nvme_ana_group_desc *desc,
 		struct nvme_ns *ns)
 {
-	enum nvme_ana_state old;
-
 	mutex_lock(&ns->head->lock);
-	old = ns->ana_state;
 	ns->ana_grpid = le32_to_cpu(desc->grpid);
 	ns->ana_state = desc->state;
 	clear_bit(NVME_NS_ANA_PENDING, &ns->flags);
 
-	if (nvme_state_is_live(ns->ana_state) && !nvme_state_is_live(old))
+	if (nvme_state_is_live(ns->ana_state))
 		nvme_mpath_set_live(ns);
 	mutex_unlock(&ns->head->lock);
 }
-- 
2.19.1

