Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1836C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959B120835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfCGK4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:56:31 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:43249 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfCGK4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:56:30 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M8QNs-1h6EPU1GzI-004Qar; Thu, 07 Mar 2019 11:56:20 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: work around clang bug in SPI_BPW_RANGE_MASK()
Date:   Thu,  7 Mar 2019 11:56:07 +0100
Message-Id: <20190307105619.2780591-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LAFgugSrWEPJAFjvltYi80urgUHgRDDZKLpH+9cHd8PH44WpKOs
 FiwyV2fFTZ0EjPTGntmOqWg8j0qOLrRpMk7X2SIfHxkfksgmKr97yx+aTwO6pYxAi1y0AQ6
 XkIV3JOwvyQ3Qab+Vl2qIv3D6JOCQ2To0StqNXvY4kLqY72hnwM0EZMq9CeD1iWGd4V9KlH
 H4c5IhvZqD5jhYaV+b53w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G0AU8Jelh6g=:IfI2fvCUUL8v7/qhVZl/+Y
 Hgzox/qBiXqMJv0wBECMxobKyxVc94gzpJkZnqQEYlKn67oRx7jLDXw43yLptpvtNhNXlo7VC
 e3Up8K56euahmygww3oNsB+8erHo2IaKxfEmukrKfOq0DSFmBQqVhbjjlt4wl/8deV10OovNS
 l7rMfldgsmyQMJvP078tcRpLEM2GkIToqSpdjcgjpaCUZOWDgpfwcR+J8sH+/v5M+otSEQhmu
 1Jm0LxhKRoGeQoW1tUYIIEJpaYhwEYtz0aDmDFkZzjhwsspKWQgnFKWBJrK3Q2i/ToUPobZS2
 moaXaILMjluf8pCSWkMlnKhcWKDW+FbEUSSFheR1xKjkN2qife2qCp40nq8KG7J6217Lv5sqm
 KHhAmBGBQ2u0HNGp2J44uL3MODpXw1IqYVZmWxZICjGd0nwNfg+KPwzD/RreLAy5Cz5eRsSyx
 Tp9VaV5KiM9Z9FXcrcSbdhyXBgPKeCE2QUQwdT4PkKZK8TYWiwpcb0ZOLj2UCnjkGm4Wi5L9p
 Ai7fSBuFMQJLlitREMNwZyd/LsJEXWKV5ydlYNcOytdqtZjWRQnVzCex4XQV6dqNiK2snt+QS
 L6rLAWta3KGGMhqPCaCT5ImPwQs+mardTf5x5RZ8Gn7NQB0H2ZSek+P6KZHoYPdxZMT+sLmTq
 TmnJQRayTz/RmFUwLAdJMl8rhT0bX0iIZ+S2IMTkOwhNG5R/kAwvavIA4KpUkyfLD1xVCiRlP
 HsootNFU2RQDzn26Fr/tSKkDcQmw6DwC8hHfMQ==
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

Change it to shift one less than we want, and then shift one
more bit afterwards. This should give the correct result for
all valid input, since it has to be in the range 1..32 anyway.

Link: https://bugs.llvm.org/show_bug.cgi?id=38789
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/spi/spi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 662b336aa2e4..758b6287cad6 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -444,8 +444,8 @@ struct spi_controller {
 	/* bitmask of supported bits_per_word for transfers */
 	u32			bits_per_word_mask;
 #define SPI_BPW_MASK(bits) BIT((bits) - 1)
-#define SPI_BIT_MASK(bits) (((bits) == 32) ? ~0U : (BIT(bits) - 1))
-#define SPI_BPW_RANGE_MASK(min, max) (SPI_BIT_MASK(max) - SPI_BIT_MASK(min - 1))
+#define SPI_BIT_MASK(bits) ((BIT((bits) - 1) << 1) - 1)
+#define SPI_BPW_RANGE_MASK(min, max) (SPI_BIT_MASK(max) - (BIT((min) - 1) - 1))
 
 	/* limits on transfer speed */
 	u32			min_speed_hz;
-- 
2.20.0

