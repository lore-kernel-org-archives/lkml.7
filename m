Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F4DC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E056C2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574890629;
	bh=XP4W78k7tWdh+OxHKfg/hOgoXSYlnsAKcT0blXHT8RY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XaCT+0nmQ+kxEm6berfA9ADtgcn2F5jD9x4/0JRRIGRDVddzJ+q7OR0sd4ItlB8Bz
	 yqiNgdO48in6W2NVzeecdMKPyPoosp1ZyIKyisIor8EUeChxF5omxXvunPNIDu/1/e
	 3ooD+lJBJiGpZH8DWVTRSzUBHk/JupaWpk1zdSvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbfK0VhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:37:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:59994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729215AbfK0UrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:47:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E653C21823;
        Wed, 27 Nov 2019 20:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887637;
        bh=XP4W78k7tWdh+OxHKfg/hOgoXSYlnsAKcT0blXHT8RY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ExVmbEo+Elv9B/EkNQA2vo8wemIuPqE73F6PHSHKUW+fL5xPIWVCbEOumkJqUZRkL
         LYSh39YO8XnYjnn7UVz5tVdFpGJxTS6eIUbg3Q18qG/DCHMFqTrY+B+3R4wHvo1N3L
         W8kT6N25L680lRaOXu5Lun677umlJPto7/MPNY+c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 035/211] misc: mic: fix a DMA pool free failure
Date:   Wed, 27 Nov 2019 21:29:28 +0100
Message-Id: <20191127203055.205259032@linuxfoundation.org>
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

From: Wenwen Wang <wang6495@umn.edu>

[ Upstream commit 6b995f4eec34745f6cb20d66d5277611f0b3c3fa ]

In _scif_prog_signal(), the boolean variable 'x100' is used to indicate
whether the MIC Coprocessor is X100. If 'x100' is true, the status
descriptor will be used to write the value to the destination. Otherwise, a
DMA pool will be allocated for this purpose. Specifically, if the DMA pool
is allocated successfully, two memory addresses will be returned. One is
for the CPU and the other is for the device to access the DMA pool. The
former is stored to the variable 'status' and the latter is stored to the
variable 'src'. After the allocation, the address in 'src' is saved to
'status->src_dma_addr', which is actually in the DMA pool, and 'src' is
then modified.

Later on, if an error occurs, the execution flow will transfer to the label
'dma_fail', which will check 'x100' and free up the allocated DMA pool if
'x100' is false. The point here is that 'status->src_dma_addr' is used for
freeing up the DMA pool. As mentioned before, 'status->src_dma_addr' is in
the DMA pool. And thus, the device is able to modify this data. This can
potentially cause failures when freeing up the DMA pool because of the
modified device address.

This patch avoids the above issue by using the variable 'src' (with
necessary calculation) to free up the DMA pool.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/mic/scif/scif_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mic/scif/scif_fence.c b/drivers/misc/mic/scif/scif_fence.c
index cac3bcc308a7e..7bb929f05d852 100644
--- a/drivers/misc/mic/scif/scif_fence.c
+++ b/drivers/misc/mic/scif/scif_fence.c
@@ -272,7 +272,7 @@ static int _scif_prog_signal(scif_epd_t epd, dma_addr_t dst, u64 val)
 dma_fail:
 	if (!x100)
 		dma_pool_free(ep->remote_dev->signal_pool, status,
-			      status->src_dma_addr);
+			      src - offsetof(struct scif_status, val));
 alloc_fail:
 	return err;
 }
-- 
2.20.1



