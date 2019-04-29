Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1D0C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC75205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="EYrLGhvr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfD2GmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 02:42:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47435 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfD2GmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 02:42:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3T6fxxT784645
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 28 Apr 2019 23:41:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3T6fxxT784645
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556520120;
        bh=6gE5WV8wFQPvP6ael5WrD7cgZpoM049F50y0eFUk8zw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=EYrLGhvrdohOjoxQ3Ng4lBkg7zw6hQ+hWsBStJcv3XV24ilV5j36tekemw2eqmRh5
         BXUA5iHFRnSqmIsXoQN2Qx/Yi8WNkfB12F9MFAejN1xaXR+w8PyvJ0txoSuCZg17ah
         msjxpR3xliitIlV0zu6D6lwnMJ6yFh2K+MtgFdwbdFF8kwK0eD96A+E2x9xKbhr26w
         8RlJcaw0jvvFzicgWwqApn3pYI/72pa71Jp57KvhJAOAwB/acep59Ro+EowbzNf0uD
         f0oVfyoHECws+22Ymc+Wp90F5NRIAfos1pp7kP6wYHK9SEkgMpDY2oXbQMnZcHjbg1
         kJxIUg9Liq9/g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3T6fxXO784642;
        Sun, 28 Apr 2019 23:41:59 -0700
Date:   Sun, 28 Apr 2019 23:41:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jakub Kicinski <tipbot@zytor.com>
Message-ID: <tip-94b5f312cfb4a66055d9b688dc9ab6b297eb9dcc@git.kernel.org>
Cc:     tglx@linutronix.de, will.deacon@arm.com, akpm@linux-foundation.org,
        paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        simon.horman@netronome.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        torvalds@linux-foundation.org, jakub.kicinski@netronome.com
Reply-To: simon.horman@netronome.com, peterz@infradead.org,
          jakub.kicinski@netronome.com, hpa@zytor.com,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          mingo@kernel.org, akpm@linux-foundation.org, will.deacon@arm.com,
          tglx@linutronix.de, paulmck@linux.vnet.ibm.com
In-Reply-To: <20190330000854.30142-4-jakub.kicinski@netronome.com>
References: <20190330000854.30142-4-jakub.kicinski@netronome.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/static_key: Don't take sleeping locks in
 __static_key_slow_dec_deferred()
Git-Commit-ID: 94b5f312cfb4a66055d9b688dc9ab6b297eb9dcc
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

Commit-ID:  94b5f312cfb4a66055d9b688dc9ab6b297eb9dcc
Gitweb:     https://git.kernel.org/tip/94b5f312cfb4a66055d9b688dc9ab6b297eb9dcc
Author:     Jakub Kicinski <jakub.kicinski@netronome.com>
AuthorDate: Fri, 29 Mar 2019 17:08:54 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 29 Apr 2019 08:29:21 +0200

locking/static_key: Don't take sleeping locks in __static_key_slow_dec_deferred()

Changing jump_label state is protected by jump_label_lock().
Rate limited static_key_slow_dec(), however, will never
directly call jump_label_update(), it will schedule a delayed
work instead.  Therefore it's unnecessary to take both the
cpus_read_lock() and jump_label_lock().

This allows static_key_slow_dec_deferred() to be called
from atomic contexts, like socket destructing in net/tls,
without the need for another indirection.

Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Simon Horman <simon.horman@netronome.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: alexei.starovoitov@gmail.com
Cc: ard.biesheuvel@linaro.org
Cc: oss-drivers@netronome.com
Cc: yamada.masahiro@socionext.com
Link: https://lkml.kernel.org/r/20190330000854.30142-4-jakub.kicinski@netronome.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/jump_label.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 02c3d11264dd..de6efdecc70d 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -221,9 +221,7 @@ static bool static_key_slow_try_dec(struct static_key *key)
 	return true;
 }
 
-static void __static_key_slow_dec_cpuslocked(struct static_key *key,
-					   unsigned long rate_limit,
-					   struct delayed_work *work)
+static void __static_key_slow_dec_cpuslocked(struct static_key *key)
 {
 	lockdep_assert_cpus_held();
 
@@ -231,23 +229,15 @@ static void __static_key_slow_dec_cpuslocked(struct static_key *key,
 		return;
 
 	jump_label_lock();
-	if (atomic_dec_and_test(&key->enabled)) {
-		if (rate_limit) {
-			atomic_inc(&key->enabled);
-			schedule_delayed_work(work, rate_limit);
-		} else {
-			jump_label_update(key);
-		}
-	}
+	if (atomic_dec_and_test(&key->enabled))
+		jump_label_update(key);
 	jump_label_unlock();
 }
 
-static void __static_key_slow_dec(struct static_key *key,
-				  unsigned long rate_limit,
-				  struct delayed_work *work)
+static void __static_key_slow_dec(struct static_key *key)
 {
 	cpus_read_lock();
-	__static_key_slow_dec_cpuslocked(key, rate_limit, work);
+	__static_key_slow_dec_cpuslocked(key);
 	cpus_read_unlock();
 }
 
@@ -255,21 +245,21 @@ void jump_label_update_timeout(struct work_struct *work)
 {
 	struct static_key_deferred *key =
 		container_of(work, struct static_key_deferred, work.work);
-	__static_key_slow_dec(&key->key, 0, NULL);
+	__static_key_slow_dec(&key->key);
 }
 EXPORT_SYMBOL_GPL(jump_label_update_timeout);
 
 void static_key_slow_dec(struct static_key *key)
 {
 	STATIC_KEY_CHECK_USE(key);
-	__static_key_slow_dec(key, 0, NULL);
+	__static_key_slow_dec(key);
 }
 EXPORT_SYMBOL_GPL(static_key_slow_dec);
 
 void static_key_slow_dec_cpuslocked(struct static_key *key)
 {
 	STATIC_KEY_CHECK_USE(key);
-	__static_key_slow_dec_cpuslocked(key, 0, NULL);
+	__static_key_slow_dec_cpuslocked(key);
 }
 
 void __static_key_slow_dec_deferred(struct static_key *key,
@@ -277,7 +267,11 @@ void __static_key_slow_dec_deferred(struct static_key *key,
 				    unsigned long timeout)
 {
 	STATIC_KEY_CHECK_USE(key);
-	__static_key_slow_dec(key, timeout, work);
+
+	if (static_key_slow_try_dec(key))
+		return;
+
+	schedule_delayed_work(work, timeout);
 }
 EXPORT_SYMBOL_GPL(__static_key_slow_dec_deferred);
 
