Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0BAC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8452084D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214032;
	bh=3jIzAoGEAbLTkPA56joQwREDvF++1UpiLp04sayvO+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eqkdSVxkTU2RAPp3QzpPtvlCSpdKLpcoMoWiim9uv/ErGBxpWHTM9yWI5tJvyEbXV
	 +3I+lrPaZSjaLEtwaevtyl+VklwRjkJky5lZ6MmMYKkVYvoSIzLXmH8lrslxgqsuyK
	 XR+2MXzwg3xOfNjnJQzyxsSPEM9nhoojYF5HHVOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390471AbfKHLxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:53:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:34318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391360AbfKHLqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:46:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A49F7222CF;
        Fri,  8 Nov 2019 11:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213592;
        bh=3jIzAoGEAbLTkPA56joQwREDvF++1UpiLp04sayvO+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vtY2MSEGmBMbRt86SNr+zWcU2NNXZcNrsnJdxS9iLvAVHjspkTRQPz70Ob71g/ryb
         0rYJwssrKDIhHq9fm6LVBEAhnAScYe9/qSoM9gRD19cX3ZLqCo7uLdCdZuLXNPrxJ4
         3n6Z2xU73RoHGYqB9uX/zohVk2+yt/l1kIeOujt0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 34/64] dmaengine: dma-jz4780: Don't depend on MACH_JZ4780
Date:   Fri,  8 Nov 2019 06:45:15 -0500
Message-Id: <20191108114545.15351-34-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114545.15351-1-sashal@kernel.org>
References: <20191108114545.15351-1-sashal@kernel.org>
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
index 141aefbe37ec9..b0f798244a897 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -120,7 +120,7 @@ config DMA_JZ4740
 
 config DMA_JZ4780
 	tristate "JZ4780 DMA support"
-	depends on MACH_JZ4780 || COMPILE_TEST
+	depends on MIPS || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.20.1

