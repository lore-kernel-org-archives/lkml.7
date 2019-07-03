Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19466C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A6421852
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfGCU4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 16:56:30 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:44615 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfGCU41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:56:27 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MqbDs-1iMWxP2do8-00masw; Wed, 03 Jul 2019 22:56:03 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Abbott Liu <liuwenliang@huawei.com>,
        linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH 2/3] kasan: disable CONFIG_KASAN_STACK with clang on arm32
Date:   Wed,  3 Jul 2019 22:54:37 +0200
Message-Id: <20190703205527.955320-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190703205527.955320-1-arnd@arndb.de>
References: <20190703205527.955320-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dVu6TB6bK7PiXC0nWCBWTtH4+VmEpXav81wxunH7qxb9O8LK6xY
 9t1OBqgcoNKISokDJOGEmpsK9Olw4WiYxv3R4Yk0VHCPHCwbE5CfGGDvCGKORzYaTcZzpMZ
 m0fJ4OWUu8fhsgmIFep0j6SXmG5L3NTwAgbpxGDx8Qj04BISYNu2I01zggQ4J9AyAUBAt5n
 camESeoPyJjNiAUdUlgtA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BtQ+/a+4hxk=:BXsO/jIoni0w1uZ5xMb/V6
 h3BmSvC14FIsrbv1u2lvwtgR132tDDF864k1Mm0/o1613vabZUA4IFS/P8E4jRRI6wzptV5lM
 jniEHTkB7qHeV/3lCntpeY7GYB4gr9Vvv+AKKRatXz3x21fZBGm2/fGSYXAXY+ZYcmSlQRb0Z
 3uc+P/LLZG12LdSV4N+0Jdl/ijlnTXia0VndfpbgkK0UMbzs9GaMSjIuFE72esecJiyh9QXlC
 jNr2Bequ/b5BgqDk6YfU+QnZsfElwGyaURabVnt6B5C4Ohxqk07JXMFYf1RDOphcRy1RG3a7g
 cX1kSgnBkWa6c7lXaA5Hp4HJ+c0RNNy3WS5G15hdnR29brBeN7LGOMTBv+bUvZj2fKB9A8rcd
 xDU4aHuOfToN3Mi0jKRBJbkqfK4pL2GQiLvrctVa9OboD57iyUbUJJQxSc64DPWyyv/TwAWg+
 4rlCQYskxhnYiA1upHe0T38dZpE4V+pDZ9UUdpPEEC+JaKy0Z7hPP3gDh8UQUk7wDeMlx43Ma
 Nj2f2RvuW0zBufN7CCC1gzXZZ7yj6LKcva/a4KeZ+T9LAHp/QTc4vBkJmaBeQePNHF7pDF9ty
 lgByqBiJ5vNeyY0IYOTYOX5SjHBdj73WL+AOjE6+yMAAfu05z4cLAPM2ewhkYRfsv/UNbfGFL
 1jdoMMETbefmQEsOxl2/ok8E/gLyIPPUwGrnjqGFE8jZCT2/J0FOdGzP9k7kfPWx7NIPnmgMn
 vIN90lJ0ZDhmHtW8bJnYoKFXqd3tUJdj5FcRRA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CONFIG_KASAN_STACK symbol tells us whether we should be using the
asan-stack=1 parameter. On clang-8, this causes explosive kernel stack
frame growth, so it is currently disabled, hopefully to be turned back
on when a future clang version is fixed. Examples include

drivers/media/dvb-frontends/mb86a20s.c:1942:12: error: stack frame size of 4128 bytes in function
drivers/net/wireless/atmel/atmel.c:1307:5: error: stack frame size of 4928 bytes in function 'atmel_open'
drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c:1521:1: error: stack frame size of 5440 bytes in function
drivers/media/i2c/mt9t112.c:670:12: error: stack frame size of 9344 bytes in function 'mt9t112_init_camera'
drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c:185:12: error: stack frame size of 10048 bytes

For the 32-bit ARM build, the logic I introduced earlier does
not work because $(CFLAGS_KASAN_SHADOW) is empty, and we don't add
those flags.

Moving the asan-stack= parameter down fixes this. No idea of any
of the other parameters should also be moved though.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/Makefile.kasan | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
index 6410bd22fe38..fc57fcf49722 100644
--- a/scripts/Makefile.kasan
+++ b/scripts/Makefile.kasan
@@ -26,10 +26,11 @@ else
 	CFLAGS_KASAN := $(CFLAGS_KASAN_SHADOW) \
 	 $(call cc-param,asan-globals=1) \
 	 $(call cc-param,asan-instrumentation-with-call-threshold=$(call_threshold)) \
-	 $(call cc-param,asan-stack=$(CONFIG_KASAN_STACK)) \
 	 $(call cc-param,asan-instrument-allocas=1)
 endif
 
+CFLAGS_KASAN += $(call cc-param,asan-stack=$(CONFIG_KASAN_STACK))
+
 endif # CONFIG_KASAN_GENERIC
 
 ifdef CONFIG_KASAN_SW_TAGS
-- 
2.20.0

