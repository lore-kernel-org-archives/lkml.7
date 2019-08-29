Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131A7C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27C62053B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcigYO73"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfH2IcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:32:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34729 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfH2IcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:32:13 -0400
Received: by mail-pl1-f194.google.com with SMTP id d3so1253206plr.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+UBCh5PmLoVykHIvNvETH0s5BN2o63WWiayGNevLad0=;
        b=bcigYO739ksQbe8O8BqYg5dX1hWWNjgVPWPnI3IKezlztRA5ZhKavoGVBFf4jHyPOO
         L2vQkkQDXaN5/ZooBLahr2CkP5DkAlm5Xd5fFGa1EW8VvfDExfVXG5lt1kNUSec1qgyq
         aud/Ee7bEl9ZdTNb/bo3KuSubZxtr4NVgtDPCW2oDSXRKXTVHm6vdpbABhGcfCmI0HR/
         +RveOKSzjAD3b2lM0b6z4YpoBRte4dWj8OLFDhh0ou8BOUv+zftXbv88MUhfW3K/tsjj
         ZPIqNMNe2wFw2L3BS0yWhMNW+hlNiKNPhTVzyv19Tox6587299tARQEqg2Isgmg5jmxG
         zX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+UBCh5PmLoVykHIvNvETH0s5BN2o63WWiayGNevLad0=;
        b=WOOclyrw6zswTeb1CyUI73iCWnSJsi6dCwyzioRPr9TpE7BOkTNMXtSomek4qnmqCM
         4Ul6eig1XotEs654f+GnJEDfxlmwxdrGUi4xFD9AJ7cGZSW+R2eoQ/i9ykkjKjUEvMES
         3CXIpIo8rKjVEbmofGcOo4KzeLJfL5X63GII4eWUbA+bNiKuqYEk5HAyxBnFkcxaowbZ
         BGTo7TCO1UFuOVbLCe2ZoVN3tO1BUZpuO0vE+jJEpnOLMKdGVN7J/YGonn22smkr2Fdw
         JQl2HEIjVp7iNSFpOcAcSMyb1Qvw7jfn/r/UFy+Vf5+AGRQxDvAHDdNCl6bWe2DR90kx
         mOCQ==
X-Gm-Message-State: APjAAAWDO3ERH26i3CZJ8wHkxsiXerSFnhagBUUpN4CVIovrfVLfZzAv
        5iCtVS8ww6Y7ZTd4uKvKVG0=
X-Google-Smtp-Source: APXvYqz6EmQ9xceltjxNlAq5XHaYfBN0p7DDmshn6AZ2vyPZFJgOMp2RUZ38jRrz5iRGtIIQjBQbRQ==
X-Received: by 2002:a17:902:42a5:: with SMTP id h34mr7235269pld.266.1567067533362;
        Thu, 29 Aug 2019 01:32:13 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v22sm1260155pgk.69.2019.08.29.01.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 01:32:12 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v4 07/30] locking/lockdep: Remove indirect dependency redundancy check
Date:   Thu, 29 Aug 2019 16:31:09 +0800
Message-Id: <20190829083132.22394-8-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190829083132.22394-1-duyuyang@gmail.com>
References: <20190829083132.22394-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Indirect dependency redundancy check was added for cross-release, which has
been reverted. Then suggested by Peter, only when CONFIG_LOCKDEP_SMALL is
set it takes effect.

With (recursive) read-write lock types considered in dependency graph,
indirect dependency redundancy check would be quite complicated to
implement. Lets remove it for good. This inevitably increases the number of
dependencies, but after combining forward and backward dependencies, the
increase will be offset.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c           | 41 --------------------------------------
 kernel/locking/lockdep_internals.h |  1 -
 kernel/locking/lockdep_proc.c      |  2 --
 3 files changed, 44 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index a0e62e5..4838c99 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1812,38 +1812,6 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 	return ret;
 }
 
-#ifdef CONFIG_LOCKDEP_SMALL
-/*
- * Check that the dependency graph starting at <src> can lead to
- * <target> or not. If it can, <src> -> <target> dependency is already
- * in the graph.
- *
- * Print an error and return 2 if it does or 1 if it does not.
- */
-static noinline int
-check_redundant(struct held_lock *src, struct held_lock *target)
-{
-	int ret;
-	struct lock_list *uninitialized_var(target_entry);
-	struct lock_list src_entry = {
-		.class = hlock_class(src),
-		.parent = NULL,
-	};
-
-	debug_atomic_inc(nr_redundant_checks);
-
-	ret = check_path(hlock_class(target), &src_entry, &target_entry);
-
-	if (!ret) {
-		debug_atomic_inc(nr_redundant);
-		ret = 2;
-	} else if (ret < 0)
-		ret = 0;
-
-	return ret;
-}
-#endif
-
 #ifdef CONFIG_TRACE_IRQFLAGS
 
 static inline int usage_accumulate(struct lock_list *entry, void *mask)
@@ -2507,15 +2475,6 @@ static inline void inc_chains(void)
 		}
 	}
 
-#ifdef CONFIG_LOCKDEP_SMALL
-	/*
-	 * Is the <prev> -> <next> link redundant?
-	 */
-	ret = check_redundant(prev, next);
-	if (ret != 1)
-		return ret;
-#endif
-
 	if (!*trace) {
 		*trace = save_trace();
 		if (!*trace)
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 18d85ae..f499426 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -177,7 +177,6 @@ struct lockdep_stats {
 	unsigned long  redundant_softirqs_on;
 	unsigned long  redundant_softirqs_off;
 	int            nr_unused_locks;
-	unsigned int   nr_redundant_checks;
 	unsigned int   nr_redundant;
 	unsigned int   nr_cyclic_checks;
 	unsigned int   nr_find_usage_forwards_checks;
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index dadb7b7..edc4a7b 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -178,8 +178,6 @@ static void lockdep_stats_debug_show(struct seq_file *m)
 		debug_atomic_read(chain_lookup_hits));
 	seq_printf(m, " cyclic checks:                 %11llu\n",
 		debug_atomic_read(nr_cyclic_checks));
-	seq_printf(m, " redundant checks:              %11llu\n",
-		debug_atomic_read(nr_redundant_checks));
 	seq_printf(m, " redundant links:               %11llu\n",
 		debug_atomic_read(nr_redundant));
 	seq_printf(m, " find-mask forwards checks:     %11llu\n",
-- 
1.8.3.1

