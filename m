Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA33FC48BE0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 19:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFB82083B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 19:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="taQTyJMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfFUT5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 15:57:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51870 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfFUT47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 15:56:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so7346644wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 12:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8vg88vnWRxvLs3lJAdeZfInkp39g26GeybwaZxk7T9o=;
        b=taQTyJMoizgQS3s08YZ9lVpQa9G2vXWshFvNXTW/nEeG616uGyr93+ASzVRG6Z+acv
         0yRYPP2+gfPNvG1jMIvWuDxdeygEmW7yIRbOqt8HIJ62iIL9uyD1rIm1701/7GRajHLt
         gaBvoNudWyDvUuLuMtcmASQWVd+giABCB8/aBfiAQvu1pauA0BP03gTHOn6YSPLhA5F2
         +BzpelmoGQP5PxzHdC9bxKNd/83U6Hhs63j6vNKMhzUM/L5GxnrWE475gY5ioHOv00S5
         rZc8Nvuu6FmmYvH889ZLAFgY3ME4EKl+Szl++m6JaFwbBm9IPGpEVXcyhD0S4wIC2BFJ
         +nhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=8vg88vnWRxvLs3lJAdeZfInkp39g26GeybwaZxk7T9o=;
        b=dwx8OyKIrtKXCDen+tELXvZ2bIFu+TA/2Z/ucx9I2tZ/x4vixfuj25Em1g0Epaayxr
         LNglLcELCjnQL+vtlqxmyFo9bk+oTAmMT3TVkpZjd5tv+w7yteyLm7AHH7GGidtqS8wy
         Qi5HGGVII+mkw4O4NsXjza5NLapS78Y9lvAqssmfmoEST+VHBJarXuSUY9kKsAHwOo5Z
         Tow9tv/R31a6/mh2ia1bknwvOuDlh/6KrqDfVKt+Jv/4JGiSnBfWcq7rEYZyA2rZJUIZ
         Df6fROrv+EXONjCcsAI6MRWFGYXIXM3XSYSpNvomGW2sEGmlNybTaLGGPJK1ZmODttlU
         NNRQ==
X-Gm-Message-State: APjAAAUYw0D5dCsNp/Ns9YbiLzRtLgHS6BEKjS6nqas1sxCR+R8kW5yV
        ubRMzVQnY6Bxw2vByueJxdY=
X-Google-Smtp-Source: APXvYqzaffUIOQsCkuLc1UVQIou04JrR82wZyNCoOhqNV147qPa9kM50/RZsRrPbH2XTto7e6HYUYw==
X-Received: by 2002:a1c:f319:: with SMTP id q25mr4946871wmq.129.1561147016691;
        Fri, 21 Jun 2019 12:56:56 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id r5sm7122038wrg.10.2019.06.21.12.56.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Jun 2019 12:56:56 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id BD9ED11459C9; Fri, 21 Jun 2019 21:56:54 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Joel Stanley <joel@jms.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] lib/mpi: fix build with clang
Date:   Fri, 21 Jun 2019 21:55:54 +0200
Message-Id: <20190621195555.20615-1-malat@debian.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621071342.17897-1-malat@debian.org>
References: <20190621071342.17897-1-malat@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove superfluous casts on output operands to avoid warnings on the
following macros:

* add_ssaaaa(sh, sl, ah, al, bh, bl)
* sub_ddmmss(sh, sl, ah, al, bh, bl)
* umul_ppmm(ph, pl, m0, m1)

Special care has been taken to keep the diff as minimal as possible from
the original header file `longlong.h` from gcc, only importing the
minimal change to make the compilation with clang pass.

Silence the following warnings triggered using W=1:

    CC      lib/mpi/generic_mpih-mul1.o
  ../lib/mpi/generic_mpih-mul1.c:37:13: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with
        -fheinous-gnu-extensions
                  umul_ppmm(prod_high, prod_low, s1_ptr[j], s2_limb);
                  ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ../lib/mpi/longlong.h:824:20: note: expanded from macro 'umul_ppmm'
          : "=r" ((USItype) ph) \
                  ~~~~~~~~~~^~

and

    CC      lib/mpi/generic_mpih-mul2.o
  ../lib/mpi/generic_mpih-mul2.c:36:13: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with
        -fheinous-gnu-extensions
                  umul_ppmm(prod_high, prod_low, s1_ptr[j], s2_limb);
                  ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ../lib/mpi/longlong.h:824:20: note: expanded from macro 'umul_ppmm'
          : "=r" ((USItype) ph) \
                  ~~~~~~~~~~^~

  1 warning generated.
    CC      lib/mpi/generic_mpih-mul3.o
  ../lib/mpi/generic_mpih-mul3.c:36:13: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with
        -fheinous-gnu-extensions
                  umul_ppmm(prod_high, prod_low, s1_ptr[j], s2_limb);
                  ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ../lib/mpi/longlong.h:824:20: note: expanded from macro 'umul_ppmm'
          : "=r" ((USItype) ph) \
                  ~~~~~~~~~~^~

Or even:

  ../lib/mpi/mpih-div.c:99:16: error: invalid use of a cast in a inline asm context requiring an l-value: remove the cast or build with -fheinous-gnu-extensions
                                  sub_ddmmss(n1, n0, n1, n0, d1, d0);
                                  ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~

Inspiration is taken from commit b682c8692442 ("powerpc/math-emu: Update
macros from GCC").

Suggested-by: Joel Stanley <joel@jms.id.au>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: Instead of passing compat flag to clang to behave as gcc, remove the superfluous cast

 lib/mpi/longlong.h | 105 +++++++++++++++------------------------------
 1 file changed, 35 insertions(+), 70 deletions(-)

diff --git a/lib/mpi/longlong.h b/lib/mpi/longlong.h
index 08c60d10747f..f5503dfa42ed 100644
--- a/lib/mpi/longlong.h
+++ b/lib/mpi/longlong.h
@@ -753,79 +753,44 @@ do {									\
 	***************************************/
 #if (defined(_ARCH_PPC) || defined(_IBMR2)) && W_TYPE_SIZE == 32
 #define add_ssaaaa(sh, sl, ah, al, bh, bl) \
-do { \
-	if (__builtin_constant_p(bh) && (bh) == 0) \
-		__asm__ ("{a%I4|add%I4c} %1,%3,%4\n\t{aze|addze} %0,%2" \
-		: "=r" ((USItype)(sh)), \
-		"=&r" ((USItype)(sl)) \
-		: "%r" ((USItype)(ah)), \
-		"%r" ((USItype)(al)), \
-		"rI" ((USItype)(bl))); \
-	else if (__builtin_constant_p(bh) && (bh) == ~(USItype) 0) \
-		__asm__ ("{a%I4|add%I4c} %1,%3,%4\n\t{ame|addme} %0,%2" \
-		: "=r" ((USItype)(sh)), \
-		"=&r" ((USItype)(sl)) \
-		: "%r" ((USItype)(ah)), \
-		"%r" ((USItype)(al)), \
-		"rI" ((USItype)(bl))); \
-	else \
-		__asm__ ("{a%I5|add%I5c} %1,%4,%5\n\t{ae|adde} %0,%2,%3" \
-		: "=r" ((USItype)(sh)), \
-		"=&r" ((USItype)(sl)) \
-		: "%r" ((USItype)(ah)), \
-		"r" ((USItype)(bh)), \
-		"%r" ((USItype)(al)), \
-		"rI" ((USItype)(bl))); \
-} while (0)
+  do {									\
+    if (__builtin_constant_p (bh) && (bh) == 0)				\
+      __asm__ ("add%I4c %1,%3,%4\n\taddze %0,%2"		\
+	     : "=r" (sh), "=&r" (sl) : "r" (ah), "%r" (al), "rI" (bl));\
+    else if (__builtin_constant_p (bh) && (bh) == ~(USItype) 0)		\
+      __asm__ ("add%I4c %1,%3,%4\n\taddme %0,%2"		\
+	     : "=r" (sh), "=&r" (sl) : "r" (ah), "%r" (al), "rI" (bl));\
+    else								\
+      __asm__ ("add%I5c %1,%4,%5\n\tadde %0,%2,%3"		\
+	     : "=r" (sh), "=&r" (sl)					\
+	     : "%r" (ah), "r" (bh), "%r" (al), "rI" (bl));		\
+  } while (0)
 #define sub_ddmmss(sh, sl, ah, al, bh, bl) \
-do { \
-	if (__builtin_constant_p(ah) && (ah) == 0) \
-		__asm__ ("{sf%I3|subf%I3c} %1,%4,%3\n\t{sfze|subfze} %0,%2" \
-		: "=r" ((USItype)(sh)), \
-		"=&r" ((USItype)(sl)) \
-		: "r" ((USItype)(bh)), \
-		"rI" ((USItype)(al)), \
-		"r" ((USItype)(bl))); \
-	else if (__builtin_constant_p(ah) && (ah) == ~(USItype) 0) \
-		__asm__ ("{sf%I3|subf%I3c} %1,%4,%3\n\t{sfme|subfme} %0,%2" \
-		: "=r" ((USItype)(sh)), \
-		"=&r" ((USItype)(sl)) \
-		: "r" ((USItype)(bh)), \
-		"rI" ((USItype)(al)), \
-		"r" ((USItype)(bl))); \
-	else if (__builtin_constant_p(bh) && (bh) == 0) \
-		__asm__ ("{sf%I3|subf%I3c} %1,%4,%3\n\t{ame|addme} %0,%2" \
-		: "=r" ((USItype)(sh)), \
-		"=&r" ((USItype)(sl)) \
-		: "r" ((USItype)(ah)), \
-		"rI" ((USItype)(al)), \
-		"r" ((USItype)(bl))); \
-	else if (__builtin_constant_p(bh) && (bh) == ~(USItype) 0) \
-		__asm__ ("{sf%I3|subf%I3c} %1,%4,%3\n\t{aze|addze} %0,%2" \
-		: "=r" ((USItype)(sh)), \
-		"=&r" ((USItype)(sl)) \
-		: "r" ((USItype)(ah)), \
-		"rI" ((USItype)(al)), \
-		"r" ((USItype)(bl))); \
-	else \
-		__asm__ ("{sf%I4|subf%I4c} %1,%5,%4\n\t{sfe|subfe} %0,%3,%2" \
-		: "=r" ((USItype)(sh)), \
-		"=&r" ((USItype)(sl)) \
-		: "r" ((USItype)(ah)), \
-		"r" ((USItype)(bh)), \
-		"rI" ((USItype)(al)), \
-		"r" ((USItype)(bl))); \
-} while (0)
+  do {									\
+    if (__builtin_constant_p (ah) && (ah) == 0)				\
+      __asm__ ("subf%I3c %1,%4,%3\n\tsubfze %0,%2"	\
+	       : "=r" (sh), "=&r" (sl) : "r" (bh), "rI" (al), "r" (bl));\
+    else if (__builtin_constant_p (ah) && (ah) == ~(USItype) 0)		\
+      __asm__ ("subf%I3c %1,%4,%3\n\tsubfme %0,%2"	\
+	       : "=r" (sh), "=&r" (sl) : "r" (bh), "rI" (al), "r" (bl));\
+    else if (__builtin_constant_p (bh) && (bh) == 0)			\
+      __asm__ ("subf%I3c %1,%4,%3\n\taddme %0,%2"		\
+	       : "=r" (sh), "=&r" (sl) : "r" (ah), "rI" (al), "r" (bl));\
+    else if (__builtin_constant_p (bh) && (bh) == ~(USItype) 0)		\
+      __asm__ ("subf%I3c %1,%4,%3\n\taddze %0,%2"		\
+	       : "=r" (sh), "=&r" (sl) : "r" (ah), "rI" (al), "r" (bl));\
+    else								\
+      __asm__ ("subf%I4c %1,%5,%4\n\tsubfe %0,%3,%2"	\
+	       : "=r" (sh), "=&r" (sl)					\
+	       : "r" (ah), "r" (bh), "rI" (al), "r" (bl));		\
+  } while (0)
 #if defined(_ARCH_PPC)
 #define umul_ppmm(ph, pl, m0, m1) \
-do { \
-	USItype __m0 = (m0), __m1 = (m1); \
-	__asm__ ("mulhwu %0,%1,%2" \
-	: "=r" ((USItype) ph) \
-	: "%r" (__m0), \
-	"r" (__m1)); \
-	(pl) = __m0 * __m1; \
-} while (0)
+  do {									\
+    USItype __m0 = (m0), __m1 = (m1);					\
+    __asm__ ("mulhwu %0,%1,%2" : "=r" (ph) : "%r" (m0), "r" (m1));	\
+    (pl) = __m0 * __m1;							\
+  } while (0)
 #define UMUL_TIME 15
 #define smul_ppmm(ph, pl, m0, m1) \
 do { \
-- 
2.20.1

