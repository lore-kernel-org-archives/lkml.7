Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECEDC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9688D2177E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368331;
	bh=C6LK8wUI3PaIBU6JkO7HTUg+bB3dxnTEjx2muKulzrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bx4sU9sm8In3NvhwnEtcZ1BKlDdpwSFtaC73qKzUizvQ0EFsN+jVDSsC5cqOm47QE
	 HB7qplLoyPu4EmPuffEK5sZq4PuRSxGnLbtgX0VJUAFO0wsXYYPvKs8rxoIi42N8XE
	 Hj1jkmFkUENUf1rLsNoZSsRcEG9VsU6ME76he6D8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbfDDI6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730908AbfDDI6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:58:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A51B621901;
        Thu,  4 Apr 2019 08:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368325;
        bh=C6LK8wUI3PaIBU6JkO7HTUg+bB3dxnTEjx2muKulzrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WdZJFB2ZOPXQNdufDC16qOIzdf4mhbAnWB0Z5VLsSxI/BReDkognDFafVcMQ0RAiY
         A3cjfS2XGgcQ7saNjvmnt1ghBOwRIVQLAkUM3E7milEI/y5rxJBH6rBC50nd9Ydewn
         y12ik9RjVl2hTrBoYVhQKT7eq/9OpFCKTk3ibOX0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Herton R. Krzesinski" <hkrzesin@redhat.com>,
        Jan Stancek <jstancek@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 095/121] cgroup/pids: turn cgroup_subsys->free() into cgroup_subsys->release() to fix the accounting
Date:   Thu,  4 Apr 2019 10:48:03 +0200
Message-Id: <20190404084550.486450620@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index e7905d9353e8..93a2469a9130 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -523,7 +523,7 @@ struct cgroup_subsys {
 	void (*cancel_fork)(struct task_struct *task);
 	void (*fork)(struct task_struct *task);
 	void (*exit)(struct task_struct *task);
-	void (*free)(struct task_struct *task);
+	void (*release)(struct task_struct *task);
 	void (*bind)(struct cgroup_subsys_state *root_css);
 
 	bool early_init:1;
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index dddbc29e2009..8e83c9055ccb 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -118,6 +118,7 @@ extern int cgroup_can_fork(struct task_struct *p);
 extern void cgroup_cancel_fork(struct task_struct *p);
 extern void cgroup_post_fork(struct task_struct *p);
 void cgroup_exit(struct task_struct *p);
+void cgroup_release(struct task_struct *p);
 void cgroup_free(struct task_struct *p);
 
 int cgroup_init_early(void);
@@ -668,6 +669,7 @@ static inline int cgroup_can_fork(struct task_struct *p) { return 0; }
 static inline void cgroup_cancel_fork(struct task_struct *p) {}
 static inline void cgroup_post_fork(struct task_struct *p) {}
 static inline void cgroup_exit(struct task_struct *p) {}
+static inline void cgroup_release(struct task_struct *p) {}
 static inline void cgroup_free(struct task_struct *p) {}
 
 static inline int cgroup_init_early(void) { return 0; }
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 7e79358b4473..694b1cc8d144 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -187,7 +187,7 @@ static u64 css_serial_nr_next = 1;
  */
 static u16 have_fork_callback __read_mostly;
 static u16 have_exit_callback __read_mostly;
-static u16 have_free_callback __read_mostly;
+static u16 have_release_callback __read_mostly;
 static u16 have_canfork_callback __read_mostly;
 
 /* cgroup namespace for init task */
@@ -5112,7 +5112,7 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 
 	have_fork_callback |= (bool)ss->fork << ss->id;
 	have_exit_callback |= (bool)ss->exit << ss->id;
-	have_free_callback |= (bool)ss->free << ss->id;
+	have_release_callback |= (bool)ss->release << ss->id;
 	have_canfork_callback |= (bool)ss->can_fork << ss->id;
 
 	/* At system boot, before all subsystems have been
@@ -5546,16 +5546,19 @@ void cgroup_exit(struct task_struct *tsk)
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
index 5523fb0c20c8..95ce231ff5e2 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -218,6 +218,7 @@ repeat:
 	}
 
 	write_unlock_irq(&tasklist_lock);
+	cgroup_release(p);
 	release_thread(p);
 	call_rcu(&p->rcu, delayed_put_task_struct);
 
-- 
2.19.1



