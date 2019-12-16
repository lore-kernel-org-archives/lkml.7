Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A165C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B3F206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576521774;
	bh=y7OMTS5PMCtYozOn+uHI++ECBNyWlbR1yxACa+fOnDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J3ca9nAI56nyzHRm5Sjqofis4jQmRQjsut43HxnTP5lQombUolpKWcKwDoCZ6O3No
	 SDdiiHtCKFmqOl0aq9zqLgAs6KBPwePj0pXkfjRHZYPbhJrnIL5MDv90Fx3tuQSeZa
	 5V4C8q6uLjHwxWkmGNxPSc0orQOSO88SgWVlchh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbfLPSmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:42:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:33842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728241AbfLPSAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:00:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F116206EC;
        Mon, 16 Dec 2019 18:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519204;
        bh=y7OMTS5PMCtYozOn+uHI++ECBNyWlbR1yxACa+fOnDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UFuwQbxa7W9yFKveb4/9dCC5dA2Fm9/Lj9u4RYjiSbl6iLRBw2d1BW0SZRCTQDYkj
         k7zxtWRbJfjBoFSsGhsc5JPKU5kA3xveXq7DRW5Jk+fSyK+ao0hw+iiNTO4D/gfNim
         QTavsTvIjocAc1n3sKvs7vGzDWH4Y8IqiuEo0j14=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Quinn Tran <qutran@marvell.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 239/267] scsi: qla2xxx: Fix DMA unmap leak
Date:   Mon, 16 Dec 2019 18:49:25 +0100
Message-Id: <20191216174915.644798754@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
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
index 7472d3882ad41..6f8c7df69f66c 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -342,6 +342,8 @@ qla2x00_process_els(struct bsg_job *bsg_job)
 		dma_map_sg(&ha->pdev->dev, bsg_job->request_payload.sg_list,
 		bsg_job->request_payload.sg_cnt, DMA_TO_DEVICE);
 	if (!req_sg_cnt) {
+		dma_unmap_sg(&ha->pdev->dev, bsg_job->request_payload.sg_list,
+		    bsg_job->request_payload.sg_cnt, DMA_TO_DEVICE);
 		rval = -ENOMEM;
 		goto done_free_fcport;
 	}
@@ -349,6 +351,8 @@ qla2x00_process_els(struct bsg_job *bsg_job)
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



