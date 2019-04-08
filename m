Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF4AC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2274C20857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfDHVbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:31:17 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:59935 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfDHVbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:31:14 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mv3I0-1gvwTg0DAW-00r1Bs; Mon, 08 Apr 2019 23:28:48 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] s390: make __load_psw_mask work with clang
Date:   Mon,  8 Apr 2019 23:26:22 +0200
Message-Id: <20190408212648.2407234-9-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190408212648.2407234-1-arnd@arndb.de>
References: <20190408212648.2407234-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ueHq0cRCIAo1fFwSIyE2OQG9Knnqslc/mc2Pd6mGkzSBwQeAWSh
 qJ9D6svp43z9Gx3F/xTbVSWAy+dqDLwAZO8BpGXmwqVAgU1yMAC36mhFYN0jldSiugWrJte
 31rw6BcRyxpqpsKIe0KqWOX0mSAD+SmeM0yl1R/K8FLitvF0JtWylz69g4qFhBl1kfR3GX9
 owWxvZYRQ0hAo5FKI1aOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:04y7NOSLvhs=:ayvR2CDPLuO9o1tDpp1gEE
 Iqz9oxoXaMM+DNHFnraJChoHvR9UHM11BWPXNEqts/GtpAspB9xW0O8d1SZOjlHPyfIMIfoY3
 ay9gsNUVttNVJCTSrxFzwaGpZU2MZ24SI0cKxJi5pPGzAGMIz+zZ/xpEZTKiOe3P+p6g4xz5Y
 fLgYl66IEKsasdIcCVpAc/zVrvDCi+aEjD2K817h3VQcx0ERN4lwp31m5fX+QiLO3xE1xWyca
 eSUmtzXw1Fld2I1Iqa9BoSeHZJCCKlUY7bLzCMApBQsT06EIxv4EhLT2ZMMu+24mnCXxz3gUA
 c9AelG5DWQPRbkND4xuoekINPqAdC/l1IXeCRIIWJ/UdU6cJtw3W+ScHZ1jve3h7FeO6VKn79
 J8uthO48Wy04Wvq2njXVJy5WyAAXlPQjF4fn+eF4DbqtFJ0J4qe66r4iFCw8v6oUBlvzhOeeE
 JTKYJW4qVtmWeZS0xBBy5s2pUCbVTS11f58QT2GlgIKlAxX3eP8m/ls39YiY+AWJwLK/jdsJl
 McHs3OKBHI9dBsQPZ2CHRzma9iQIIpZla03mT4O6FUqZc6xL8HB1o50m6pSlUILa+uCnP2KlM
 kkH3k3mefLZ89UK+fLVop7HpBX++vgrSXTU6TPDo0mdeEUQ41V1wdRMKllJQ1Waa9RntAKqJ7
 n7Oqdt59wshwFBwunH1pFeVxnVNXisxA9EgIYXXjHSQF54e1S3NtoE8gseaRqGDFi8awrk9M7
 07pQHguhgJJ+0oeCjJ1i1ry1FicniKIldVWoWQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang fails to use the %O and %R inline assembly modifiers
the same way as gcc, leading to build failures with every use
of __load_psw_mask():

/tmp/nmi-4a9f80.s: Assembler messages:
/tmp/nmi-4a9f80.s:571: Error: junk at end of line: `+8(160(%r11))'
/tmp/nmi-4a9f80.s:626: Error: junk at end of line: `+8(160(%r11))'

Replace these with a more conventional way of passing the addresses
that should work with both clang and gcc.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/include/asm/processor.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 81038ab357ce..700c650ffd4f 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -339,10 +339,10 @@ static __no_kasan_or_inline void __load_psw_mask(unsigned long mask)
 
 	asm volatile(
 		"	larl	%0,1f\n"
-		"	stg	%0,%O1+8(%R1)\n"
-		"	lpswe	%1\n"
+		"	stg	%0,%1\n"
+		"	lpswe	%2\n"
 		"1:"
-		: "=&d" (addr), "=Q" (psw) : "Q" (psw) : "memory", "cc");
+		: "=&d" (addr), "=Q" (psw.addr) : "Q" (psw) : "memory", "cc");
 }
 
 /*
-- 
2.20.0

