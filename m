Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01ADC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE10820C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367707;
	bh=zYbbeAZ0200g8efW3tFVQSwkKLGIZgHyPPavUzAmpmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WibgNxkd1pUc/U3Yf8FEBBlCbFy7JPWdf8CQnhNsbgKF+knVVl+j1QxXaMcGBKy+P
	 aGjR/0lGiD4Ak7dxAKEO/iN1EI2pqRTaSPqwQsu7c/tx26C7dpZ3znxMJDHZBLpVCc
	 q1ZfsN8b92XBFBKjwPoV6cLECqf+4o9s+afk79IA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387850AbfB1PLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:11:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:43836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731595AbfB1PK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:10:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9A7C218B0;
        Thu, 28 Feb 2019 15:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366657;
        bh=zYbbeAZ0200g8efW3tFVQSwkKLGIZgHyPPavUzAmpmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TmeQKx+N+vqK2qt96vV2EvoYe9ZlM6koavacoxelndtgBwMNlKQge0gTRLaSyb+V5
         BvNZ/EmvKPPsNYhmEj0JW86LMxGSbNt+3sTw7zyRAeNbmEuOxn9uPt/jmBMuyspXX3
         beJ8PYnzCmYWIQoeA4rbVKN1wZZAiEjWmdxblpdE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.20 76/81] nvme-pci: fix rapid add remove sequence
Date:   Thu, 28 Feb 2019 10:08:08 -0500
Message-Id: <20190228150813.10256-76-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
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
index c0d01048ce4de..439b9f4eb246a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2280,16 +2280,7 @@ static void nvme_reset_work(struct work_struct *work)
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
@@ -2308,6 +2299,17 @@ static void nvme_reset_work(struct work_struct *work)
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

