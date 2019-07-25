Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C2DC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFC522BED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="pt9Qj6Kr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390581AbfGYQ0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:26:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35641 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388480AbfGYQ0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:26:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PGPgaC1078651
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:25:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PGPgaC1078651
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564071943;
        bh=vrwpouAJzGwAjN3WnIO2pOCy/oOTZngfJ5RVKPVUTGQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=pt9Qj6Kruoy8bUGYXIxzfuZKqicXJSBMfaC9ixcdnTUf0NhaYXx0IpMhuUmnXLgdG
         wfrGaEVBrpRZnoVC9RySjWwn7/KWj77vUBdgVZa1WJAeGhpKWeHJJZuYqGMwlnA7G/
         qu5iRwOlLDJspR47iikL3QgB3AMX4xDdEkeFoe4iuzVZ6Lbc8Evd0UNqP/43Tb7AMc
         zKgPH/acTh2lMa74wtuNCEgeJytsyuL9XApCUmNk4cTKPNMgTVEVz66iRIWaOdPM0X
         99JhDZXX2hZIamCZXBY/kjxyfGna/6X5dhhhSKj6YRRz3qEq3DoWQdHVw4pMANAkCB
         4sFEXsytl/VwQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PGPgm41078648;
        Thu, 25 Jul 2019 09:25:42 -0700
Date:   Thu, 25 Jul 2019 09:25:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juri Lelli <tipbot@zytor.com>
Message-ID: <tip-a07db5c0865799ebed1f88be0df50c581fb65029@git.kernel.org>
Cc:     torvalds@linux-foundation.org, bristot@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        mingo@kernel.org, tglx@linutronix.de, tj@kernel.org,
        peterz@infradead.org, mkoutny@suse.com
Reply-To: juri.lelli@redhat.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          bristot@redhat.com, tj@kernel.org, tglx@linutronix.de,
          mingo@kernel.org, mkoutny@suse.com, peterz@infradead.org
In-Reply-To: <20190719063455.27328-1-juri.lelli@redhat.com>
References: <20190719063455.27328-1-juri.lelli@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Fix CPU controller for !RT_GROUP_SCHED
Git-Commit-ID: a07db5c0865799ebed1f88be0df50c581fb65029
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

Commit-ID:  a07db5c0865799ebed1f88be0df50c581fb65029
Gitweb:     https://git.kernel.org/tip/a07db5c0865799ebed1f88be0df50c581fb65029
Author:     Juri Lelli <juri.lelli@redhat.com>
AuthorDate: Fri, 19 Jul 2019 08:34:55 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:55:05 +0200

sched/core: Fix CPU controller for !RT_GROUP_SCHED

On !CONFIG_RT_GROUP_SCHED configurations it is currently not possible to
move RT tasks between cgroups to which CPU controller has been attached;
but it is oddly possible to first move tasks around and then make them
RT (setschedule to FIFO/RR).

E.g.:

  # mkdir /sys/fs/cgroup/cpu,cpuacct/group1
  # chrt -fp 10 $$
  # echo $$ > /sys/fs/cgroup/cpu,cpuacct/group1/tasks
  bash: echo: write error: Invalid argument
  # chrt -op 0 $$
  # echo $$ > /sys/fs/cgroup/cpu,cpuacct/group1/tasks
  # chrt -fp 10 $$
  # cat /sys/fs/cgroup/cpu,cpuacct/group1/tasks
  2345
  2598
  # chrt -p 2345
  pid 2345's current scheduling policy: SCHED_FIFO
  pid 2345's current scheduling priority: 10

Also, as Michal noted, it is currently not possible to enable CPU
controller on unified hierarchy with !CONFIG_RT_GROUP_SCHED (if there
are any kernel RT threads in root cgroup, they can't be migrated to the
newly created CPU controller's root in cgroup_update_dfl_csses()).

Existing code comes with a comment saying the "we don't support RT-tasks
being in separate groups". Such comment is however stale and belongs to
pre-RT_GROUP_SCHED times. Also, it doesn't make much sense for
!RT_GROUP_ SCHED configurations, since checks related to RT bandwidth
are not performed at all in these cases.

Make moving RT tasks between CPU controller groups viable by removing
special case check for RT (and DEADLINE) tasks.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: lizefan@huawei.com
Cc: longman@redhat.com
Cc: luca.abeni@santannapisa.it
Cc: rostedt@goodmis.org
Link: https://lkml.kernel.org/r/20190719063455.27328-1-juri.lelli@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1bceb22dac18..042c736b2b73 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6995,10 +6995,6 @@ static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
 #ifdef CONFIG_RT_GROUP_SCHED
 		if (!sched_rt_can_attach(css_tg(css), task))
 			return -EINVAL;
-#else
-		/* We don't support RT-tasks being in separate groups */
-		if (task->sched_class != &fair_sched_class)
-			return -EINVAL;
 #endif
 		/*
 		 * Serialize against wake_up_new_task() such that if its
