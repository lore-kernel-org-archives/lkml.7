Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6424CC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DCD21847
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887800;
	bh=zVi3l48Dj1pEq/lXVT7CWip3HEIXhUTRhaX6jVURMJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JroW+xt86ANVVPOPzwlHenKUpmO7yxKb4t6ukprRwcMfixCgiWEOkp36bFENlp7L2
	 M0CuhzZeE8I2toM2lOiqOl6g/+fNwiTnvMN7pocX+xB+nE9L3rJR6LxZTtW3WER/Oj
	 Hxk2osVdCSgTzK9TgVUanfNoddeONyfRelqK+qtY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbfK0Ut7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:49:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:35624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729874AbfK0Utz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:49:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43F2D21843;
        Wed, 27 Nov 2019 20:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887794;
        bh=zVi3l48Dj1pEq/lXVT7CWip3HEIXhUTRhaX6jVURMJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ovLStZijde1wXRR/IibclDv5Yatwry+WK1/YucsnxugkJk0bDqHzj9qYKddVBZsPL
         XCwY7KsdcNg0lXbwD3YVzuOeDfwNnXPVk+a8LQ34rhlIRTGFzX2RvbHe5LZ3+W7xt4
         k/mhaMAqiGsW2L4i3dRVtbfg1bIZfFWKRGxJBnNc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 054/211] scsi: dc395x: fix dma API usage in srb_done
Date:   Wed, 27 Nov 2019 21:29:47 +0100
Message-Id: <20191127203059.231825161@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203049.431810767@linuxfoundation.org>
References: <20191127203049.431810767@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 3a5bd7021184dec2946f2a4d7a8943f8a5713e52 ]

We can't just transfer ownership to the CPU and then unmap, as this will
break with swiotlb.

Instead unmap the command and sense buffer a little earlier in the I/O
completion handler and get rid of the pci_dma_sync_sg_for_cpu call
entirely.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/dc395x.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index 5ee7f44cf869b..9da0ac360848f 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -3450,14 +3450,12 @@ static void srb_done(struct AdapterCtlBlk *acb, struct DeviceCtlBlk *dcb,
 		}
 	}
 
-	if (dir != PCI_DMA_NONE && scsi_sg_count(cmd))
-		pci_dma_sync_sg_for_cpu(acb->dev, scsi_sglist(cmd),
-					scsi_sg_count(cmd), dir);
-
 	ckc_only = 0;
 /* Check Error Conditions */
       ckc_e:
 
+	pci_unmap_srb(acb, srb);
+
 	if (cmd->cmnd[0] == INQUIRY) {
 		unsigned char *base = NULL;
 		struct ScsiInqData *ptr;
@@ -3511,7 +3509,6 @@ static void srb_done(struct AdapterCtlBlk *acb, struct DeviceCtlBlk *dcb,
 			cmd, cmd->result);
 		srb_free_insert(acb, srb);
 	}
-	pci_unmap_srb(acb, srb);
 
 	cmd->scsi_done(cmd);
 	waiting_process_next(acb);
-- 
2.20.1



