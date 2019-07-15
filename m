Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972D5C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C94B206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563199837;
	bh=7UG0nrF22yhrDipXTNw8TTJF5gVp6UDRWvICFZJ+Ze0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SAk2q3KYfGqF4YfnRWf4d4jn4sTnuXoQ4JGQkV/fCYCbUjFyqQdo/6iXHcLaF6LA8
	 KVnsTCWPLbJqX4OGjExLgu4ZJkjTlDcSRek5vDakDcy2+fSiiiDAVBkhf464kUDVgY
	 FpubDmLi51fJlJvzLKYUVS12bUTb4yX9ST+f7f3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388891AbfGOOKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:10:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388880AbfGOOKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:10:32 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EB722083D;
        Mon, 15 Jul 2019 14:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563199831;
        bh=7UG0nrF22yhrDipXTNw8TTJF5gVp6UDRWvICFZJ+Ze0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PJ/SFZh3LHEKFBUPSSXQk7K9yvB7mhC1ZZ7U1CsvSABoM2SR1NhCLpdwWUugOEjPm
         DVuXzhfsSti80ahBwT1bVZcNwDCJYRKP8tR4Ukkjtg8m/fLQBXhzrdeg7WyA4qFJSR
         wttmu323lOJWm9y4eeQkZqE/PFC86Wq2Nx3lDwxc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.1 120/219] nvme-pci: set the errno on ctrl state change error
Date:   Mon, 15 Jul 2019 10:02:01 -0400
Message-Id: <20190715140341.6443-120-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715140341.6443-1-sashal@kernel.org>
References: <20190715140341.6443-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

[ Upstream commit e71afda49335620e3d9adf56015676db33a3bd86 ]

This patch removes the confusing assignment of the variable result at
the time of declaration and sets the value in error cases next to the
places where the actual error is happening.

Here we also set the result value to -ENODEV when we fail at the final
ctrl state transition in nvme_reset_work(). Without this assignment
result will hold 0 from nvme_setup_io_queue() and on failure 0 will be
passed to he nvme_remove_dead_ctrl() from final state transition.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 21a51a0ff4d7..9c956ff5344d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2504,11 +2504,13 @@ static void nvme_reset_work(struct work_struct *work)
 	struct nvme_dev *dev =
 		container_of(work, struct nvme_dev, ctrl.reset_work);
 	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
-	int result = -ENODEV;
+	int result;
 	enum nvme_ctrl_state new_state = NVME_CTRL_LIVE;
 
-	if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING))
+	if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING)) {
+		result = -ENODEV;
 		goto out;
+	}
 
 	/*
 	 * If we're called to reset a live controller first shut it down before
@@ -2606,6 +2608,7 @@ static void nvme_reset_work(struct work_struct *work)
 	if (!nvme_change_ctrl_state(&dev->ctrl, new_state)) {
 		dev_warn(dev->ctrl.device,
 			"failed to mark controller state %d\n", new_state);
+		result = -ENODEV;
 		goto out;
 	}
 
-- 
2.20.1

