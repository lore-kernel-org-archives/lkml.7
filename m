Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81C4C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 21:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08B520650
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 21:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="scqM8yUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732417AbfJNVZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 17:25:48 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33596 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731991AbfJNVZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 17:25:47 -0400
Received: by mail-lj1-f193.google.com with SMTP id a22so18064489ljd.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 14:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X+lnbWcSkcDwPIsFytYHP4Lin40lipRFRetqvAeDiCM=;
        b=scqM8yUc9u0hD5FGyP5x5ZQyMVArfUYBT1caCY/s8upxKS+OADZendXPcbkjtgDwRX
         fBFDle84CvSkmCmqz15j5h0ZqbWYwMaPeIwxyszbynwibdmhrGPkdSgWErQQ4/9uycRh
         g3iGC1AVqaoZ858izFhwlF3rLg9NLYZSQcg7s2BpXH8QlGXUFwMfx1iJIZVYKe9ouONH
         PIh9UCVG8MFqKHJFE+QIiBR7LdCC38n5zBoNrPq2CGVxFZ/Remz1ddPUDyfp0aRsB7dD
         uETEqRTsC6MpSm33eY7rHVMdCKs4xnOsW3J9bx77uV/bUA+MYXW9x6WO99WJCHwEzefc
         a5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X+lnbWcSkcDwPIsFytYHP4Lin40lipRFRetqvAeDiCM=;
        b=lnWf57efTl6CLjqgHzv+nHHfpfz+3HJASQ4TuPf4/W7k1soYsc51k8y9V9S92pFdAP
         xrKPHwDUGreQqoa3YLI4QbeDdVcuAiyI2mrw15DRKipuV9rsOm8b7QgbCkcHXyLK4wKW
         8WoP8cHmPFibqA9Vt7x40n1nvt6h6+Vr0LVZHkoMFvV+tl9RyX0VvuKagsftjeLDLUMY
         U7CsExZXANw9AzNX2rSkTFFcrHoNnjoyxlxN8xoMDvxfLaR9ObWWI3DhxzRW7qPXX7AW
         j0683vtRGRh2MjYfnLbzxm96upt4EkEy0GolyIIprHqu4j52BX8DHVpPiM8+lShdUrV4
         8Lzw==
X-Gm-Message-State: APjAAAWIZNl7XtAuJpQy1B8I5hU4XN+rPcA3IW9JDfi2OZf/DEvc/Vya
        ga+7vZpjsBJkHrmLIcqs6BE=
X-Google-Smtp-Source: APXvYqyrzFu8ETl5LAaaK0h64UqKgnHlFkkwLUVOG5U6g1GetDVSV9F+30JsVszl8VEwx7hu2cZS/A==
X-Received: by 2002:a05:651c:8b:: with SMTP id 11mr20114009ljq.100.1571088344747;
        Mon, 14 Oct 2019 14:25:44 -0700 (PDT)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id m15sm4429434ljh.50.2019.10.14.14.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 14:25:44 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v3 3/3] xtensa: fix type conversion in __get_user_[no]check
Date:   Mon, 14 Oct 2019 14:25:13 -0700
Message-Id: <20191014212513.17661-4-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014212513.17661-1-jcmvbkbc@gmail.com>
References: <20191014212513.17661-1-jcmvbkbc@gmail.com>
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

Zero initialize __x in __get_user_asm and use '+' constraint for its
assembly argument, so that its value is preserved in error cases. This
may add at most 1 cycle to the fast path, but saves an instruction and
two padding bytes in the fixup section for each use of this macro and
works for both misaligned store and store exception.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v2->v3:
- rearrange result zero-initialization for error paths in __get_user_asm

Changes v1->v2:
- initialize result when access_ok check fails in __get_user_check

 arch/xtensa/include/asm/uaccess.h | 55 ++++++++++++++++---------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/arch/xtensa/include/asm/uaccess.h b/arch/xtensa/include/asm/uaccess.h
index da4d35445063..3f80386f1883 100644
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
 
@@ -218,24 +218,27 @@ do {									\
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
-	:[err] "+r"(err_), [tmp] "=r"(cb), [x] "=r"(x_)\
-	:[addr] "r"(addr_), [efault] "i"(-EFAULT))
+do {							\
+	u32 __x = 0;					\
+	__asm__ __volatile__(				\
+		__check_align_##align			\
+		"1: "insn"  %[x], %[addr], 0	\n"	\
+		"2:				\n"	\
+		"   .section  .fixup,\"ax\"	\n"	\
+		"   .align 4			\n"	\
+		"   .literal_position		\n"	\
+		"5:				\n"	\
+		"   movi   %[tmp], 2b		\n"	\
+		"   movi   %[err], %[efault]	\n"	\
+		"   jx     %[tmp]		\n"	\
+		"   .previous			\n"	\
+		"   .section  __ex_table,\"a\"	\n"	\
+		"   .long	1b, 5b		\n"	\
+		"   .previous"				\
+		:[err] "+r"(err_), [tmp] "=r"(cb), [x] "+r"(__x) \
+		:[addr] "r"(addr_), [efault] "i"(-EFAULT)); \
+	(x_) = (__force __typeof__(*(addr_)))__x;	\
+} while (0)
 
 
 /*
-- 
2.20.1

