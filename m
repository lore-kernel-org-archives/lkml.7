Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AF6C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F172199C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731689AbfGVSYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:24:54 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:35489 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfGVSYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:24:52 -0400
Received: by mail-pg1-f172.google.com with SMTP id s1so11747235pgr.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 11:24:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1EfSAXLS776m30VFEsBj9d2jg74PE/IyptCPDbntNqw=;
        b=E4xUoESX4SkfB7lkxIBzgL3naBG8+WouTuXWoXzOEcOQFTrzLw/d1PdygD9MaMAbAB
         VLK53Enjt2LdJALPm/9P/4t4pnGvJjHgI1klI6dYF++BY7sadeoqb9r8oApTkcpjkidA
         qABWnDNsr4qwaFKPCL3fuFuG5wRdvDGcHh6SKhM9YWhRUrDxLKi/q1+9qPAY+YLO2YiX
         WdLmxloFgcmDpb8zpOlPepABN4vRFXyYKoEOMLxKzlSpZlH0PYfTRjCalkqXeTK+wcPo
         rDXIBOGya58MMAY3ySzhzMM8TkSTIO2Rlfj4N/HVaZ+CzmGmiW8o4Re6imEVdy30mjCK
         YJCw==
X-Gm-Message-State: APjAAAXwKHjKJBf8Lr9Y/d38WLC9R9BVSmUFlVWicsfiXq3fuuceBELM
        EVy1s4UxVu+v/0ARjX9+Hj8=
X-Google-Smtp-Source: APXvYqzmx2BF9T4KC9CeFVYDbk9SgqFMzDel5/ZogBSGsPZbtM1/tToYNr7Rz8YDpk2EA0xlyNlxLg==
X-Received: by 2002:a65:448a:: with SMTP id l10mr47889639pgq.327.1563819891659;
        Mon, 22 Jul 2019 11:24:51 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id p23sm44556008pfn.10.2019.07.22.11.24.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 11:24:50 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 1/4] locking/lockdep: Make it clear that what lock_class::key points at is not modified
Date:   Mon, 22 Jul 2019 11:24:40 -0700
Message-Id: <20190722182443.216015-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
In-Reply-To: <20190722182443.216015-1-bvanassche@acm.org>
References: <20190722182443.216015-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does not change the behavior of the lockdep code.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Waiman Long <longman@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
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
index 341f52117f88..f4127c5a495d 100644
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
index 65b6a1600c8f..1ba5780182e7 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -398,7 +398,7 @@ static void seq_lock_time(struct seq_file *m, struct lock_time *lt)
 
 static void seq_stats(struct seq_file *m, struct lock_stat_data *data)
 {
-	struct lockdep_subclass_key *ckey;
+	const struct lockdep_subclass_key *ckey;
 	struct lock_class_stats *stats;
 	struct lock_class *class;
 	const char *cname;
-- 
2.22.0.657.g960e92d24f-goog

