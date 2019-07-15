Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB978C742D2
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839EF21655
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbfGOAik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 20:38:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729109AbfGOAhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 20:37:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 263B7308A9E0;
        Mon, 15 Jul 2019 00:37:38 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-170.rdu2.redhat.com [10.10.120.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F31325D9D2;
        Mon, 15 Jul 2019 00:37:36 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 09/22] x86/uaccess: Remove redundant CLACs in getuser/putuser error paths
Date:   Sun, 14 Jul 2019 19:37:04 -0500
Message-Id: <c2d4ab0da95cfaab8e96a7f5d02f37e21573c3d4.1563150885.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1563150885.git.jpoimboe@redhat.com>
References: <cover.1563150885.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 15 Jul 2019 00:37:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same getuser/putuser error paths are used regardless of whether AC
is set.  In non-exception failure cases, this results in an unnecessary
CLAC.

Fixes the following warnings:

  arch/x86/lib/getuser.o: warning: objtool: .altinstr_replacement+0x18: redundant UACCESS disable
  arch/x86/lib/putuser.o: warning: objtool: .altinstr_replacement+0x18: redundant UACCESS disable

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/lib/getuser.S | 20 ++++++++++----------
 arch/x86/lib/putuser.S | 29 ++++++++++++++++-------------
 2 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index 74fdff968ea3..304f958c27b2 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -115,29 +115,29 @@ ENDPROC(__get_user_8)
 EXPORT_SYMBOL(__get_user_8)
 
 
+bad_get_user_clac:
+	ASM_CLAC
 bad_get_user:
 	xor %edx,%edx
 	mov $(-EFAULT),%_ASM_AX
-	ASM_CLAC
 	ret
-END(bad_get_user)
 
 #ifdef CONFIG_X86_32
+bad_get_user_8_clac:
+	ASM_CLAC
 bad_get_user_8:
 	xor %edx,%edx
 	xor %ecx,%ecx
 	mov $(-EFAULT),%_ASM_AX
-	ASM_CLAC
 	ret
-END(bad_get_user_8)
 #endif
 
-	_ASM_EXTABLE_UA(1b, bad_get_user)
-	_ASM_EXTABLE_UA(2b, bad_get_user)
-	_ASM_EXTABLE_UA(3b, bad_get_user)
+	_ASM_EXTABLE_UA(1b, bad_get_user_clac)
+	_ASM_EXTABLE_UA(2b, bad_get_user_clac)
+	_ASM_EXTABLE_UA(3b, bad_get_user_clac)
 #ifdef CONFIG_X86_64
-	_ASM_EXTABLE_UA(4b, bad_get_user)
+	_ASM_EXTABLE_UA(4b, bad_get_user_clac)
 #else
-	_ASM_EXTABLE_UA(4b, bad_get_user_8)
-	_ASM_EXTABLE_UA(5b, bad_get_user_8)
+	_ASM_EXTABLE_UA(4b, bad_get_user_8_clac)
+	_ASM_EXTABLE_UA(5b, bad_get_user_8_clac)
 #endif
diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index d2e5c9c39601..14bf78341d3c 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -32,8 +32,6 @@
  */
 
 #define ENTER	mov PER_CPU_VAR(current_task), %_ASM_BX
-#define EXIT	ASM_CLAC ;	\
-		ret
 
 .text
 ENTRY(__put_user_1)
@@ -43,7 +41,8 @@ ENTRY(__put_user_1)
 	ASM_STAC
 1:	movb %al,(%_ASM_CX)
 	xor %eax,%eax
-	EXIT
+	ASM_CLAC
+	ret
 ENDPROC(__put_user_1)
 EXPORT_SYMBOL(__put_user_1)
 
@@ -56,7 +55,8 @@ ENTRY(__put_user_2)
 	ASM_STAC
 2:	movw %ax,(%_ASM_CX)
 	xor %eax,%eax
-	EXIT
+	ASM_CLAC
+	ret
 ENDPROC(__put_user_2)
 EXPORT_SYMBOL(__put_user_2)
 
@@ -69,7 +69,8 @@ ENTRY(__put_user_4)
 	ASM_STAC
 3:	movl %eax,(%_ASM_CX)
 	xor %eax,%eax
-	EXIT
+	ASM_CLAC
+	ret
 ENDPROC(__put_user_4)
 EXPORT_SYMBOL(__put_user_4)
 
@@ -85,19 +86,21 @@ ENTRY(__put_user_8)
 5:	movl %edx,4(%_ASM_CX)
 #endif
 	xor %eax,%eax
-	EXIT
+	ASM_CLAC
+	RET
 ENDPROC(__put_user_8)
 EXPORT_SYMBOL(__put_user_8)
 
+bad_put_user_clac:
+	ASM_CLAC
 bad_put_user:
 	movl $-EFAULT,%eax
-	EXIT
-END(bad_put_user)
+	RET
 
-	_ASM_EXTABLE_UA(1b, bad_put_user)
-	_ASM_EXTABLE_UA(2b, bad_put_user)
-	_ASM_EXTABLE_UA(3b, bad_put_user)
-	_ASM_EXTABLE_UA(4b, bad_put_user)
+	_ASM_EXTABLE_UA(1b, bad_put_user_clac)
+	_ASM_EXTABLE_UA(2b, bad_put_user_clac)
+	_ASM_EXTABLE_UA(3b, bad_put_user_clac)
+	_ASM_EXTABLE_UA(4b, bad_put_user_clac)
 #ifdef CONFIG_X86_32
-	_ASM_EXTABLE_UA(5b, bad_put_user)
+	_ASM_EXTABLE_UA(5b, bad_put_user_clac)
 #endif
-- 
2.20.1

