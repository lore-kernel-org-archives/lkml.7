Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8062FC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492062087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557155186;
	bh=zDAKcMa/8chgKR168C5oTv7UXbBJQlB3EXyfwadbaiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SDM36j3amPpcmczYE8xCY/PLg6N0sWoH5EC/uTxVTAGymRik3LUdgV8ioY4cqOcfa
	 q/XOXKmAP6C4lIk3ACm1YohJNv0Dke6GVtL/Rs1zOPvlUDkFfn5h7XDZVQmvVhKQks
	 3Hg7sKL93OqfC9+OSr7fjB4VzsHGlzIjFDEyBe7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfEFPGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:06:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbfEFOhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:37:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACA93214AF;
        Mon,  6 May 2019 14:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153474;
        bh=zDAKcMa/8chgKR168C5oTv7UXbBJQlB3EXyfwadbaiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qeJejRd3lDaaFcGE1GSwf6eYDBWKUUJWWAu2UDIi85PRuVnrfODvWGXoj3tJRRZDs
         KSFSzNnQL69dSrGlAEH0ZIlleuDV1Igm9Wve9Pp8wckdssEm0PRnJ6wSWqeM7mM+mN
         Xs4Cgn1CPLrg/TxRwQ5uxwucbtmaaCK94oBg3Goo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 5.0 081/122] ARM: orion: dont use using 64-bit DMA masks
Date:   Mon,  6 May 2019 16:32:19 +0200
Message-Id: <20190506143102.082580250@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143054.670334917@linuxfoundation.org>
References: <20190506143054.670334917@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit cd92d74d67c811dc22544430b9ac3029f5bd64c5 ]

clang warns about statically defined DMA masks from the DMA_BIT_MASK
macro with length 64:

arch/arm/plat-orion/common.c:625:29: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
                .coherent_dma_mask      = DMA_BIT_MASK(64),
                                          ^~~~~~~~~~~~~~~~
include/linux/dma-mapping.h:141:54: note: expanded from macro 'DMA_BIT_MASK'
 #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))

The ones in orion shouldn't really be 64 bit masks, so changing them
to what the driver can support avoids the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 arch/arm/plat-orion/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index a2399fd66e97..1e970873439c 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -622,7 +622,7 @@ static struct platform_device orion_xor0_shared = {
 	.resource	= orion_xor0_shared_resources,
 	.dev            = {
 		.dma_mask               = &orion_xor_dmamask,
-		.coherent_dma_mask      = DMA_BIT_MASK(64),
+		.coherent_dma_mask      = DMA_BIT_MASK(32),
 		.platform_data          = &orion_xor0_pdata,
 	},
 };
@@ -683,7 +683,7 @@ static struct platform_device orion_xor1_shared = {
 	.resource	= orion_xor1_shared_resources,
 	.dev            = {
 		.dma_mask               = &orion_xor_dmamask,
-		.coherent_dma_mask      = DMA_BIT_MASK(64),
+		.coherent_dma_mask      = DMA_BIT_MASK(32),
 		.platform_data          = &orion_xor1_pdata,
 	},
 };
-- 
2.20.1



