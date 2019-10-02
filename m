Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95F7C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 20:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89FB521848
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 20:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="av+DOKXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfJBUZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 16:25:12 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:42281 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfJBUZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 16:25:12 -0400
Received: by mail-qt1-f201.google.com with SMTP id f5so496167qto.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 13:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to;
        bh=fMttwO8IbnrLW6/EKswpdi1khD6zSduQpT9XvrjjN7Q=;
        b=av+DOKXzdPP3u4At3ye1ET0SbH96S+WyUXLGPf3Z7lWPikd90qjrl6tOIBKZeyd8YB
         jziIvB65e2r+4ePA9TspIO3U9E+ksCmGXyq/FWkbjz7LgCN2VMVX3UeZu+QfEbOiEdaH
         /mFSOEFB3nNmT0IEpoBCpgx8nKwmieo0bpZvG1FeTfK6RV7sRvl7J0J5rSqqHp8Zyq3t
         rz1tA0MFtBozf2MiuLrHhi5GqVnl+p1zw0nZW4Z4tZii5/koIEUr1sVHAeHv9ddUfvFj
         EmqqqXk/LjawxZBCdIuv0IV9XyO0bSBzRX1H7nFCtA2NZmc3aDd8MljS2V39DmtJcyCx
         EFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=fMttwO8IbnrLW6/EKswpdi1khD6zSduQpT9XvrjjN7Q=;
        b=gO4CV1HqfDuMQiMk8u3+dRWkUyYrPLqvhEbrXTQ0CQDCWd984YEHZy4kiU1bgtJ8cl
         GGCf37bc/eezGvvpEqTn1lVMXjulj/nsr21QLu1W1n7Z87NY6XrkJzD2WyGKGhm27BiL
         FjdMZk1uiD2YF68mb8nH/jD0WhwGUccA13dNioAoSNzNU/CiwGyEUQGt/ZtPwTVP5AVE
         fmSpt9oUdxjER8HSid9XpPrrgAvjKe2+L2JnMKs5XpFkL2+BA2UOvi9T1perYrQbI5Az
         YNBBBilXqrMz7UxO9j+cPL9AnGZvuBFVQErQ5Uub9zKCj+P2WMuDcPpncsy+9M0Wi3MA
         9OUA==
X-Gm-Message-State: APjAAAXbrCnwCg3Xg9Wkm+YubkgFHN778c4ZWmFaxGzJ/asiiRxMl2uU
        FhcGQIzzyYwx+rgmTlfJV/RJwUDVuA8=
X-Google-Smtp-Source: APXvYqyxE2JY46XiHePJwXKI2BZPbxp3pi/S7gZFVJrGpz9HuK7iaqLlhiT8t774SWcwtVoqT58r7osVKAA=
X-Received: by 2002:ac8:46d8:: with SMTP id h24mr6222814qto.235.1570047909825;
 Wed, 02 Oct 2019 13:25:09 -0700 (PDT)
Date:   Wed,  2 Oct 2019 13:24:36 -0700
Message-Id: <20191002202436.202731-1-dancol@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH] Make SPLIT_RSS_COUNTING configurable
From:   Daniel Colascione <dancol@google.com>
To:     dancol@google.com, timmurray@google.com, surenb@google.com,
        linux-mm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the new config option, users can disable SPLIT_RSS_COUNTING to
get increased accuracy in user-visible mm counters.

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 include/linux/mm.h            |  4 ++--
 include/linux/mm_types_task.h |  5 ++---
 include/linux/sched.h         |  2 +-
 kernel/fork.c                 |  2 +-
 mm/Kconfig                    | 11 +++++++++++
 mm/memory.c                   |  6 +++---
 6 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index cc292273e6ba..221395de3cb4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1637,7 +1637,7 @@ static inline unsigned long get_mm_counter(struct mm_struct *mm, int member)
 {
 	long val = atomic_long_read(&mm->rss_stat.count[member]);
 
-#ifdef SPLIT_RSS_COUNTING
+#ifdef CONFIG_SPLIT_RSS_COUNTING
 	/*
 	 * counter is updated in asynchronous manner and may go to minus.
 	 * But it's never be expected number for users.
@@ -1723,7 +1723,7 @@ static inline void setmax_mm_hiwater_rss(unsigned long *maxrss,
 		*maxrss = hiwater_rss;
 }
 
-#if defined(SPLIT_RSS_COUNTING)
+#ifdef CONFIG_SPLIT_RSS_COUNTING
 void sync_mm_rss(struct mm_struct *mm);
 #else
 static inline void sync_mm_rss(struct mm_struct *mm)
diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
index c1bc6731125c..d2adc8057e65 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -48,14 +48,13 @@ enum {
 	NR_MM_COUNTERS
 };
 
-#if USE_SPLIT_PTE_PTLOCKS && defined(CONFIG_MMU)
-#define SPLIT_RSS_COUNTING
+#ifdef CONFIG_SPLIT_RSS_COUNTING
 /* per-thread cached information, */
 struct task_rss_stat {
 	int events;	/* for synchronization threshold */
 	int count[NR_MM_COUNTERS];
 };
-#endif /* USE_SPLIT_PTE_PTLOCKS */
+#endif /* CONFIG_SPLIT_RSS_COUNTING */
 
 struct mm_rss_stat {
 	atomic_long_t count[NR_MM_COUNTERS];
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2c2e56bd8913..22f354774540 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -729,7 +729,7 @@ struct task_struct {
 	/* Per-thread vma caching: */
 	struct vmacache			vmacache;
 
-#ifdef SPLIT_RSS_COUNTING
+#ifdef CONFIG_SPLIT_RSS_COUNTING
 	struct task_rss_stat		rss_stat;
 #endif
 	int				exit_state;
diff --git a/kernel/fork.c b/kernel/fork.c
index f9572f416126..fc5e0889922b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1917,7 +1917,7 @@ static __latent_entropy struct task_struct *copy_process(
 	p->vtime.state = VTIME_INACTIVE;
 #endif
 
-#if defined(SPLIT_RSS_COUNTING)
+#ifdef CONFIG_SPLIT_RSS_COUNTING
 	memset(&p->rss_stat, 0, sizeof(p->rss_stat));
 #endif
 
diff --git a/mm/Kconfig b/mm/Kconfig
index a5dae9a7eb51..372ef9449924 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -736,4 +736,15 @@ config ARCH_HAS_PTE_SPECIAL
 config ARCH_HAS_HUGEPD
 	bool
 
+config SPLIT_RSS_COUNTING
+	bool "Per-thread mm counter caching"
+	depends on MMU
+	default y if NR_CPUS >= SPLIT_PTLOCK_CPUS
+	help
+	  Cache mm counter updates in thread structures and
+	  flush them to visible per-process statistics in batches.
+	  Say Y here to slightly reduce cache contention in processes
+	  with many threads at the expense of decreasing the accuracy
+	  of memory statistics in /proc.
+	  
 endmenu
diff --git a/mm/memory.c b/mm/memory.c
index b1ca51a079f2..bf557ed5ba23 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -141,7 +141,7 @@ static int __init init_zero_pfn(void)
 core_initcall(init_zero_pfn);
 
 
-#if defined(SPLIT_RSS_COUNTING)
+#ifdef CONFIG_SPLIT_RSS_COUNTING
 
 void sync_mm_rss(struct mm_struct *mm)
 {
@@ -177,7 +177,7 @@ static void check_sync_rss_stat(struct task_struct *task)
 	if (unlikely(task->rss_stat.events++ > TASK_RSS_EVENTS_THRESH))
 		sync_mm_rss(task->mm);
 }
-#else /* SPLIT_RSS_COUNTING */
+#else /* CONFIG_SPLIT_RSS_COUNTING */
 
 #define inc_mm_counter_fast(mm, member) inc_mm_counter(mm, member)
 #define dec_mm_counter_fast(mm, member) dec_mm_counter(mm, member)
@@ -186,7 +186,7 @@ static void check_sync_rss_stat(struct task_struct *task)
 {
 }
 
-#endif /* SPLIT_RSS_COUNTING */
+#endif /* CONFIG_SPLIT_RSS_COUNTING */
 
 /*
  * Note: this doesn't free the actual pages themselves. That
-- 
2.23.0.581.g78d2f28ef7-goog

