Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B19C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF000214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="iaMHChIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbfFYIdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:33:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48665 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfFYIdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:33:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8WtfC3531147
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:32:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8WtfC3531147
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561451577;
        bh=aFiAewJnhCZARhf+ZqoTzp3Hdge67LZiaXUFhLNjVq4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=iaMHChIsQGB/J9h5j1v4Arkc6W0GYfdMPEmvS10ZxIPTMkDPgRCxaljU2UY2Uu2RB
         LRgKtFJM6fMnGl5LVzuGqUaSWUwEwpQx34Tber01SQEdI7hirmM0shjcvIWpA/Oz9c
         Kvl+gGXBDtEKOrws0ay3ama+cRNUjwOfZ3wH1GZ0rT0AlUboQTrY8lGKJU83W8H8UO
         zWjH3Nk1j8WSMOEeyYNSMt4tEcLnUBn4qEi8BHt3RKu8GwcudBJsasng+vKnmp/w+x
         ivNVD/t9D9AsFfV+eu9sxd058ZNXCMwW6FIsBB0x2JllNykp1WrNVqF84JgLIKB4Kq
         s2gUuKaH2gqyQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8WtUA3531144;
        Tue, 25 Jun 2019 01:32:55 -0700
Date:   Tue, 25 Jun 2019 01:32:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Patrick Bellasi <tipbot@zytor.com>
Message-ID: <tip-1d6362fa0cfc8c7b243fa92924429d826599e691@git.kernel.org>
Cc:     viresh.kumar@linaro.org, balsini@android.com, pjt@google.com,
        tkjos@google.com, tj@kernel.org, patrick.bellasi@arm.com,
        rafael.j.wysocki@intel.com, joelaf@google.com, mingo@kernel.org,
        vincent.guittot@linaro.org, surenb@google.com,
        dietmar.eggemann@arm.com, smuckle@google.com,
        torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        morten.rasmussen@arm.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, quentin.perret@arm.com,
        juri.lelli@redhat.com
Reply-To: balsini@android.com, viresh.kumar@linaro.org,
          patrick.bellasi@arm.com, tkjos@google.com, tj@kernel.org,
          pjt@google.com, mingo@kernel.org, joelaf@google.com,
          rafael.j.wysocki@intel.com, tglx@linutronix.de,
          torvalds@linux-foundation.org, smuckle@google.com,
          dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
          surenb@google.com, hpa@zytor.com, peterz@infradead.org,
          morten.rasmussen@arm.com, linux-kernel@vger.kernel.org,
          juri.lelli@redhat.com, quentin.perret@arm.com
In-Reply-To: <20190621084217.8167-6-patrick.bellasi@arm.com>
References: <20190621084217.8167-6-patrick.bellasi@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Allow sched_setattr() to use the
 current policy
Git-Commit-ID: 1d6362fa0cfc8c7b243fa92924429d826599e691
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

Commit-ID:  1d6362fa0cfc8c7b243fa92924429d826599e691
Gitweb:     https://git.kernel.org/tip/1d6362fa0cfc8c7b243fa92924429d826599e691
Author:     Patrick Bellasi <patrick.bellasi@arm.com>
AuthorDate: Fri, 21 Jun 2019 09:42:06 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 24 Jun 2019 19:23:46 +0200

sched/core: Allow sched_setattr() to use the current policy

The sched_setattr() syscall mandates that a policy is always specified.
This requires to always know which policy a task will have when
attributes are configured and this makes it impossible to add more
generic task attributes valid across different scheduling policies.
Reading the policy before setting generic tasks attributes is racy since
we cannot be sure it is not changed concurrently.

Introduce the required support to change generic task attributes without
affecting the current task policy. This is done by adding an attribute flag
(SCHED_FLAG_KEEP_POLICY) to enforce the usage of the current policy.

Add support for the SETPARAM_POLICY policy, which is already used by the
sched_setparam() POSIX syscall, to the sched_setattr() non-POSIX
syscall.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alessio Balsini <balsini@android.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Perret <quentin.perret@arm.com>
Cc: Rafael J . Wysocki <rafael.j.wysocki@intel.com>
Cc: Steve Muckle <smuckle@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Todd Kjos <tkjos@google.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://lkml.kernel.org/r/20190621084217.8167-6-patrick.bellasi@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/uapi/linux/sched.h | 4 +++-
 kernel/sched/core.c        | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index ed4ee170bee2..58b2368d3634 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -51,9 +51,11 @@
 #define SCHED_FLAG_RESET_ON_FORK	0x01
 #define SCHED_FLAG_RECLAIM		0x02
 #define SCHED_FLAG_DL_OVERRUN		0x04
+#define SCHED_FLAG_KEEP_POLICY		0x08
 
 #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
 			 SCHED_FLAG_RECLAIM		| \
-			 SCHED_FLAG_DL_OVERRUN)
+			 SCHED_FLAG_DL_OVERRUN		| \
+			 SCHED_FLAG_KEEP_POLICY)
 
 #endif /* _UAPI_LINUX_SCHED_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b74de86b68c7..6d519f3f9789 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4897,6 +4897,8 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
 
 	if ((int)attr.sched_policy < 0)
 		return -EINVAL;
+	if (attr.sched_flags & SCHED_FLAG_KEEP_POLICY)
+		attr.sched_policy = SETPARAM_POLICY;
 
 	rcu_read_lock();
 	retval = -ESRCH;
