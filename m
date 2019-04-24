Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55DCC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B328218FD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117496;
	bh=kbPImaxhSTMElddTnrUVtWwHk6sVFIPf9yZa/qhindg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LBdvE/oP3D8Hgb/2ODWJ5Iyt1RQFNQcCNVUxdTH5R67uwjr3Wnfn41vWrHgkQsVEI
	 n8xDUjnB7QY0n4zjLuGKAqOGhNmRcIp0mse0v3ZuHjrFgbVQpaMf/0RUFoPoLJ169K
	 vgaDy0RjEb0MxI2vpOJs4xAOuO+fajJBc4VRyp/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731403AbfDXOvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:51:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732820AbfDXOv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:51:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8B33218FD;
        Wed, 24 Apr 2019 14:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556117489;
        bh=kbPImaxhSTMElddTnrUVtWwHk6sVFIPf9yZa/qhindg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t2ryPiy4SeWt2c8FOeuGrDQ37Wg2OpN6cbVqaOBuhfjVlxII7t1IqRBeHh8MH7pSW
         0A9Kw8ZGhvurvyQoZAiW0JAlk6tqxJbvbcomYY9EtYoH33YscnRKZi7i3McEClQ1Ja
         XBFs9rLS30+I9GSl7y7HbMmjS5gl5xEX7UbXXg38=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 27/28] ARM: orion: don't use using 64-bit DMA masks
Date:   Wed, 24 Apr 2019 10:50:11 -0400
Message-Id: <20190424145012.30886-27-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424145012.30886-1-sashal@kernel.org>
References: <20190424145012.30886-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

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
index 272f49b2c68f..bb29e6ebdc0d 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -605,7 +605,7 @@ static struct platform_device orion_xor0_shared = {
 	.resource	= orion_xor0_shared_resources,
 	.dev            = {
 		.dma_mask               = &orion_xor_dmamask,
-		.coherent_dma_mask      = DMA_BIT_MASK(64),
+		.coherent_dma_mask      = DMA_BIT_MASK(32),
 		.platform_data          = &orion_xor0_pdata,
 	},
 };
@@ -666,7 +666,7 @@ static struct platform_device orion_xor1_shared = {
 	.resource	= orion_xor1_shared_resources,
 	.dev            = {
 		.dma_mask               = &orion_xor_dmamask,
-		.coherent_dma_mask      = DMA_BIT_MASK(64),
+		.coherent_dma_mask      = DMA_BIT_MASK(32),
 		.platform_data          = &orion_xor1_pdata,
 	},
 };
-- 
2.19.1

