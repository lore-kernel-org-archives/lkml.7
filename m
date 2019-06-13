Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522F7C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 276FE208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="IUKGD7qi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389674AbfFMPvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:51:40 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:51194 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731664AbfFMJLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:11:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45PdKN4JJzzB09Zf;
        Thu, 13 Jun 2019 11:11:52 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=IUKGD7qi; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 3RUzFGec82Hn; Thu, 13 Jun 2019 11:11:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45PdKN327kzB09ZZ;
        Thu, 13 Jun 2019 11:11:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1560417112; bh=cUi98ap1JHPgzHUcPuQ+SGqO7xRW7HHyt2QyM8V7Ab8=;
        h=From:Subject:To:Cc:Date:From;
        b=IUKGD7qiW0+tIV5Tl076uAfx5o59J4G32wQJhvMkR10S8zPGKOqG62aI8WeWyN44b
         wFyj2WCxfdcednX0RRFE4XXa2bO+7ev5Hv0qaH9v8Ve+6tQs5OKxAiIkFsp1VNWWZp
         mFjyK+/qKYIHd1BQlzlVSECePreCN6PkmjRk3dhY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 75C1E8B8C0;
        Thu, 13 Jun 2019 11:11:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id AJ27zzXuDbW2; Thu, 13 Jun 2019 11:11:53 +0200 (CEST)
Received: from po16838vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3C0898B8B9;
        Thu, 13 Jun 2019 11:11:53 +0200 (CEST)
Received: by po16838vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 06C4568B1D; Thu, 13 Jun 2019 09:11:53 +0000 (UTC)
Message-Id: <1930b7e67ab361e68f356e7fdeba403e32ce3ad0.1560416986.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 01/10] powerpc/8xx: move CPM1 related files from sysdev/ to
 platforms/8xx
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, oss@buserror.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 13 Jun 2019 09:11:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only 8xx selects CPM1 and related CONFIG options are already
in platforms/8xx/Kconfig

Move the related C files to platforms/8xx/.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/platforms/8xx/Makefile                 | 3 +++
 arch/powerpc/{sysdev => platforms/8xx}/cpm1.c       | 0
 arch/powerpc/{sysdev => platforms/8xx}/cpm_gpio.c   | 0
 arch/powerpc/{sysdev => platforms/8xx}/micropatch.c | 0
 arch/powerpc/sysdev/Makefile                        | 3 ---
 5 files changed, 3 insertions(+), 3 deletions(-)
 rename arch/powerpc/{sysdev => platforms/8xx}/cpm1.c (100%)
 rename arch/powerpc/{sysdev => platforms/8xx}/cpm_gpio.c (100%)
 rename arch/powerpc/{sysdev => platforms/8xx}/micropatch.c (100%)

diff --git a/arch/powerpc/platforms/8xx/Makefile b/arch/powerpc/platforms/8xx/Makefile
index 708ab099e886..10b338436655 100644
--- a/arch/powerpc/platforms/8xx/Makefile
+++ b/arch/powerpc/platforms/8xx/Makefile
@@ -3,6 +3,9 @@
 # Makefile for the PowerPC 8xx linux kernel.
 #
 obj-y			+= m8xx_setup.o machine_check.o pic.o
+obj-$(CONFIG_CPM1)		+= cpm1.o
+obj-$(CONFIG_UCODE_PATCH)	+= micropatch.o
+obj-$(CONFIG_8xx_GPIO)		+= cpm_gpio.o
 obj-$(CONFIG_MPC885ADS)   += mpc885ads_setup.o
 obj-$(CONFIG_MPC86XADS)   += mpc86xads_setup.o
 obj-$(CONFIG_PPC_EP88XC)  += ep88xc.o
diff --git a/arch/powerpc/sysdev/cpm1.c b/arch/powerpc/platforms/8xx/cpm1.c
similarity index 100%
rename from arch/powerpc/sysdev/cpm1.c
rename to arch/powerpc/platforms/8xx/cpm1.c
diff --git a/arch/powerpc/sysdev/cpm_gpio.c b/arch/powerpc/platforms/8xx/cpm_gpio.c
similarity index 100%
rename from arch/powerpc/sysdev/cpm_gpio.c
rename to arch/powerpc/platforms/8xx/cpm_gpio.c
diff --git a/arch/powerpc/sysdev/micropatch.c b/arch/powerpc/platforms/8xx/micropatch.c
similarity index 100%
rename from arch/powerpc/sysdev/micropatch.c
rename to arch/powerpc/platforms/8xx/micropatch.c
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index aaf23283ba0c..cfcade8270a9 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -37,12 +37,9 @@ obj-$(CONFIG_XILINX_PCI)	+= xilinx_pci.o
 obj-$(CONFIG_OF_RTC)		+= of_rtc.o
 
 obj-$(CONFIG_CPM)		+= cpm_common.o
-obj-$(CONFIG_CPM1)		+= cpm1.o
 obj-$(CONFIG_CPM2)		+= cpm2.o cpm2_pic.o cpm_gpio.o
-obj-$(CONFIG_8xx_GPIO)		+= cpm_gpio.o
 obj-$(CONFIG_QUICC_ENGINE)	+= cpm_common.o
 obj-$(CONFIG_PPC_DCR)		+= dcr.o
-obj-$(CONFIG_UCODE_PATCH)	+= micropatch.o
 
 obj-$(CONFIG_PPC_MPC512x)	+= mpc5xxx_clocks.o
 obj-$(CONFIG_PPC_MPC52xx)	+= mpc5xxx_clocks.o
-- 
2.13.3

