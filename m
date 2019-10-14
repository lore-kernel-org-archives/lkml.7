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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4842ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 21:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE062067B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 21:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p4x27pY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732261AbfJNVZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 17:25:47 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42486 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731950AbfJNVZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 17:25:45 -0400
Received: by mail-lj1-f195.google.com with SMTP id y23so18000365lje.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 14:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DEgyVkL1sRyTaJ07rFVWXkm6zQa7bcNVlWuViQ4TgNU=;
        b=p4x27pY5o1BRq8AMo8WFS8GZ6D0eaSL/VI0BXPX27bftuxZPW7jpu1H7GGEAc2szhU
         7BgOUad4M9W1l5TXn2ONUnxEiiH3nZKhpj5pE/nzgH0smDp9+db17IF1N226dphGLmzp
         fpgny4cDX38i3hGPi2IDnZy6lAky4o6W1uccekOtQlP0mzgVFeIyd7TWpgHkeA5OuIzT
         TR8UdBQ70X/oLmA6ibzzjLIPhXYiysKXaDrXjKityi4Iohj/2KOk2cckpalix+QLP/Xw
         k3j+fU9Qkw93fX31y0k5+hYfUO2xjzMwc+aS1Z8rF/EBmjHSsIPOokVdVnrTd1GOtWkr
         GGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DEgyVkL1sRyTaJ07rFVWXkm6zQa7bcNVlWuViQ4TgNU=;
        b=l9Jr2+h1fuRNQAxEt1fsijo8uN5qFzMTd5+M3H/GusDGtfmYidWd+rkFanUpDEHNlX
         6rnvIw14WLxEL8TKPaPDPdHTqUb1pQUVVrlYrjbnMe/yzmKmKsRiKq37zgNomCOXoo6K
         V56k99qgvzuG83rXzFut/DzY/2fvLMIn73KHiE/urDDDxJs9fmdKoMZkX/EhK7A+qvD0
         03kk/PlTUZzfIRC9xAf420xYltvghH2MtkoSsXkc+Ti1KiK+B5SOTBvLtU8vug58dyV7
         vEjDZGDIDwHrrhXOdaAKGY/pf57TeUz3wkyuM4x0euLZngtlbF+T3/cdynMj86xSRiid
         fDVg==
X-Gm-Message-State: APjAAAVP1XLFPEtGX7D+1WbucFGpWzWuvebxOhrsjTj0ny7BbJTaoIt2
        Ic2hKXd4qP5xBHpBokE3h2g=
X-Google-Smtp-Source: APXvYqyY3tP9am2tq4FKuD+kPXcviflzydBEde4bb/OQl6d8Be+IeuS0n04q8xmHWm/uccdoWT3nVg==
X-Received: by 2002:a2e:9151:: with SMTP id q17mr7797001ljg.115.1571088341828;
        Mon, 14 Oct 2019 14:25:41 -0700 (PDT)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id m15sm4429434ljh.50.2019.10.14.14.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 14:25:41 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v3 2/3] xtensa: clean up assembly arguments in uaccess macros
Date:   Mon, 14 Oct 2019 14:25:12 -0700
Message-Id: <20191014212513.17661-3-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014212513.17661-1-jcmvbkbc@gmail.com>
References: <20191014212513.17661-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Numeric assembly arguments are hard to understand and assembly code that
uses them is hard to modify. Use named arguments in __check_align_*,
__get_user_asm and __put_user_asm. Modify macro parameter names so that
they don't affect argument names. Use '+' constraint for the [err]
argument instead of having it as both input and output.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v2->v3:
- fix assembly argument constraint for error code

 arch/xtensa/include/asm/uaccess.h | 42 +++++++++++++++----------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/xtensa/include/asm/uaccess.h b/arch/xtensa/include/asm/uaccess.h
index f568c00392ec..da4d35445063 100644
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
+	:[err] "+r"(err_), [tmp] "=r"(cb)		\
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
+	:[err] "+r"(err_), [tmp] "=r"(cb), [x] "=r"(x_)\
+	:[addr] "r"(addr_), [efault] "i"(-EFAULT))
 
 
 /*
-- 
2.20.1

