Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C35C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3CB218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552410831;
	bh=jysny0CJvbkdU9dyemd/IHq1zGEhrE+kX6yxwDMZZxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BS5ElQ2VI3jisvHTKBtaa7SnPaLlrLvlWj9L/YGt+66/LsFJlrvFpDY9VH+Pq4Klj
	 GKFI/y5C7VshfGQ2FdXFHJV/QpsOqDb8kQ1jtX7qtbPO04lpgmWLiBn7IdCVzqbDRt
	 9zv4pCzVGNS+sBadXmGTfC1k2L601COT4sLx02is=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfCLRNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:13:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727846AbfCLRNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:15 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7AC3217D4;
        Tue, 12 Mar 2019 17:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410794;
        bh=jysny0CJvbkdU9dyemd/IHq1zGEhrE+kX6yxwDMZZxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H0lIBGg5juPD2jjSnHQ6SSd+LoCWdkE1PDOuj6DFJOBcC+jTzdqte4/k7U7p1gSJw
         qaZvbxlJ+LX6lL9+bUrbnR2ak6pQbDRw961mB+PILprESm3OUzT5wrTkb1oPNJOdjz
         4a/hOzes06d1hpJqplJCYIF0BUttoCi0SV8jZfEw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Gagniuc <Alex_Gagniuc@Dellteam.com>,
        Keith Busch <keith.busch@intel.com>,
        Alex Gagniuc <mr.nuke.me@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 140/171] nvme-pci: fix rapid add remove sequence
Date:   Tue, 12 Mar 2019 10:08:40 -0700
Message-Id: <20190312170359.715739642@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index c0d01048ce4d..439b9f4eb246 100644
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



