Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF4BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593F2206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfCMVBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:01:25 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:33549 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfCMVBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:01:24 -0400
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MxDck-1gor2645zU-00xcC1; Wed, 13 Mar 2019 22:01:19 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: fix SPI_BPW_RANGE_MASK() regression
Date:   Wed, 13 Mar 2019 22:00:34 +0100
Message-Id: <20190313210118.3507256-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gTNYpA6VAErBXYa0k3CCyol9+XgXGiQJk1rGCmT89cKHv0cXR3O
 X7N+Mnco7tnWoOqVb4Uo7Ha5B8SYtlFBJG51V2+OFTpw29m3xwmIq0uH4wIoLJeVSSRkDe0
 GrKUgLkI+ta1ZVhymZEla4lhZqJGRJz+lNKT7tat53ofOUqhfNrd4MEWSuWdzDbGHzyFMkd
 Mu0iZaxEwKJzwiPQG60WQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yic6wNQ1vyo=:meDvKFWAQcwvNrUuwHeS09
 aXAyc4m9f4MFW5NuMtlQMj3M0va+DncQ+vpOU0l9rU7upgTdQ28PbVL7QM0qS7eoS6m/cfdJQ
 Fb9Sjv2qVhfq5qsnh4vDe5f+X9f4mZszZ6O2Dg6SoBq4GFE3QwZp2op2009KWFgmuqQZE2tAc
 TZuVQxDb5fV0O138y9szpYLIM+mi/vXuo6RD9QwU/Pc0/r3t56g24QyDJAOdHgpOROgXd6R/O
 KeinoZIYQiWN99tC5/6slcLPpMI2V7kX7NJC9ipD+51wxeQIuuqkKf3/htUff3zTEp70glNXx
 4EzKZgg/A8vzoYz3wrVlA4eY15hB7ET1dR7cosrwY8YE20ND6JiKMHCwB+yPb5Iyp3DUV9Klo
 5u8NY5eBj644SUEqJ3vTjyib5YXboXbJZ5AfsizZO43pGbHRbKMMs7bVwd5AUqRbgurGkZqLW
 ywLeHGgHoOLb0FT3sdOa6TcphYAgTldqqgX6LFqZak+7ZUiNC9YeukHEAJicaCFm9slwhiR6H
 7o1u/iF6JYEW/hEMaMOYTpAiTDCTSt7QsYgrbnl8i5wftOi49gl0Lz0gI5P6v9XKbFBzrmApc
 NDAc6bOu1NxH7lI+iU+8I0YgPWS+YbtQectp5jzrMDGPy22/6tzY1MktIRKbdpUvqc8BWlu7Z
 sz3+YoYUua5ai+QSQRA5wRlbQkZIj7ZrtJHz33baPPYYXRMcCHrdI3MVrIebp5WslLZS4V3LU
 q3u45imKpumUJdMkVgUv5FCNYLyY3w4hQKZUqA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert points out that I confused the min/max arguments that are
reversed between SPI_BPW_RANGE_MASK() and GENMASK(). This time
I have verified the result of the macro after fixing the arguments.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: eefffb42f665 ("spi: work around clang bug in SPI_BPW_RANGE_MASK()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
The broken commit is currently in the for-5.2 branch of the spi
tree. If this is a branch that gets rebased, please just fold this
fix into the original patch
---
 include/linux/spi/spi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index b27386450089..a0975cf76cf6 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -444,7 +444,7 @@ struct spi_controller {
 	/* bitmask of supported bits_per_word for transfers */
 	u32			bits_per_word_mask;
 #define SPI_BPW_MASK(bits) BIT((bits) - 1)
-#define SPI_BPW_RANGE_MASK(min, max) GENMASK((min) - 1, (max) - 1)
+#define SPI_BPW_RANGE_MASK(min, max) GENMASK((max) - 1, (min) - 1)
 
 	/* limits on transfer speed */
 	u32			min_speed_hz;
-- 
2.20.0

