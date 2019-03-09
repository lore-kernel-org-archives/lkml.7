Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F295EC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA032087C
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfCIOpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 09:45:49 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40249 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbfCIOpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 09:45:49 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29Ef1pt3109520
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 06:41:01 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29Eex8O3109515;
        Sat, 9 Mar 2019 06:40:59 -0800
Date:   Sat, 9 Mar 2019 06:40:59 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-3fe7522fb766f6ee76bf7bc2837f1e3cc52c4e27@git.kernel.org>
Cc:     torvalds@linux-foundation.org, riel@surriel.com,
        tglx@linutronix.de, dave.hansen@linux.intel.com,
        longman@redhat.com, arnd@arndb.de, eranian@google.com,
        penguin-kernel@I-love.SAKURA.ne.jp, acme@redhat.com,
        peterz@infradead.org, hpa@zytor.com, vincent.weaver@maine.edu,
        akpm@linux-foundation.org, luto@kernel.org, frederic@kernel.org,
        jolsa@redhat.com, bvanassche@acm.org, joel@joelfernandes.org,
        will.deacon@arm.com, alexander.shishkin@linux.intel.com,
        paulmck@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, bp@alien8.de, mingo@kernel.org
Reply-To: hpa@zytor.com, akpm@linux-foundation.org,
          vincent.weaver@maine.edu, frederic@kernel.org, luto@kernel.org,
          torvalds@linux-foundation.org, longman@redhat.com,
          dave.hansen@linux.intel.com, tglx@linutronix.de,
          riel@surriel.com, peterz@infradead.org, acme@redhat.com,
          penguin-kernel@I-love.SAKURA.ne.jp, arnd@arndb.de,
          eranian@google.com, linux-kernel@vger.kernel.org,
          rostedt@goodmis.org, mingo@kernel.org, bp@alien8.de,
          bvanassche@acm.org, jolsa@redhat.com, will.deacon@arm.com,
          joel@joelfernandes.org, paulmck@linux.vnet.ibm.com,
          alexander.shishkin@linux.intel.com
In-Reply-To: <20190307075222.3424524-1-arnd@arndb.de>
References: <20190307075222.3424524-1-arnd@arndb.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] locking/lockdep: Avoid a Clang warning
Git-Commit-ID: 3fe7522fb766f6ee76bf7bc2837f1e3cc52c4e27
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

Commit-ID:  3fe7522fb766f6ee76bf7bc2837f1e3cc52c4e27
Gitweb:     https://git.kernel.org/tip/3fe7522fb766f6ee76bf7bc2837f1e3cc52c4e27
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Thu, 7 Mar 2019 08:52:12 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 9 Mar 2019 14:15:51 +0100

locking/lockdep: Avoid a Clang warning

Clang warns about a tentative array definition without a length:

  kernel/locking/lockdep.c:845:12: error: tentative array definition assumed to have one element [-Werror]

There is no real reason to do this here, so just set the same length as
in the real definition later in the same file.  It has to be hidden in
an #ifdef or annotated __maybe_unused though, to avoid the unused-variable
warning if CONFIG_PROVE_LOCKING is disabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/r/20190307075222.3424524-1-arnd@arndb.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 21cb81fe6359..35a144dfddf5 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -842,7 +842,9 @@ static bool class_lock_list_valid(struct lock_class *c, struct list_head *h)
 	return true;
 }
 
-static u16 chain_hlocks[];
+#ifdef CONFIG_PROVE_LOCKING
+static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
+#endif
 
 static bool check_lock_chain_key(struct lock_chain *chain)
 {
