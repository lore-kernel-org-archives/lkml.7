Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3524AC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0155C214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563999420;
	bh=afFU0aM8UiXGmjSi7LgqQ+z7YK9DmF3xnMSk4DBEfRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nQ42b2p9o3wYGOcNuCcSTMONWuYqNOaQI6kWD0WebjlfcVObxLxHll6R1k2kJDe0g
	 vTNTYP4uVhgcchcHqXncF8YF1E6ZIJsRY44PPCK6i/MCC3nb1H76I0t7N6HxMXGa5C
	 8gTtbuHfkrObe17QQc/3c5kcT1XQh0VCvBe7urxU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392858AbfGXUQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:16:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403902AbfGXTut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:50:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCB5820659;
        Wed, 24 Jul 2019 19:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997848;
        bh=afFU0aM8UiXGmjSi7LgqQ+z7YK9DmF3xnMSk4DBEfRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OEzY5FV9CiatYWXVeuDsiHL3d6cSFtd/5sJ6VODJqZHRV2IMv/v80AGLU9YeRo+Sz
         igW5fA7SIVmAffTIcVWttM65uVKxqqQuind7LaaaL8lYjZzfKcA8vYDDXid1yA1CNT
         2eawQW8Yf16JJYopeqdvRbe+SOHApVJY2Caevf2I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 122/371] nvme-pci: set the errno on ctrl state change error
Date:   Wed, 24 Jul 2019 21:17:54 +0200
Message-Id: <20190724191734.051789441@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



