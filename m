Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1A6C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3A320843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557918449;
	bh=pWx+gOD2V8JM4p0svlMqSMD6Grb5nz9Xoi1IWHwocTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S1abyAt0IYTn9rPAgHSa/VrkLIsIou0Mg6h27J0ns8wKkvX4R+v4/dr0s2OnZZHjj
	 dtyptnEMMzqaZglMCAQIgB8jWvWt6O3wlSPHbp8OgGd47vMxOcH6VLBDR0S+YYO5++
	 YaC3sH1hbikGrScD5NOkadUmeDV1sWnM/cgm/14M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbfEOLH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:07:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728523AbfEOLHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:07:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6E0C21473;
        Wed, 15 May 2019 11:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918443;
        bh=pWx+gOD2V8JM4p0svlMqSMD6Grb5nz9Xoi1IWHwocTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U7omnVXfV0iI4fBGe1udqgrPGxp6t7vdI3zon10vRhcXh+V0ws7wmHlJl06qky8LZ
         CAO7uP3kBwbBabcTOeWbeqOQtnAYz0pqWIQN3SxuMZo5pFhHoNWD9CeUX3oZLIZ1g5
         0oGBlaJZNYcqGy3l2MwqVmtBluCWfMiSlHalWgh4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 133/266] ARM: orion: dont use using 64-bit DMA masks
Date:   Wed, 15 May 2019 12:54:00 +0200
Message-Id: <20190515090727.444360804@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090722.696531131@linuxfoundation.org>
References: <20190515090722.696531131@linuxfoundation.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/plat-orion/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index 8861c367d061..51c3737ddba7 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -645,7 +645,7 @@ static struct platform_device orion_xor0_shared = {
 	.resource	= orion_xor0_shared_resources,
 	.dev            = {
 		.dma_mask               = &orion_xor_dmamask,
-		.coherent_dma_mask      = DMA_BIT_MASK(64),
+		.coherent_dma_mask      = DMA_BIT_MASK(32),
 		.platform_data          = &orion_xor0_pdata,
 	},
 };
@@ -706,7 +706,7 @@ static struct platform_device orion_xor1_shared = {
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



