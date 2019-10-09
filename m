Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E05FECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D60206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 17:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570642365;
	bh=u1QY37GQqiMRz3nMqJTL9xuwt1CVrLfwwm/6Qk4iZPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2GTN7riKkxaj4vYHlWik5c7oYNba+qpCq1aoi7txnnHeWssakbeqVCX6wXBBFMoLz
	 0E4L1liHsMbDOdKF0H+32jERqDztxKOuIZPQGbEP0Wu6gkdLDQWiQ+HiW3WYOkl8sP
	 ZFSgYT1jt26Dw5q0KeDBKGnqWU3QttkBaZtUpv40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732668AbfJIRcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 13:32:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731985AbfJIRXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:23:55 -0400
Received: from sasha-vm.mshome.net (unknown [167.220.2.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D76E2190F;
        Wed,  9 Oct 2019 17:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570641835;
        bh=u1QY37GQqiMRz3nMqJTL9xuwt1CVrLfwwm/6Qk4iZPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GJbjEGac3/M1WXVOHXDrlX/BsDB6t+4wt6/wJf+eDuaS+Gqtwj+YpZZDJOAt2+EM6
         1YGKCjYP+vQksjEGWb8XQjafxTenA26VCg1pSDyqhDLlYEITayxtFoJ4rF8Qe4Yoiq
         uqbXS4iZWJYDgY/J4bBMkQGCkZiDDZeCerntZbDU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Balbir Singh <sblbir@amzn.com>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.3 06/68] nvme-pci: Fix a race in controller removal
Date:   Wed,  9 Oct 2019 13:04:45 -0400
Message-Id: <20191009170547.32204-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191009170547.32204-1-sashal@kernel.org>
References: <20191009170547.32204-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balbir Singh <sblbir@amzn.com>

[ Upstream commit b224726de5e496dbf78147a66755c3d81e28bdd2 ]

User space programs like udevd may try to read to partitions at the
same time the driver detects a namespace is unusable, and may deadlock
if revalidate_disk() is called while such a process is waiting to
enter the frozen queue. On detecting a dead namespace, move the disk
revalidate after unblocking dispatchers that may be holding bd_butex.

changelog Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Balbir Singh <sblbir@amzn.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d3d6b7bd69033..28217cee5e762 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -103,10 +103,13 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
 	 */
 	if (!ns->disk || test_and_set_bit(NVME_NS_DEAD, &ns->flags))
 		return;
-	revalidate_disk(ns->disk);
 	blk_set_queue_dying(ns->queue);
 	/* Forcibly unquiesce queues to avoid blocking dispatch */
 	blk_mq_unquiesce_queue(ns->queue);
+	/*
+	 * Revalidate after unblocking dispatchers that may be holding bd_butex
+	 */
+	revalidate_disk(ns->disk);
 }
 
 static void nvme_queue_scan(struct nvme_ctrl *ctrl)
-- 
2.20.1

