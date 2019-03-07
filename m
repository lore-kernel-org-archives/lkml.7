Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57354C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2492A20851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 07:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfCGHzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 02:55:19 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:36875 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCGHzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 02:55:19 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MY5s5-1ha90m2mS5-00YRcO; Thu, 07 Mar 2019 08:52:25 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lockdep: avoid a clang warning
Date:   Thu,  7 Mar 2019 08:52:12 +0100
Message-Id: <20190307075222.3424524-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:G8mhJwLDpTkj9/KY84pG4Ibbbquqd5jhJl4LFurbt6BePUkuR3K
 tnlJMDzsRkAVCVZ6XrnlzgS7towk12whK1psomvc4hxzgsoSfxUTQhYkd0Umceatgm9wJW+
 bXhIDXy6RP9Jeq1n3mfZcx6DOGAWKvwv2d3kCFtTVaJ1dH5vkOp2NEBG5goeEtGfJXXZddz
 QMn4oXEc4PSDHjM5po/9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NQsCYikYSZM=:twR1be6WSsfM60pj4/nvwT
 RVbZldgh3+3AbHBIT2qCqSUK9MKSfgtNWaTu8/axQLrwHVZ2FH9SS0MYy7BELidbHET8KTfSt
 db1ul+gtAnePPyEYK1nr3IEZ7EidagsKnA2Kyblvq5d4yP8epQcTpcm2XASXjsSsSbeerdavH
 7Xqps1UPRFhUZV4lwL/5kE+fq4LWvif43MWvGmCtsN9vIgNKOICstJZ0mTlU6UqommEuMlc90
 Wvfy9WPI6zn5pk1DmssX4qi/Siq9hz1XU4KoZws3Q2pzUV6c8wssrhZjpj0fQJDBm1VkaFDid
 IF+RK75SaC4NzTmsWT+TdG0+aLs8R9pIUTwOVyd7rk3nGa3U32dmR4p+/NxSTlhqGTyNzI+WQ
 YfMY6DjwK37veXbCkrFQ4zs9JcarC2mqnIsHj30TXyLAcf11dvz/fyUl4WbvoBMrcIRPqKqu0
 PYLwrGEw1ay7SPXr1LukF9nKAhih4deejVNkzFHaO+DgpLL8heNsZvJcFRMrEtv2AJ6Eo0M7z
 gEMwQqkUxILeo3xr2THLfJCB+Po9DAulNJRL9LNBATXlhp62LI+/eEVlCMb/Z/j7raAm9JGVy
 oInMQO27iEkRbpRqiXWocDEHbLSqiUBk9YBsItl+GSL7FWKfuM3cWgQJujWb/ESPrICRVxBHw
 ZGutaj0LKkW7fHn4AW7TcTmOdNPuOnSOPjJWIIMKvbymGSVTZc26Sh9PBfbC5WEVVvR6+uxbV
 kJlRkQ4xUefUp0buDCSQkOvjZ0AUPKXzmVN7Qw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns about a tentative array definition without a length:

kernel/locking/lockdep.c:845:12: error: tentative array definition assumed to have one element [-Werror]

There is no real reason to do this here, so just set the same length as
in the real definition later in the same file.  It has to be hidden in
an #ifdef or annotated __maybe_unused though, to avoid the unused-variable
warning if CONFIG_PROVE_LOCKING is disabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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
-- 
2.20.0

