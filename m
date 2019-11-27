Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF43C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13866217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888296;
	bh=+5WDG++5xSQuxpiwkJ1J9wYvQqH+k4jLnKBFQ/nlJIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cjDnXDXTe1iBA8r+rECIjTvQhpRl4NIkcUKljdFV4SAS5t9XMKck1rdugjmU4DNdi
	 zzXa6ow9qvJwwgfc156G4kb+nUTkS5cZuWfQlHm81ehTHvLrcJJXYBbfkzaEjQvpnZ
	 j9tDpBwkifcO/e/NzVObMxWDKt1ohPIt8Hu1YtNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730903AbfK0U6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:58:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:49414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731287AbfK0U6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:58:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C68FF2084D;
        Wed, 27 Nov 2019 20:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888290;
        bh=+5WDG++5xSQuxpiwkJ1J9wYvQqH+k4jLnKBFQ/nlJIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RsS9Kx7tlMRMQnmpCDs+Fh/KT+k8jTmOrhKePLmDVxmWKc4WEoroMc9mVKscf0AlH
         zW2lpEng6GU8MNPyc3M0uupaWaia7du2qANgGCBhFKmwXTguaEWnJRldAHU9jsUbOH
         Adr3sCUzTXsjDUHgFstcU83Y9fOtNjUBx5RSQlLM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 077/306] nvme-pci: fix hot removal during error handling
Date:   Wed, 27 Nov 2019 21:28:47 +0100
Message-Id: <20191127203120.503867385@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Busch <keith.busch@intel.com>

[ Upstream commit cb4bfda62afa25b4eee3d635d33fccdd9485dd7c ]

A removal waits for the reset_work to complete. If a surprise removal
occurs around the same time as an error triggered controller reset, and
reset work happened to dispatch a command to the removed controller, the
command won't be recovered since the timeout work doesn't do anything
during error recovery. We wouldn't want to wait for timeout handling
anyway, so this patch fixes this by disabling the controller and killing
admin queues prior to syncing with the reset_work.

Signed-off-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a64a8bca0d5b9..9479c0db08f62 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2583,13 +2583,12 @@ static void nvme_remove(struct pci_dev *pdev)
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
-
-	cancel_work_sync(&dev->ctrl.reset_work);
 	pci_set_drvdata(pdev, NULL);
 
 	if (!pci_device_is_present(pdev)) {
 		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
 		nvme_dev_disable(dev, true);
+		nvme_dev_remove_admin(dev);
 	}
 
 	flush_work(&dev->ctrl.reset_work);
-- 
2.20.1



