Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0F6C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3A1206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbfCEMoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:44:23 -0500
Received: from s30320.gliwa.com ([148.251.52.238]:35572 "EHLO mail.gliwa.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728063AbfCEMoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 07:44:23 -0500
Received: by mail.gliwa.com (Postfix, from userid 992)
        id C468A340CF1; Tue,  5 Mar 2019 13:44:20 +0100 (CET)
X-Virus-Checker-Version: ClamAV 0.101.1/25379/Tue Mar 5 11:47:12 2019
X-Virus-Status: OK
Received: from claudio-HP-ProBook-470-G5.local (dslb-178-003-217-045.178.003.pools.vodafone-ip.de [178.3.217.45])
        by mail.gliwa.com (Postfix) with ESMTPSA id 83B7F34031D;
        Tue,  5 Mar 2019 13:44:20 +0100 (CET)
From:   Claudio Fontana <claudio.fontana@gliwa.com>
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrey Vagin <avagin@openvz.org>, linux-kernel@vger.kernel.org,
        Claudio Fontana <claudio.fontana@gmail.com>
Subject: [RFC] tsacct: fixup ac_pid field to contain tgid
Date:   Tue,  5 Mar 2019 13:44:17 +0100
Message-Id: <1551789857-19985-1-git-send-email-claudio.fontana@gliwa.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudio Fontana <claudio.fontana@gmail.com>

commit f3cef7a99469 ("[PATCH] csa: basic accounting over taskstats")
introduced accounting fields over taskstats,

however the ac_pid field has been filled in with the Linux pid
(the tid), instead of the POSIX pid (the tgid) like for acct.c

This change aligns the ac_pid field in tsacct with
the ac_pid field in acct.c

Signed-off-by: Claudio Fontana <claudio.fontana@gmail.com>
---
 kernel/tsacct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Hello all,

this is just to spark some responses regarding the current status
of tsacct field ac_pid, which currently is filled up with pid,
where I would expect a tgid, like for acct.c.

in acct.c:

ac.ac_pid = task_tgid_nr_ns(current, ns);

in tsacct.c:

stats->ac_pid    = task_pid_nr_ns(tsk, pid_ns);

I am trying to have a low overhead way from a C userspace program
to get the tgid given a single pid.

I have tried using the tgid map provided by ftrace, however
parsing and reparsing the text of the whole map is quite expensive.

Reading from /proc/PID/ is of higher overhead, with multiple opens,
reads and close calls necessary.

I have experimented with previous work by Andrey Vagin on
task_diag (the old and the new method), but neither is currently
upstream; one of the comments at the time mentioned that the
functionality should instead be merged into netlink taskstats.

https://criu.org/Task-diag

https://lwn.net/Articles/683371/

I think that for backward compatibility reasons, this particular
change in this RFC cannot be applied as such.

Maybe adding a new field ac_tgid would be preferable?

Maybe the information could be carried inside the NETLINK
taskstat response as an unconditional additional
TASKSTATS_TYPE_TGID field, even when the TASKSTATS_CMD_GET
requests a TASKSTATS_CMD_ATTR_PID?

Thank you and looking forward for your comments,

Claudio


diff --git a/kernel/tsacct.c b/kernel/tsacct.c
index 370724b..28ecedb 100644
--- a/kernel/tsacct.c
+++ b/kernel/tsacct.c
@@ -59,7 +59,7 @@ void bacct_add_tsk(struct user_namespace *user_ns,
 		stats->ac_flag |= AXSIG;
 	stats->ac_nice	 = task_nice(tsk);
 	stats->ac_sched	 = tsk->policy;
-	stats->ac_pid	 = task_pid_nr_ns(tsk, pid_ns);
+	stats->ac_pid	 = task_tgid_nr_ns(tsk, pid_ns);
 	rcu_read_lock();
 	tcred = __task_cred(tsk);
 	stats->ac_uid	 = from_kuid_munged(user_ns, tcred->uid);
-- 
2.7.4

