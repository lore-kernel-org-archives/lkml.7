Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE70C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3386620675
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558553867;
	bh=f00Z042OxVO1lpGglNkqwDzP9Wehwz5cJyphswOCSj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oo6IeTax2rGHy1Gtx7ofX4kgfxZqO4QC9WWDWLEID8VLs6nnfGQglHmEQpjsWj+LO
	 iNko+gL8O4Yoaq2oDA4l8kMCe8cu6yFo5Bz2OAhQfn4phjCBA5AETZtRmrUF/gBJMi
	 tQ96rvEqHFa4pSKeYwvO9nqAzLcxNfdGLAtM7iPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfEVThq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:37:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733150AbfEVTaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:30:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34042217D4;
        Wed, 22 May 2019 19:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553410;
        bh=f00Z042OxVO1lpGglNkqwDzP9Wehwz5cJyphswOCSj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AjIClk0dEqX6DgKVOAdpBcoFy9bVu9UCiZ49YcPkTyjMUJrkZF3BpCm7vMXMcwvct
         RmB1qEyNtfqzOTPcdOKmIkHRb3I5dhx5D9rkrHZLzU3zqji8KRlMzUR14tdiKxc8vQ
         AUVj+Wy6Vz69ATP3OUvSUBfshF3ntCCRoKhleHjA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 058/167] dmaengine: at_xdmac: remove BUG_ON macro in tasklet
Date:   Wed, 22 May 2019 15:26:53 -0400
Message-Id: <20190522192842.25858-58-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192842.25858-1-sashal@kernel.org>
References: <20190522192842.25858-1-sashal@kernel.org>
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
index 4db2cd1c611de..22764cd30cc39 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1606,7 +1606,11 @@ static void at_xdmac_tasklet(unsigned long data)
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

