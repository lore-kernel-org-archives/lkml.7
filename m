Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC98C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745222075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfDCPKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:10:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41327 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDCPKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:10:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x33FAEQv1897596
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Apr 2019 08:10:14 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x33FAB231897584;
        Wed, 3 Apr 2019 08:10:11 -0700
Date:   Wed, 3 Apr 2019 08:10:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jann Horn <tipbot@zytor.com>
Message-ID: <tip-a6cbfbe6677efb5ca47bb7958c2718236c25126e@git.kernel.org>
Cc:     qiaowei.ren@intel.com, will.deacon@arm.com, hpa@zytor.com,
        luto@kernel.org, mingo@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, bp@suse.de,
        akpm@linux-foundation.org, mingo@kernel.org, mojha@codeaurora.org,
        x86@kernel.org, jannh@google.com, rppt@linux.ibm.com
Reply-To: luto@kernel.org, mingo@redhat.com, tglx@linutronix.de,
          hpa@zytor.com, qiaowei.ren@intel.com, will.deacon@arm.com,
          rppt@linux.ibm.com, mojha@codeaurora.org, mingo@kernel.org,
          x86@kernel.org, jannh@google.com, linux-kernel@vger.kernel.org,
          akpm@linux-foundation.org, bp@suse.de
In-Reply-To: <20190329214652.258477-4-jannh@google.com>
References: <20190329214652.258477-4-jannh@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/uaccess: Fix implicit cast of __user pointer
Git-Commit-ID: a6cbfbe6677efb5ca47bb7958c2718236c25126e
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

Commit-ID:  a6cbfbe6677efb5ca47bb7958c2718236c25126e
Gitweb:     https://git.kernel.org/tip/a6cbfbe6677efb5ca47bb7958c2718236c25126e
Author:     Jann Horn <jannh@google.com>
AuthorDate: Fri, 29 Mar 2019 22:46:52 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 3 Apr 2019 16:26:17 +0200

x86/uaccess: Fix implicit cast of __user pointer

The first two arguments of __user_atomic_cmpxchg_inatomic() are:

 - @uval is a kernel pointer into which the old value should be stored
 - @ptr is the user pointer on which the cmpxchg should operate

This means that casting @uval to __typeof__(ptr) is wrong. Since @uval
is only used once inside the macro, just get rid of __uval and use
(uval) directly.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Qiaowei Ren <qiaowei.ren@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190329214652.258477-4-jannh@google.com
---
 arch/x86/include/asm/uaccess.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 1954dd5552a2..a21f2a2f17bf 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -585,7 +585,6 @@ extern void __cmpxchg_wrong_size(void)
 #define __user_atomic_cmpxchg_inatomic(uval, ptr, old, new, size)	\
 ({									\
 	int __ret = 0;							\
-	__typeof__(ptr) __uval = (uval);				\
 	__typeof__(*(ptr)) __old = (old);				\
 	__typeof__(*(ptr)) __new = (new);				\
 	__uaccess_begin_nospec();					\
@@ -661,7 +660,7 @@ extern void __cmpxchg_wrong_size(void)
 		__cmpxchg_wrong_size();					\
 	}								\
 	__uaccess_end();						\
-	*__uval = __old;						\
+	*(uval) = __old;						\
 	__ret;								\
 })
 
