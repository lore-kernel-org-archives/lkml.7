Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73211C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D88A21473
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Y2+blOIV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfD2Gld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 02:41:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51183 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfD2Glc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 02:41:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3T6fGVF784582
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 28 Apr 2019 23:41:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3T6fGVF784582
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556520077;
        bh=qcDvF/824BNWLAG3lmtXcJpnih50CQefhcIgfq+xZqQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Y2+blOIVzVD0af8CVM19FvoUjrk1nrXbef8KRAXXG9DSsaKYN7f5GQ0VaXWVADtgE
         +xz1G2Zc7526vXS4cuI0aNBYesx7jyZexbEwwG21wyuOtqlGvs0esRlPXVtbflo9YU
         XvSy8/pi3k0oZ3sEX4KzCbet2qCiyjM9mJHBLg/hIZOY6lCLxgBoBxnAeZHriRWZpl
         PWc0TB5gXnQz3Ub7jatM8nXEbZMwlDohuVYs4VVqwDm/h8bsViW+2Ni30OTiCB2Wb6
         kXOGURHs5ZJ+IGCLoGIXgRJRjm3XnQhjovKotxta1z0aStayPzl8D0XmGotm7pTKb2
         504YrToZrJwcQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3T6fFgn784577;
        Sun, 28 Apr 2019 23:41:16 -0700
Date:   Sun, 28 Apr 2019 23:41:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jakub Kicinski <tipbot@zytor.com>
Message-ID: <tip-b92e793bbe4a1c49dbf78d8d526561e7a7dd568a@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        paulmck@linux.vnet.ibm.com, simon.horman@netronome.com,
        peterz@infradead.org, will.deacon@arm.com, hpa@zytor.com,
        jakub.kicinski@netronome.com, torvalds@linux-foundation.org,
        akpm@linux-foundation.org
Reply-To: simon.horman@netronome.com, paulmck@linux.vnet.ibm.com,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          tglx@linutronix.de, mingo@kernel.org, akpm@linux-foundation.org,
          torvalds@linux-foundation.org, will.deacon@arm.com,
          jakub.kicinski@netronome.com, hpa@zytor.com
In-Reply-To: <20190330000854.30142-3-jakub.kicinski@netronome.com>
References: <20190330000854.30142-3-jakub.kicinski@netronome.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/static_key: Factor out the fast path of
 static_key_slow_dec()
Git-Commit-ID: b92e793bbe4a1c49dbf78d8d526561e7a7dd568a
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

Commit-ID:  b92e793bbe4a1c49dbf78d8d526561e7a7dd568a
Gitweb:     https://git.kernel.org/tip/b92e793bbe4a1c49dbf78d8d526561e7a7dd568a
Author:     Jakub Kicinski <jakub.kicinski@netronome.com>
AuthorDate: Fri, 29 Mar 2019 17:08:53 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 29 Apr 2019 08:29:21 +0200

locking/static_key: Factor out the fast path of static_key_slow_dec()

static_key_slow_dec() checks if the atomic enable count is larger
than 1, and if so there decrements it before taking the jump_label_lock.
Move this logic into a helper for reuse in rate limitted keys.

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
Link: https://lkml.kernel.org/r/20190330000854.30142-3-jakub.kicinski@netronome.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/jump_label.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 73bbbaddbd9c..02c3d11264dd 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -202,13 +202,13 @@ void static_key_disable(struct static_key *key)
 }
 EXPORT_SYMBOL_GPL(static_key_disable);
 
-static void __static_key_slow_dec_cpuslocked(struct static_key *key,
-					   unsigned long rate_limit,
-					   struct delayed_work *work)
+static bool static_key_slow_try_dec(struct static_key *key)
 {
 	int val;
 
-	lockdep_assert_cpus_held();
+	val = atomic_fetch_add_unless(&key->enabled, -1, 1);
+	if (val == 1)
+		return false;
 
 	/*
 	 * The negative count check is valid even when a negative
@@ -217,11 +217,18 @@ static void __static_key_slow_dec_cpuslocked(struct static_key *key,
 	 * returns is unbalanced, because all other static_key_slow_inc()
 	 * instances block while the update is in progress.
 	 */
-	val = atomic_fetch_add_unless(&key->enabled, -1, 1);
-	if (val != 1) {
-		WARN(val < 0, "jump label: negative count!\n");
+	WARN(val < 0, "jump label: negative count!\n");
+	return true;
+}
+
+static void __static_key_slow_dec_cpuslocked(struct static_key *key,
+					   unsigned long rate_limit,
+					   struct delayed_work *work)
+{
+	lockdep_assert_cpus_held();
+
+	if (static_key_slow_try_dec(key))
 		return;
-	}
 
 	jump_label_lock();
 	if (atomic_dec_and_test(&key->enabled)) {
