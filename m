Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9D5C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08EF20857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfDHVbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:31:22 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:34471 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfDHVbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:31:15 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N9dbx-1gsJJO1ZYr-015ddJ; Mon, 08 Apr 2019 23:29:31 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] [PROBABLY WRONG] s390: void '0' constraint in inline assembly
Date:   Mon,  8 Apr 2019 23:26:25 +0200
Message-Id: <20190408212648.2407234-12-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190408212648.2407234-1-arnd@arndb.de>
References: <20190408212648.2407234-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/523MLjqVgMjdMMdQozji7Pa+uMzu03WWSDDICQXvB4QKMS7Oow
 9r92BFyrTb5IKqo1HqDs52BLOY0TZ34uTbd8FSYI5IhCSrurBij39jiW27O7q2vFzUWCJ23
 elyG7wQt33TnJbV51kEZPkWhZIIO6JuCn1H+FlnbnWoAktIs8mz1tmSX6s160zvESOXMw0V
 1KIRwvFEYpMyU78lDufcg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZMEZuQtfJXc=:napCevtCoaEVls+FA1p7Nd
 oPgvXre3cFbpqmvHA+X9zsd1K6q9Ee2tX83v0ihEpDjRrJScc5RWLO8LFfDJ0nTTt2E3qB3HZ
 7GkU5qokZFJCJ4UrqV3Q1xN8AOVlr4/bhWp5/XEmCySQKid/nXLMkKGXFVGNd29C9d3Jo3wyo
 63h4qAfdeI+pUkvaQLdAZQLLfoZ333gJu/cz9tVYzspOzYWnX1D4iFfTIVIyioqspcTsqJ50G
 gQR3JXOhj1bs7xsRkcxWQMtzcCFaNnGc/XnIAbLuHlGGdEE77eyq3+6JPLHnqYV3tDEyRUguI
 m4DZFIV4Q7Gbtik9Q4qgotfKeaASZ9n59QH39gZkbZcgNR45JVV2WVtEGiX8YQPzVTGo0mVB1
 1crcMlDZDFQD5hpogwjeVTKnhN/nhK3bfF9uZgR01dYbW/RAhQbt9+miA0icdwtGNLEU+nxGE
 r9Vz+FbMvburIaZhlkLPZiQsyPhlJ5/oh3lzOQJA3H+Mwzsq1o7PKnFPqZy8qIiKwWExrOvoT
 wDl4hOOmHwS89E1ZiMN0u1+lr9TMC86mx6HSbXknCjnd1MB+Y7YPcTVkVgj/g1GN1lDgI3731
 7RcVcIVwDneHToETNWj3oCsSwYrAAfF6cmpl9MdAEeGE2/3zqMrhjveB5pnDht/edORPLkUYj
 GHtyzg3mbMuHhA2ME6d/j7krG9YYNJqB+1ZYDev47QNp9ZX+TEwVo3TQRt0LEOzjBZj4nPsVx
 /3zSAih3T9KK3ziT/lWLO8ECzndgjZn+QrMPrQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang does not understand the contraint "0" in the CALL_ON_STACK()
macro:

../arch/s390/mm/maccess.c:117:10: error: invalid input constraint '0' in asm
                return CALL_ON_STACK(_memcpy_real, S390_lowcore.nodat_stack,
                       ^
../arch/s390/include/asm/processor.h:292:20: note: expanded from macro 'CALL_ON_STACK'
                  [_fn] "X" (fn) CALL_FMT_##nr : CALL_CLOBBER_##nr);    \
                                 ^
<scratch space>:207:1: note: expanded from here
CALL_FMT_3
^
../arch/s390/include/asm/processor.h:267:20: note: expanded from macro 'CALL_FMT_3'
 #define CALL_FMT_3 CALL_FMT_2, "d" (r4)
                   ^
../arch/s390/include/asm/processor.h:266:20: note: expanded from macro 'CALL_FMT_2'
 #define CALL_FMT_2 CALL_FMT_1, "d" (r3)
                   ^
../arch/s390/include/asm/processor.h:265:32: note: expanded from macro 'CALL_FMT_1'
 #define CALL_FMT_1 CALL_FMT_0, "0" (r2)
                               ^

I don't know what the correct fix here would be, changing it to "d" made
it build, since clang does understand this one.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/include/asm/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 700c650ffd4f..84c59c99668a 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -262,7 +262,7 @@ static __no_kasan_or_inline unsigned short stap(void)
 	register unsigned long r4 asm("6") = (unsigned long)(arg5)
 
 #define CALL_FMT_0
-#define CALL_FMT_1 CALL_FMT_0, "0" (r2)
+#define CALL_FMT_1 CALL_FMT_0, "d" (r2)
 #define CALL_FMT_2 CALL_FMT_1, "d" (r3)
 #define CALL_FMT_3 CALL_FMT_2, "d" (r4)
 #define CALL_FMT_4 CALL_FMT_3, "d" (r5)
-- 
2.20.0

