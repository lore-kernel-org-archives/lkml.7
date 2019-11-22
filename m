Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7E6C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66A620721
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419258;
	bh=3jIzAoGEAbLTkPA56joQwREDvF++1UpiLp04sayvO+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iEQDXI6BVBVs7NPo0/q6F/yA7dG+8J7ZM7hxbNQm+MVR+zG7/6afcauaYS/9If7Qm
	 EnhavTweUYTCQ4RAU/au5rRqgYCBVt1th0knsM9m2fnKqvJFmKqJYB0gcpU/Osd6W1
	 jeKgJa8TImt+BOP/InnG2vng2BoYMOKIwmFqwakY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfKVKk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:40:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:45116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727688AbfKVKky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:40:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19EE82071F;
        Fri, 22 Nov 2019 10:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419253;
        bh=3jIzAoGEAbLTkPA56joQwREDvF++1UpiLp04sayvO+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N4uTJxdY2epUsgnZSnWE1GXv/Mjb589fbZ9QlHChDwFGkbZH+20jqDhVJMyZkSsbh
         gKC/YhPQp82xAPQhNqpbIV6xgnA2fdfTxq5GF96BBSgN0bMaQM24Y8RHfiF1DAC2aj
         77eYZMZemUBaNUU3Txmn33eoS257EqUeL1cEZyW0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 049/222] dmaengine: dma-jz4780: Dont depend on MACH_JZ4780
Date:   Fri, 22 Nov 2019 11:26:29 +0100
Message-Id: <20191122100853.666068079@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
References: <20191122100830.874290814@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



