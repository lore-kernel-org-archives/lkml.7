Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042EDC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A8021019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="FScQIFbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391159AbfGRTNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:13:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59791 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRTNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:13:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6IJDPeY2124697
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Jul 2019 12:13:25 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6IJDPeY2124697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563477206;
        bh=f/77feDo4hbYRgZSpJtkEIboOsiaUJV635jSW9nwWfo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=FScQIFbnNe0mW4ezIyapZTEND60ZN6semzDdfpR4qMue+IADnhUpEebSGRAl6NfK9
         rI2SEw0Hwf5g61pXBEQJmD1D+bTRg/xbLUtagqXVtqn3yXW+KkVTW22qYds7HwTQ1A
         o5Y/YPzbQj9Kas9NiYUme1lqnuwEFA4A9lJ4QIoqkGTqOIs7yjKSqP91YDb1j7vpwp
         BNGxnmLmUBhtsX7o5J4S0YlQDKa0789C8OSJtKzTeaAd3ReTD5cuiGGZ48bWaFN1St
         PTrvcxb5eUAOIKlTtnczW8lXDoXblvXLIKCbB8QTuscdJtdoGTX5GGx6aP6lyRZYU/
         U9NPI6Kal/SYg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6IJDPtt2124694;
        Thu, 18 Jul 2019 12:13:25 -0700
Date:   Thu, 18 Jul 2019 12:13:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-82e844a6536d1a3c12a73e44712f4021d90a4b53@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
        mingo@kernel.org, peterz@infradead.org, jpoimboe@redhat.com
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org, peterz@infradead.org, hpa@zytor.com,
          jpoimboe@redhat.com
In-Reply-To: <bc14ded2755ae75bd9010c446079e113dbddb74b.1563413318.git.jpoimboe@redhat.com>
References: <bc14ded2755ae75bd9010c446079e113dbddb74b.1563413318.git.jpoimboe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] x86/uaccess: Remove redundant CLACs in
 getuser/putuser error paths
Git-Commit-ID: 82e844a6536d1a3c12a73e44712f4021d90a4b53
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  82e844a6536d1a3c12a73e44712f4021d90a4b53
Gitweb:     https://git.kernel.org/tip/82e844a6536d1a3c12a73e44712f4021d90a4b53
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Wed, 17 Jul 2019 20:36:44 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 18 Jul 2019 21:01:06 +0200

x86/uaccess: Remove redundant CLACs in getuser/putuser error paths

The same getuser/putuser error paths are used regardless of whether AC
is set.  In non-exception failure cases, this results in an unnecessary
CLAC.

Fixes the following warnings:

  arch/x86/lib/getuser.o: warning: objtool: .altinstr_replacement+0x18: redundant UACCESS disable
  arch/x86/lib/putuser.o: warning: objtool: .altinstr_replacement+0x18: redundant UACCESS disable

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/bc14ded2755ae75bd9010c446079e113dbddb74b.1563413318.git.jpoimboe@redhat.com

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
