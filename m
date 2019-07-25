Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B82C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E370D218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="TzOLZZSV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbfGYOjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:39:02 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:47081 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfGYOjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:39:02 -0400
Received: by mail-qk1-f193.google.com with SMTP id r4so36509188qkm.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 07:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=xoSQWHPuY8p2jMXFibHmTvGdIgXKgADFPKfleeYedKc=;
        b=TzOLZZSVdD98/bsYWrEMVRMiB7YL1jkX/aTLpQQQtcwfOb/qvsneJBe4ac8EsSFTTG
         25/V0MPGaTCyIpTLaOnzxFOyZ+gYsrUCNjhfXhZUSJg8dm1t31mafVWEHNv5JoDnoom6
         E2P8lvJqW1Vue20LcRbEobmcdJ6POxMdXCXfwCmH3edcF4f+nQajPgBn3JT4kuJXudac
         zE9teWow4RjihX6O/KhNJlEo4SXIICJ3ol2Ld2ryW4ZJ0+Cok3BRCgnYpi3eXnwR2PCo
         8nxB/76FOl+0+oplA6XmD1H2jVANH4fq0kaoJuEsoxOj/NjYJdaZyfaA9Bxd42DWqlAe
         19+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xoSQWHPuY8p2jMXFibHmTvGdIgXKgADFPKfleeYedKc=;
        b=UOHf/Kp7dCHeefjENu/K/TIML93J4Gd7YCwleXgQE4xm1hOaS5yh5fACdnVNLUQ9rL
         y20nFGUU5nVlEH3owLFY50VvvGuP1L6z+Qe+COwJQj/48CqcpdIAC6J3Ytmg9ojdfSiC
         QxeaUaahALy76ddT4Ha5jQlrqFETKOz3pfMILgurNkV7hI4oQ+xKwuw/Z5o44OLwLW0S
         yjtcH4SrQhG48gqn5xzOr4BDdluL4LrpZGlftWJa4VIcMr5rbE6b+xhAEml8gGPYqxtV
         nKFm5E4IJexfNkv7Tu9sprzacpxV4j+QhLB7ZfXYzSLa+TpOIrqxN9m0UBffVGpRfRyQ
         aNqA==
X-Gm-Message-State: APjAAAXeOzXGWZR7uz+IwMHtd3HGdyvD83+PAzW7JtfvTTdO1Ve3rQ7n
        o6ZP5ysmejqjLXkxnFfCVpbwyQ==
X-Google-Smtp-Source: APXvYqwYdHITXRbJ6ij5XUgOpu0S6BImw+97Pi1ktV41V8Wq/G73zQvo8GFdTk+JgKe/q/9DxQvXnw==
X-Received: by 2002:a37:4d82:: with SMTP id a124mr57121919qkb.72.1564065540575;
        Thu, 25 Jul 2019 07:39:00 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q17sm17821291qtl.13.2019.07.25.07.38.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 07:38:59 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     tobin@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        tj@kernel.org, dchinner@redhat.com, fengguang.wu@intel.com,
        jack@suse.cz, axboe@kernel.dk, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v2] writeback: fix -Wstringop-truncation warnings
Date:   Thu, 25 Jul 2019 10:38:31 -0400
Message-Id: <1564065511-13206-1-git-send-email-cai@lca.pw>
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

v2: Use strscpy_pad() to address the possible data leaking concern from Steve [1].
    Replace strlcpy() as well for consistency.

[1] https://lore.kernel.org/lkml/20190716170339.1c44719d@gandalf.local.home/

 include/trace/events/writeback.h | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index aa7f3aeac740..41092d63a8de 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -66,8 +66,10 @@
 	),
 
 	TP_fast_assign(
-		strncpy(__entry->name,
-			mapping ? dev_name(inode_to_bdi(mapping->host)->dev) : "(unknown)", 32);
+		strscpy_pad(__entry->name,
+			    mapping ?
+			    dev_name(inode_to_bdi(mapping->host)->dev) :
+			    "(unknown)", 32);
 		__entry->ino = mapping ? mapping->host->i_ino : 0;
 		__entry->index = page->index;
 	),
@@ -110,8 +112,8 @@
 		struct backing_dev_info *bdi = inode_to_bdi(inode);
 
 		/* may be called for files on pseudo FSes w/ unregistered bdi */
-		strncpy(__entry->name,
-			bdi->dev ? dev_name(bdi->dev) : "(unknown)", 32);
+		strscpy_pad(__entry->name,
+			    bdi->dev ? dev_name(bdi->dev) : "(unknown)", 32);
 		__entry->ino		= inode->i_ino;
 		__entry->state		= inode->i_state;
 		__entry->flags		= flags;
@@ -190,8 +192,8 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
 	),
 
 	TP_fast_assign(
-		strncpy(__entry->name,
-			dev_name(inode_to_bdi(inode)->dev), 32);
+		strscpy_pad(__entry->name,
+			    dev_name(inode_to_bdi(inode)->dev), 32);
 		__entry->ino		= inode->i_ino;
 		__entry->sync_mode	= wbc->sync_mode;
 		__entry->cgroup_ino	= __trace_wbc_assign_cgroup(wbc);
@@ -234,8 +236,9 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
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
@@ -288,7 +291,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
 		__field(unsigned int, cgroup_ino)
 	),
 	TP_fast_assign(
-		strncpy(__entry->name, dev_name(wb->bdi->dev), 32);
+		strscpy_pad(__entry->name, dev_name(wb->bdi->dev), 32);
 		__entry->cgroup_ino = __trace_wb_assign_cgroup(wb);
 	),
 	TP_printk("bdi %s: cgroup_ino=%u",
@@ -310,7 +313,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
 		__array(char, name, 32)
 	),
 	TP_fast_assign(
-		strncpy(__entry->name, dev_name(bdi->dev), 32);
+		strscpy_pad(__entry->name, dev_name(bdi->dev), 32);
 	),
 	TP_printk("bdi %s",
 		__entry->name
@@ -335,7 +338,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
 	),
 
 	TP_fast_assign(
-		strncpy(__entry->name, dev_name(bdi->dev), 32);
+		strscpy_pad(__entry->name, dev_name(bdi->dev), 32);
 		__entry->nr_to_write	= wbc->nr_to_write;
 		__entry->pages_skipped	= wbc->pages_skipped;
 		__entry->sync_mode	= wbc->sync_mode;
@@ -386,7 +389,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
 	),
 	TP_fast_assign(
 		unsigned long *older_than_this = work->older_than_this;
-		strncpy(__entry->name, dev_name(wb->bdi->dev), 32);
+		strscpy_pad(__entry->name, dev_name(wb->bdi->dev), 32);
 		__entry->older	= older_than_this ?  *older_than_this : 0;
 		__entry->age	= older_than_this ?
 				  (jiffies - *older_than_this) * 1000 / HZ : -1;
@@ -472,7 +475,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
 	),
 
 	TP_fast_assign(
-		strlcpy(__entry->bdi, dev_name(wb->bdi->dev), 32);
+		strscpy_pad(__entry->bdi, dev_name(wb->bdi->dev), 32);
 		__entry->write_bw	= KBps(wb->write_bandwidth);
 		__entry->avg_write_bw	= KBps(wb->avg_write_bandwidth);
 		__entry->dirty_rate	= KBps(dirty_rate);
@@ -537,7 +540,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
 
 	TP_fast_assign(
 		unsigned long freerun = (thresh + bg_thresh) / 2;
-		strlcpy(__entry->bdi, dev_name(wb->bdi->dev), 32);
+		strscpy_pad(__entry->bdi, dev_name(wb->bdi->dev), 32);
 
 		__entry->limit		= global_wb_domain.dirty_limit;
 		__entry->setpoint	= (global_wb_domain.dirty_limit +
@@ -597,8 +600,8 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
 	),
 
 	TP_fast_assign(
-		strncpy(__entry->name,
-		        dev_name(inode_to_bdi(inode)->dev), 32);
+		strscpy_pad(__entry->name,
+			    dev_name(inode_to_bdi(inode)->dev), 32);
 		__entry->ino		= inode->i_ino;
 		__entry->state		= inode->i_state;
 		__entry->dirtied_when	= inode->dirtied_when;
@@ -671,8 +674,8 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
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

