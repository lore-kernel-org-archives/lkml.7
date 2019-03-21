Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB61C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B85218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfCUL2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:28:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53915 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbfCUL2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 07:28:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2LBSEZY107068
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 21 Mar 2019 04:28:14 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2LBSC39107065;
        Thu, 21 Mar 2019 04:28:12 -0700
Date:   Thu, 21 Mar 2019 04:28:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nick Desaulniers <tipbot@zytor.com>
Message-ID: <tip-a9c640ac96e19b3966357ec9bb586edd2e1e74de@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, ubizjak@gmail.com,
        ndesaulniers@google.com, fanc.fnst@cn.fujitsu.com,
        sfr@canb.auug.org.au, natechancellor@gmail.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: ndesaulniers@google.com, fanc.fnst@cn.fujitsu.com,
          sfr@canb.auug.org.au, natechancellor@gmail.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, ubizjak@gmail.com
In-Reply-To: <20190314221458.83047-1-ndesaulniers@google.com>
References: <20190314221458.83047-1-ndesaulniers@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/boot: Restrict header scope to make Clang
 happy
Git-Commit-ID: a9c640ac96e19b3966357ec9bb586edd2e1e74de
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

Commit-ID:  a9c640ac96e19b3966357ec9bb586edd2e1e74de
Gitweb:     https://git.kernel.org/tip/a9c640ac96e19b3966357ec9bb586edd2e1e74de
Author:     Nick Desaulniers <ndesaulniers@google.com>
AuthorDate: Thu, 14 Mar 2019 15:14:57 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 21 Mar 2019 12:24:38 +0100

x86/boot: Restrict header scope to make Clang happy

The inclusion of <linux/kernel.h> was causing issue as the definition of
__arch_hweight64 from arch/x86/include/asm/arch_hweight.h eventually gets
included. The definition is problematic when compiled with -m16 (all code
in arch/x86/boot/ is) as the "D" inline assembly constraint is rejected
by both compilers when passed an argument of type long long (regardless
of signedness, anything smaller is fine).

Because GCC performs inlining before semantic analysis, and
__arch_hweight64 is dead in this translation unit, GCC does not report
any issues at compile time.  Clang does the semantic analysis in the
front end, before inlining (run in the middle) can determine the code is
dead. I consider this another case of PR33587, which I think we can do
more work to solve.

It turns out that arch/x86/boot/string.c doesn't actually need
linux/kernel.h, simply linux/limits.h and linux/compiler.h.

Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Cc: bp@alien8.de
Cc: niravd@google.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: Uros Bizjak <ubizjak@gmail.com>
Link: https://bugs.llvm.org/show_bug.cgi?id=33587
Link: https://github.com/ClangBuiltLinux/linux/issues/347
Link: https://lkml.kernel.org/r/20190314221458.83047-1-ndesaulniers@google.com

---
 arch/x86/boot/string.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
index 315a67b8896b..90154df8f125 100644
--- a/arch/x86/boot/string.c
+++ b/arch/x86/boot/string.c
@@ -13,8 +13,9 @@
  */
 
 #include <linux/types.h>
-#include <linux/kernel.h>
+#include <linux/compiler.h>
 #include <linux/errno.h>
+#include <linux/limits.h>
 #include <asm/asm.h>
 #include "ctype.h"
 #include "string.h"
