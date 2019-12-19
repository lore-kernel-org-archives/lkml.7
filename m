Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E89FC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF632467E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576782576;
	bh=gYixBj+Z0j6dKD9kAf7Nre3FIdd6/MyceRv3Vd1hygY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0NPP7QDUwtdvsUm5L5WHZcHfn3AWg3KUS/M7BdfIINrnAi57HQBORS/3R7+yKvwI5
	 z+6XPx1cR0EVobviQGDG5K7NSRoTd0EHoAxHj/ss+MWB+v/B/vGMdlse/TRLfAGgjU
	 wr7X4hfvmqCy/NqJK5ijsJ5Ae3PznLTG4QTqKGJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfLSSkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:40:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:59218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728378AbfLSSk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:40:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D68724679;
        Thu, 19 Dec 2019 18:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780828;
        bh=gYixBj+Z0j6dKD9kAf7Nre3FIdd6/MyceRv3Vd1hygY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tga/j22fX4o8+YuSYRhNnxjVIc95WHwpZtoesFWa/piwXI2S3lROjWlPO5BTtFBPf
         2W5S3FtsLwW1+bnXdgH+52bvOZg+2koy2fWxbkGjXbSh74U1VYZ4bcv0x9GfL2gws9
         1eHVkGF4HJIm9sYC2yp2mrDVhIEPeoasJJw1fDy8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <qutran@marvell.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 134/162] scsi: qla2xxx: Fix DMA unmap leak
Date:   Thu, 19 Dec 2019 19:34:02 +0100
Message-Id: <20191219183215.937277258@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183150.477687052@linuxfoundation.org>
References: <20191219183150.477687052@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Himanshu Madhani <hmadhani@marvell.com>

[ Upstream commit 5d328de64d89400dcf9911125844d8adc0db697f ]

With debug kernel we see following wanings indicating memory leak.

[28809.523959] WARNING: CPU: 3 PID: 6790 at lib/dma-debug.c:978
dma_debug_device_change+0x166/0x1d0
[28809.523964] pci 0000:0c:00.6: DMA-API: device driver has pending DMA
allocations while released from device [count=5]
[28809.523964] One of leaked entries details: [device
address=0x00000002aefe4000] [size=8208 bytes] [mapped with DMA_BIDIRECTIONAL]
[mapped as coherent]

Fix this by unmapping DMA memory.

Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_bsg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index 2d5375d677367..df856a2895ae1 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -336,6 +336,8 @@ qla2x00_process_els(struct fc_bsg_job *bsg_job)
 		dma_map_sg(&ha->pdev->dev, bsg_job->request_payload.sg_list,
 		bsg_job->request_payload.sg_cnt, DMA_TO_DEVICE);
 	if (!req_sg_cnt) {
+		dma_unmap_sg(&ha->pdev->dev, bsg_job->request_payload.sg_list,
+		    bsg_job->request_payload.sg_cnt, DMA_TO_DEVICE);
 		rval = -ENOMEM;
 		goto done_free_fcport;
 	}
@@ -343,6 +345,8 @@ qla2x00_process_els(struct fc_bsg_job *bsg_job)
 	rsp_sg_cnt = dma_map_sg(&ha->pdev->dev, bsg_job->reply_payload.sg_list,
 		bsg_job->reply_payload.sg_cnt, DMA_FROM_DEVICE);
         if (!rsp_sg_cnt) {
+		dma_unmap_sg(&ha->pdev->dev, bsg_job->reply_payload.sg_list,
+		    bsg_job->reply_payload.sg_cnt, DMA_FROM_DEVICE);
 		rval = -ENOMEM;
 		goto done_free_fcport;
 	}
-- 
2.20.1



