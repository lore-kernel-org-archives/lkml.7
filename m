Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37271C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0294E204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963659;
	bh=5uEX26ZE7WH+wFv4Nv9saiO0kt6YeJU1atH9WFLnGsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y8MOfM62rUs4fIYS5VlWGHaS0d3JLHav7uB9lpIDkJiSop2cT/uJ5fHeTJWiofNyK
	 /V/AqMRU3dsu68A9h9BG7fmsBBs9CULuIWHCrw0CO3QH2el++JYiZt0sZwjcwbQS3a
	 8zDqieIHyrqyqIuLeNmiamBjdCJ1dfrePN4d1woo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbfDVUHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:07:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728867AbfDVToI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:44:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34551218EA;
        Mon, 22 Apr 2019 19:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962247;
        bh=5uEX26ZE7WH+wFv4Nv9saiO0kt6YeJU1atH9WFLnGsc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uWAdDcOxNTNaVNH26K8wGXEsVai9sEHAtyzEhBh40htMo5MGZ8+56ewCyNjPxUiTj
         zaSkQk5ikgxj+x12yGab33jjRZM0p1fx9Yhc3DcpGWUOx9VghqjiVHhqTwk63keGFn
         r/zGm9cCREzmciyh9RBmAANCksMsOpHk8wbFLlLs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dave Carroll <david.carroll@microsemi.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 63/98] scsi: aacraid: Insure we don't access PCIe space during AER/EEH
Date:   Mon, 22 Apr 2019 15:41:30 -0400
Message-Id: <20190422194205.10404-63-sashal@kernel.org>
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

From: Dave Carroll <david.carroll@microsemi.com>

[ Upstream commit b6554cfe09e1f610aed7d57164ab7760be57acd9 ]

There are a few windows during AER/EEH when we can access PCIe I/O mapped
registers. This will harden the access to insure we do not allow PCIe
access during errors

Signed-off-by: Dave Carroll <david.carroll@microsemi.com>
Reviewed-by: Sagar Biradar <sagar.biradar@microchip.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/scsi/aacraid/aacraid.h | 7 ++++++-
 drivers/scsi/aacraid/commsup.c | 4 ++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
index 3291d1c16864..8bd09b96ea18 100644
--- a/drivers/scsi/aacraid/aacraid.h
+++ b/drivers/scsi/aacraid/aacraid.h
@@ -2640,9 +2640,14 @@ static inline unsigned int cap_to_cyls(sector_t capacity, unsigned divisor)
 	return capacity;
 }
 
+static inline int aac_pci_offline(struct aac_dev *dev)
+{
+	return pci_channel_offline(dev->pdev) || dev->handle_pci_error;
+}
+
 static inline int aac_adapter_check_health(struct aac_dev *dev)
 {
-	if (unlikely(pci_channel_offline(dev->pdev)))
+	if (unlikely(aac_pci_offline(dev)))
 		return -1;
 
 	return (dev)->a_ops.adapter_check_health(dev);
diff --git a/drivers/scsi/aacraid/commsup.c b/drivers/scsi/aacraid/commsup.c
index a3adc954f40f..09367b8a3885 100644
--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -672,7 +672,7 @@ int aac_fib_send(u16 command, struct fib *fibptr, unsigned long size,
 					return -ETIMEDOUT;
 				}
 
-				if (unlikely(pci_channel_offline(dev->pdev)))
+				if (unlikely(aac_pci_offline(dev)))
 					return -EFAULT;
 
 				if ((blink = aac_adapter_check_health(dev)) > 0) {
@@ -772,7 +772,7 @@ int aac_hba_send(u8 command, struct fib *fibptr, fib_callback callback,
 
 		spin_unlock_irqrestore(&fibptr->event_lock, flags);
 
-		if (unlikely(pci_channel_offline(dev->pdev)))
+		if (unlikely(aac_pci_offline(dev)))
 			return -EFAULT;
 
 		fibptr->flags |= FIB_CONTEXT_FLAG_WAIT;
-- 
2.19.1

