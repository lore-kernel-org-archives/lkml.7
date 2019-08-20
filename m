Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE228C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 06:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1685206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 06:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="KZ4UvmaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbfHTGOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 02:14:46 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37770 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728878AbfHTGOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 02:14:46 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 5E08120B718C; Mon, 19 Aug 2019 23:14:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5E08120B718C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1566281685;
        bh=8ETceY5cQaIbFG6NG3N9TrVwSxmoSIPofIv/ugh7xNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KZ4UvmaJuWQuuZ7mjqup9jeBTEBinwWveOX1EHHL5IVVRorgpXPpxLUxLKvFJoQ1e
         sPZ5oBfIaskBUJqKDZY79Lr9Umjo4dHNDhFl9RPr+YJAFf8iv03tCqEPniIl4EAMW1
         UxyAVs+/wGicnq8o3OwNkV0pfLr1aoMnGXz+3n4g=
From:   longli@linuxonhyperv.com
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [PATCH 1/3] sched: define a function to report the number of context switches on a CPU
Date:   Mon, 19 Aug 2019 23:14:27 -0700
Message-Id: <1566281669-48212-2-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1566281669-48212-1-git-send-email-longli@linuxonhyperv.com>
References: <1566281669-48212-1-git-send-email-longli@linuxonhyperv.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

The number of context switches on a CPU is useful to determine how busy this
CPU is on processing IRQs. Export this information so it can be used by device
drivers.

Signed-off-by: Long Li <longli@microsoft.com>
---
 include/linux/sched.h | 1 +
 kernel/sched/core.c   | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9b35aff09f70..575f1ef7b159 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1500,6 +1500,7 @@ current_restore_flags(unsigned long orig_flags, unsigned long flags)
 
 extern int cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
 extern int task_can_attach(struct task_struct *p, const struct cpumask *cs_cpus_allowed);
+extern u64 get_cpu_rq_switches(int cpu);
 #ifdef CONFIG_SMP
 extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask);
 extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4a8e7207cafa..1a76f0e97c2d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1143,6 +1143,12 @@ int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask)
 }
 EXPORT_SYMBOL_GPL(set_cpus_allowed_ptr);
 
+u64 get_cpu_rq_switches(int cpu)
+{
+	return cpu_rq(cpu)->nr_switches;
+}
+EXPORT_SYMBOL_GPL(get_cpu_rq_switches);
+
 void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 {
 #ifdef CONFIG_SCHED_DEBUG
-- 
2.17.1

