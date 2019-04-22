Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771B3C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C585218B0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962299;
	bh=auA7qvc7fCxnhXc78AYK6rx6+Cn/ERShntnbtiRRI/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NhSKo9azUI9f55I+H9m42GOdJ4nt0NuQj+Pv/6pV2AMZrhUnnzOIHNlfm26BIqgKa
	 zkTJzmM2m1DYdJQ0VbsUp/6Sd7MeDnrbXioLWAlrc8Wn67iLIMSlkgvy5a6gWTQQiS
	 Cl6uYjgpKcEfztE2f0y9s/5re3i4K+5JNRM5tSCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbfDVTo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:44:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729612AbfDVTo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:44:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9452218B0;
        Mon, 22 Apr 2019 19:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962295;
        bh=auA7qvc7fCxnhXc78AYK6rx6+Cn/ERShntnbtiRRI/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kh2rEdQ13KcW/y7QYpf+Kc03Uz+jg6gml1l663ZdREbyNAsFs3hD7V3B8UCwJbCDK
         JHZ3fDFA2P+HLz2bja0IH2Dug4bDCfejaTwnWiaSLO55zjCMZRTuZ4ibQQGvwt8kBp
         nFIEFfbXmTgmfUy/+J7RYUI0n0NczVIWPglVp/SM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin George <marting@netapp.com>,
        Gargi Srinivas <sring@netapp.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.0 88/98] nvme-multipath: relax ANA state check
Date:   Mon, 22 Apr 2019 15:41:55 -0400
Message-Id: <20190422194205.10404-88-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
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
index b9fff3b8ed1b..23da7beadd62 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -366,15 +366,12 @@ static inline bool nvme_state_is_live(enum nvme_ana_state state)
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

