Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_RHS_DOB autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458EAC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075492183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="T/XLFAqM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388872AbfDRMFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:05:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38789 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388344AbfDRMFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:05:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3IC48O9179348
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Apr 2019 05:04:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3IC48O9179348
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555589048;
        bh=JL9+7+pFYvySRLyNll7CCmm1kHXJFdZsaD50rqoztgc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=T/XLFAqMoWdzMgTn/V1WoeUxL9jj1kM04MazKY61wqp6GaToyM6WnA3KZV6+vccf1
         MhB6n1tYDys0TlqbvGA9nnaMzWncLzJUo/j4Dmqps/4WIFyImGR3SXMTdmx80gLReK
         4KY1TRwtE0yDC1ltBgZEXewitTRORG56y14eWO8s5ZOCbdNol/hp6Dql5t/qzEp+zW
         rglzd6gIazE958Bx+BsKgtTwUlqwzQvN7jHMTq67Yh01j5/9bceT/07iRldn6qhv3P
         BoXbIOQZQ0VVu71yBhSnliJUNKGi/JUUkNjdaopsQjUWL2/I0DfzjwN4/eSuWS40k2
         2aFHxQPn3rGNw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3IC47pC179345;
        Thu, 18 Apr 2019 05:04:07 -0700
Date:   Thu, 18 Apr 2019 05:04:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-3771b0fe9dfc3801eac0142d1af6ba94dee83c6c@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, longman@redhat.com, arnd@arndb.de,
        natechancellor@gmail.com, peterz@infradead.org, hpa@zytor.com,
        rostedt@goodmis.org, will.deacon@arm.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        ndesaulniers@google.com, bvanassche@acm.org
Reply-To: linux-kernel@vger.kernel.org, joel@joelfernandes.org,
          mingo@kernel.org, bvanassche@acm.org, ndesaulniers@google.com,
          tglx@linutronix.de, torvalds@linux-foundation.org,
          natechancellor@gmail.com, peterz@infradead.org,
          will.deacon@arm.com, rostedt@goodmis.org, hpa@zytor.com,
          arnd@arndb.de, longman@redhat.com
In-Reply-To: <20190325125807.1437049-1-arnd@arndb.de>
References: <20190325125807.1437049-1-arnd@arndb.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Avoid bogus Clang warning
Git-Commit-ID: 3771b0fe9dfc3801eac0142d1af6ba94dee83c6c
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

Commit-ID:  3771b0fe9dfc3801eac0142d1af6ba94dee83c6c
Gitweb:     https://git.kernel.org/tip/3771b0fe9dfc3801eac0142d1af6ba94dee83c6c
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Mon, 25 Mar 2019 13:57:57 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 18 Apr 2019 14:01:17 +0200

locking/lockdep: Avoid bogus Clang warning

When lockdep is enabled, and -Wuninitialized warnings are enabled,
Clang produces a silly warning for every file we compile:

 In file included from  kernel/sched/fair.c:23:
  kernel/sched/sched.h:1094:15: error: variable 'cookie' is uninitialized when used here [-Werror,-Wuninitialized]
         rf->cookie = lockdep_pin_lock(&rq->lock);
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
  include/linux/lockdep.h:474:60: note: expanded from macro 'lockdep_pin_lock'
  #define lockdep_pin_lock(l)                     ({ struct pin_cookie cookie; cookie; })
                                                                             ^~~~~~
  kernel/sched/sched.h:1094:15: note: variable 'cookie' is declared here
  include/linux/lockdep.h:474:34: note: expanded from macro 'lockdep_pin_lock'
  #define lockdep_pin_lock(l)                     ({ struct pin_cookie cookie; cookie; })
                                                    ^

As the 'struct pin_cookie' structure is empty in this configuration,
there is no need to initialize it for correctness, but it also
does not hurt to set it to an empty structure, so do that to
avoid the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: clang-built-linux@googlegroups.com
Link: http://lkml.kernel.org/r/20190325125807.1437049-1-arnd@arndb.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/lockdep.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 79c3873d58ac..21725a91442b 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -471,7 +471,7 @@ struct pin_cookie { };
 
 #define NIL_COOKIE (struct pin_cookie){ }
 
-#define lockdep_pin_lock(l)			({ struct pin_cookie cookie; cookie; })
+#define lockdep_pin_lock(l)			({ struct pin_cookie cookie = { }; cookie; })
 #define lockdep_repin_lock(l, c)		do { (void)(l); (void)(c); } while (0)
 #define lockdep_unpin_lock(l, c)		do { (void)(l); (void)(c); } while (0)
 
