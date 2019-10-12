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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB52FECE58D
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 00:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64F0214E0
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 00:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URInePOr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbfJLAHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 20:07:36 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37124 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfJLAHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 20:07:35 -0400
Received: by mail-lf1-f66.google.com with SMTP id w67so8185824lff.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 17:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kjWi0GH8KhuY/mSwjF/Yf4/A/3SkcDswuz7RL6JGBfI=;
        b=URInePOrEmnoQ3aSXGuMmeQ6pfLDeRUtLk+sbV+1CVy8AiVBIX51IPm+uKGAop7u2v
         7cGoTbB4p0uzqFdbddu+7sAUhmfegCkfpTU+rZbmzMxnVRl8rA8/PEbD6DSeYcRZGIzx
         rSlEsbxEGKK6UilrLfKhbmLL0aU650pV8O3NG58H37Q07UPIlQAcgODfF/3ji4BPO1Jg
         9xDsiN6NT8A16rAfVexaiuRj4DswDn+/BtNyPloh42kSHKhShngq32QRFSaIcaQaQWgS
         w0ngF/mqkTWPhyS3WQ+RRkbz4KqZ9kk69zVazjK9yKhYl2LZ+HEMVwcbQfFepw5fkbfN
         JAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kjWi0GH8KhuY/mSwjF/Yf4/A/3SkcDswuz7RL6JGBfI=;
        b=t2f0Ate3xdWlmm/oL35ljJ7YM/c4F0Q6erh0WG45RqhitCACZE3zBqzsNWF51WQUdV
         ww34M5bvNcgCMr/xCEWOBVUXVgC1o+U/BD7SDSPI2KalJ7Pse6QZaU7CwYRIs49rvMSO
         q+2gtSzCyjExn85X9u+04BQQR2s6ycBth0BtF2LMHat6YLY74gNFwAa+lDC3UCwAVvrQ
         5wllR9aDu7UJNYSQGQDe/Qn4r05XmuqkMzjPfuvd+dcLcPdqq3iPapO26obxJqWqMy6N
         ija02AdnRCFzM0E+4hYv4XipfQLJq+3sMrrJ8lInQmRS/NkuahKf56BGAkfd8S7h+fTs
         K5ww==
X-Gm-Message-State: APjAAAXRg++aWHm+RrRaA9rgKwkc4odi7m3VyFFa2FPn2+7E/kOc0yJ6
        Ns/w7Db+ptYLdMDqNkokXAg=
X-Google-Smtp-Source: APXvYqy+5Q4/pGNPrYajeTrCijSnJ3nA1LhqZV1/pIMLaMHN59uReEs15y9MlElSV9aX3TZ6v3Oq9A==
X-Received: by 2002:a19:4bcf:: with SMTP id y198mr10078998lfa.168.1570838853636;
        Fri, 11 Oct 2019 17:07:33 -0700 (PDT)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id x17sm2215705lji.62.2019.10.11.17.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 17:07:33 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 2/3] xtensa: clean up assembly arguments in uaccess macros
Date:   Fri, 11 Oct 2019 17:07:10 -0700
Message-Id: <20191012000711.3775-3-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191012000711.3775-1-jcmvbkbc@gmail.com>
References: <20191012000711.3775-1-jcmvbkbc@gmail.com>
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

