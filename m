Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7FFC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9B52081C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558553556;
	bh=D200CXy67XjO1scPzvvOcxjzJGmSM2K1O0HZUnjQlWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yrnOVc1uuy/esjkcb3TFmNmaVzCu6vaVMiJjGVKLCMLV9oJJXJ3nHyCwbs1u6b9iI
	 FbaD2479gHVlU7kZyKq5NXmAuJGOgTPAeNq+X/jg7GQgwY8BFUhYsw4pzoKzBrx4p3
	 XmHYEUoEZ5Y5TVxYXDoBp8iRtpb8c0+QrX3pTssE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387813AbfEVTcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:32:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387772AbfEVTcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:32:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B19E7204FD;
        Wed, 22 May 2019 19:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553533;
        bh=D200CXy67XjO1scPzvvOcxjzJGmSM2K1O0HZUnjQlWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TZ9hQJCCJAigzgLO1frtTNAjgrVFwWiAoXoqPJwlsFigvcsZGvZnhnmBIg8W9rNUR
         Clm1yeX09cE69XgEMz7pzxv83aRSwNshj5flUipzgKWsnI23NVImZEadiOUcKU0h+h
         LQWRaOafvL6kjgWtPscS5lvLi3GvGIl8YWkg2PAY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 29/92] dmaengine: at_xdmac: remove BUG_ON macro in tasklet
Date:   Wed, 22 May 2019 15:30:24 -0400
Message-Id: <20190522193127.27079-29-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522193127.27079-1-sashal@kernel.org>
References: <20190522193127.27079-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

[ Upstream commit e2c114c06da2d9ffad5b16690abf008d6696f689 ]

Even if this case shouldn't happen when controller is properly programmed,
it's still better to avoid dumping a kernel Oops for this.
As the sequence may happen only for debugging purposes, log the error and
just finish the tasklet call.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/at_xdmac.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index af24c5bf32d69..8aa3ccf42e55a 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1608,7 +1608,11 @@ static void at_xdmac_tasklet(unsigned long data)
 					struct at_xdmac_desc,
 					xfer_node);
 		dev_vdbg(chan2dev(&atchan->chan), "%s: desc 0x%p\n", __func__, desc);
-		BUG_ON(!desc->active_xfer);
+		if (!desc->active_xfer) {
+			dev_err(chan2dev(&atchan->chan), "Xfer not active: exiting");
+			spin_unlock_bh(&atchan->lock);
+			return;
+		}
 
 		txd = &desc->tx_dma_desc;
 
-- 
2.20.1

