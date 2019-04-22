Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1B2C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E73E218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963266;
	bh=t3gCV20ZUlQnVbrpTeGE+GE+GW/w4xR6g03lr6zyncg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qBZJtMmL2Dy3gbqsL5HNNl7T+a/e931try9K3D7ike/ErHpkElPPDjHcOd5aKO9C4
	 AK15ejKFEoiwXc8DpMMF0fa6Nfm31SxqBzPCrtVTev83ZInnVPAYfn+H1RX/96qlUF
	 POVTdB4KtsQen05Hm47sq0T5aUgQTKXKB536Rtas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbfDVTrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:47:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730120AbfDVTq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:46:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85F1E21902;
        Mon, 22 Apr 2019 19:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962416;
        bh=t3gCV20ZUlQnVbrpTeGE+GE+GW/w4xR6g03lr6zyncg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=upb+m9ZxcQq/Oz4dpdvutVNrpwfEao9YhkUw/qMpP86btBbXZAcnFq8cXhc8AIntU
         Jyz5EfS4Y/IJIA8M6sewIpF9jn4tQ9512sFjS9/qT9tjobqQriZ7yj1YwyRlrl+dYL
         t1o+1ZUSt5Vaa4EAZc9FnAowfGrfAAfgIJbJ8OY4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dave Carroll <david.carroll@microsemi.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 50/68] scsi: aacraid: Insure we don't access PCIe space during AER/EEH
Date:   Mon, 22 Apr 2019 15:44:58 -0400
Message-Id: <20190422194516.11634-50-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194516.11634-1-sashal@kernel.org>
References: <20190422194516.11634-1-sashal@kernel.org>
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
index 39eb415987fc..074760f21014 100644
--- a/drivers/scsi/aacraid/aacraid.h
+++ b/drivers/scsi/aacraid/aacraid.h
@@ -2639,9 +2639,14 @@ static inline unsigned int cap_to_cyls(sector_t capacity, unsigned divisor)
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
index 3236240a4edd..b7588de4484e 100644
--- a/drivers/scsi/aacraid/commsup.c
+++ b/drivers/scsi/aacraid/commsup.c
@@ -673,7 +673,7 @@ int aac_fib_send(u16 command, struct fib *fibptr, unsigned long size,
 					return -ETIMEDOUT;
 				}
 
-				if (unlikely(pci_channel_offline(dev->pdev)))
+				if (unlikely(aac_pci_offline(dev)))
 					return -EFAULT;
 
 				if ((blink = aac_adapter_check_health(dev)) > 0) {
@@ -773,7 +773,7 @@ int aac_hba_send(u8 command, struct fib *fibptr, fib_callback callback,
 
 		spin_unlock_irqrestore(&fibptr->event_lock, flags);
 
-		if (unlikely(pci_channel_offline(dev->pdev)))
+		if (unlikely(aac_pci_offline(dev)))
 			return -EFAULT;
 
 		fibptr->flags |= FIB_CONTEXT_FLAG_WAIT;
-- 
2.19.1

