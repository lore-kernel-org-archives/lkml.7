Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE7EC10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A20421874
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfCVOFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:05:16 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:55721 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbfCVOFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:05:16 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mlejs-1ghJNm2mf4-00igkg; Fri, 22 Mar 2019 15:05:08 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Zhao Qiang <qiang.zhao@nxp.com>,
        Yalin Wang <yalin.wang@sonymobile.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bitrev: fix constant bitrev
Date:   Fri, 22 Mar 2019 15:04:55 +0100
Message-Id: <20190322140503.123580-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DjxO67pqGSmp/6OXn3JSRwKihmVX3Z6HQD8rsXRcR2QgYIGheUs
 1A/SGunzMjAjCuL9pk10yL/joHa/RBrzqiF8gFGRG+pqe6MsayQLHLFPiTPyQ5I0q+W7Kct
 0BLMvLUSMD89AgV7l6z5dIMS0ObsvhWlWK8KaPxLGoRboVGFxEmwsDABe/ullalPP/YAd3Z
 EhuYoUJN+mpe1qDOzLKgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z//SUnpAaVw=:RMLFOHxNBAN5wj1JB7NMYh
 EAAYYml6kukoFQkDrnPEWxcmm56Xwzcs810TaF/STKKS4rBLLM7DSxpar8OIzSjg0wePPRvUF
 n9j8bO96nTBReKb4QAphhU/Ms/2HDNRzNrdOcRDGaVW94IkE8ik0Q0qTguICzx6Li4uqNoG1H
 WiDu0vCMxoBWR6vEGj8Z0Hxjnp3jhQnKJ4BTvLk2xxlA1PyWNmoj6El0G2ZX+jULukRkQ38Ez
 +f81FanxuYYGT9KljND87Zgvq1JiFciFW0QmSLFARXeNK9YYPyO6nLEwhTcG4f70XbHDpYs9y
 99HljQsq1C6fnKJJdd14+XTz4zu0gMtSWZ6jrsXXoliCi/4+fE2xgH1rkPF1QGvPVFdzaiyRS
 yx6KS60m3z1M1JqYElpFCIj4kaX0vm46l4adjIaFnhi0S9EiSNeejBQM06d5oVtMmuPUjMrwp
 NI3G1Zl8VhRscEYalsfvCLRm3vNGb7hsBfEM+9wVk/0LN4ZL8xRnu33u7XNARnRLCgyUgHttV
 /F1M7A8RENahjyQd0kc8aWwU+7L8VuCNfqGPEJgveIe556dMRP0RmOSb3eDKINcSm6sDS1MDl
 ikTwlYy8OnaO8KkRyr4i8CmxvsQdjbPJAyN/naOV8Xo91MFizgQ0xKyGvDHBXnhPSwdMwPT6t
 lnQvp7bwCbE13pJIAypceEXbOogX8wn4OvIl7qMihUUbDuCuZgGlyDn3sN/USamu9R3ZVB7A6
 gWwi9FrxgIxIKhTsNI+uQ2/EZ0mBvKk1xoneqg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang points out with hundreds of warnings that the bitrev macros
have a problem with constant input:

drivers/hwmon/sht15.c:187:11: error: variable '__x' is uninitialized when used within its own initialization
      [-Werror,-Wuninitialized]
        u8 crc = bitrev8(data->val_status & 0x0F);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/bitrev.h:102:21: note: expanded from macro 'bitrev8'
        __constant_bitrev8(__x) :                       \
        ~~~~~~~~~~~~~~~~~~~^~~~
include/linux/bitrev.h:67:11: note: expanded from macro '__constant_bitrev8'
        u8 __x = x;                     \
           ~~~   ^

Both the bitrev and the __constant_bitrev macros use an internal variable
named __x, which goes horribly wrong when passing one to the other.

The obvious fix is to rename one of the variables, so this adds an
extra '_'.

It seems we got away with this because
- there are only a few drivers using bitrev macros
- usually there are no constant arguments to those
- when they are constant, they tend to be either 0 or (unsigned)-1
  (drivers/isdn/i4l/isdnhdlc.o, drivers/iio/amplifiers/ad8366.c)
  and give the correct result by pure chance.

In fact, the only driver that I could find that gets different results
with this is drivers/net/wan/slic_ds26522.c, which in turn is a driver
for fairly rare hardware (adding the maintainer to Cc for testing).

Cc: Zhao Qiang <qiang.zhao@nxp.com>
Cc: Yalin Wang <yalin.wang@sonymobile.com>
Cc: stable@vger.kernel.org
Fixes: 556d2f055bf6 ("ARM: 8187/1: add CONFIG_HAVE_ARCH_BITREVERSE to support rbit instruction")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/bitrev.h | 46 +++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/linux/bitrev.h b/include/linux/bitrev.h
index 50fb0dee23e8..d35b8ec1c485 100644
--- a/include/linux/bitrev.h
+++ b/include/linux/bitrev.h
@@ -34,41 +34,41 @@ static inline u32 __bitrev32(u32 x)
 
 #define __constant_bitrev32(x)	\
 ({					\
-	u32 __x = x;			\
-	__x = (__x >> 16) | (__x << 16);	\
-	__x = ((__x & (u32)0xFF00FF00UL) >> 8) | ((__x & (u32)0x00FF00FFUL) << 8);	\
-	__x = ((__x & (u32)0xF0F0F0F0UL) >> 4) | ((__x & (u32)0x0F0F0F0FUL) << 4);	\
-	__x = ((__x & (u32)0xCCCCCCCCUL) >> 2) | ((__x & (u32)0x33333333UL) << 2);	\
-	__x = ((__x & (u32)0xAAAAAAAAUL) >> 1) | ((__x & (u32)0x55555555UL) << 1);	\
-	__x;								\
+	u32 ___x = x;			\
+	___x = (___x >> 16) | (___x << 16);	\
+	___x = ((___x & (u32)0xFF00FF00UL) >> 8) | ((___x & (u32)0x00FF00FFUL) << 8);	\
+	___x = ((___x & (u32)0xF0F0F0F0UL) >> 4) | ((___x & (u32)0x0F0F0F0FUL) << 4);	\
+	___x = ((___x & (u32)0xCCCCCCCCUL) >> 2) | ((___x & (u32)0x33333333UL) << 2);	\
+	___x = ((___x & (u32)0xAAAAAAAAUL) >> 1) | ((___x & (u32)0x55555555UL) << 1);	\
+	___x;								\
 })
 
 #define __constant_bitrev16(x)	\
 ({					\
-	u16 __x = x;			\
-	__x = (__x >> 8) | (__x << 8);	\
-	__x = ((__x & (u16)0xF0F0U) >> 4) | ((__x & (u16)0x0F0FU) << 4);	\
-	__x = ((__x & (u16)0xCCCCU) >> 2) | ((__x & (u16)0x3333U) << 2);	\
-	__x = ((__x & (u16)0xAAAAU) >> 1) | ((__x & (u16)0x5555U) << 1);	\
-	__x;								\
+	u16 ___x = x;			\
+	___x = (___x >> 8) | (___x << 8);	\
+	___x = ((___x & (u16)0xF0F0U) >> 4) | ((___x & (u16)0x0F0FU) << 4);	\
+	___x = ((___x & (u16)0xCCCCU) >> 2) | ((___x & (u16)0x3333U) << 2);	\
+	___x = ((___x & (u16)0xAAAAU) >> 1) | ((___x & (u16)0x5555U) << 1);	\
+	___x;								\
 })
 
 #define __constant_bitrev8x4(x) \
 ({			\
-	u32 __x = x;	\
-	__x = ((__x & (u32)0xF0F0F0F0UL) >> 4) | ((__x & (u32)0x0F0F0F0FUL) << 4);	\
-	__x = ((__x & (u32)0xCCCCCCCCUL) >> 2) | ((__x & (u32)0x33333333UL) << 2);	\
-	__x = ((__x & (u32)0xAAAAAAAAUL) >> 1) | ((__x & (u32)0x55555555UL) << 1);	\
-	__x;								\
+	u32 ___x = x;	\
+	___x = ((___x & (u32)0xF0F0F0F0UL) >> 4) | ((___x & (u32)0x0F0F0F0FUL) << 4);	\
+	___x = ((___x & (u32)0xCCCCCCCCUL) >> 2) | ((___x & (u32)0x33333333UL) << 2);	\
+	___x = ((___x & (u32)0xAAAAAAAAUL) >> 1) | ((___x & (u32)0x55555555UL) << 1);	\
+	___x;								\
 })
 
 #define __constant_bitrev8(x)	\
 ({					\
-	u8 __x = x;			\
-	__x = (__x >> 4) | (__x << 4);	\
-	__x = ((__x & (u8)0xCCU) >> 2) | ((__x & (u8)0x33U) << 2);	\
-	__x = ((__x & (u8)0xAAU) >> 1) | ((__x & (u8)0x55U) << 1);	\
-	__x;								\
+	u8 ___x = x;			\
+	___x = (___x >> 4) | (___x << 4);	\
+	___x = ((___x & (u8)0xCCU) >> 2) | ((___x & (u8)0x33U) << 2);	\
+	___x = ((___x & (u8)0xAAU) >> 1) | ((___x & (u8)0x55U) << 1);	\
+	___x;								\
 })
 
 #define bitrev32(x) \
-- 
2.20.0

