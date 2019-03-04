Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885CAC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561B220823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551689248;
	bh=OsartALlhrn5u2AQ19H7Jxb+1pc9Rd57YESZritMKCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PyC7zoBvhuH85D1YLwtlzEkGNgfhjrZWr6A1vTAVVHdDWkzkqoSYaIEAXJbyZ0SRR
	 bE6xnjxJMC26rJD7+yN5Ti2pcx3inPvx32zwi1dktJhzS2i2FH2SD+DrHXunJbZGRI
	 lEMnCKyHtPi3E3cmq0uTuXbE9eilhTTmBDbm0ExM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfCDIYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:24:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:41344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbfCDIYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:24:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2352120823;
        Mon,  4 Mar 2019 08:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551687845;
        bh=OsartALlhrn5u2AQ19H7Jxb+1pc9Rd57YESZritMKCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VCaLwzEtMZlecwY7+r12c4FXsC6H2ngKPwE/yKg3rpw+mmTKdsOxLFZZACQiaBq4K
         9Yx8SN9jrW4rNBNyWt+XAo+jq3vnjuqgAgN0gy+w91WThfegftDAhbI0Up6Rl4rwHu
         xsU7BBlkjTTNjyD0U4lvREWBRJOEM7R0ISjHe87g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Denys Vlasenko <dvlasenk@redhat.com>
Subject: [PATCH 4.9 32/32] x86/uaccess: Dont leak the AC flag into __put_user() value evaluation
Date:   Mon,  4 Mar 2019 09:22:20 +0100
Message-Id: <20190304081604.693774540@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081602.307094059@linuxfoundation.org>
References: <20190304081602.307094059@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20190225125231.845656645@infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/uaccess.h |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -292,8 +292,7 @@ do {									\
 		__put_user_asm(x, ptr, retval, "l", "k", "ir", errret);	\
 		break;							\
 	case 8:								\
-		__put_user_asm_u64((__typeof__(*ptr))(x), ptr, retval,	\
-				   errret);				\
+		__put_user_asm_u64(x, ptr, retval, errret);		\
 		break;							\
 	default:							\
 		__put_user_bad();					\
@@ -427,8 +426,10 @@ do {									\
 #define __put_user_nocheck(x, ptr, size)			\
 ({								\
 	int __pu_err;						\
+	__typeof__(*(ptr)) __pu_val;				\
+	__pu_val = x;						\
 	__uaccess_begin();					\
-	__put_user_size((x), (ptr), (size), __pu_err, -EFAULT);	\
+	__put_user_size(__pu_val, (ptr), (size), __pu_err, -EFAULT);\
 	__uaccess_end();					\
 	__builtin_expect(__pu_err, 0);				\
 })


