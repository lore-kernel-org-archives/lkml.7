Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51F0C47404
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 00:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B0C20663
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 00:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLyoSZs9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfJLAhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 20:37:37 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:41413 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfJLAhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 20:37:36 -0400
Received: by mail-lj1-f182.google.com with SMTP id f5so11441973ljg.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 17:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3VhNl1tLqxf423XM745kkSFjB6bV87mUwX23qYKwwNg=;
        b=kLyoSZs9NskajqWUwo3zYIbRCP7M526pfDX1G4GomRrhFxGy0tTVO3ycewOGAq1lzm
         p3y+Rr+wEkzbA0QoPHeXEr5V3L66+6SBa/U1HM7TaBLxwVY9WJoCc0cOUz6aU3K8Qc+i
         pL9Mhotdi4eZtpL6NH5Y6nhO9hleV4Ylgjvp69d4amAe9Lo94tWioMxFcdrdE9+TACS/
         vb8aW6QroeoJdCTaYREv9n77c1VHj+eP1KuH495lvlbHsCfDfLtOzPno8BNgalBma+wK
         B3fQg77ifhm2Uvsa8vc9cdkvtyxstCR/6Ht6v4axQwmm3W0rMY3hUrvh7X/M+ptCbIpU
         ZTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3VhNl1tLqxf423XM745kkSFjB6bV87mUwX23qYKwwNg=;
        b=OtEwYy0T4sxZ+aJqGatUHmtCTtC5vKbo9SgH3FQ1eRQh0WX3mg0Hndg00oNMHzdW0m
         zEOEj2BDr/vECr5MAUkIAfKtb8fkxTxKgSlL8YcFKn9ajjOEsTfgdQBWZGCt+gxPjhf0
         uGdsfS5q21C124otY/gjPiosPfYKn7gXtD5jNF5vwkz3eVXK99kP9Q16pc0np3L7dvdw
         GSRN+iC7ykhMSIV/GsoKh85S04pLJJc0EdiUeGsD6A6GhHaOhLYdG811fD1Hl2T+YF3p
         saB282p323s+AbfbBdfO9LA6rw/pWwZs+dU3VD11SNnAWI0JpF+TepDkbucFwRGtIeIL
         qqUA==
X-Gm-Message-State: APjAAAUUOrgBFyfmenHa8i+mqwKika7iY58ynKVEd/o0Vl/NzCm12w6j
        IsRSLh5Nx0zexPg3kku6vWs=
X-Google-Smtp-Source: APXvYqwYByWgzdtg+M7FX4ZPeGlTUAqpmhSTLah5cmuhj0NYdtuPfoYRGybaXvnnHEJ6Rk+1KD577Q==
X-Received: by 2002:a2e:2c0f:: with SMTP id s15mr10985859ljs.63.1570840654255;
        Fri, 11 Oct 2019 17:37:34 -0700 (PDT)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id f22sm2346620lfa.41.2019.10.11.17.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 17:37:33 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 3/4] xtensa: fix type conversion in __get_user_[no]check
Date:   Fri, 11 Oct 2019 17:37:07 -0700
Message-Id: <20191012003708.22182-4-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191012003708.22182-1-jcmvbkbc@gmail.com>
References: <20191012003708.22182-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__get_user_[no]check uses temporary buffer of type long to store result
of __get_user_size and do sign extension on it when necessary. This
doesn't work correctly for 64-bit data. Fix it by moving temporary
buffer/sign extension logic to __get_user_asm.
Don't do assignment of __get_user_bad result to (x) as it may not always
be integer-compatible now and issue warning even when it's going to be
optimized. Instead do (x) = 0; and call __get_user_bad separately.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:
- initialize result when access_ok check fails in __get_user_check

 arch/xtensa/include/asm/uaccess.h | 56 +++++++++++++++++--------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/arch/xtensa/include/asm/uaccess.h b/arch/xtensa/include/asm/uaccess.h
index aca510707189..43e923678dfb 100644
--- a/arch/xtensa/include/asm/uaccess.h
+++ b/arch/xtensa/include/asm/uaccess.h
@@ -172,19 +172,19 @@ __asm__ __volatile__(					\
 
 #define __get_user_nocheck(x, ptr, size)			\
 ({								\
-	long __gu_err, __gu_val;				\
-	__get_user_size(__gu_val, (ptr), (size), __gu_err);	\
-	(x) = (__force __typeof__(*(ptr)))__gu_val;		\
+	long __gu_err;						\
+	__get_user_size((x), (ptr), (size), __gu_err);		\
 	__gu_err;						\
 })
 
 #define __get_user_check(x, ptr, size)					\
 ({									\
-	long __gu_err = -EFAULT, __gu_val = 0;				\
+	long __gu_err = -EFAULT;					\
 	const __typeof__(*(ptr)) *__gu_addr = (ptr);			\
-	if (access_ok(__gu_addr, size))			\
-		__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
-	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
+	if (access_ok(__gu_addr, size))					\
+		__get_user_size((x), __gu_addr, (size), __gu_err);	\
+	else								\
+		(x) = 0;						\
 	__gu_err;							\
 })
 
@@ -208,7 +208,7 @@ do {									\
 		}							\
 		break;							\
 	}								\
-	default: (x) = __get_user_bad();				\
+	default: (x) = 0; __get_user_bad();				\
 	}								\
 } while (0)
 
@@ -218,24 +218,28 @@ do {									\
  * __check_align_* macros still work.
  */
 #define __get_user_asm(x_, addr_, err_, align, insn, cb) \
-__asm__ __volatile__(				\
-	__check_align_##align			\
-	"1: "insn"  %[x], %[addr], 0	\n"	\
-	"2:				\n"	\
-	"   .section  .fixup,\"ax\"	\n"	\
-	"   .align 4			\n"	\
-	"   .literal_position		\n"	\
-	"5:				\n"	\
-	"   movi   %[tmp], 2b		\n"	\
-	"   movi   %[x], 0		\n"	\
-	"   movi   %[err], %[efault]	\n"	\
-	"   jx     %[tmp]		\n"	\
-	"   .previous			\n"	\
-	"   .section  __ex_table,\"a\"	\n"	\
-	"   .long	1b, 5b		\n"	\
-	"   .previous"				\
-	:[err] "=r"(err_), [tmp] "=r"(cb), [x] "=r"(x_)\
-	:[addr] "r"(addr_), [efault] "i"(-EFAULT))
+do {							\
+	u32 __x;					\
+	__asm__ __volatile__(				\
+		__check_align_##align			\
+		"1: "insn"  %[x], %[addr], 0	\n"	\
+		"2:				\n"	\
+		"   .section  .fixup,\"ax\"	\n"	\
+		"   .align 4			\n"	\
+		"   .literal_position		\n"	\
+		"5:				\n"	\
+		"   movi   %[tmp], 2b		\n"	\
+		"   movi   %[x], 0		\n"	\
+		"   movi   %[err], %[efault]	\n"	\
+		"   jx     %[tmp]		\n"	\
+		"   .previous			\n"	\
+		"   .section  __ex_table,\"a\"	\n"	\
+		"   .long	1b, 5b		\n"	\
+		"   .previous"				\
+		:[err] "=r"(err_), [tmp] "=r"(cb), [x] "=r"(__x) \
+		:[addr] "r"(addr_), [efault] "i"(-EFAULT)); \
+	(x_) = (__force __typeof__(*(addr_)))__x;	\
+} while (0)
 
 
 /*
-- 
2.20.1

