Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA0BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A842087E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbfCYPvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:51:25 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:43903 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbfCYPvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 11:51:23 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MfHMj-1gTJdc1nn1-00glfR; Mon, 25 Mar 2019 16:51:03 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>, arm@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: orion: don't use using 64-bit DMA masks
Date:   Mon, 25 Mar 2019 16:50:42 +0100
Message-Id: <20190325155101.3544731-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:COBMlKzTRvZ6y/b9fWVlle7Lr1pZJQdoRG82Gy4ic7tc+JYEdfn
 /da8hPKxn/piF3r0wUar3rQRg6d16Mbg3KZD3g7TPYyLk36tMx9u3DqngiCRK6yAYn//T01
 e1k7l/Md2szJDSPbmKO8xvjX7jNpaqTI8xUOuW2kLAMp+w0oyYzMIVmMtSFhY9CkYJQPrRC
 Ha178RlaBaCsQmVaFTKvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1BYFSPewexA=:lbtFuhNoThCFslHT2j2Qxs
 rmsSsH5KRbTR8s0QS2Cy3ivO5ofrsvdnU9VdCdC5ERoXwWySgHXJ0Eo2WHDDRYThjsMKgakaf
 IdcGNcxj0EbKxP7JMG3pqnfwujTu0JXO4ExqynEznkHLEx6ttA29emsXLklJW0eVhEIoVREeW
 33E6//mPo3pe/Nkbx4KwFH7pLt74dnVZemXHkOkbm1SvL2PkS0G0wmLDNPt1blxtXO37/exhK
 4y8/O+jAR+9fRYn3OgCNfo3u3ZLD2I5G/MjYZjfzK3GEctIoZYVZuakg9TqZozjclWkGKYhmc
 +meD0xDK0RsmLbXSX3ORtJSSuWMYXa5osChbmdw1Cfk9iyNfd8PNF8erBEtUPE8aFsgpR3KHi
 gnQaSFfoMHzOi9KDmrfyR9QCpkC/cRgyMhPk1g0eTtfKmtfKQskTF5Yg8qaDFWNvcR1dtHwJl
 +8XUX03FTiHE39psKoQ1BVogAmAdxG5cCljgTFs59c602kcjcuMd1wS3FBoIZ2+jxx7A8leo1
 sl3rlkyWH3jJa4Yy+6y6exdZh3Xb2NOGv5V2H726N8+/iObKDPIlvIB3PUGBzwJx6z9q/v7Bm
 h+mbmYH+Sasi7SwEYNKxrEJ9rUJjt2TgzBxYm2gkJGScRAs0hkdpLhyKJ/PxrlZpS3gRtSAwS
 uNcE499E10ZkNc3K8bUXtXRluuOZo5jmUxkLLbHubprBFhC6ct8V3Ukd/D+Pfg4ijaE/BpU5G
 UGCB96aZNy6XFhv39qM2YJv9BMJAKLAD7OOoYg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 arch/arm/plat-orion/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index a6c81ce00f52..8647cb80a93b 100644
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
2.20.0

