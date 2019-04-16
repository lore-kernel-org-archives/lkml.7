Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D197CC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5CF32077C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbfDPNSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:18:03 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:45223 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfDPNSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:18:03 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MPXQi-1hU3CQ4A9S-00MbZQ; Tue, 16 Apr 2019 15:17:49 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     arm@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Baruch Siach <baruch@tkos.co.il>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: debug-ll: add default address for digicolor
Date:   Tue, 16 Apr 2019 15:17:30 +0200
Message-Id: <20190416131746.1303495-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fwTdw+l9kVa6fOtmnIO52nhUJMcaPosyBl1f+hU03D9+UXyS4oT
 oC6YMst8gZVfVL2ovllRDbGPcqN+sJSrhg0uhwD183hxpk26+mYzVsajxe9sZCCCrKU88Er
 ZCkXMcp4AtDLN6ZLGG91kULXwmfpqatn0KkoGD7AsAUSHN5F1C8hzo/UMn72OHe10dobIOy
 B2j4qGajZCit1IbQ29lNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vaTzPpgMRbA=:NqXmIO/mq/mvAFXCpgYiF+
 9zHN3YIE2mhVOF0AtMt8npzcbj+8HT64MwVdY6x0MnC2s6nt+kKfwBqu84UUrt/JHMYTHt1Om
 1XbrVOZGWqTAx9He6IUvLwPRVAN8mGEeoB1qHr+FBG4rLYXguS6OMhH0890YRb5q9uZDw9E90
 rzPmOHjKlihvrze5lzATCfUNFtG0LnohNPn1ie3JZeCTue7lNfMVdeiZbi8W8gRdh7re6X8bM
 h7XXk+sYC1XNI4ME584KGNGWHudOjuKUp05gtobjUYWIw8WtgbHKTN/jzzhKSkeuDfWWE9cVk
 gCZai57nPmtRx4oIDhJnxRz7VLJu9yE8/MRucEdddVfXuf9N5MZRG6h13ougi9gQ84trEr5Bv
 fM8KTR92Wc2ml2ltmKmJODGM7AEX22S8AU1VhmcRvbc4QwHzhF80aorPWi8j1/0Odw1WdeTQR
 UDPpLvs1UjtIbspCNd19ZrMTrDTRD65T66tXtO39ey0dDD/KQ/xe79idkrw8C5qVW/BoZ19Y+
 rbIatp77zZ36IGehJX+7o3umDK/iI24LWc71ujHhyROllz7om0T8b6u+9PEclAXO5mmL6rV6m
 8olZae1jqBunOSt/wb2U3JYJJn4MVA1Eaz9ajUf1D66CBZGrs7bSa2vGq2hsbe4CLtm1cV2x5
 MWTtQDC8CukD8xLWfwuk6ZVtlD07OwuRJ17N9txPMErdHM7NtpsWQomznreTURSPbA3Sc7tr2
 Rtd3zz8My3FMcBGjOofWeN/6hMUioOMO5I7glA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The digicolor platform has three UARTs, but the Kconfig.debug
file explicitly lists port zero as the one to be used for the
console, while not providing any default values.

This can get an automated randconfig build stuck in a loop
waiting for the user to input the number. As we already know
the physical address, this patch provides that number as
default, along with a reasonable default value for the virtual
address.

Cc: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig.debug | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index a8a1e14f20ab..e5f0b36d797f 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1676,6 +1676,7 @@ config DEBUG_UART_PHYS
 	default 0xe6e68000 if DEBUG_RCAR_GEN2_SCIF1
 	default 0xe6ee0000 if DEBUG_RCAR_GEN2_SCIF4
 	default 0xe8008000 if DEBUG_R7S72100_SCIF2
+	default 0xf0000740 if DEBUG_DIGICOLOR_UA0
 	default 0xf0000be0 if ARCH_EBSA110
 	default 0xf1012000 if DEBUG_MVEBU_UART0_ALTERNATE
 	default 0xf1012100 if DEBUG_MVEBU_UART1_ALTERNATE
@@ -1785,6 +1786,7 @@ config DEBUG_UART_VIRT
 	default 0xfd012000 if DEBUG_MVEBU_UART0_ALTERNATE && ARCH_MV78XX0
 	default 0xfd883000 if DEBUG_ALPINE_UART0
 	default 0xfde12000 if DEBUG_MVEBU_UART0_ALTERNATE && ARCH_DOVE
+	default 0xfe000740 if DEBUG_DIGICOLOR_UA0
 	default 0xfe012000 if DEBUG_MVEBU_UART0_ALTERNATE && ARCH_ORION5X
 	default 0xfe017000 if DEBUG_MMP_UART2
 	default 0xfe018000 if DEBUG_MMP_UART3
-- 
2.20.0

