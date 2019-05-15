Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3C1C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5705A21734
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557917983;
	bh=VKIaQHqILKktV1uilDIzU4auAHkCA0xrJuZDJAa28PY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pqHBKMEtNJtStTwiWEVRwfD0TH/IRlceg1cdxi9ZYpRfgtNQvnKpwQ0rIu6mZZJ8l
	 j9rMWvQ3LFve7AQBl9TmSB4IYUKCIWtCd1b8ub/ff/MhGp0WbPbOdr3R7wiJzf9mQt
	 CJ//gy6Do5Kj4r6SRe9AVCqIgnRsU1+gpZEi4EzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfEOK7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 06:59:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727205AbfEOK7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 06:59:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B261C21734;
        Wed, 15 May 2019 10:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557917978;
        bh=VKIaQHqILKktV1uilDIzU4auAHkCA0xrJuZDJAa28PY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MIU4wNqCicPZXBRdM/CVho/zP12IF6FYkFSWLKHyAs7H4WAoQ94jVg8WJ/cxdf4N7
         XJWmhYBHVNIffQWZ5eTLkihSQd/s0kpQc5X09Nc1NQqluZ9o4JB9cLkmWYk4E1hfiz
         dCkqqGNP+P7qO1XPx1vwkU8gf3tgLBwBc4NVPkYQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 46/86] ARM: iop: dont use using 64-bit DMA masks
Date:   Wed, 15 May 2019 12:55:23 +0200
Message-Id: <20190515090651.503656678@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090642.339346723@linuxfoundation.org>
References: <20190515090642.339346723@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 2125801ccce19249708ca3245d48998e70569ab8 ]

clang warns about statically defined DMA masks from the DMA_BIT_MASK
macro with length 64:

 arch/arm/mach-iop13xx/setup.c:303:35: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
 static u64 iop13xx_adma_dmamask = DMA_BIT_MASK(64);
                                  ^~~~~~~~~~~~~~~~
 include/linux/dma-mapping.h:141:54: note: expanded from macro 'DMA_BIT_MASK'
 #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                      ^ ~~~

The ones in iop shouldn't really be 64 bit masks, so changing them
to what the driver can support avoids the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-iop13xx/setup.c |  8 ++++----
 arch/arm/mach-iop13xx/tpmi.c  | 10 +++++-----
 arch/arm/plat-iop/adma.c      |  6 +++---
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-iop13xx/setup.c b/arch/arm/mach-iop13xx/setup.c
index 53c316f7301e..fe4932fda01d 100644
--- a/arch/arm/mach-iop13xx/setup.c
+++ b/arch/arm/mach-iop13xx/setup.c
@@ -300,7 +300,7 @@ static struct resource iop13xx_adma_2_resources[] = {
 	}
 };
 
-static u64 iop13xx_adma_dmamask = DMA_BIT_MASK(64);
+static u64 iop13xx_adma_dmamask = DMA_BIT_MASK(32);
 static struct iop_adma_platform_data iop13xx_adma_0_data = {
 	.hw_id = 0,
 	.pool_size = PAGE_SIZE,
@@ -324,7 +324,7 @@ static struct platform_device iop13xx_adma_0_channel = {
 	.resource = iop13xx_adma_0_resources,
 	.dev = {
 		.dma_mask = &iop13xx_adma_dmamask,
-		.coherent_dma_mask = DMA_BIT_MASK(64),
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 		.platform_data = (void *) &iop13xx_adma_0_data,
 	},
 };
@@ -336,7 +336,7 @@ static struct platform_device iop13xx_adma_1_channel = {
 	.resource = iop13xx_adma_1_resources,
 	.dev = {
 		.dma_mask = &iop13xx_adma_dmamask,
-		.coherent_dma_mask = DMA_BIT_MASK(64),
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 		.platform_data = (void *) &iop13xx_adma_1_data,
 	},
 };
@@ -348,7 +348,7 @@ static struct platform_device iop13xx_adma_2_channel = {
 	.resource = iop13xx_adma_2_resources,
 	.dev = {
 		.dma_mask = &iop13xx_adma_dmamask,
-		.coherent_dma_mask = DMA_BIT_MASK(64),
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 		.platform_data = (void *) &iop13xx_adma_2_data,
 	},
 };
diff --git a/arch/arm/mach-iop13xx/tpmi.c b/arch/arm/mach-iop13xx/tpmi.c
index db511ec2b1df..116feb6b261e 100644
--- a/arch/arm/mach-iop13xx/tpmi.c
+++ b/arch/arm/mach-iop13xx/tpmi.c
@@ -152,7 +152,7 @@ static struct resource iop13xx_tpmi_3_resources[] = {
 	}
 };
 
-u64 iop13xx_tpmi_mask = DMA_BIT_MASK(64);
+u64 iop13xx_tpmi_mask = DMA_BIT_MASK(32);
 static struct platform_device iop13xx_tpmi_0_device = {
 	.name = "iop-tpmi",
 	.id = 0,
@@ -160,7 +160,7 @@ static struct platform_device iop13xx_tpmi_0_device = {
 	.resource = iop13xx_tpmi_0_resources,
 	.dev = {
 		.dma_mask          = &iop13xx_tpmi_mask,
-		.coherent_dma_mask = DMA_BIT_MASK(64),
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 };
 
@@ -171,7 +171,7 @@ static struct platform_device iop13xx_tpmi_1_device = {
 	.resource = iop13xx_tpmi_1_resources,
 	.dev = {
 		.dma_mask          = &iop13xx_tpmi_mask,
-		.coherent_dma_mask = DMA_BIT_MASK(64),
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 };
 
@@ -182,7 +182,7 @@ static struct platform_device iop13xx_tpmi_2_device = {
 	.resource = iop13xx_tpmi_2_resources,
 	.dev = {
 		.dma_mask          = &iop13xx_tpmi_mask,
-		.coherent_dma_mask = DMA_BIT_MASK(64),
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 };
 
@@ -193,7 +193,7 @@ static struct platform_device iop13xx_tpmi_3_device = {
 	.resource = iop13xx_tpmi_3_resources,
 	.dev = {
 		.dma_mask          = &iop13xx_tpmi_mask,
-		.coherent_dma_mask = DMA_BIT_MASK(64),
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 	},
 };
 
diff --git a/arch/arm/plat-iop/adma.c b/arch/arm/plat-iop/adma.c
index a4d1f8de3b5b..d9612221e484 100644
--- a/arch/arm/plat-iop/adma.c
+++ b/arch/arm/plat-iop/adma.c
@@ -143,7 +143,7 @@ struct platform_device iop3xx_dma_0_channel = {
 	.resource = iop3xx_dma_0_resources,
 	.dev = {
 		.dma_mask = &iop3xx_adma_dmamask,
-		.coherent_dma_mask = DMA_BIT_MASK(64),
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 		.platform_data = (void *) &iop3xx_dma_0_data,
 	},
 };
@@ -155,7 +155,7 @@ struct platform_device iop3xx_dma_1_channel = {
 	.resource = iop3xx_dma_1_resources,
 	.dev = {
 		.dma_mask = &iop3xx_adma_dmamask,
-		.coherent_dma_mask = DMA_BIT_MASK(64),
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 		.platform_data = (void *) &iop3xx_dma_1_data,
 	},
 };
@@ -167,7 +167,7 @@ struct platform_device iop3xx_aau_channel = {
 	.resource = iop3xx_aau_resources,
 	.dev = {
 		.dma_mask = &iop3xx_adma_dmamask,
-		.coherent_dma_mask = DMA_BIT_MASK(64),
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 		.platform_data = (void *) &iop3xx_aau_data,
 	},
 };
-- 
2.20.1



