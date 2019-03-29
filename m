Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9C3C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02996218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cqMEa3PN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbfC2RqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:46:15 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:41881 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbfC2RqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 13:46:14 -0400
Received: by mail-qt1-f202.google.com with SMTP id d49so2962967qtk.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 10:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HecDosyfTxgMGrjWUH7w5Q0D6lV4nYY1byCXj4k9AG4=;
        b=cqMEa3PNpRy8WcyNUOAaWlijQ16ZhQ1K9HVHCM7lPtjNNDvV2lsXTo4+K99HEiJYmd
         vs9r7/EH23//ynO/F2i86aYhzGBI0p7v1Vju239SnZSoWHBFSJWhSCe67Dv+ImTSIoHI
         a/n4+EoooBJZFJzKxUeatMaaslRvljHknhH9g4nuIfFZU5EagUURuBSFPyr+Y4+Hb23Z
         rvA2fEFfriP4w4Ua+4PisqiFxHkTI6wZ+DnAJH+Mql+xGlI04BCe9yumhkeafdmFFIe1
         prrcH3H3UFMcZsxwUSSMvG/yh2UxwQ8xmvveb6IruN4OY9A3VoE4wnSlqx1NHUYkPh0/
         QRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HecDosyfTxgMGrjWUH7w5Q0D6lV4nYY1byCXj4k9AG4=;
        b=CYuSNImcvVt3rFtdve2u9H1KoKK/UETNHj9JMLYAaQBh5SodxtfgFXanWh3GPEYgqc
         fNi5S0+JJGr10zlr6BPV2Wq/u8jJ74rM1Ha3gA7TXw20OCUJCFLoYAa7wZ1W7ZwZlt/2
         IxZWcknEXdlkZIbhx98ZcQx2wZ3k1FIW0ZtfqKyb2hlUikgRXNYPWemqgp02UKd9l/u6
         WpYNj03+KkE2WzoswjDR2rAqXHYugRa2VqT+QGFx0lySQ3i91vhXVq22wWvrXRloGeaA
         M7YUdzKT7ClbpG+wtvf/GguSAVXgfs73U/jv140twrS+jCi4+7LDMG1dU1Y+ZOpio2Io
         DvoQ==
X-Gm-Message-State: APjAAAU3OTmbAexH+ki3AC2yFLVIXijmktm14jC9yw5GfRKdIK/9id0o
        0oqg+hDE8XdYfO3+6VM0RCZtDf2It39N
X-Google-Smtp-Source: APXvYqxzQW2SonDnjkuDuqtoTZtQBTSwsDbdzgUhTk7AvwJAB1uNC0V/3RxlJqSUgG1KzxxU+5gRzKTGdW23
X-Received: by 2002:a0c:9622:: with SMTP id 31mr716828qvx.22.1553881573167;
 Fri, 29 Mar 2019 10:46:13 -0700 (PDT)
Date:   Fri, 29 Mar 2019 10:46:09 -0700
Message-Id: <20190329174609.164344-1-gthelen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v2] writeback: use exact memcg dirty counts
From:   Greg Thelen <gthelen@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Greg Thelen <gthelen@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit a983b5ebee57 ("mm: memcontrol: fix excessive complexity in
memory.stat reporting") memcg dirty and writeback counters are managed
as:
1) per-memcg per-cpu values in range of [-32..32]
2) per-memcg atomic counter
When a per-cpu counter cannot fit in [-32..32] it's flushed to the
atomic.  Stat readers only check the atomic.
Thus readers such as balance_dirty_pages() may see a nontrivial error
margin: 32 pages per cpu.
Assuming 100 cpus:
   4k x86 page_size:  13 MiB error per memcg
  64k ppc page_size: 200 MiB error per memcg
Considering that dirty+writeback are used together for some decisions
the errors double.

This inaccuracy can lead to undeserved oom kills.  One nasty case is
when all per-cpu counters hold positive values offsetting an atomic
negative value (i.e. per_cpu[*]=32, atomic=n_cpu*-32).
balance_dirty_pages() only consults the atomic and does not consider
throttling the next n_cpu*32 dirty pages.  If the file_lru is in the
13..200 MiB range then there's absolutely no dirty throttling, which
burdens vmscan with only dirty+writeback pages thus resorting to oom
kill.

It could be argued that tiny containers are not supported, but it's more
subtle.  It's the amount the space available for file lru that matters.
If a container has memory.max-200MiB of non reclaimable memory, then it
will also suffer such oom kills on a 100 cpu machine.

The following test reliably ooms without this patch.  This patch avoids
oom kills.

  $ cat test
  mount -t cgroup2 none /dev/cgroup
  cd /dev/cgroup
  echo +io +memory > cgroup.subtree_control
  mkdir test
  cd test
  echo 10M > memory.max
  (echo $BASHPID > cgroup.procs && exec /memcg-writeback-stress /foo)
  (echo $BASHPID > cgroup.procs && exec dd if=/dev/zero of=/foo bs=2M count=100)

  $ cat memcg-writeback-stress.c
  /*
   * Dirty pages from all but one cpu.
   * Clean pages from the non dirtying cpu.
   * This is to stress per cpu counter imbalance.
   * On a 100 cpu machine:
   * - per memcg per cpu dirty count is 32 pages for each of 99 cpus
   * - per memcg atomic is -99*32 pages
   * - thus the complete dirty limit: sum of all counters 0
   * - balance_dirty_pages() only sees atomic count -99*32 pages, which
   *   it max()s to 0.
   * - So a workload can dirty -99*32 pages before balance_dirty_pages()
   *   cares.
   */
  #define _GNU_SOURCE
  #include <err.h>
  #include <fcntl.h>
  #include <sched.h>
  #include <stdlib.h>
  #include <stdio.h>
  #include <sys/stat.h>
  #include <sys/sysinfo.h>
  #include <sys/types.h>
  #include <unistd.h>

  static char *buf;
  static int bufSize;

  static void set_affinity(int cpu)
  {
  	cpu_set_t affinity;

  	CPU_ZERO(&affinity);
  	CPU_SET(cpu, &affinity);
  	if (sched_setaffinity(0, sizeof(affinity), &affinity))
  		err(1, "sched_setaffinity");
  }

  static void dirty_on(int output_fd, int cpu)
  {
  	int i, wrote;

  	set_affinity(cpu);
  	for (i = 0; i < 32; i++) {
  		for (wrote = 0; wrote < bufSize; ) {
  			int ret = write(output_fd, buf+wrote, bufSize-wrote);
  			if (ret == -1)
  				err(1, "write");
  			wrote += ret;
  		}
  	}
  }

  int main(int argc, char **argv)
  {
  	int cpu, flush_cpu = 1, output_fd;
  	const char *output;

  	if (argc != 2)
  		errx(1, "usage: output_file");

  	output = argv[1];
  	bufSize = getpagesize();
  	buf = malloc(getpagesize());
  	if (buf == NULL)
  		errx(1, "malloc failed");

  	output_fd = open(output, O_CREAT|O_RDWR);
  	if (output_fd == -1)
  		err(1, "open(%s)", output);

  	for (cpu = 0; cpu < get_nprocs(); cpu++) {
  		if (cpu != flush_cpu)
  			dirty_on(output_fd, cpu);
  	}

  	set_affinity(flush_cpu);
  	if (fsync(output_fd))
  		err(1, "fsync(%s)", output);
  	if (close(output_fd))
  		err(1, "close(%s)", output);
  	free(buf);
  }

Make balance_dirty_pages() and wb_over_bg_thresh() work harder to
collect exact per memcg counters.  This avoids the aforementioned oom
kills.

This does not affect the overhead of memory.stat, which still reads the
single atomic counter.

Why not use percpu_counter?  memcg already handles cpus going offline,
so no need for that overhead from percpu_counter.  And the
percpu_counter spinlocks are more heavyweight than is required.

It probably also makes sense to use exact dirty and writeback counters
in memcg oom reports.  But that is saved for later.

Cc: stable@vger.kernel.org # v4.16+
Signed-off-by: Greg Thelen <gthelen@google.com>
---
Changelog since v1:
- Move memcg_exact_page_state() into memcontrol.c.
- Unconditionally gather exact (per cpu) counters in mem_cgroup_wb_stats(), it's
  not called in performance sensitive paths.
- Unconditionally check for underflow regardless of CONFIG_SMP.  It's just
  easier this way.  This isn't performance sensitive.
- Add stable tag.

 include/linux/memcontrol.h |  5 ++++-
 mm/memcontrol.c            | 20 ++++++++++++++++++--
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 1f3d880b7ca1..dbb6118370c1 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -566,7 +566,10 @@ struct mem_cgroup *lock_page_memcg(struct page *page);
 void __unlock_page_memcg(struct mem_cgroup *memcg);
 void unlock_page_memcg(struct page *page);
 
-/* idx can be of type enum memcg_stat_item or node_stat_item */
+/*
+ * idx can be of type enum memcg_stat_item or node_stat_item.
+ * Keep in sync with memcg_exact_page_state().
+ */
 static inline unsigned long memcg_page_state(struct mem_cgroup *memcg,
 					     int idx)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 532e0e2a4817..81a0d3914ec9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3882,6 +3882,22 @@ struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb)
 	return &memcg->cgwb_domain;
 }
 
+/*
+ * idx can be of type enum memcg_stat_item or node_stat_item.
+ * Keep in sync with memcg_exact_page().
+ */
+static unsigned long memcg_exact_page_state(struct mem_cgroup *memcg, int idx)
+{
+	long x = atomic_long_read(&memcg->stat[idx]);
+	int cpu;
+
+	for_each_online_cpu(cpu)
+		x += per_cpu_ptr(memcg->stat_cpu, cpu)->count[idx];
+	if (x < 0)
+		x = 0;
+	return x;
+}
+
 /**
  * mem_cgroup_wb_stats - retrieve writeback related stats from its memcg
  * @wb: bdi_writeback in question
@@ -3907,10 +3923,10 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
 	struct mem_cgroup *parent;
 
-	*pdirty = memcg_page_state(memcg, NR_FILE_DIRTY);
+	*pdirty = memcg_exact_page_state(memcg, NR_FILE_DIRTY);
 
 	/* this should eventually include NR_UNSTABLE_NFS */
-	*pwriteback = memcg_page_state(memcg, NR_WRITEBACK);
+	*pwriteback = memcg_exact_page_state(memcg, NR_WRITEBACK);
 	*pfilepages = mem_cgroup_nr_lru_pages(memcg, (1 << LRU_INACTIVE_FILE) |
 						     (1 << LRU_ACTIVE_FILE));
 	*pheadroom = PAGE_COUNTER_MAX;
-- 
2.21.0.392.gf8f6787159e-goog

