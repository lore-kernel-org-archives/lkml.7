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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7763DECE58D
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 00:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7EA21835
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 00:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rh4nxRsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbfJLAhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 20:37:34 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34487 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfJLAhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 20:37:33 -0400
Received: by mail-lj1-f195.google.com with SMTP id j19so11472403lja.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 17:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kjWi0GH8KhuY/mSwjF/Yf4/A/3SkcDswuz7RL6JGBfI=;
        b=rh4nxRsKkMkiwnIctrOGT5SbHJrYngN5eKB5fsnIHEReNl9P+A3GddlSrOmeuFKJ61
         CvQlE5p2RXKXy+N42l7kEI/mV0tUMy2dT7X9LzbjR7FDw2WVjG5qYcD6i2so+H92Jmrv
         mKf1CTJBbkNIQMYf8mDPNSc6wkxZZVn8556hg7QOIGZZQ04uR8pPqVOskjnlTPALkrCf
         RwzuVQxreg+3fSSdRfgCspVcEmxVt4Ay2tuzSdrC+BKwcNZ4uJpEKl0CEM29mCAyg/ZE
         zEXreg1qwL1m2LD8Q6ZB86KwYJZ7QvE4OS7HsX2G8Yx55CvsQvNrFDmQJbxZNnoslAUF
         C5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kjWi0GH8KhuY/mSwjF/Yf4/A/3SkcDswuz7RL6JGBfI=;
        b=Z3VOuWtr4T2I/CwYxrIlqIOWNQO95iP9m/VC8YtThK4phwP9CiV1lemm0XcoLqh2Qd
         BZobwCqGzY0y1+CnNQzBBxES9MGPMWjXrUT3VcVSR3rmy6tAx2LOCDePrV1TzePxJ81s
         fqICHHg+TJc4Z0/u4j7VaI2W2J+Pz3P+rRB6cdOK0lPQFRo7Kwv7DBRonRizAhaIrQO1
         /ACCfXsZhPPEgoegbmnL8gn+Sdiy/u2lPsA/iC53y52Bpvj3UqyHWu6vpNeOzfAn59CL
         lQ5sX6TBHXZ+Uc6oYVHKHvRFjUSGyvnq94ffzyzaUmfZFMPoWndoxGMvRnLgcq48SPO8
         z8Pg==
X-Gm-Message-State: APjAAAUx9Fm3L8UUcdIXcw5ZjwR5g9YKI3wAOsocPvIRN5ufDYu3zLA/
        S03WNqgKy1jlXuBgvQaF92c=
X-Google-Smtp-Source: APXvYqw6fcCV0PZreTMFX3gLNfVBk9VZ2rni/sqhP0+1ifefTyR1iykvxk+3suosh4xnI6Ft+8OEeA==
X-Received: by 2002:a2e:5354:: with SMTP id t20mr10842119ljd.227.1570840651571;
        Fri, 11 Oct 2019 17:37:31 -0700 (PDT)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id f22sm2346620lfa.41.2019.10.11.17.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 17:37:30 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 2/4] xtensa: clean up assembly arguments in uaccess macros
Date:   Fri, 11 Oct 2019 17:37:06 -0700
Message-Id: <20191012003708.22182-3-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191012003708.22182-1-jcmvbkbc@gmail.com>
References: <20191012003708.22182-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Numeric assembly arguments are hard to understand and assembly code that
uses them is hard to modify. Use named arguments in __check_align_*,
__get_user_asm and __put_user_asm. Modify macro parameter names so that
they don't affect argument names.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/uaccess.h | 42 +++++++++++++++----------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/xtensa/include/asm/uaccess.h b/arch/xtensa/include/asm/uaccess.h
index f568c00392ec..aca510707189 100644
--- a/arch/xtensa/include/asm/uaccess.h
+++ b/arch/xtensa/include/asm/uaccess.h
@@ -132,14 +132,14 @@ do {									\
 #define __check_align_1  ""
 
 #define __check_align_2				\
-	"   _bbci.l %3,  0, 1f		\n"	\
-	"   movi    %0, %4		\n"	\
+	"   _bbci.l %[addr], 0, 1f	\n"	\
+	"   movi    %[err], %[efault]	\n"	\
 	"   _j      2f			\n"
 
 #define __check_align_4				\
-	"   _bbsi.l %3,  0, 0f		\n"	\
-	"   _bbci.l %3,  1, 1f		\n"	\
-	"0: movi    %0, %4		\n"	\
+	"   _bbsi.l %[addr], 0, 0f	\n"	\
+	"   _bbci.l %[addr], 1, 1f	\n"	\
+	"0: movi    %[err], %[efault]	\n"	\
 	"   _j      2f			\n"
 
 
@@ -151,24 +151,24 @@ do {									\
  * WARNING: If you modify this macro at all, verify that the
  * __check_align_* macros still work.
  */
-#define __put_user_asm(x, addr, err, align, insn, cb)	\
+#define __put_user_asm(x_, addr_, err_, align, insn, cb)\
 __asm__ __volatile__(					\
 	__check_align_##align				\
-	"1: "insn"  %2, %3, 0		\n"		\
+	"1: "insn"  %[x], %[addr], 0	\n"		\
 	"2:				\n"		\
 	"   .section  .fixup,\"ax\"	\n"		\
 	"   .align 4			\n"		\
 	"   .literal_position		\n"		\
 	"5:				\n"		\
-	"   movi   %1, 2b		\n"		\
-	"   movi   %0, %4		\n"		\
-	"   jx     %1			\n"		\
+	"   movi   %[tmp], 2b		\n"		\
+	"   movi   %[err], %[efault]	\n"		\
+	"   jx     %[tmp]		\n"		\
 	"   .previous			\n"		\
 	"   .section  __ex_table,\"a\"	\n"		\
 	"   .long	1b, 5b		\n"		\
 	"   .previous"					\
-	:"=r" (err), "=r" (cb)				\
-	:"r" ((int)(x)), "r" (addr), "i" (-EFAULT), "0" (err))
+	:[err] "=r"(err_), [tmp] "=r"(cb)		\
+	:[x] "r"(x_), [addr] "r"(addr_), [efault] "i"(-EFAULT))
 
 #define __get_user_nocheck(x, ptr, size)			\
 ({								\
@@ -217,25 +217,25 @@ do {									\
  * WARNING: If you modify this macro at all, verify that the
  * __check_align_* macros still work.
  */
-#define __get_user_asm(x, addr, err, align, insn, cb) \
-__asm__ __volatile__(			\
+#define __get_user_asm(x_, addr_, err_, align, insn, cb) \
+__asm__ __volatile__(				\
 	__check_align_##align			\
-	"1: "insn"  %2, %3, 0		\n"	\
+	"1: "insn"  %[x], %[addr], 0	\n"	\
 	"2:				\n"	\
 	"   .section  .fixup,\"ax\"	\n"	\
 	"   .align 4			\n"	\
 	"   .literal_position		\n"	\
 	"5:				\n"	\
-	"   movi   %1, 2b		\n"	\
-	"   movi   %2, 0		\n"	\
-	"   movi   %0, %4		\n"	\
-	"   jx     %1			\n"	\
+	"   movi   %[tmp], 2b		\n"	\
+	"   movi   %[x], 0		\n"	\
+	"   movi   %[err], %[efault]	\n"	\
+	"   jx     %[tmp]		\n"	\
 	"   .previous			\n"	\
 	"   .section  __ex_table,\"a\"	\n"	\
 	"   .long	1b, 5b		\n"	\
 	"   .previous"				\
-	:"=r" (err), "=r" (cb), "=r" (x)	\
-	:"r" (addr), "i" (-EFAULT), "0" (err))
+	:[err] "=r"(err_), [tmp] "=r"(cb), [x] "=r"(x_)\
+	:[addr] "r"(addr_), [efault] "i"(-EFAULT))
 
 
 /*
-- 
2.20.1

