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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DD1C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1010320C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 18:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p1bth4T+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407262AbfHISVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 14:21:20 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:39690 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfHISVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 14:21:20 -0400
Received: by mail-qt1-f202.google.com with SMTP id r15so11027777qtt.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 11:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AfTcG56zmwo+ldOTopXdEviJ01wH7yWHp2h8SCNYIzM=;
        b=p1bth4T+dnzyYMSmrcDJ0MtjQJnVJKlJ2xP5NDQSsWQau0y+cTyPAyWzulS3Wj5vip
         91pLNuH856Ct4xX1mCbGtqpxzf6vHz7rW8/+QRrC3Qb1JQs3HNHeRtEF7yskfTTq3NBS
         g/OQ7VcDRzteoALGdT/qUd8Cg/pWZrqzHkKhPIAnfP4S/BEbpPFC3xUD+0c0CFJkCu67
         a/kiYjVRt56URANpDGuxohhdQvHYM2TRM29JWOz6T1iO8j9GvAl+BdH+3dcGL/HfQtuz
         qodCmqtq0wWoI4LlconGshbfCPaw3D6uwxuhWJw3bsBE8Ae3qDSzT4wau477IBIbG/Lf
         C1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AfTcG56zmwo+ldOTopXdEviJ01wH7yWHp2h8SCNYIzM=;
        b=bFXj6ctZTQLu1V2Do2vFAqXeOMu8vhZsB74V3raNzQE1H5IenJoUGjhNL6X6YfU6hO
         2LmaFpbgAsC+RncWLYDWru8SNj266RBf1rZ1thO+9Rw8UultUNSVNp9bBAyH+0TqnoDm
         hTwyOQMt5UygVwsUtYn8IFDE6JP2esjEilQxD4tGMpgxFG4iDmu73xvwQSVd3Q3X3yNY
         UDPEADuikCEsz9/QfXOBe2qNMOuadiScOJQR3jY+CGYBujiFDB/YB8sjzDsg4f7XVVsk
         MJ1DMEwAq+SmzNS4gthaKOkGFfJnPxnpt6o+MvOY2js53UdC62ZZHoyg3an4nb7wLrb1
         FXyA==
X-Gm-Message-State: APjAAAVIAQh3ZfbjOFtLQ5J5uKnWp0ElQbBZCXixMSkQiDL+zWV9uMBA
        3tajiq3IqZ76vASU1eNG/htWpcmKytbxyRSvq/o=
X-Google-Smtp-Source: APXvYqyBr9e8t8qXW2aILi8aFM5Vs+bZlZEMDvFRIEl4oiFC36YtYLyM576WormxdGC+xze9sVJ/oZmBIENQpBI3fzQ=
X-Received: by 2002:a05:620a:685:: with SMTP id f5mr19419821qkh.238.1565374879207;
 Fri, 09 Aug 2019 11:21:19 -0700 (PDT)
Date:   Fri,  9 Aug 2019 11:21:05 -0700
In-Reply-To: <87h873zs88.fsf@concordia.ellerman.id.au>
Message-Id: <20190809182106.62130-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <87h873zs88.fsf@concordia.ellerman.id.au>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH] powerpc: fix inline asm constraints for dcbz
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

The input parameter is modified, so it should be an output parameter
with "=" to make it so that a copy of the input is not made by Clang.

Link: https://bugs.llvm.org/show_bug.cgi?id=42762
Link: https://gcc.gnu.org/onlinedocs/gcc/Modifiers.html#Modifiers
Link: https://github.com/ClangBuiltLinux/linux/issues/593
Link: https://godbolt.org/z/QwhZXi
Link: https://lore.kernel.org/lkml/20190721075846.GA97701@archlinux-threadripper/
Fixes: 6c5875843b87 ("powerpc: slightly improve cache helpers")
Debugged-by: Nathan Chancellor <natechancellor@gmail.com>
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Reported-by: kbuild test robot <lkp@intel.com>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Green CI run:
https://travis-ci.com/ClangBuiltLinux/continuous-integration/builds/122521976
https://github.com/ClangBuiltLinux/continuous-integration/pull/197/files#diff-40bd16e3188587e4d648c30e0c2d6d37

 arch/powerpc/include/asm/cache.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/cache.h
index b3388d95f451..5a0df6a1b9dc 100644
--- a/arch/powerpc/include/asm/cache.h
+++ b/arch/powerpc/include/asm/cache.h
@@ -107,22 +107,22 @@ extern void _set_L3CR(unsigned long);
 
 static inline void dcbz(void *addr)
 {
-	__asm__ __volatile__ ("dcbz %y0" : : "Z"(*(u8 *)addr) : "memory");
+	__asm__ __volatile__ ("dcbz %y0" : "=Z"(*(u8 *)addr) :: "memory");
 }
 
 static inline void dcbi(void *addr)
 {
-	__asm__ __volatile__ ("dcbi %y0" : : "Z"(*(u8 *)addr) : "memory");
+	__asm__ __volatile__ ("dcbi %y0" : "=Z"(*(u8 *)addr) :: "memory");
 }
 
 static inline void dcbf(void *addr)
 {
-	__asm__ __volatile__ ("dcbf %y0" : : "Z"(*(u8 *)addr) : "memory");
+	__asm__ __volatile__ ("dcbf %y0" : "=Z"(*(u8 *)addr) :: "memory");
 }
 
 static inline void dcbst(void *addr)
 {
-	__asm__ __volatile__ ("dcbst %y0" : : "Z"(*(u8 *)addr) : "memory");
+	__asm__ __volatile__ ("dcbst %y0" : "=Z"(*(u8 *)addr) :: "memory");
 }
 #endif /* !__ASSEMBLY__ */
 #endif /* __KERNEL__ */
-- 
2.23.0.rc1.153.gdeed80330f-goog

