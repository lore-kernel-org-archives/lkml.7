Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E983AC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE36121473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbfDCIWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:22:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:32983 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfDCIWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:22:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x338LoeX1758688
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Apr 2019 01:21:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x338Lno91758685;
        Wed, 3 Apr 2019 01:21:49 -0700
Date:   Wed, 3 Apr 2019 01:21:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Message-ID: <tip-37686b1353cfc30e127cef811959cdbcd0495d98@git.kernel.org>
Cc:     peterz@infradead.org, hpa@zytor.com, torvalds@linux-foundation.org,
        jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, bp@alien8.de, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, bp@alien8.de, tglx@linutronix.de,
          mingo@kernel.org, jpoimboe@redhat.com,
          torvalds@linux-foundation.org, peterz@infradead.org,
          hpa@zytor.com
In-Reply-To: <20190307174802.46fmpysxyo35hh43@treble>
References: <20190307174802.46fmpysxyo35hh43@treble>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/objtool] tracing: Improve "if" macro code generation
Git-Commit-ID: 37686b1353cfc30e127cef811959cdbcd0495d98
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

Commit-ID:  37686b1353cfc30e127cef811959cdbcd0495d98
Gitweb:     https://git.kernel.org/tip/37686b1353cfc30e127cef811959cdbcd0495d98
Author:     Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate: Thu, 7 Mar 2019 11:48:02 -0600
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Apr 2019 09:36:27 +0200

tracing: Improve "if" macro code generation

With CONFIG_PROFILE_ALL_BRANCHES=y, the "if" macro converts the
conditional to an array index.  This can cause GCC to create horrible
code.  When there are nested ifs, the generated code uses register
values to encode branching decisions.

Make it easier for GCC to optimize by keeping the conditional as a
conditional rather than converting it to an integer.  This shrinks the
generated code quite a bit, and also makes the code sane enough for
objtool to understand.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: brgerst@gmail.com
Cc: catalin.marinas@arm.com
Cc: dvlasenk@redhat.com
Cc: dvyukov@google.com
Cc: hpa@zytor.com
Cc: james.morse@arm.com
Cc: julien.thierry@arm.com
Cc: luto@amacapital.net
Cc: luto@kernel.org
Cc: rostedt@goodmis.org
Cc: valentin.schneider@arm.com
Cc: will.deacon@arm.com
Link: https://lkml.kernel.org/r/20190307174802.46fmpysxyo35hh43@treble
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 445348facea9..d58aa0db05f9 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -67,7 +67,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 				.line = __LINE__,			\
 			};						\
 		______r = !!(cond);					\
-		______f.miss_hit[______r]++;					\
+		______r ? ______f.miss_hit[1]++ : ______f.miss_hit[0]++;\
 		______r;						\
 	}))
 #endif /* CONFIG_PROFILE_ALL_BRANCHES */
