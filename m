Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F805C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3591720835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfCDUTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:19:55 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:59245 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCDUTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:19:55 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MryOx-1hLRlX3AF3-00nweE; Mon, 04 Mar 2019 21:19:46 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Linus Walleij <linusw@kernel.org>, Enrico Weigelt <info@metux.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] x86: apuv2: fix input dependencies
Date:   Mon,  4 Mar 2019 21:19:20 +0100
Message-Id: <20190304201930.1622839-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190304201930.1622839-1-arnd@arndb.de>
References: <20190304201930.1622839-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ylsiu+1WUSKbU/xQv18irdCbEBXfU0nongfEalQpp7PDSOC7332
 atWBq/XLdpiw1EP4DY6RKEptDAndTP46Xwg9RqMRI9rO2cJqVmam4msuRpBVhZXxv6odnvV
 g5K+xFLc+po/Jn9ZNcP4khEv8+/RZj94nQkKoje0zmnnVMlWLgnx3jORpqQ9/D1MMbP5vxl
 wLJkmznkS5bzcL66mN1pA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vxi3d1CkIjM=:Kv/xz16e0cT2tVvFcjLiTm
 ep0vrQiqkLICd611ziJE7MHcpUhHAYbUtgQKrk87S15p6o5gkb9lm33+MyCOWCB8JsKnwabOm
 Cc2IjFIpiQlRzHh03tHH9T8rc7cqpG1sEvTFvWY8TnTX5osZ0K55aKv2P+6j+uY4dmi+zyEzN
 XN7LuThxVYvUvOY2GBOZwMcPHZqgYEW8ti5Lg4EiIqAvdxRvjh6ivBAeokJlfTvivm1xrCCMm
 Ph94g0uDcWoLq/AN57WEt4cIzk+fpZCQ9XWcur4Kwc8uM6Z9i8D1MjfcpRu2X0FQ0e8I93Frq
 asCv1rieGK5BaRwXJlHLcup6PvML9jH+oeZvSzzxblCdR5RFLp2pLoIsr+O9yEPJ86fOA7ykt
 BuJk6kGtDMSDohW1+AXyWd3UEqbm4mmHDuRrXdDHmb1xICCO/sTchrtGR2h3SQ3wchTU9ILgx
 z5902sy+tPPqceXWe0SDzqNPGSrMO2IunO8Y53XEMJ8bz5snhQzT03L5tfcBqdEil1bS7eniS
 2QoOtfNOX8gBet/xVAz9j3fbAUkRhN10ubXh5Qz7Tk+QNdqgiS7ybyvjuMtOooJ6NytA2qQ8D
 wkLnXIpOQzC0Obx3ELte3B6lJQ6q8qumnHTfBVWHR1WgNDp+upazaQ665kgriTDQpOTpm8tuQ
 MCb/fsKWBswV5V2N1q9Aiu0NUkrPsSg2Cxw479I1UCn+z2shwn2cmftDPE0Bbb6YTrY6+0gqU
 SvO9vaQAggb/UaHl0Hj+nW0SngNYSkS1xjjTdQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We cannot select KEYBOARD_GPIO_POLLED if CONFIG_INPUT or CONFIG_INPUT_KEYBOARD
are disabled:

WARNING: unmet direct dependencies detected for KEYBOARD_GPIO_POLLED
  Depends on [n]: !UML && INPUT [=y] && INPUT_KEYBOARD [=n] && GPIOLIB [=y]
  Selected by [y]:
  - PCENGINES_APU2 [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y]

This could be fixed using either a dependency or a 'select' statement.
I'm chosen 'depends on' here since it is simpler has a lower risk of
introducing circular dependencies.

Fixes: f8eb0235f659 ("x86: pcengines apuv2 gpio/leds/keys platform driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 851ea921a58d..4d65d37b0c86 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1305,6 +1305,7 @@ config HUAWEI_WMI
 
 config PCENGINES_APU2
 	tristate "PC Engines APUv2/3 front button and LEDs driver"
+	depends on INPUT && INPUT_KEYBOARD
 	select GPIO_AMD_FCH
 	select KEYBOARD_GPIO_POLLED
 	select LEDS_GPIO
-- 
2.20.0

