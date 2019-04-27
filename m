Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61627C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36747208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbfD0P3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:29:09 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:32910 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727281AbfD0PPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:19 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2q-0000zM-4m; Sat, 27 Apr 2019 16:15:16 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2n-0004dM-Ei; Sat, 27 Apr 2019 16:15:13 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Denys Vlasenko" <dvlasenk@redhat.com>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Brian Gerst" <brgerst@gmail.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Borislav Petkov" <bp@suse.de>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.622339469@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 176/202] x86/uaccess: Don't leak the AC flag into
 __put_user() value evaluation
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>

commit 2a418cf3f5f1caf911af288e978d61c9844b0695 upstream.

When calling __put_user(foo(), ptr), the __put_user() macro would call
foo() in between __uaccess_begin() and __uaccess_end().  If that code
were buggy, then those bugs would be run without SMAP protection.

Fortunately, there seem to be few instances of the problem in the
kernel. Nevertheless, __put_user() should be fixed to avoid doing this.
Therefore, evaluate __put_user()'s argument before setting AC.

This issue was noticed when an objtool hack by Peter Zijlstra complained
about genregs_get() and I compared the assembly output to the C source.

 [ bp: Massage commit message and fixed up whitespace. ]

Fixes: 11f1a4b9755f ("x86: reorganize SMAP handling in user space accesses")
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Link: http://lkml.kernel.org/r/20190225125231.845656645@infradead.org
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -311,8 +311,7 @@ do {									\
 		__put_user_asm(x, ptr, retval, "l", "k", "ir", errret);	\
 		break;							\
 	case 8:								\
-		__put_user_asm_u64((__typeof__(*ptr))(x), ptr, retval,	\
-				   errret);				\
+		__put_user_asm_u64(x, ptr, retval, errret);		\
 		break;							\
 	default:							\
 		__put_user_bad();					\
@@ -423,8 +422,10 @@ do {									\
 #define __put_user_nocheck(x, ptr, size)			\
 ({								\
 	int __pu_err;						\
+	__typeof__(*(ptr)) __pu_val;				\
+	__pu_val = x;						\
 	__uaccess_begin();					\
-	__put_user_size((x), (ptr), (size), __pu_err, -EFAULT);	\
+	__put_user_size(__pu_val, (ptr), (size), __pu_err, -EFAULT); \
 	__uaccess_end();					\
 	__pu_err;						\
 })

