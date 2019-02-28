Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A484AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D044218E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551366816;
	bh=xEuySOkh6418pzby7AYaZfAKHTsUQs4pqs6/bQLAtIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y8X8jg/1o9nTG1ImuUulB/YxK+k6pQK41W7B7FMHp6K9t5Tau1g8snyTxsY8yLNcg
	 10RWRsk1gW7WYilbTIxNqcyXPvVDEZEht+NfDUxGsS0ZDzVutomI5zYhxKt7HYo2+s
	 /JaAaHIk4Sp7HrYrt/z8QkrxW+WPEbh0pFJhiLMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388435AbfB1PNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:13:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:47426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388423AbfB1PN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:13:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D56E218D8;
        Thu, 28 Feb 2019 15:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366807;
        bh=xEuySOkh6418pzby7AYaZfAKHTsUQs4pqs6/bQLAtIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y71tVclG8j4IR+pIMfM7Z2hxlbUHHSU9qDWDEdXcI4AHP4PNYlUT+x99+fg+6NH4H
         5fX6/bFXIV+4tJikrDnIFiz40aPDlHDVOPqLpJQ2hZWUsoK0VvFQwVli/CgJ4Vr6Zt
         vtKNHiRJOfoHxILBw66w4/i3iT0eNGyyTdv7yw4k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 59/64] nvme-pci: fix rapid add remove sequence
Date:   Thu, 28 Feb 2019 10:11:00 -0500
Message-Id: <20190228151105.11277-59-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151105.11277-1-sashal@kernel.org>
References: <20190228151105.11277-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Busch <keith.busch@intel.com>

[ Upstream commit 5c959d73dba6495ec01d04c206ee679d61ccb2b0 ]

A surprise removal may fail to tear down request queues if it is racing
with the initial asynchronous probe. If that happens, the remove path
won't see the queue resources to tear down, and the controller reset
path may create a new request queue on a removed device, but will not
be able to make forward progress, deadlocking the pci removal.

Protect setting up non-blocking resources from a shutdown by holding the
same mutex, and transition to the CONNECTING state after these resources
are initialized so the probe path may see the dead controller state
before dispatching new IO.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=202081
Reported-by: Alex Gagniuc <Alex_Gagniuc@Dellteam.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
Tested-by: Alex Gagniuc <mr.nuke.me@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f46313f441ece..6398ffbce6dea 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2260,16 +2260,7 @@ static void nvme_reset_work(struct work_struct *work)
 	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
 		nvme_dev_disable(dev, false);
 
-	/*
-	 * Introduce CONNECTING state from nvme-fc/rdma transports to mark the
-	 * initializing procedure here.
-	 */
-	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_CONNECTING)) {
-		dev_warn(dev->ctrl.device,
-			"failed to mark controller CONNECTING\n");
-		goto out;
-	}
-
+	mutex_lock(&dev->shutdown_lock);
 	result = nvme_pci_enable(dev);
 	if (result)
 		goto out;
@@ -2288,6 +2279,17 @@ static void nvme_reset_work(struct work_struct *work)
 	 */
 	dev->ctrl.max_hw_sectors = NVME_MAX_KB_SZ << 1;
 	dev->ctrl.max_segments = NVME_MAX_SEGS;
+	mutex_unlock(&dev->shutdown_lock);
+
+	/*
+	 * Introduce CONNECTING state from nvme-fc/rdma transports to mark the
+	 * initializing procedure here.
+	 */
+	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_CONNECTING)) {
+		dev_warn(dev->ctrl.device,
+			"failed to mark controller CONNECTING\n");
+		goto out;
+	}
 
 	result = nvme_init_identify(&dev->ctrl);
 	if (result)
-- 
2.19.1

