Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0ED4C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF63215A4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887249;
	bh=+MSac9lGQ3g4tukeHIJJKFOOP18cM1X5Kz249xwJKOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S123wRiy4fpEU6apcBl8DqE2lmDbVbwuGSgufiqMA1YDX1sRIIjiRQngFcLns9vKc
	 gXpck/ua768QLzwE9j8JvGx1wQHULJj3yK0zwislsaRU8gg54jxRbR3jFRsiRXSt3t
	 hLbdnvI2SxziKk3uloY/I5vkkmbqEiF7IczHEJS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbfK0Uks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:40:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:45446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729065AbfK0Ukn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:40:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E48CA21780;
        Wed, 27 Nov 2019 20:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887243;
        bh=+MSac9lGQ3g4tukeHIJJKFOOP18cM1X5Kz249xwJKOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BB3m/LUKuaUITuPsklJ5fz8K1GpN3vjeXjq31R8ueRi4IWD3hoELXhgZdtsDsqsas
         Eang9WKT3t2zzt99mj3KDJNl+DL82/u1DrHT+IwRVR392vkguIk3QqBdQ0+cQ9iBfR
         4eCeDJAu9vFUkNrMbyD7zfdNNeMFWjemSvpS++iM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 036/151] scsi: dc395x: fix DMA API usage in sg_update_list
Date:   Wed, 27 Nov 2019 21:30:19 +0100
Message-Id: <20191127203022.471385962@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203000.773542911@linuxfoundation.org>
References: <20191127203000.773542911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 6c404a68bf83b4135a8a9aa1c388ebdf98e8ba7f ]

We need to transfer device ownership to the CPU before we can manipulate
the mapped data.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/dc395x.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index 9da0ac360848f..830b2d2dcf206 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -1972,6 +1972,11 @@ static void sg_update_list(struct ScsiReqBlk *srb, u32 left)
 			xferred -= psge->length;
 		} else {
 			/* Partial SG entry done */
+			pci_dma_sync_single_for_cpu(srb->dcb->
+					    acb->dev,
+					    srb->sg_bus_addr,
+					    SEGMENTX_LEN,
+					    PCI_DMA_TODEVICE);
 			psge->length -= xferred;
 			psge->address += xferred;
 			srb->sg_index = idx;
-- 
2.20.1



