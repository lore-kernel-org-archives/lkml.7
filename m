Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BFBC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F6320840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfCGPzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:55:16 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:52649 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfCGPzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:55:16 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MlfGs-1gcB010reU-00ihuN; Thu, 07 Mar 2019 16:55:11 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v3] spi: work around clang bug in SPI_BPW_RANGE_MASK()
Date:   Thu,  7 Mar 2019 16:54:21 +0100
Message-Id: <20190307155506.2993868-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:L/LSRopOXQh6OeRW8D6OrIyx9PmpLgOLgU6/FG3n93lP0OQh/d1
 W/xudIwXDI+JqGBr3ZJnjLT3gDcp8NROLWyDfIixB6xiFpQyuLN4xQBkivBZDHWZJ5OOcDe
 gn+/+rZDiG3S3vjd3xvBuuk73r3pQkbWYencG534b8Pv6lMMw67hnnSRHWzckmuCcqQAXyO
 F9WqyW8zr+i9bR4XNVqIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ExDB5wYZMpw=:Td4Qud0kQWOC55zMjsFQKy
 MCG0mdL5Z/2yDYM6Ceh3Wl/FCWdY7Kb0H4bVqKqG+8Emq/0Jnvdsykj8LpIR6Zf4VjCjJ19x5
 5yK3xu4V632YR6EkfkX9M048ynRP9VgY+6hd2NO8E7X9AnJQ10UB6pJu+wET0J1sS4pv1LQy8
 5geFAgxQI7ITwLf72J9ETf/FS/nfxNugDT6dH0PL0kXqtFrquLvWyMdw98gleIvC0iDdN3u3x
 u8mH7faiG35k4xc5pS2nOaqEoklFyaUOLTrjHZW/9M2iRVuvqUl86ZZI08C0/SLLrZbe1uCvc
 Yy3eIbxS2N7xZKUzFuGE+ACdi/ryxYzqdictW5muDfytyIIsg7kmgpNYR5GKGdSfMUQrfSlOw
 0FVLXbUaLDhKMv2Zz5NfoI6AH73fXDWkF2+FJTFBJDZkYczH6EnHKHKJDtY2QiFJexSWEOrkk
 Z/+4+Pon+opwEX2GYT8Sh7Hmx3M+wsbZyhpcv4gp72MIz8jZWFjpOSSs5uqIfog6aRMrRa4Mi
 4JX2dQjTWGoz+rP/s0+xPZ7mhao2FEZRBw5rgGFt5p5GiXt1G5WDII51vb89/ZLJloxNisiyB
 Pc+6+dRE6fL96ijMyz1NJoBuSPof/hteTFvs6s8gqSSitoXqTVnz/bNAq0vfLCsffL50oCu6u
 JPurQlC1IgnEQcOaCCk3JjexDGh2CeTxWtSQwnSvYlYoge1VpIB4pbLTsGIHLoEe73jG6iVVs
 g6qW28ayx/RptRqbvioW1L79MTbrSxu1gPmhKQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang-8 evaluates both sides of a ?: expression to check for
valid arithmetic even in the side that is never taken. This
results in a build warning:

drivers/spi/spi-sh-msiof.c:1052:24: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
        .bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 32),
                              ^~~~~~~~~~~~~~~~~~~~~~~~~

Change the implementation to use the GENMASK() macro that does
what we want here but does not have a problem with the shift
count overflow.

Link: https://bugs.llvm.org/show_bug.cgi?id=38789
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v3: use GENMASK() instead of open-coding it
v2: add a code comment
---
 include/linux/spi/spi.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 662b336aa2e4..b27386450089 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -444,8 +444,7 @@ struct spi_controller {
 	/* bitmask of supported bits_per_word for transfers */
 	u32			bits_per_word_mask;
 #define SPI_BPW_MASK(bits) BIT((bits) - 1)
-#define SPI_BIT_MASK(bits) (((bits) == 32) ? ~0U : (BIT(bits) - 1))
-#define SPI_BPW_RANGE_MASK(min, max) (SPI_BIT_MASK(max) - SPI_BIT_MASK(min - 1))
+#define SPI_BPW_RANGE_MASK(min, max) GENMASK((min) - 1, (max) - 1)
 
 	/* limits on transfer speed */
 	u32			min_speed_hz;
-- 
2.20.0

