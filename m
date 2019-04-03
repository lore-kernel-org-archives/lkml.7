Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C788C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0722084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 11:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfDCLLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 07:11:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53551 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfDCLLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 07:11:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x33BAF6k1821997
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Apr 2019 04:10:15 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x33BACRZ1821987;
        Wed, 3 Apr 2019 04:10:12 -0700
Date:   Wed, 3 Apr 2019 04:10:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jann Horn <tipbot@zytor.com>
Message-ID: <tip-a0fe2c6479aab5723239b315ef1b552673f434a3@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        keescook@chromium.org, jannh@google.com, bp@suse.de,
        tglx@linutronix.de, hpa@zytor.com, x86@kernel.org,
        avagin@openvz.org, akpm@linux-foundation.org,
        dan.carpenter@oracle.com, mojha@codeaurora.org, neilb@suse.com,
        yamada.masahiro@socionext.com, peterz@infradead.org,
        qiaowei.ren@intel.com, mingo@kernel.org, jani.nikula@intel.com
Reply-To: neilb@suse.com, mojha@codeaurora.org, dan.carpenter@oracle.com,
          peterz@infradead.org, yamada.masahiro@socionext.com,
          mingo@kernel.org, qiaowei.ren@intel.com, jani.nikula@intel.com,
          akpm@linux-foundation.org, bp@suse.de, tglx@linutronix.de,
          x86@kernel.org, avagin@openvz.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
          jannh@google.com, keescook@chromium.org
In-Reply-To: <20190329214652.258477-1-jannh@google.com>
References: <20190329214652.258477-1-jannh@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] linux/kernel.h: Use parentheses around argument
 in u64_to_user_ptr()
Git-Commit-ID: a0fe2c6479aab5723239b315ef1b552673f434a3
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

Commit-ID:  a0fe2c6479aab5723239b315ef1b552673f434a3
Gitweb:     https://git.kernel.org/tip/a0fe2c6479aab5723239b315ef1b552673f434a3
Author:     Jann Horn <jannh@google.com>
AuthorDate: Fri, 29 Mar 2019 22:46:49 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 3 Apr 2019 11:43:49 +0200

linux/kernel.h: Use parentheses around argument in u64_to_user_ptr()

Use parentheses around uses of the argument in u64_to_user_ptr() to
ensure that the cast doesn't apply to part of the argument.

There are existing uses of the macro of the form

  u64_to_user_ptr(A + B)

which expands to

  (void __user *)(uintptr_t)A + B

(the cast applies to the first operand of the addition, the addition
is a pointer addition). This happens to still work as intended, the
semantic difference doesn't cause a difference in behavior.

But I want to use u64_to_user_ptr() with a ternary operator in the
argument, like so:

  u64_to_user_ptr(A ? B : C)

This currently doesn't work as intended.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Cc: Andrei Vagin <avagin@openvz.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: NeilBrown <neilb@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Qiaowei Ren <qiaowei.ren@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190329214652.258477-1-jannh@google.com
---
 include/linux/kernel.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 34a5036debd3..2d14e21c16c0 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -47,8 +47,8 @@
 
 #define u64_to_user_ptr(x) (		\
 {					\
-	typecheck(u64, x);		\
-	(void __user *)(uintptr_t)x;	\
+	typecheck(u64, (x));		\
+	(void __user *)(uintptr_t)(x);	\
 }					\
 )
 
