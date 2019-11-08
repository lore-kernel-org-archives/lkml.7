Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E08FC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6D321D7F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213269;
	bh=Ze+zPj9F92/cxye0P++w2Oo8cvHRn+ZLD1meN+16LYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K0edgOoHkkysr+LQS70OCLmAsWAW5UGYT4TWoLCLXNJ1lNUX2R8cilXLT38EIrOdJ
	 hkfXqHSJ0meIiK6haGwNfR5LS+LJIi8UvFC4AEiAWjxJb2CqNVZKAoZ87Fbjiw5b+D
	 LVbltYCtNzNZ+goYJ/vOoqrp3EyYDpkra07gEYTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389192AbfKHLlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:41:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:53976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389067AbfKHLk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:40:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AF7621D7F;
        Fri,  8 Nov 2019 11:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213256;
        bh=Ze+zPj9F92/cxye0P++w2Oo8cvHRn+ZLD1meN+16LYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z+ySufRCxQT76o86mKikddIfB73kqEZSUZ8HZ1oo93TtkjS94J7hHvWclWGlLQMXg
         IosjEwBEG/QmM0ZcB514u+TlqHBM7lKrfhllLfr8MO76t5oUKC11YsIxoZSRRIiJeg
         lxHIk3eAHAt8+qJomHyKKbDgWZxYl1X7ZFalr05w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 121/205] dmaengine: dma-jz4780: Don't depend on MACH_JZ4780
Date:   Fri,  8 Nov 2019 06:36:28 -0500
Message-Id: <20191108113752.12502-121-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Cercueil <paul@crapouillou.net>

[ Upstream commit c558ecd21c852c97ff98dc6c61f715ba420ec251 ]

If we make this driver depend on MACH_JZ4780, that means it can be
enabled only if we're building a kernel specially crafted for a
JZ4780-based board, while most GNU/Linux distributions will want one
generic MIPS kernel that works on multiple boards.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index dacf3f42426de..a4f95574eb9ad 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -143,7 +143,7 @@ config DMA_JZ4740
 
 config DMA_JZ4780
 	tristate "JZ4780 DMA support"
-	depends on MACH_JZ4780 || COMPILE_TEST
+	depends on MIPS || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.20.1

