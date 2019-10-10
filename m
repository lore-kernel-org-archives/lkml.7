Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE327C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE238206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfJJUkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 16:40:31 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:42177 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfJJUkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:40:31 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M1JJC-1iFv8y1hxS-002m0W; Thu, 10 Oct 2019 22:40:18 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 14/36] ARM: s3c: move irqchip driver back into platform
Date:   Thu, 10 Oct 2019 22:29:58 +0200
Message-Id: <20191010203043.1241612-14-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191010203043.1241612-1-arnd@arndb.de>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tpUU70kK2mbi+5FuJ7O/HDHJNvQ8Wxs2kgX7rE8BR+L60lBoHF3
 wudUVfEaPZ9r7AlBGTwQ0IxuvapY4pSNPE0QBHfF+o50E83eu4tVD1qYwE6XUbr46E4S4CB
 PLET0g3wo0KgjbRE2wat355k7aL1MgVVW0+pgArdBYfiF+X0dI8YgaMNmtJufHX+aYCzOCC
 HLscEytGGJ2sXXgaVEk4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q6XMjTeUzfA=:kDFlER7V334bXhY74s+aIR
 u3ogHMtNrh4V/IPMBwdJUxAYexjVtwtYWli4YpVUT7eNc94Edi1n6HlrJIT3Uks3xzHL/Aiio
 sD8r5yaB2audjRtGokFlBjtEuOm7dgB557Hm/0scEcKcwYGcwCiavuJnuDBDQzoZdIse5+HNM
 wUZdOy6PjZNPA9SktuBKQElsVX3i8z+G5zu60ry63tPG2frH28OPRI68mi7dXmF0kS73Bs/5V
 WG9oUYkTlVkbTjccpzyGqxfx/VNO64NkG/byVmT+q65qidyLadkd6N/Jxk3onG5nYu7RwYW5R
 0wh+OpcUzPA9UcyHIyAgtQko0pOgGhh0HoK7cN/hshmtbympJdYcnThHxrLRCkGYRVMCvaCSU
 TRjDydkbrRcIfpLkmHkzsnp2/xB0Y0OzqPaYELfgNmeDK2ffk+/fTLv/TTjPxjrfi+7qGtV85
 5tZyZP2zRKeXl2v2WSuFI1MEteHrEAMvcbZxUnczyfgifZAmGCs0lJInkdsUHUFgO4gNihHFw
 LrCLW2UIBcGQilEpQwTdEVuIs9l2G4qMXEWEU4MO3/eKTz2fJ9VDyPTaD+Co0sajf0G79Nhna
 gaY2z0GpLjtT3mBAc5ZoNW2+gTqZyq3f6yxcHVV36U3mrTpVuDwMfO4PNLdzaf+zbyRL+UV3j
 GXpPl0v4G4zeFjWXEz3Tk74cp2kX54MIv8VU5t1Ya9geXNK21FwDWVFVPMYm6ROCBCP9id4fv
 Kfi/qwP3bzpB1PPfNq4j22rsXokzBVv5L/hJ4+RDaaJNYMPkgF9R44FmHBoP5iAb5i8g58ysk
 2mU0CR+ieJGPiyJVIxXINQfBSh6Ta/XGRX+d92EOigqJWVxAgawm0txOak/khOmw1qmLpnWNm
 1G2OwpElH6YpJGzp7AAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was a good idea to move it out at first, but the irqchip code
is still tightly connected to the s3c24xx platform code and uses
multiple internal header files, so just move it back for the
time being to avoid those dependencies.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-s3c24xx/Makefile                           | 1 +
 {drivers/irqchip => arch/arm/mach-s3c24xx}/irq-s3c24xx.c | 0
 drivers/irqchip/Makefile                                 | 1 -
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename {drivers/irqchip => arch/arm/mach-s3c24xx}/irq-s3c24xx.c (100%)

diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index 6692f2de71b2..8c31f84f8c97 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -8,6 +8,7 @@
 # core
 
 obj-y				+= common.o
+obj-y				+= irq-s3c24xx.o
 
 obj-$(CONFIG_CPU_S3C2410)	+= s3c2410.o
 obj-$(CONFIG_S3C2410_PLL)	+= pll-s3c2410.o
diff --git a/drivers/irqchip/irq-s3c24xx.c b/arch/arm/mach-s3c24xx/irq-s3c24xx.c
similarity index 100%
rename from drivers/irqchip/irq-s3c24xx.c
rename to arch/arm/mach-s3c24xx/irq-s3c24xx.c
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index cc7c43932f16..92864e496251 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -16,7 +16,6 @@ obj-$(CONFIG_ARCH_LPC32XX)		+= irq-lpc32xx.o
 obj-$(CONFIG_ARCH_MMP)			+= irq-mmp.o
 obj-$(CONFIG_IRQ_MXS)			+= irq-mxs.o
 obj-$(CONFIG_ARCH_TEGRA)		+= irq-tegra.o
-obj-$(CONFIG_ARCH_S3C24XX)		+= irq-s3c24xx.o
 obj-$(CONFIG_DW_APB_ICTL)		+= irq-dw-apb-ictl.o
 obj-$(CONFIG_CLPS711X_IRQCHIP)		+= irq-clps711x.o
 obj-$(CONFIG_OMPIC)			+= irq-ompic.o
-- 
2.20.0

