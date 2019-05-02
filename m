Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E01C04AA9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E583D2085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556810889;
	bh=g5WyNPA/QqcB+9T8YAbD78uEc7IjUwCwmyAd3x5SmyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CjiGInyRYeMQmkUttMINkz7WEs1c5xeijMxq6vmhxrDLDepV/tnOM++nwUP0rV+wz
	 3laflzXAZoJsPAe+XYuYt2HFL5coRRU+Y7no/QcRI3w8JhfjmLEVb8ialCTekMGQ90
	 1CEg7S68W5BSm3Ykxr7qFpOmCAe8QvqqOMsLpjec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfEBP2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:28:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728124AbfEBP2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:28:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8884F217F9;
        Thu,  2 May 2019 15:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810883;
        bh=g5WyNPA/QqcB+9T8YAbD78uEc7IjUwCwmyAd3x5SmyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0WUsHqUsTjIbpyRzenGJIPGeazlPJPu2XEYrDiHefJ8Nm3oUHeZnbAfpz5QHX4e5O
         5m/0kJRypjfkFkq5qfFZ++mc1RKtNusbT3SIcfpUvd2itIXbjfMHh2+cTAiaRzDM7W
         QNTBfnkzNak/AZyRODJsBPEcgUTOD4/twKaKEJ94=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin George <marting@netapp.com>,
        Gargi Srinivas <sring@netapp.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.19 66/72] nvme-multipath: relax ANA state check
Date:   Thu,  2 May 2019 17:21:28 +0200
Message-Id: <20190502143338.545674853@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143333.437607839@linuxfoundation.org>
References: <20190502143333.437607839@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



