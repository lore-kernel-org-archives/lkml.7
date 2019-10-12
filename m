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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67961C47404
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 00:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6A1214E0
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 00:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9Osl97j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfJLAHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 20:07:39 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:34645 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfJLAHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 20:07:38 -0400
Received: by mail-lf1-f46.google.com with SMTP id r22so8193080lfm.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 17:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nhYT88TgT/VRwvcGZf4aIWkeFGM34JRMlU0vJpd9odg=;
        b=L9Osl97jEz1Gg7GX9IqpMD4GeCF9Qqpe794rXv8//Gr1gXpcBjO+WfybpUDNIiBZ64
         1XLOLYaMQQfqX8pPze+LJE5B6Imov/FGtFi5poRwhmBy/R5QcoW0Nk6vPathTzJQx9PD
         f5WDQFLfvKnCw3R0QFiYIW1YR6c3A/L3kNIooqOS99FPlkHshsyn6c4O9fIJbA1Mv7b8
         wTUJ26wKzqVLdlidXDPR5ZBMDe8FjGmLmrHLgI4idxzyNYitgLz5QR2O1CzpiYSZ+r+1
         sDQJQq3gBdtO6wg4GsZWh2bOQoxOZq1v6aWk1LXtkkbPiGu7/rhOb5cSVSE3rAPkgLpl
         V9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nhYT88TgT/VRwvcGZf4aIWkeFGM34JRMlU0vJpd9odg=;
        b=Aq9qUx6CIV4C5E02vo9JywKRdy1ghI5kJnOsByqYGIN94SmAwsoWzDMHL0T8lyiwbz
         JrwxDsBwfc7fA5cAFbNcWmrq3H5elsXXVJB8FzWPDG1bdDn44QbjXt7oAU6lUhbwSjrL
         iiK4IuhkNOJJvbCO7tr7M+2MbYkr/RAB6jsfyEmdMljlCCdMKFCegucrObWiX49GRmFt
         V6up67vQR3vrqtdVSMFvScepIb2lRRp29+zuWJaa0jeInhF9+XoQghztYKH5/Zt9C/06
         VatRsl/G44pOlidy5apBbPm6RGJcO5LnlSouzWCK/CV24iuIuxi+oXMSfoqSdNPOYN2w
         jTKw==
X-Gm-Message-State: APjAAAXiTREFzb84NoyDg4oX6MU3g1pPpssL5Qc2jPaOwALayK68mf+7
        IBX8sjVg2YcVfgNEnl+aduY=
X-Google-Smtp-Source: APXvYqwLoZZbFjUbSruh+7FFb8QBV47QEWc7w3TBQBoNH9GIBzCZF32hJAIeHLW/RNy9RpND63cXIw==
X-Received: by 2002:ac2:46ed:: with SMTP id q13mr7575786lfo.187.1570838856189;
        Fri, 11 Oct 2019 17:07:36 -0700 (PDT)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id x17sm2215705lji.62.2019.10.11.17.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 17:07:35 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 3/3] xtensa: fix type conversion in __get_user_[no]check
Date:   Fri, 11 Oct 2019 17:07:11 -0700
Message-Id: <20191012000711.3775-4-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191012000711.3775-1-jcmvbkbc@gmail.com>
References: <20191012000711.3775-1-jcmvbkbc@gmail.com>
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
 arch/xtensa/include/asm/uaccess.h | 54 ++++++++++++++++---------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/arch/xtensa/include/asm/uaccess.h b/arch/xtensa/include/asm/uaccess.h
index aca510707189..da62a1017cc7 100644
--- a/arch/xtensa/include/asm/uaccess.h
+++ b/arch/xtensa/include/asm/uaccess.h
@@ -172,19 +172,17 @@ __asm__ __volatile__(					\
 
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
 	__gu_err;							\
 })
 
@@ -208,7 +206,7 @@ do {									\
 		}							\
 		break;							\
 	}								\
-	default: (x) = __get_user_bad();				\
+	default: (x) = 0; __get_user_bad();				\
 	}								\
 } while (0)
 
@@ -218,24 +216,28 @@ do {									\
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

