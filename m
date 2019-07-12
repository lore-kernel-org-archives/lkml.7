Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1815C742B0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE0420863
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfGLJHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 05:07:43 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:41329 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfGLJHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 05:07:43 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MWR6x-1hxf5K14xf-00XsqW; Fri, 12 Jul 2019 11:07:41 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] lib/mpi: fix building with 32-bit x86
Date:   Fri, 12 Jul 2019 11:07:34 +0200
Message-Id: <20190712090740.340186-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oshOUE/i3SB/+6j50OZzcgZaoU8IfG0hYfG87EvVrAoYQhBFCPj
 TYXcsD3c36xAYC+HbHBgw4TgevC2UdWi6oHQX7AL6pnoh6y+hvIRMl3Q0Mf9Aul4Mm7W4Fu
 j9PumrWVK4JrtKZDt8ChnFkB4vkMlznKcVJXeFtICQ9YCj0ckdi2R0xUkVnzLB7TBzZSwvq
 tvSKL//VB4vGstTl1rdJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E7yiX+Q7/mY=:byTXnfUAj5/OJR3X6n4+7O
 JpZrOENWt75JJxW99jNUg8wMyY2aQzrHrnDhUg+LIzQcAsJlfSsqfK15iIgYD4Y4cWVIZdYaK
 Xhn0RyaspVrksHOZIV6mDJbVyGQ7lN4wdpH+f5Y+aR4NcnO9cLX/r+PSED3vGcqYSo4asqnmn
 1M5rro6KQqttjjDXcidfu3jsK5WswGYeHpZ9fI+wZ1vWu68sk4Q+kKxtQdUzVDb9sXixnaLaf
 ZD5ib0U5KAjiZ7BMmwNFm1knxWEjxl3aisoDAn8dwxLIx3yBarUpBDsLnJGwE+qcWabQusJlI
 DjeFXYgJQmHiKWw5bIMBTA+jpzcOi9x8e7mm1P8v6g42NExrbfOhddLorlld0CzcNPBMkQ4R5
 uBNF/SixDQLbP9hw91nohqeShQp41NT9QmZ7Ub797INqBQoKIUX9IFw4ipOSlcI2wTRYGHUQ8
 fPotyEK+sNhrnNYLsvFXma8sM9MDDqFUPaNBOO5ghswuiQCvRytkYTVF5OILaTRzXPSqBeyfx
 5pU37sQS6a6lupJX+J6TrAQTDKiA1NmgVwuDNJfHhkBGjX5cnLsPwAlLyZV4YINpd3MubwC6r
 BrfOVS2AMzLvmPsxD1qv+DE+6rhR/5lPJ3JL8plT+MV/Cvf+rDAmyszBwFbUqZpGEBQmhB8Y0
 N+Q1y0UnvDjFOk+o2uM65LKaWsWvmiqf7HcjBOpzN8bX3eeA264xK5bX0JKIjXFSYMvwT6zSy
 Obt4URscfAdBKyzZSgVzRZQVIoilAKe7Uliv8A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mpi library contains some rather old inline assembly statements
that produce a lot of warnings for 32-bit x86, such as:

lib/mpi/mpih-div.c:76:16: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
                                udiv_qrnnd(qp[i], n1, n1, np[i], d);
                                ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
lib/mpi/longlong.h:423:20: note: expanded from macro 'udiv_qrnnd'
        : "=a" ((USItype)(q)), \
                ~~~~~~~~~~^~

There is no point in doing a type cast for the output of an inline assembler
statement, so just remove the cast here, as we have done for other architectures
in the past.

See-also: dea632cadd12 ("lib/mpi: fix build with clang")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/mpi/longlong.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/mpi/longlong.h b/lib/mpi/longlong.h
index 08c60d10747f..3bb6260d8f42 100644
--- a/lib/mpi/longlong.h
+++ b/lib/mpi/longlong.h
@@ -397,8 +397,8 @@ do { \
 #define add_ssaaaa(sh, sl, ah, al, bh, bl) \
 	__asm__ ("addl %5,%1\n" \
 	   "adcl %3,%0" \
-	: "=r" ((USItype)(sh)), \
-	     "=&r" ((USItype)(sl)) \
+	: "=r" (sh), \
+	     "=&r" (sl) \
 	: "%0" ((USItype)(ah)), \
 	     "g" ((USItype)(bh)), \
 	     "%1" ((USItype)(al)), \
@@ -406,22 +406,22 @@ do { \
 #define sub_ddmmss(sh, sl, ah, al, bh, bl) \
 	__asm__ ("subl %5,%1\n" \
 	   "sbbl %3,%0" \
-	: "=r" ((USItype)(sh)), \
-	     "=&r" ((USItype)(sl)) \
+	: "=r" (sh), \
+	     "=&r" (sl) \
 	: "0" ((USItype)(ah)), \
 	     "g" ((USItype)(bh)), \
 	     "1" ((USItype)(al)), \
 	     "g" ((USItype)(bl)))
 #define umul_ppmm(w1, w0, u, v) \
 	__asm__ ("mull %3" \
-	: "=a" ((USItype)(w0)), \
-	     "=d" ((USItype)(w1)) \
+	: "=a" (w0), \
+	     "=d" (w1) \
 	: "%0" ((USItype)(u)), \
 	     "rm" ((USItype)(v)))
 #define udiv_qrnnd(q, r, n1, n0, d) \
 	__asm__ ("divl %4" \
-	: "=a" ((USItype)(q)), \
-	     "=d" ((USItype)(r)) \
+	: "=a" (q), \
+	     "=d" (r) \
 	: "0" ((USItype)(n0)), \
 	     "1" ((USItype)(n1)), \
 	     "rm" ((USItype)(d)))
-- 
2.20.0

