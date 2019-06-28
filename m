Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CA4C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60218208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+0xqXz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfF1JQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:16:16 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42545 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfF1JQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:16:15 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay6so2885341plb.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I9dPsEtJCEiuhZNIYsC+o8qAD4cE4xsOv38Yk3OtHVU=;
        b=a+0xqXz406H/gWw9iI88Ua4QzScP+2/k2GPlX5ljJG3Yv8beQlYGPZQqhs7gXfI1C+
         LF/kV9Se5mIaB43eSPYbO2hhqbdtOk1KriLDs1wKOwEUSKiT4D4Tac2ZSqUNVyA37OkO
         bg8+ntq5nfKPWEPnXYsC/zyjW3VuCsSbOoPEO47oOLMDdRVTszxE1tZhxuYcWgdvM9AI
         DgWzCuDyP8xCjf3BF1jaNDZDOhVrVd3Iq+ODLwm9mvTMXDeulx/zr6h+0omrlmi+riwb
         +UWqh/++OIIJwq/8FRVP5N4blou6xL1woRSvqcCMI8HNX+JPC2lLQ9GEe5mIm8scASFc
         fnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I9dPsEtJCEiuhZNIYsC+o8qAD4cE4xsOv38Yk3OtHVU=;
        b=LaU4PR6A8J4XKIvLiS8FgpLdb043MSyyifZ4Zs4YdxfirvXA5BzrtF4v/3DxW6Tz07
         YpCD/+OlfpPOHSa98IWgi0pd9bB+7T67kM8w8H+VB2az57Z+4HNpfVpXCQt0CRqSN399
         tUJwvr4i1+li0NcwfiBlQDbi9Xg6giWhZ5qIXNk+7oZrwdGYix9MAme658i0IAM+Wmzn
         AowAcbTC7XtMniUmNc1LsJJ6BsruNYV9SPHFztRw8dMj94voBSFwndpDndJhIzFn3UKU
         gZsPtsl5URHgdAV5PN2y41dKorXSefwxNWywe4C/yavVlL6pCRsikljVcE+1i5Nnhd1H
         ZCPg==
X-Gm-Message-State: APjAAAX7UO4nKwzBAnevqu5BcVkQ3D5nVZaeaFGZs9VfbkRjAKvpqkeh
        g94c9fW370JxwmMuGG/KMEc=
X-Google-Smtp-Source: APXvYqwGs4QmXLyIvd3ejZvYmwbgViyP+2geKsL+QgWMy6kgum64Rh5GaWyola68ccEN88uMve+H3A==
X-Received: by 2002:a17:902:9a84:: with SMTP id w4mr10086499plp.160.1561713374992;
        Fri, 28 Jun 2019 02:16:14 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id x65sm1754521pfd.139.2019.06.28.02.16.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 02:16:14 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v3 07/30] locking/lockdep: Remove indirect dependency redundancy check
Date:   Fri, 28 Jun 2019 17:15:05 +0800
Message-Id: <20190628091528.17059-8-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190628091528.17059-1-duyuyang@gmail.com>
References: <20190628091528.17059-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Indirect dependency redundancy check was added for cross-release, which
has been reverted. Then suggested by Peter, only when setting
CONFIG_LOCKDEP_SMALL it takes effect.

With (recursive) read-write lock types considered in dependency graph,
indirect dependency redundancy check would be very complicated if not
impossible to be correctly done. Lets remove it for good.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c           | 41 --------------------------------------
 kernel/locking/lockdep_internals.h |  1 -
 kernel/locking/lockdep_proc.c      |  2 --
 3 files changed, 44 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index f171c6e..c61fdef 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1744,38 +1744,6 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
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
@@ -2437,15 +2405,6 @@ static inline void inc_chains(void)
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
 	if (!trace->nr_entries && !save_trace(trace))
 		return 0;
 
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index cc83568..e9a8ed6 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -170,7 +170,6 @@ struct lockdep_stats {
 	unsigned long  redundant_softirqs_on;
 	unsigned long  redundant_softirqs_off;
 	int            nr_unused_locks;
-	unsigned int   nr_redundant_checks;
 	unsigned int   nr_redundant;
 	unsigned int   nr_cyclic_checks;
 	unsigned int   nr_find_usage_forwards_checks;
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 9c49ec6..58ed889 100644
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

