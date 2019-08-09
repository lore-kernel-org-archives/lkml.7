Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739EFC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 22:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436E92089E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 22:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UAy9ZliJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfHIWDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 18:03:54 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:33695 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfHIWDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 18:03:53 -0400
Received: by mail-pg1-f202.google.com with SMTP id a21so53591464pgv.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 15:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=u8woyYEIswYwSZI+RYUkZJav0hcCzSUKciws/3A8eFI=;
        b=UAy9ZliJfC3GBJda6OupIsMHCFcE4vNQm2ZAXWx+g5D+Xc+o6gxSBXsGdAj1BhAOjY
         hSwd/IwvlqOvSdqSMQOmX9p/+rpqBYA08jtB9SYYVtWwVhP7F0S622nlMFQWmNLSOXa3
         xK91hSiDK4QDyJzR0q2MhImhCKHoS3RNPrDf6KkCrCzwJ9qA7xvxtKRhQmrAjnEm4sf9
         /2O4fsBnrhfr0f7F3ao8dLP9ZWeAKno01jBit4kG+8z8xxpdQrLtWxrKEPh5HqYs6E3a
         L6e15UPxTBSSjZnDQZBhDAF4sY05lkmSxhnOiLpve//mGS5PNXfR1Sq+Vwdl1F283s11
         EXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u8woyYEIswYwSZI+RYUkZJav0hcCzSUKciws/3A8eFI=;
        b=FD0XAcyrh15UEM6P5Bth/7t3CWGdX9ZnuF+UXT1zyJSJUJnSYqu4ERGV4Yc9Zq5d2i
         Be4U/VsMIdBjL7MZLRFZsa83D++s2ARNadbSFiWB9+mHkc/g2kLabu0SPGPK7g23fq9Q
         ke8EhSVJuAqfUl+2obEsQJXmOsfsGKKPsQXEhaJNe/iXBKxmExRhUIqx75IIcTB6gSwM
         bm7nf0RYKDmZVG1u1GhhqMAq3vBdpRxLZEX2VM+AYRvnc9xdsEHgBnAZjdzsENTtYD5F
         NwOOYjMVqHnfBdVbzAyuPpUy2zlc77J7Y6pCGJzxI2/dGKL5rFei0iJMFcYyZCVLLzwJ
         3Z9w==
X-Gm-Message-State: APjAAAVcU6UHXobLxznPgfVvX1F3E3jCv3XfseW4pzNin8VX6Z50PS44
        3DFCj1HcaQm3oBICA6STmmNhUfU4prwTyPtYv5M=
X-Google-Smtp-Source: APXvYqzyM1XJN7FOkuZaGwj9xH3x7cZlnraGtnkG5xN3p+7O5NNPZIyQr9Gfn94WugA8q8zgwEwvJofBRod2VyPs1Tc=
X-Received: by 2002:a63:6a81:: with SMTP id f123mr19637717pgc.348.1565388232571;
 Fri, 09 Aug 2019 15:03:52 -0700 (PDT)
Date:   Fri,  9 Aug 2019 15:03:47 -0700
In-Reply-To: <20190809220301.Horde.AR6y4Bx4WGIq58V9K0En9g4@messagerie.si.c-s.fr>
Message-Id: <20190809220348.127314-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190809220301.Horde.AR6y4Bx4WGIq58V9K0En9g4@messagerie.si.c-s.fr>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH v3] Revert "powerpc: slightly improve cache helpers"
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     mpe@ellerman.id.au
Cc:     christophe.leroy@c-s.fr, segher@kernel.crashing.org, arnd@arndb.de,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        kbuild test robot <lkp@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 6c5875843b87c3adea2beade9d1b8b3d4523900a.

Work around Clang bug preventing ppc32 from booting.

Link: https://bugs.llvm.org/show_bug.cgi?id=42762
Link: https://github.com/ClangBuiltLinux/linux/issues/593
Debugged-by: Nathan Chancellor <natechancellor@gmail.com>
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Reported-by: kbuild test robot <lkp@intel.com>
Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes V2 -> V3:
* Just revert, as per Christophe.
Changes V1 -> V2:
* Change to ouput paremeter.


 arch/powerpc/include/asm/cache.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/cache.h
index b3388d95f451..45e3137ccd71 100644
--- a/arch/powerpc/include/asm/cache.h
+++ b/arch/powerpc/include/asm/cache.h
@@ -107,22 +107,22 @@ extern void _set_L3CR(unsigned long);
 
 static inline void dcbz(void *addr)
 {
-	__asm__ __volatile__ ("dcbz %y0" : : "Z"(*(u8 *)addr) : "memory");
+	__asm__ __volatile__ ("dcbz 0, %0" : : "r"(addr) : "memory");
 }
 
 static inline void dcbi(void *addr)
 {
-	__asm__ __volatile__ ("dcbi %y0" : : "Z"(*(u8 *)addr) : "memory");
+	__asm__ __volatile__ ("dcbi 0, %0" : : "r"(addr) : "memory");
 }
 
 static inline void dcbf(void *addr)
 {
-	__asm__ __volatile__ ("dcbf %y0" : : "Z"(*(u8 *)addr) : "memory");
+	__asm__ __volatile__ ("dcbf 0, %0" : : "r"(addr) : "memory");
 }
 
 static inline void dcbst(void *addr)
 {
-	__asm__ __volatile__ ("dcbst %y0" : : "Z"(*(u8 *)addr) : "memory");
+	__asm__ __volatile__ ("dcbst 0, %0" : : "r"(addr) : "memory");
 }
 #endif /* !__ASSEMBLY__ */
 #endif /* __KERNEL__ */
-- 
2.23.0.rc1.153.gdeed80330f-goog

