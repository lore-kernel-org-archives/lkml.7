Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73020C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 425D0206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713177;
	bh=tFeNp6xCiZeNYkO2BJ7gGcX3pgY0wjQG9gAkEM1G8oE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BHH7xeaELLqezGgJpARWL5IXD1RQGrMusA652PG20mU+JSULIU2KKJF55n4ReV4Kv
	 fDWlnqfe72M1zWKL0v3WgLL/DcvS+bOOzpnfV4l5+SpHmdqvTUiSzskgVHfXnSL/hB
	 3gtfjLRJdQzYvwR3EgrJ3ZR8T40EUIwngwdXZHvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389892AbfC0S7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:59:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389224AbfC0SPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:15:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3FB020449;
        Wed, 27 Mar 2019 18:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710505;
        bh=tFeNp6xCiZeNYkO2BJ7gGcX3pgY0wjQG9gAkEM1G8oE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Aqe7uKlF1v9ZtSuArorD4hovd/p75LtfWyEK2S4xGIzRMxMnEYw0+c2lIBaJNnfF1
         VB+6sdTtfH0M5MF59LIKRKHjKd939OTp0urQzt1p0JWj+GJbSwXDLY6OkaVF2h/qAS
         HsQoAWmRGJ5q/Th+FMj2kv7d+oyp+alH9hXzEV6A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>,
        Sasha Levin <sashal@kernel.org>, cgroups@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 149/192] cgroup/pids: turn cgroup_subsys->free() into cgroup_subsys->release() to fix the accounting
Date:   Wed, 27 Mar 2019 14:09:41 -0400
Message-Id: <20190327181025.13507-149-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleg Nesterov <oleg@redhat.com>

[ Upstream commit 51bee5abeab2058ea5813c5615d6197a23dbf041 ]

The only user of cgroup_subsys->free() callback is pids_cgrp_subsys which
needs pids_free() to uncharge the pid.

However, ->free() is called from __put_task_struct()->cgroup_free() and this
is too late. Even the trivial program which does

	for (;;) {
		int pid = fork();
		assert(pid >= 0);
		if (pid)
			wait(NULL);
		else
			exit(0);
	}

can run out of limits because release_task()->call_rcu(delayed_put_task_struct)
implies an RCU gp after the task/pid goes away and before the final put().

Test-case:

	mkdir -p /tmp/CG
	mount -t cgroup2 none /tmp/CG
	echo '+pids' > /tmp/CG/cgroup.subtree_control

	mkdir /tmp/CG/PID
	echo 2 > /tmp/CG/PID/pids.max

	perl -e 'while ($p = fork) { wait; } $p // die "fork failed: $!\n"' &
	echo $! > /tmp/CG/PID/cgroup.procs

Without this patch the forking process fails soon after migration.

Rename cgroup_subsys->free() to cgroup_subsys->release() and move the callsite
into the new helper, cgroup_release(), called by release_task() which actually
frees the pid(s).

Reported-by: Herton R. Krzesinski <hkrzesin@redhat.com>
Reported-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/cgroup-defs.h |  2 +-
 include/linux/cgroup.h      |  2 ++
 kernel/cgroup/cgroup.c      | 15 +++++++++------
 kernel/cgroup/pids.c        |  4 ++--
 kernel/exit.c               |  1 +
 5 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 22254c1fe1c5..6002275937f5 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -597,7 +597,7 @@ struct cgroup_subsys {
 	void (*cancel_fork)(struct task_struct *task);
 	void (*fork)(struct task_struct *task);
 	void (*exit)(struct task_struct *task);
-	void (*free)(struct task_struct *task);
+	void (*release)(struct task_struct *task);
 	void (*bind)(struct cgroup_subsys_state *root_css);
 
 	bool early_init:1;
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 32c553556bbd..ca51b2c15bcc 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -119,6 +119,7 @@ extern int cgroup_can_fork(struct task_struct *p);
 extern void cgroup_cancel_fork(struct task_struct *p);
 extern void cgroup_post_fork(struct task_struct *p);
 void cgroup_exit(struct task_struct *p);
+void cgroup_release(struct task_struct *p);
 void cgroup_free(struct task_struct *p);
 
 int cgroup_init_early(void);
@@ -699,6 +700,7 @@ static inline int cgroup_can_fork(struct task_struct *p) { return 0; }
 static inline void cgroup_cancel_fork(struct task_struct *p) {}
 static inline void cgroup_post_fork(struct task_struct *p) {}
 static inline void cgroup_exit(struct task_struct *p) {}
+static inline void cgroup_release(struct task_struct *p) {}
 static inline void cgroup_free(struct task_struct *p) {}
 
 static inline int cgroup_init_early(void) { return 0; }
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e710ac7fbbbf..63dae7e0ccae 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -195,7 +195,7 @@ static u64 css_serial_nr_next = 1;
  */
 static u16 have_fork_callback __read_mostly;
 static u16 have_exit_callback __read_mostly;
-static u16 have_free_callback __read_mostly;
+static u16 have_release_callback __read_mostly;
 static u16 have_canfork_callback __read_mostly;
 
 /* cgroup namespace for init task */
@@ -5240,7 +5240,7 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 
 	have_fork_callback |= (bool)ss->fork << ss->id;
 	have_exit_callback |= (bool)ss->exit << ss->id;
-	have_free_callback |= (bool)ss->free << ss->id;
+	have_release_callback |= (bool)ss->release << ss->id;
 	have_canfork_callback |= (bool)ss->can_fork << ss->id;
 
 	/* At system boot, before all subsystems have been
@@ -5676,16 +5676,19 @@ void cgroup_exit(struct task_struct *tsk)
 	} while_each_subsys_mask();
 }
 
-void cgroup_free(struct task_struct *task)
+void cgroup_release(struct task_struct *task)
 {
-	struct css_set *cset = task_css_set(task);
 	struct cgroup_subsys *ss;
 	int ssid;
 
-	do_each_subsys_mask(ss, ssid, have_free_callback) {
-		ss->free(task);
+	do_each_subsys_mask(ss, ssid, have_release_callback) {
+		ss->release(task);
 	} while_each_subsys_mask();
+}
 
+void cgroup_free(struct task_struct *task)
+{
+	struct css_set *cset = task_css_set(task);
 	put_css_set(cset);
 }
 
diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
index 9829c67ebc0a..c9960baaa14f 100644
--- a/kernel/cgroup/pids.c
+++ b/kernel/cgroup/pids.c
@@ -247,7 +247,7 @@ static void pids_cancel_fork(struct task_struct *task)
 	pids_uncharge(pids, 1);
 }
 
-static void pids_free(struct task_struct *task)
+static void pids_release(struct task_struct *task)
 {
 	struct pids_cgroup *pids = css_pids(task_css(task, pids_cgrp_id));
 
@@ -342,7 +342,7 @@ struct cgroup_subsys pids_cgrp_subsys = {
 	.cancel_attach 	= pids_cancel_attach,
 	.can_fork	= pids_can_fork,
 	.cancel_fork	= pids_cancel_fork,
-	.free		= pids_free,
+	.release	= pids_release,
 	.legacy_cftypes	= pids_files,
 	.dfl_cftypes	= pids_files,
 	.threaded	= true,
diff --git a/kernel/exit.c b/kernel/exit.c
index d607e23fd0c3..5c0964dc805a 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -219,6 +219,7 @@ void release_task(struct task_struct *p)
 	}
 
 	write_unlock_irq(&tasklist_lock);
+	cgroup_release(p);
 	release_thread(p);
 	call_rcu(&p->rcu, delayed_put_task_struct);
 
-- 
2.19.1

