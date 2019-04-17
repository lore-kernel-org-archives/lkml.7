Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B334C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110DC217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732647AbfDQPOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:14:05 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:44591 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731472AbfDQPOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:14:05 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MYe6H-1hKKlV1Dsp-00Vdk2; Wed, 17 Apr 2019 17:13:54 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     arm@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Baruch Siach <baruch@tkos.co.il>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] ARM: debug-ll: add default address for digicolor
Date:   Wed, 17 Apr 2019 17:13:27 +0200
Message-Id: <20190417151348.100050-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lN9u0ql+aUnL4uj8ptZUgD/NVAUFWrEyugq5Kx0iHAGwOZIiaSs
 ID5XQkqiuBABPpzZMf8lxPnmEEwBoOIaOtzJhZYJX9fFNyrvDcSkW6mT6ODDqqqHYeeMccO
 aUQnVuj65lXcYZsYAcDPe+6cCc3GPCg8kMP0bqdZIOiHjm6WSzw9FNsC3q8ECaEehSKH3g/
 pWKgnlmYnr0fy3/9tbCyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yJCA4eDQoNA=:KeK/+ZZOEsE54Prwol3Ss7
 QFY5/N9lF7T0YyRQHyyO+PokI4ngaQMKqnYfAeyiR3BBM5VrFzQnyxdaIf6bkktaGxZSrqPdg
 FiPIi3jlqU2o5+PcGoBTWXjD/f5rMpc8uBUK3+Kqh7mS0XAIWIRzKFRdT5Dr2o7NhuwBwG1az
 Ed0PUGRPoceDeBv17x5+rlBwglY12ysizuWcKWk7a2P5aZwaDq9e4/xCs/PwyiImKjrrDX97e
 6xu7bpEdjSsyRQlYymBY4Xr7BlzXo9ddcxU4jKRNLlm/JvYdIiJ9pMmuoNqkoffFAX/+7tmT1
 EJvFvGbEbA3q0zm+PP8vXUwYRSZeF9x357NLdZZQQjcDuNUdg2oky43yWGJ8Ktnf2prqgblrC
 35ssIEUO10Ns8qC81gWUPYeISa1CjVoE00do35ClmudDIdlQlKHiDEoTpg50xRSX3u40zdweq
 JgaoOEuJ0uslM9zHFAowoEe5Xa8Uly7rD0/gRVd9rAQhyvcnea8yPxOUqkFHWIegF8dxubTRE
 u39YCwat8e9HTAgY5fbZzLTzIs2380aroXcxGk8yVJaSkuTSbgweddn/HPyN0BUs7xwRBfr1/
 K0Tc5C/zUQHnGIUd6AlKbIh+OMjYiJjhkBKS/ThHDHH4NDmD3pnYIoGpsTi0HJCwFww5pBkwV
 LsIlB9R4uvEV/q9XUO77OojQkWx2/XOqK6irLONnduGOwR9r0SpMyR6yjeW0rPqIRKOwYKRH2
 kVtuDvJu4MNveGQ0KznWluJ4rhXBjQv0UgKJSw==
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
index a8a1e14f20ab..3e33753bd60c 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1676,6 +1676,7 @@ config DEBUG_UART_PHYS
 	default 0xe6e68000 if DEBUG_RCAR_GEN2_SCIF1
 	default 0xe6ee0000 if DEBUG_RCAR_GEN2_SCIF4
 	default 0xe8008000 if DEBUG_R7S72100_SCIF2
+	default 0xf0000000 if DEBUG_DIGICOLOR_UA0
 	default 0xf0000be0 if ARCH_EBSA110
 	default 0xf1012000 if DEBUG_MVEBU_UART0_ALTERNATE
 	default 0xf1012100 if DEBUG_MVEBU_UART1_ALTERNATE
@@ -1728,6 +1729,7 @@ config DEBUG_UART_VIRT
 	default 0xe0010fe0 if ARCH_RPC
 	default 0xf0000be0 if ARCH_EBSA110
 	default 0xf0010000 if DEBUG_ASM9260_UART
+	default 0xf0100000 if DEBUG_DIGICOLOR_UA0
 	default 0xf01fb000 if DEBUG_NOMADIK_UART
 	default 0xf0201000 if DEBUG_BCM2835 || DEBUG_BCM2836
 	default 0xf1000300 if DEBUG_BCM_5301X
-- 
2.20.0

