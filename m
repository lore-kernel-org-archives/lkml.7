Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A775C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2452075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="szG/bRcV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfD2Gku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 02:40:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56869 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbfD2Gku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 02:40:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3T6eXim784439
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 28 Apr 2019 23:40:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3T6eXim784439
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556520034;
        bh=svZTN1DxhjXtRIAPclSOK0fyXxnGVGBjFM6gHiJZX3s=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=szG/bRcV67+AIEklX0dBunz5rNP/1QKaECGSVnefpRLJNaExrzuUc+js+y3BfgzH9
         vFFyGzvav57IMLsbSRNZ/j9rjexY/dVf8vryqljk6HKh4NuwB94M/GzZHo6mrZyDFg
         LLnqwDfjKcOPObKGFi9ORvpZ29l7JOIWXlxo/UhFPJHwdS3hfCcBvlO+Cv7jG6CHNS
         cUT0s9HJCYMjWF5poNuaieXr52FmDbVxekB4/WCfmjAgzHssbTpdWIJEPtkZ2YA2F5
         +1FPwBpbhyACf0jqEhYaVmL02o5yKm1P6qXtIds+GtEZI06RWr51gOLQB8rbl33sZm
         CijZEa2LnfY/w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3T6eWX5784436;
        Sun, 28 Apr 2019 23:40:32 -0700
Date:   Sun, 28 Apr 2019 23:40:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jakub Kicinski <tipbot@zytor.com>
Message-ID: <tip-ad282a8117d5048398f506f20b092c14b3b3c43f@git.kernel.org>
Cc:     akpm@linux-foundation.org, will.deacon@arm.com,
        jakub.kicinski@netronome.com, torvalds@linux-foundation.org,
        paulmck@linux.vnet.ibm.com, hpa@zytor.com, mingo@kernel.org,
        peterz@infradead.org, simon.horman@netronome.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Reply-To: will.deacon@arm.com, torvalds@linux-foundation.org,
          jakub.kicinski@netronome.com, akpm@linux-foundation.org,
          hpa@zytor.com, paulmck@linux.vnet.ibm.com, peterz@infradead.org,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, simon.horman@netronome.com
In-Reply-To: <20190330000854.30142-2-jakub.kicinski@netronome.com>
References: <20190330000854.30142-2-jakub.kicinski@netronome.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/static_key: Add support for deferred
 static branches
Git-Commit-ID: ad282a8117d5048398f506f20b092c14b3b3c43f
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

Commit-ID:  ad282a8117d5048398f506f20b092c14b3b3c43f
Gitweb:     https://git.kernel.org/tip/ad282a8117d5048398f506f20b092c14b3b3c43f
Author:     Jakub Kicinski <jakub.kicinski@netronome.com>
AuthorDate: Fri, 29 Mar 2019 17:08:52 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 29 Apr 2019 08:29:20 +0200

locking/static_key: Add support for deferred static branches

Add deferred static branches.  We can't unfortunately use the
nice trick of encapsulating the entire structure in true/false
variants, because the inside has to be either struct static_key_true
or struct static_key_false.  Use defines to pass the appropriate
members to the helpers separately.

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
Link: https://lkml.kernel.org/r/20190330000854.30142-2-jakub.kicinski@netronome.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/jump_label_ratelimit.h | 64 ++++++++++++++++++++++++++++++++++--
 kernel/jump_label.c                  | 17 ++++++----
 2 files changed, 71 insertions(+), 10 deletions(-)

diff --git a/include/linux/jump_label_ratelimit.h b/include/linux/jump_label_ratelimit.h
index a49f2b45b3f0..42710d5949ba 100644
--- a/include/linux/jump_label_ratelimit.h
+++ b/include/linux/jump_label_ratelimit.h
@@ -12,21 +12,79 @@ struct static_key_deferred {
 	struct delayed_work work;
 };
 
-extern void static_key_slow_dec_deferred(struct static_key_deferred *key);
-extern void static_key_deferred_flush(struct static_key_deferred *key);
+struct static_key_true_deferred {
+	struct static_key_true key;
+	unsigned long timeout;
+	struct delayed_work work;
+};
+
+struct static_key_false_deferred {
+	struct static_key_false key;
+	unsigned long timeout;
+	struct delayed_work work;
+};
+
+#define static_key_slow_dec_deferred(x)					\
+	__static_key_slow_dec_deferred(&(x)->key, &(x)->work, (x)->timeout)
+#define static_branch_slow_dec_deferred(x)				\
+	__static_key_slow_dec_deferred(&(x)->key.key, &(x)->work, (x)->timeout)
+
+#define static_key_deferred_flush(x)					\
+	__static_key_deferred_flush((x), &(x)->work)
+
+extern void
+__static_key_slow_dec_deferred(struct static_key *key,
+			       struct delayed_work *work,
+			       unsigned long timeout);
+extern void __static_key_deferred_flush(void *key, struct delayed_work *work);
 extern void
 jump_label_rate_limit(struct static_key_deferred *key, unsigned long rl);
 
+extern void jump_label_update_timeout(struct work_struct *work);
+
+#define DEFINE_STATIC_KEY_DEFERRED_TRUE(name, rl)			\
+	struct static_key_true_deferred name = {			\
+		.key =		{ STATIC_KEY_INIT_TRUE },		\
+		.timeout =	(rl),					\
+		.work =	__DELAYED_WORK_INITIALIZER((name).work,		\
+						   jump_label_update_timeout, \
+						   0),			\
+	}
+
+#define DEFINE_STATIC_KEY_DEFERRED_FALSE(name, rl)			\
+	struct static_key_false_deferred name = {			\
+		.key =		{ STATIC_KEY_INIT_FALSE },		\
+		.timeout =	(rl),					\
+		.work =	__DELAYED_WORK_INITIALIZER((name).work,		\
+						   jump_label_update_timeout, \
+						   0),			\
+	}
+
+#define static_branch_deferred_inc(x)	static_branch_inc(&(x)->key)
+
 #else	/* !CONFIG_JUMP_LABEL */
 struct static_key_deferred {
 	struct static_key  key;
 };
+struct static_key_true_deferred {
+	struct static_key_true key;
+};
+struct static_key_false_deferred {
+	struct static_key_false key;
+};
+#define DEFINE_STATIC_KEY_DEFERRED_TRUE(name, rl)	\
+	struct static_key_true_deferred name = { STATIC_KEY_TRUE_INIT }
+#define DEFINE_STATIC_KEY_DEFERRED_FALSE(name, rl)	\
+	struct static_key_false_deferred name = { STATIC_KEY_FALSE_INIT }
+
+#define static_branch_slow_dec_deferred(x)	static_branch_dec(&(x)->key)
+
 static inline void static_key_slow_dec_deferred(struct static_key_deferred *key)
 {
 	STATIC_KEY_CHECK_USE(key);
 	static_key_slow_dec(&key->key);
 }
-static inline void static_key_deferred_flush(struct static_key_deferred *key)
+static inline void static_key_deferred_flush(void *key)
 {
 	STATIC_KEY_CHECK_USE(key);
 }
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index a799b1ac6b2f..73bbbaddbd9c 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -244,12 +244,13 @@ static void __static_key_slow_dec(struct static_key *key,
 	cpus_read_unlock();
 }
 
-static void jump_label_update_timeout(struct work_struct *work)
+void jump_label_update_timeout(struct work_struct *work)
 {
 	struct static_key_deferred *key =
 		container_of(work, struct static_key_deferred, work.work);
 	__static_key_slow_dec(&key->key, 0, NULL);
 }
+EXPORT_SYMBOL_GPL(jump_label_update_timeout);
 
 void static_key_slow_dec(struct static_key *key)
 {
@@ -264,19 +265,21 @@ void static_key_slow_dec_cpuslocked(struct static_key *key)
 	__static_key_slow_dec_cpuslocked(key, 0, NULL);
 }
 
-void static_key_slow_dec_deferred(struct static_key_deferred *key)
+void __static_key_slow_dec_deferred(struct static_key *key,
+				    struct delayed_work *work,
+				    unsigned long timeout)
 {
 	STATIC_KEY_CHECK_USE(key);
-	__static_key_slow_dec(&key->key, key->timeout, &key->work);
+	__static_key_slow_dec(key, timeout, work);
 }
-EXPORT_SYMBOL_GPL(static_key_slow_dec_deferred);
+EXPORT_SYMBOL_GPL(__static_key_slow_dec_deferred);
 
-void static_key_deferred_flush(struct static_key_deferred *key)
+void __static_key_deferred_flush(void *key, struct delayed_work *work)
 {
 	STATIC_KEY_CHECK_USE(key);
-	flush_delayed_work(&key->work);
+	flush_delayed_work(work);
 }
-EXPORT_SYMBOL_GPL(static_key_deferred_flush);
+EXPORT_SYMBOL_GPL(__static_key_deferred_flush);
 
 void jump_label_rate_limit(struct static_key_deferred *key,
 		unsigned long rl)
