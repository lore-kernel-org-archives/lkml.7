Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDFAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B38D2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 15:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbfCYPvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:51:45 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:56519 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbfCYPvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 11:51:45 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MTzjI-1hZIRP1azK-00R4M0; Mon, 25 Mar 2019 16:51:29 +0100
From:   Arnd Bergmann <arnd@arndb.de>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>, arm@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: iop: don't use using 64-bit DMA masks
Date:   Mon, 25 Mar 2019 16:50:43 +0100
Message-Id: <20190325155101.3544731-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190325155101.3544731-1-arnd@arndb.de>
References: <20190325155101.3544731-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Hv3LTYYLlNBnUJVUFqJpGCxxG4jl6evNSCupUx46HycKGBxmm7w
 MXPSMJfuEagKHZyuZ+35E29j2Zez4il1iWh8qxMH8zNMiMYAQXuDwRT43We+EOYj0HL+c74
 n5Yg/h2MqoXjzZhF3D/+G9cNXkTjVh5NYCY7u7moY2+mhbFOAy9ksSpEgLGeGK5JGDR0nff
 ehFv4ZyWZFo3FIdBRqLTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fhkbTZq//L8=:EW4G0364E4EzR8fmxAy6iI
 6n/KFiS0AZRP4gPKYbSvGpVM/e8lmFemCFlfExxCdv5kPiA0iCb7seHOIV7YCIDPjkuJnG4R9
 sJ0MjU0ZI6UfBFge+yIfJsBDXSk9BtdYz3xQhEx22IwbJFIQ8VX9zsvk9V4ZAq8PBlqurUVoO
 mw2BNUNLgMkLvomLBH4UfuyktxW/tFhoYDkx72DRHQX43kGvBBGVO2oBAhuWAPLmdjVyrYfAv
 cPsJW4Zg+dW1cdMUbnCAEx9N02YZv34bNNqpaewoRrnwOEIIkhgQhlYBcFuxqAbc/ej9uv/HJ
 h5PYTpQJHMzlP8ffC9l+H6oG/JEtOWwGMlCaSVsoHj+YorLob85aBhS7Tpw5Xwdb4Qw+tQBzY
 fWiBBCBpxu71XP5qaOouaeLTp7Lm/UU+EfaSrcExh/X/HrXlUxlWLgPWGXTuzDAqBch2qAOI3
 r7qYAEmJ13NPR2WS+EAbcx27Bq0oQEkMRcsn/UNqToVp2XtM6yzSJvdV0IwT29y8eL7WAcrjU
 lOWQmW2xrPInp2fuceaSrXc6HM46mml8Dj1V9U+etW8px5l89TSjISoQ+eyqhjza/JTS/M4he
 eT5J7H+JDurXWswJZo7nyVir4AkfrIOx9dsq28u95MUrozegE2z52uOBI04dD53DkkE4hl2x/
 lp/ZCFLFkMEpQUDSzV7hMfnh1hTZXwdjHwit2C486uVGC6Yf79yVvmAPoiqPMVHLBkzaBLz9T
 z90UbpKk5unXIxQrsdgZPt+BAxILkG3jc6BGRA==
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
iop and orion appear to be the only platforms declaring 64 bit masks
statically. When they are fixed, we don't need to change the macro.
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
2.20.0

