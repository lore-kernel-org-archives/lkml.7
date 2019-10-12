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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BDBECE58D
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 00:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE73320663
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 00:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uPOussVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbfJLAhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 20:37:40 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40489 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfJLAhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 20:37:39 -0400
Received: by mail-lj1-f196.google.com with SMTP id 7so11436131ljw.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 17:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=54LRcAZD00eVKPK3FNvqhw23ruw7tf3kBIi8BnJjoS0=;
        b=uPOussVDx72S+iDIooeNqsmbtrl7it6MbxgKtymlvx2TNLPMvf8vvRvlMzTvEba84v
         wvzMXMASiBtbhasQZVqhQCC4QC8X657wNp3wxbRSIFZ5SjONATAoHk4ATDB/AuzrGR85
         8lLOdZtC0Bd0A9tMSlM/QRPVzPZ+QQ/YX+ESPA6zDMHUajQtOUxVvfqb2nvMkM1nt9Yx
         eS1wDxICqSE0Z/FVMlkJ1sqBHx35V294Uoz8sAk0UEDd4iTFl+vN4shsomAoTcYOfpj4
         p9fXKnxoFeotcFLADwxbNWoezyWiTYmkOQDXlfQlsVLQRLEIvJMV4fS7uFRPwSbk4MlN
         MR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=54LRcAZD00eVKPK3FNvqhw23ruw7tf3kBIi8BnJjoS0=;
        b=FRBQai4aWjIUn1Bg+8JEfMtSYNWDASgxIN/W7gWR5x36DSX16O5Eg3oxOe5ynOHoL0
         9H6Mr3V9QVUFY6RM5qXkaG+ogKzFjEOMsdkeMIrDfMWD1hmDxJg/tdhDMLM3WFEEer2V
         oBbfV+7iu8139aTU9EafARjke7eAvbwq16ofr5AhpZ2mD//Whzrv32KFWio/JmpfZTUY
         EoxJbUrjkWAuuoDj9bFwCuT8lrmwWVXRIbvY+2jqDANs5d5Ef8Bjp3lqsKeRBNIDUsaE
         hcCH4CDmCpQ0eoXvNmdJqWRjHWehIuEXSaAYwrWpS4MjdcTMJVq6qqNVc6Qdb/UDUlRV
         9Rwg==
X-Gm-Message-State: APjAAAWCbGGqA6NOTNlMzXQOam30bH594hvDIUOkshWk8UN3ZShToVE6
        cXDuOjRWIKOcC7cpCqaAhNc=
X-Google-Smtp-Source: APXvYqxzdqPlMilQU3nmxFk9zBN8wXeKdCdXWAgxhYCM5tHpBierUSArhoJz2E33Mv9AH+DcQUXXeQ==
X-Received: by 2002:a2e:3c05:: with SMTP id j5mr11098180lja.24.1570840657244;
        Fri, 11 Oct 2019 17:37:37 -0700 (PDT)
Received: from octofox.cadence.com (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id f22sm2346620lfa.41.2019.10.11.17.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 17:37:36 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 4/4] xtensa: initialize result in __get_user_asm for unaligned access
Date:   Fri, 11 Oct 2019 17:37:08 -0700
Message-Id: <20191012003708.22182-5-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191012003708.22182-1-jcmvbkbc@gmail.com>
References: <20191012003708.22182-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__get_user_asm macro leaves result register uninitialized when alignment
check fails. Add 'insn' parameter to __check_align_{1,2,4} and pass an
instruction that initializes result register from __get_user_asm.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/uaccess.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/xtensa/include/asm/uaccess.h b/arch/xtensa/include/asm/uaccess.h
index 43e923678dfb..d8cff972f3cf 100644
--- a/arch/xtensa/include/asm/uaccess.h
+++ b/arch/xtensa/include/asm/uaccess.h
@@ -129,17 +129,19 @@ do {									\
  * sync.
  */
 
-#define __check_align_1  ""
+#define __check_align_1(insn)  ""
 
-#define __check_align_2				\
+#define __check_align_2(insn)			\
 	"   _bbci.l %[addr], 0, 1f	\n"	\
 	"   movi    %[err], %[efault]	\n"	\
+	"   "insn"			\n"	\
 	"   _j      2f			\n"
 
-#define __check_align_4				\
+#define __check_align_4(insn)			\
 	"   _bbsi.l %[addr], 0, 0f	\n"	\
 	"   _bbci.l %[addr], 1, 1f	\n"	\
 	"0: movi    %[err], %[efault]	\n"	\
+	"   "insn"			\n"	\
 	"   _j      2f			\n"
 
 
@@ -153,7 +155,7 @@ do {									\
  */
 #define __put_user_asm(x_, addr_, err_, align, insn, cb)\
 __asm__ __volatile__(					\
-	__check_align_##align				\
+	__check_align_##align("")			\
 	"1: "insn"  %[x], %[addr], 0	\n"		\
 	"2:				\n"		\
 	"   .section  .fixup,\"ax\"	\n"		\
@@ -221,7 +223,7 @@ do {									\
 do {							\
 	u32 __x;					\
 	__asm__ __volatile__(				\
-		__check_align_##align			\
+		__check_align_##align("movi %[x], 0")	\
 		"1: "insn"  %[x], %[addr], 0	\n"	\
 		"2:				\n"	\
 		"   .section  .fixup,\"ax\"	\n"	\
-- 
2.20.1

