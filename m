Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3712CC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101DE20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfCGMKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:10:15 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:54663 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfCGMKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 07:10:14 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M1YpJ-1h4Kgg2Y2N-0033Ye; Thu, 07 Mar 2019 13:10:05 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] spi: work around clang bug in SPI_BPW_RANGE_MASK()
Date:   Thu,  7 Mar 2019 13:09:46 +0100
Message-Id: <20190307121004.1068172-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:C+Y06PKXuxT+51gK/T75WIVIzS/YmSjK3h6DTpL2Ufat49CCNTU
 QBhknMDjavxmXvdSismG2+YwTZpvqIogux6Yg15PGcR5vcO+ki8S/lau+4lx8hQJL8en4cw
 znTl0N6w2YxEAUoFt4dZ854GbpXGlREkebBQk0ik9bDzwpt5CPZlG7V+0+NykJWW33IN/3j
 nsAx5xZJ9kyy8758JPWHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QwT8fHCGlMo=:ZfG71IUUYpKua44RdT6BJB
 Bqe8W6Ov2O+jI3PTiYTmaaAFaoENZxSNnRI5EAENTveokD4BhlIKiD9vPzM30lVx3pbY1U7r1
 Wisbk1+CgNPaGxSXgDYg4cUJvo5c8b5bqPGnC4UlJnB8YcLMcRsrOrG3+qKGgzVTeZLuCvNjA
 qOvGUBUw8nL6RxNRxq9AkN1TgYLvbKbz/wtApsUES7BW5GGgo0L5V4U/WLeVNZgJdvsFPxJqc
 3HhqZpxJwlVFj68tdy3gm7/VFeHQ0TeAFOgS6PtgtYq7o6315I+tLtSTxYshBTmwl+M7EMPaw
 VvTcqGgTIuXb6C7QFqpKkZsHz7mLehkxGPRIGqw8rM36Kf7WprCtyuMFTBrsxH3cozL9udOcC
 ypuXD3ZBtHht79yCOw5HmpQlSTh59WWtZNdU9djI1PXDtnjHhC4gTl4c2Fzvw8EhG+n54RTJ8
 91eoQsg27a7Pp9344kO9vzvsm3XgcQSn7/EQlOigK73g7BpEdzt+BR5SV8fAn3Eog0eXGFBSW
 0bOrCBQn5skp4yaWsgyvoNnpBBcnbGD8TSaF7LorzjALe+SSVUGh2opb9KLiM+6oTv7Cw0gUi
 01kNLd0HAibVVP1dyBmAzlH6JxpqYnfQ/FBedgufasU3uVNKhNPIIUotdHhRcJqORGgjFq4HL
 Z3AUQ3OZORc9j+KPySGYIGj2C+uhoDl0bW0sr9VgtN7ibZK+G2fHzcXF6aOlvpLcFCrHv5Is+
 4Z23O4vcTxA545byLjdKuplGqSkrJvNSRYBcRQ==
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
v2: add a code comment
---
 include/linux/spi/spi.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 662b336aa2e4..1500745a9835 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -444,8 +444,12 @@ struct spi_controller {
 	/* bitmask of supported bits_per_word for transfers */
 	u32			bits_per_word_mask;
 #define SPI_BPW_MASK(bits) BIT((bits) - 1)
-#define SPI_BIT_MASK(bits) (((bits) == 32) ? ~0U : (BIT(bits) - 1))
-#define SPI_BPW_RANGE_MASK(min, max) (SPI_BIT_MASK(max) - SPI_BIT_MASK(min - 1))
+/*
+ * double shift to avoid shifting beyond BITS_PER_LONG, see also
+ * https://bugs.llvm.org/show_bug.cgi?id=38789
+ */
+#define SPI_BIT_MASK(bits) ((BIT((bits) - 1) << 1) - 1)
+#define SPI_BPW_RANGE_MASK(min, max) (SPI_BIT_MASK(max) - (BIT((min) - 1) - 1))
 
 	/* limits on transfer speed */
 	u32			min_speed_hz;
-- 
2.20.0

