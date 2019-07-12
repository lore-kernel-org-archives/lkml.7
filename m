Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F37C742D1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 16:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA7F208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 16:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="aVwLdTOJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfGLQPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 12:15:12 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33713 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfGLQPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 12:15:12 -0400
Received: by mail-qt1-f193.google.com with SMTP id r6so4454691qtt.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 09:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=NFa47ynvJNVKijb8ipsUqShcDYxM8i8guWDLcd1fJdY=;
        b=aVwLdTOJhRLneF7C+yyvbofowq4Wx+ZKFxls9sj6tIGx/JIF/PM4blmdXborKxscoI
         IJ2DjnJpQU4Y3VM3yTR6V+GOqlAZ/Vq93V0799wIaV/mLuvuxMp8B87UxYon0KxvWxb+
         ekCZw6rtVBDvY3Ym53olKYaOebzKTZY4W8USH8ijznC1Q9Mkfr6FfnJ3l+cyDmanSg5f
         caYbP52s8MdU+GTPSM/t+3CzXpvC9kTI0DCedsQp+jTY0WoGXth7Gl36VRz1LsiND5P/
         OUP0yDmmjl43/qEzGe4cBLVcrhC8x/VoiucN/h00Fo7hJtIDuSFKGcs74Hw1Np6ugmNa
         DIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NFa47ynvJNVKijb8ipsUqShcDYxM8i8guWDLcd1fJdY=;
        b=L8aexdcS2XCzl+yVizPzjPyQ//tyKFz148uYVAJNFwXwweesjL07YYbejtT+LuKS3z
         Ko0N1JjRsb7ap/jNjfm4az4K3Vh3YMJ/oagTQk9LMIyzcOn2H29pMRDYOYroIZDcyNxD
         fmuS83954n8O6XqMrrv/ktc7HzhZtW1Ilsp5cH1vYmab9jYM0YYCIfJ1Hw540yzdiM0w
         oEtX6TSm+MgmOYvd5tg2wpoOG7lJoPvPT7NF4jUlTL9M38FJU42al23MlkvM6vneVGSV
         lweg4qVaE0oFEqsfSFlltNKtGqrtll4jvsNuU5Qztip2h3ndTVK3kfsjHJMpKMxe9DJp
         G+uA==
X-Gm-Message-State: APjAAAVavItg4/UEI3zq8Z8MNVcRkIDpjDmpHLf/ujcyECopJp3SRLFW
        GqTn3Hr4DDLvDBKSXL0w8UKv+w==
X-Google-Smtp-Source: APXvYqzJpsr0V6tw0AJ2IK66ngUsHrsW73Hd904xsHbRKoy1m09e3gShD8WVbTlk123Mg3V+s0Swaw==
X-Received: by 2002:ac8:2642:: with SMTP id v2mr6641202qtv.333.1562948111022;
        Fri, 12 Jul 2019 09:15:11 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id r36sm1438381qte.71.2019.07.12.09.15.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 09:15:10 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     tj@kernel.org, dchinner@redhat.com, fengguang.wu@intel.com,
        jack@suse.cz, linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] trace/writeback: fix Wstringop-truncation warnings
Date:   Fri, 12 Jul 2019 12:14:47 -0400
Message-Id: <1562948087-5374-1-git-send-email-cai@lca.pw>
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

Fix it by using strlcpy() which will always be NUL-terminated instead of
strncpy(). strlcpy() has already been used at some places in this file.

Fixes: 455b2864686d ("writeback: Initial tracing support")
Fixes: 028c2dd184c0 ("writeback: Add tracing to balance_dirty_pages")
Fixes: e84d0a4f8e39 ("writeback: trace event writeback_queue_io")
Fixes: b48c104d2211 ("writeback: trace event bdi_dirty_ratelimit")
Fixes: cc1676d917f3 ("writeback: Move requeueing when I_SYNC set to writeback_sb_inodes()")
Fixes: 9fb0a7da0c52 ("writeback: add more tracepoints")

Signed-off-by: Qian Cai <cai@lca.pw>
---
 include/trace/events/writeback.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index aa7f3aeac740..8e3b3c4fd964 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -66,7 +66,7 @@
 	),
 
 	TP_fast_assign(
-		strncpy(__entry->name,
+		strlcpy(__entry->name,
 			mapping ? dev_name(inode_to_bdi(mapping->host)->dev) : "(unknown)", 32);
 		__entry->ino = mapping ? mapping->host->i_ino : 0;
 		__entry->index = page->index;
@@ -110,7 +110,7 @@
 		struct backing_dev_info *bdi = inode_to_bdi(inode);
 
 		/* may be called for files on pseudo FSes w/ unregistered bdi */
-		strncpy(__entry->name,
+		strlcpy(__entry->name,
 			bdi->dev ? dev_name(bdi->dev) : "(unknown)", 32);
 		__entry->ino		= inode->i_ino;
 		__entry->state		= inode->i_state;
@@ -190,7 +190,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
 	),
 
 	TP_fast_assign(
-		strncpy(__entry->name,
+		strlcpy(__entry->name,
 			dev_name(inode_to_bdi(inode)->dev), 32);
 		__entry->ino		= inode->i_ino;
 		__entry->sync_mode	= wbc->sync_mode;
@@ -234,7 +234,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
 		__field(unsigned int, cgroup_ino)
 	),
 	TP_fast_assign(
-		strncpy(__entry->name,
+		strlcpy(__entry->name,
 			wb->bdi->dev ? dev_name(wb->bdi->dev) : "(unknown)", 32);
 		__entry->nr_pages = work->nr_pages;
 		__entry->sb_dev = work->sb ? work->sb->s_dev : 0;
@@ -288,7 +288,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
 		__field(unsigned int, cgroup_ino)
 	),
 	TP_fast_assign(
-		strncpy(__entry->name, dev_name(wb->bdi->dev), 32);
+		strlcpy(__entry->name, dev_name(wb->bdi->dev), 32);
 		__entry->cgroup_ino = __trace_wb_assign_cgroup(wb);
 	),
 	TP_printk("bdi %s: cgroup_ino=%u",
@@ -310,7 +310,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
 		__array(char, name, 32)
 	),
 	TP_fast_assign(
-		strncpy(__entry->name, dev_name(bdi->dev), 32);
+		strlcpy(__entry->name, dev_name(bdi->dev), 32);
 	),
 	TP_printk("bdi %s",
 		__entry->name
@@ -335,7 +335,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
 	),
 
 	TP_fast_assign(
-		strncpy(__entry->name, dev_name(bdi->dev), 32);
+		strlcpy(__entry->name, dev_name(bdi->dev), 32);
 		__entry->nr_to_write	= wbc->nr_to_write;
 		__entry->pages_skipped	= wbc->pages_skipped;
 		__entry->sync_mode	= wbc->sync_mode;
@@ -386,7 +386,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
 	),
 	TP_fast_assign(
 		unsigned long *older_than_this = work->older_than_this;
-		strncpy(__entry->name, dev_name(wb->bdi->dev), 32);
+		strlcpy(__entry->name, dev_name(wb->bdi->dev), 32);
 		__entry->older	= older_than_this ?  *older_than_this : 0;
 		__entry->age	= older_than_this ?
 				  (jiffies - *older_than_this) * 1000 / HZ : -1;
@@ -597,7 +597,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
 	),
 
 	TP_fast_assign(
-		strncpy(__entry->name,
+		strlcpy(__entry->name,
 		        dev_name(inode_to_bdi(inode)->dev), 32);
 		__entry->ino		= inode->i_ino;
 		__entry->state		= inode->i_state;
@@ -671,7 +671,7 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
 	),
 
 	TP_fast_assign(
-		strncpy(__entry->name,
+		strlcpy(__entry->name,
 			dev_name(inode_to_bdi(inode)->dev), 32);
 		__entry->ino		= inode->i_ino;
 		__entry->state		= inode->i_state;
-- 
1.8.3.1

