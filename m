Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EA2C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF09215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119119;
	bh=rhHRo2v442EhnNaf/8eTEgT06HCu/RNtjBI3CumZBPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UkFyYfFAj1IwVkBk9AFt6V+4pBgxB4dEqqsMJBSeM1cTkVYPrX57MC6n4w/4/O96n
	 31lD8CimqB28+2VJgnTCPvqgPbN1IwG+klwM6PR1vq5EKvBqG46is/dKEDY/th5YyN
	 8T92XK7tH0XFinFYnBVggIf9r6qE+L6Sq5u2xSmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387671AbfJCQL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:11:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:33786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387928AbfJCQLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:11:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF52A20865;
        Thu,  3 Oct 2019 16:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119112;
        bh=rhHRo2v442EhnNaf/8eTEgT06HCu/RNtjBI3CumZBPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1UOPMFLZp7naOFCE2vxg3OGhoD3grQyE47I7TlbUWgpLOudcj+u+yGcKwHVNXl6CG
         ssbY0QU/kl4NFz1WqJ0Yc3e0Bu46qhTq/41eKv/nDsxrHS/nnRienC9vWkrEgSQwGO
         GsiK3sWTQpeLEsvCNs8ygCAYStS/WNSYlr3FG7Ts=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 123/185] dmaengine: ti: edma: Do not reset reserved paRAM slots
Date:   Thu,  3 Oct 2019 17:53:21 +0200
Message-Id: <20191003154505.673074578@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154437.541662648@linuxfoundation.org>
References: <20191003154437.541662648@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

[ Upstream commit c5dbe60664b3660f5ac5854e21273ea2e7ff698f ]

Skip resetting paRAM slots marked as reserved as they might be used by
other cores.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20190823125618.8133-2-peter.ujfalusi@ti.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/edma.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index a7ea20e7b8e94..519c24465dea4 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -2268,9 +2268,6 @@ static int edma_probe(struct platform_device *pdev)
 
 	ecc->default_queue = info->default_queue;
 
-	for (i = 0; i < ecc->num_slots; i++)
-		edma_write_slot(ecc, i, &dummy_paramset);
-
 	if (info->rsv) {
 		/* Set the reserved slots in inuse list */
 		rsv_slots = info->rsv->rsv_slots;
@@ -2283,6 +2280,12 @@ static int edma_probe(struct platform_device *pdev)
 		}
 	}
 
+	for (i = 0; i < ecc->num_slots; i++) {
+		/* Reset only unused - not reserved - paRAM slots */
+		if (!test_bit(i, ecc->slot_inuse))
+			edma_write_slot(ecc, i, &dummy_paramset);
+	}
+
 	/* Clear the xbar mapped channels in unused list */
 	xbar_chans = info->xbar_chans;
 	if (xbar_chans) {
-- 
2.20.1



