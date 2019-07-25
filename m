Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1EDC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C9E229F3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="IwKmfo+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbfGYQIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:08:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60821 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfGYQIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:08:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PG8d8w1073660
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:08:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PG8d8w1073660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564070920;
        bh=oYTeL3GOY3mtE+waBDjlY7wEdy9+TmFH9r+4KQBj7rQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=IwKmfo+jgEGrfO4NkJRhJqdNYD7zcxUhrmswXbJ+Wn6lAlhj/j/ZIB82Sa5/m0+pb
         FOyK/L4ptmzLZprOqpHih1gmYCUmL9D+WfOnD5zp6PJOGlIv4FOFmCWoHsFISrbgU5
         zAQeW+2iAxLer0EgymBukilyxwg2XA3jyYHwaesVcMPlIaEr6BqqOuYoEiPmpvDX7e
         XS+dENBz//xbb9VQdJ8rhnIIxi5y9yVeXokjrU8AhCbVUYry1bY//L7WuonxRgO9n+
         pBqy0UBnJ9HQwV7AiGrYzX+M2aHoEx4WBr3Fa6+6HFaWf0qdmCoikF2Pu2THVQWXje
         XhDx+78OZzc5A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PG8d2p1073657;
        Thu, 25 Jul 2019 09:08:39 -0700
Date:   Thu, 25 Jul 2019 09:08:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-364f6afc4f5537b79cf454eb35cae92920676075@git.kernel.org>
Cc:     tglx@linutronix.de, bvanassche@acm.org, mingo@kernel.org,
        peterz@infradead.org, longman@redhat.com, will.deacon@arm.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com,
          torvalds@linux-foundation.org, will.deacon@arm.com,
          longman@redhat.com, peterz@infradead.org, mingo@kernel.org,
          tglx@linutronix.de, bvanassche@acm.org
In-Reply-To: <20190722182443.216015-2-bvanassche@acm.org>
References: <20190722182443.216015-2-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Make it clear that what
 lock_class::key points at is not modified
Git-Commit-ID: 364f6afc4f5537b79cf454eb35cae92920676075
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

Commit-ID:  364f6afc4f5537b79cf454eb35cae92920676075
Gitweb:     https://git.kernel.org/tip/364f6afc4f5537b79cf454eb35cae92920676075
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Mon, 22 Jul 2019 11:24:40 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:43:26 +0200

locking/lockdep: Make it clear that what lock_class::key points at is not modified

This patch does not change the behavior of the lockdep code.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/r/20190722182443.216015-2-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/lockdep.h            | 2 +-
 kernel/locking/lockdep.c           | 2 +-
 kernel/locking/lockdep_internals.h | 3 ++-
 kernel/locking/lockdep_proc.c      | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 0b0d7259276d..cdb3c2f06092 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -97,7 +97,7 @@ struct lock_class {
 	 */
 	struct list_head		locks_after, locks_before;
 
-	struct lockdep_subclass_key	*key;
+	const struct lockdep_subclass_key *key;
 	unsigned int			subclass;
 	unsigned int			dep_gen_id;
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4861cf8e274b..af6627866191 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -511,7 +511,7 @@ static const char *usage_str[] =
 };
 #endif
 
-const char * __get_key_name(struct lockdep_subclass_key *key, char *str)
+const char *__get_key_name(const struct lockdep_subclass_key *key, char *str)
 {
 	return kallsyms_lookup((unsigned long)key, NULL, NULL, NULL, str);
 }
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index cc83568d5012..2e518369add4 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -116,7 +116,8 @@ extern struct lock_chain lock_chains[];
 extern void get_usage_chars(struct lock_class *class,
 			    char usage[LOCK_USAGE_CHARS]);
 
-extern const char * __get_key_name(struct lockdep_subclass_key *key, char *str);
+extern const char *__get_key_name(const struct lockdep_subclass_key *key,
+				  char *str);
 
 struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i);
 
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index bda006f8a88b..ed9842425cac 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -399,7 +399,7 @@ static void seq_lock_time(struct seq_file *m, struct lock_time *lt)
 
 static void seq_stats(struct seq_file *m, struct lock_stat_data *data)
 {
-	struct lockdep_subclass_key *ckey;
+	const struct lockdep_subclass_key *ckey;
 	struct lock_class_stats *stats;
 	struct lock_class *class;
 	const char *cname;
