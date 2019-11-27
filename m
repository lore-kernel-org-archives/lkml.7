Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46586C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E7121844
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887803;
	bh=+MSac9lGQ3g4tukeHIJJKFOOP18cM1X5Kz249xwJKOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=szpkE6emW7GYreJIqvjs0wBGV/K70EyV+uc7fV0fK3kqDwxg0jIPUlg1zaurXqFWc
	 TbFu0CpAmA8+eX6qaBMIuRPYRyNaXuNsKdL9oYqEy4licYW7RW53KmAmaHrWOsbu5q
	 mLmLUn9T8ZnwHvV8BWe17pu5LMfG3N8vOg/U+quE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbfK0UuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:50:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:35682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730293AbfK0Ut5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:49:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B686221787;
        Wed, 27 Nov 2019 20:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887797;
        bh=+MSac9lGQ3g4tukeHIJJKFOOP18cM1X5Kz249xwJKOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qK9AxabDDpCNh8FABottI0bul3evCScLUB0TvJSOoiZtXgVopxqxNmuU/2md46k7m
         0ksl6yEI3WRCqTHEVcPdUG+1c2iMEqFECbT6AdYIdIuBn1V2JObpz71TdaJxFSYMw7
         p1rtLM1CqsBH03JQzQ4RDPVhXJ26Hyg7hhEl4WMU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 055/211] scsi: dc395x: fix DMA API usage in sg_update_list
Date:   Wed, 27 Nov 2019 21:29:48 +0100
Message-Id: <20191127203059.335114220@linuxfoundation.org>
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



