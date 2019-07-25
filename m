Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F69DC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1112238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="rbuv0wIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbfGYRSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:18:52 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34253 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbfGYRSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:18:50 -0400
Received: by mail-qt1-f195.google.com with SMTP id k10so49906633qtq.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 10:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=x6mWKXQBEsXrypFg3m3uh2GS8z569WtSNg12TrjebsY=;
        b=rbuv0wIYRR52xWnonq3jMof9ULoPU3NLbv9qlXFuTQ+w8a37n0vpsVPDyTSn7ORYbj
         5JVh8+IF8swdbkDpFV0uEVqQhYXmSAMBZEGhQZuwHMYC7mVOSrdN6SBKbtTAVgAc8uhr
         qSJxMFS8UamVpSx9dOmVx55pRfR1N4qkS8Y4pIe9BUKDMladbd8Bqpfyhhqr+1DCCg+d
         kutHilchcLM+S6UtkvlbFUP99qWgQWvmzoHVtuU6lqtgXswM8NNJqv7MV6rQuG7nQvgp
         7tMkYvM6DIebTiIiQjbokVbUMeocLJ3N2H2HPYpKDebeCVH8HF8MHwktXcEjVy6FP2sQ
         +VBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x6mWKXQBEsXrypFg3m3uh2GS8z569WtSNg12TrjebsY=;
        b=puBaTt8LFPOxvgdFUIeewhbLrK5S3DJkucaot+wvqbl2vihKdAWfeS1e6BYr3BJUt4
         jhpTdgEs0VcHC98te4pvbBjIchreEISbHCzBF8beSYFBC8OfLm2czsOYCfnR1XChLQg+
         do+wit9XFplmHykG8/dlhZArMLCuukJe7A2zWYQqMBcNV+5hSGKliKo9q5xY0pQh7JL3
         WwCVsWWCIfSCi8xybFY9LuwhhKBSbTlWCHlB07L6m3tIzo4DFx33Q67wAXrQNPzJkpbX
         45XeCQud/Q756aejW0V4ocZomaKeU+JBmKhzA4uPcBDFf695cP6Fr0x7663Iu83bochH
         ouiA==
X-Gm-Message-State: APjAAAWoUZz+5+T71eYDhaR1DxQdwV4CY+WyRdKJ2rt6opDI1K3j0g1m
        Q4zghz4Qh6cuhjuFR0LrvThsIw==
X-Google-Smtp-Source: APXvYqz5j7cXKdoCpMWEHUJ6QfccwlWiQnIW3aaDbgd8fWPj81Qbw+kdlaxMxIdF0G7JD0h+kR0qZw==
X-Received: by 2002:ac8:2b62:: with SMTP id 31mr63677562qtv.140.1564075129144;
        Thu, 25 Jul 2019 10:18:49 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x8sm21460560qkl.27.2019.07.25.10.18.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 10:18:48 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     tobin@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        tj@kernel.org, dchinner@redhat.com, fengguang.wu@intel.com,
        jack@suse.cz, axboe@kernel.dk, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v3] writeback: fix -Wstringop-truncation warnings
Date:   Thu, 25 Jul 2019 13:18:19 -0400
Message-Id: <1564075099-27750-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many of those warnings.

In file included from ./arch/powerpc/include/asm/paca.h:15,
                 from ./arch/powerpc/include/asm/current.h:13,
                 from ./include/linux/thread_info.h:21,
                 from ./include/asm-generic/preempt.h:5,
                 from ./arch/powerpc/include/generated/asm/preempt.h:1,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/spinlock.h:51,
                 from fs/fs-writeback.c:19:
In function 'strncpy',
    inlined from 'perf_trace_writeback_page_template' at
./include/trace/events/writeback.h:56:1:
./include/linux/string.h:260:9: warning: '__builtin_strncpy' specified
bound 32 equals destination size [-Wstringop-truncation]
  return __builtin_strncpy(p, q, size);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fix it by using the new strscpy_pad() which was introduced in the
commit 458a3bf82df4 ("lib/string: Add strscpy_pad() function") and will
always be NUL-terminated instead of strncpy(). Also, changes strlcpy()
to use strscpy_pad() in this file for consistency.

Fixes: 455b2864686d ("writeback: Initial tracing support")
Fixes: 028c2dd184c0 ("writeback: Add tracing to balance_dirty_pages")
Fixes: e84d0a4f8e39 ("writeback: trace event writeback_queue_io")
Fixes: b48c104d2211 ("writeback: trace event bdi_dirty_ratelimit")
Fixes: cc1676d917f3 ("writeback: Move requeueing when I_SYNC set to writeback_sb_inodes()")
Fixes: 9fb0a7da0c52 ("writeback: add more tracepoints")
Signed-off-by: Qian Cai <cai@lca.pw>
---

v3: Rearrange a long-line a bit to make the code more readable.
v2: Use strscpy_pad() to address the possible data leaking concern from Steve [1].
    Replace strlcpy() as well for consistency.

[1] https://lore.kernel.org/lkml/20190716170339.1c44719d@gandalf.local.home/

 include/trace/events/writeback.h | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index aa7f3aeac740..79095434c1be 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -66,8 +66,9 @@
 	),
 
 	TP_fast_assign(
-		strncpy(__entry->name,
-			mapping ? dev_name(inode_to_bdi(mapping->host)->dev) : "(unknown)", 32);
+		strscpy_pad(__entry->name,
+			    mapping ? dev_name(inode_to_bdi(mapping->host)->dev) : "(unknown)",
+			    32);
 		__entry->ino = mapping ? mapping->host->i_ino : 0;
 		__entry->index = page->index;
 	),
@@ -110,8 +111,8 @@
 		struct backing_dev_info *bdi = inode_to_bdi(inode);
 
 		/* may be called for files on pseudo FSes w/ unregistered bdi */
-		strncpy(__entry->name,
-			bdi->dev ? dev_name(bdi->dev) : "(unknown)", 32);
+		strscpy_pad(__entry->name,
+			    bdi->dev ? dev_name(bdi->dev) : "(unknown)", 32);
 		__entry->ino		= inode->i_ino;
 		__entry->state		= inode->i_state;
 		__entry->flags		= flags;
@@ -190,8 +191,8 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
 	),
 
 	TP_fast_assign(
-		strncpy(__entry->name,
-			dev_name(inode_to_bdi(inode)->dev), 32);
+		strscpy_pad(__entry->name,
+			    dev_name(inode_to_bdi(inode)->dev), 32);
 		__entry->ino		= inode->i_ino;
 		__entry->sync_mode	= wbc->sync_mode;
 		__entry->cgroup_ino	= __trace_wbc_assign_cgroup(wbc);
@@ -234,8 +235,9 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
 		__field(unsigned int, cgroup_ino)
 	),
 	TP_fast_assign(
-		strncpy(__entry->name,
-			wb->bdi->dev ? dev_name(wb->bdi->dev) : "(unknown)", 32);
+		strscpy_pad(__entry->name,
+			    wb->bdi->dev ? dev_name(wb->bdi->dev) :
+			    "(unknown)", 32);
 		__entry->nr_pages = work->nr_pages;
 		__entry->sb_dev = work->sb ? work->sb->s_dev : 0;
 		__entry->sync_mode = work->sync_mode;
@@ -288,7 +290,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
 		__field(unsigned int, cgroup_ino)
 	),
 	TP_fast_assign(
-		strncpy(__entry->name, dev_name(wb->bdi->dev), 32);
+		strscpy_pad(__entry->name, dev_name(wb->bdi->dev), 32);
 		__entry->cgroup_ino = __trace_wb_assign_cgroup(wb);
 	),
 	TP_printk("bdi %s: cgroup_ino=%u",
@@ -310,7 +312,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
 		__array(char, name, 32)
 	),
 	TP_fast_assign(
-		strncpy(__entry->name, dev_name(bdi->dev), 32);
+		strscpy_pad(__entry->name, dev_name(bdi->dev), 32);
 	),
 	TP_printk("bdi %s",
 		__entry->name
@@ -335,7 +337,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
 	),
 
 	TP_fast_assign(
-		strncpy(__entry->name, dev_name(bdi->dev), 32);
+		strscpy_pad(__entry->name, dev_name(bdi->dev), 32);
 		__entry->nr_to_write	= wbc->nr_to_write;
 		__entry->pages_skipped	= wbc->pages_skipped;
 		__entry->sync_mode	= wbc->sync_mode;
@@ -386,7 +388,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
 	),
 	TP_fast_assign(
 		unsigned long *older_than_this = work->older_than_this;
-		strncpy(__entry->name, dev_name(wb->bdi->dev), 32);
+		strscpy_pad(__entry->name, dev_name(wb->bdi->dev), 32);
 		__entry->older	= older_than_this ?  *older_than_this : 0;
 		__entry->age	= older_than_this ?
 				  (jiffies - *older_than_this) * 1000 / HZ : -1;
@@ -472,7 +474,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
 	),
 
 	TP_fast_assign(
-		strlcpy(__entry->bdi, dev_name(wb->bdi->dev), 32);
+		strscpy_pad(__entry->bdi, dev_name(wb->bdi->dev), 32);
 		__entry->write_bw	= KBps(wb->write_bandwidth);
 		__entry->avg_write_bw	= KBps(wb->avg_write_bandwidth);
 		__entry->dirty_rate	= KBps(dirty_rate);
@@ -537,7 +539,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
 
 	TP_fast_assign(
 		unsigned long freerun = (thresh + bg_thresh) / 2;
-		strlcpy(__entry->bdi, dev_name(wb->bdi->dev), 32);
+		strscpy_pad(__entry->bdi, dev_name(wb->bdi->dev), 32);
 
 		__entry->limit		= global_wb_domain.dirty_limit;
 		__entry->setpoint	= (global_wb_domain.dirty_limit +
@@ -597,8 +599,8 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
 	),
 
 	TP_fast_assign(
-		strncpy(__entry->name,
-		        dev_name(inode_to_bdi(inode)->dev), 32);
+		strscpy_pad(__entry->name,
+			    dev_name(inode_to_bdi(inode)->dev), 32);
 		__entry->ino		= inode->i_ino;
 		__entry->state		= inode->i_state;
 		__entry->dirtied_when	= inode->dirtied_when;
@@ -671,8 +673,8 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
 	),
 
 	TP_fast_assign(
-		strncpy(__entry->name,
-			dev_name(inode_to_bdi(inode)->dev), 32);
+		strscpy_pad(__entry->name,
+			    dev_name(inode_to_bdi(inode)->dev), 32);
 		__entry->ino		= inode->i_ino;
 		__entry->state		= inode->i_state;
 		__entry->dirtied_when	= inode->dirtied_when;
-- 
1.8.3.1

