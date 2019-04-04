Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9ACC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967E42054F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369403;
	bh=BaTOscRvP/3TwjepuMepZt9ssror7ywwkasILrDryxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bvHYB0XAVPI6bFqxf3tMxB7264pjz0Cqd9muEK/osDMUbTlVndxjF/si8qmLwlMn4
	 Kw59XkFtAWUPmLueNjbhfs7x6woWLN1F1Vg+f6QTG48DoqwqGe98iAf/JUYJmBW8Hs
	 Ut04bwQ5mrX+fglUteT3FXI1coKUlX09CSemDYEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388100AbfDDJQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:16:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388075AbfDDJQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:16:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1620220820;
        Thu,  4 Apr 2019 09:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369392;
        bh=BaTOscRvP/3TwjepuMepZt9ssror7ywwkasILrDryxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ha6RuFHiCk8Jbh/v213XDolwbe45wblYxCFpLtP3DGlWZUThj0rvt4EANqVccKjdZ
         1u9fktJx12cqZWbpgNjaFXQ0pPOl957PPf8/IFnkZkhWY4dtGCsPet0irDh5Bet3tJ
         vPgB3S5WKOUJxUmPdZhrmLKZIUtgqxSlmkjKnbOQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Herton R. Krzesinski" <hkrzesin@redhat.com>,
        Jan Stancek <jstancek@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 191/246] cgroup/pids: turn cgroup_subsys->free() into cgroup_subsys->release() to fix the accounting
Date:   Thu,  4 Apr 2019 10:48:11 +0200
Message-Id: <20190404084625.873080315@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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
index 8fcbae1b8db0..120d1d40704b 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -602,7 +602,7 @@ struct cgroup_subsys {
 	void (*cancel_fork)(struct task_struct *task);
 	void (*fork)(struct task_struct *task);
 	void (*exit)(struct task_struct *task);
-	void (*free)(struct task_struct *task);
+	void (*release)(struct task_struct *task);
 	void (*bind)(struct cgroup_subsys_state *root_css);
 
 	bool early_init:1;
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 9968332cceed..81f58b4a5418 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -121,6 +121,7 @@ extern int cgroup_can_fork(struct task_struct *p);
 extern void cgroup_cancel_fork(struct task_struct *p);
 extern void cgroup_post_fork(struct task_struct *p);
 void cgroup_exit(struct task_struct *p);
+void cgroup_release(struct task_struct *p);
 void cgroup_free(struct task_struct *p);
 
 int cgroup_init_early(void);
@@ -697,6 +698,7 @@ static inline int cgroup_can_fork(struct task_struct *p) { return 0; }
 static inline void cgroup_cancel_fork(struct task_struct *p) {}
 static inline void cgroup_post_fork(struct task_struct *p) {}
 static inline void cgroup_exit(struct task_struct *p) {}
+static inline void cgroup_release(struct task_struct *p) {}
 static inline void cgroup_free(struct task_struct *p) {}
 
 static inline int cgroup_init_early(void) { return 0; }
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 503bba3c4bae..f84bf28f36ba 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -197,7 +197,7 @@ static u64 css_serial_nr_next = 1;
  */
 static u16 have_fork_callback __read_mostly;
 static u16 have_exit_callback __read_mostly;
-static u16 have_free_callback __read_mostly;
+static u16 have_release_callback __read_mostly;
 static u16 have_canfork_callback __read_mostly;
 
 /* cgroup namespace for init task */
@@ -5316,7 +5316,7 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 
 	have_fork_callback |= (bool)ss->fork << ss->id;
 	have_exit_callback |= (bool)ss->exit << ss->id;
-	have_free_callback |= (bool)ss->free << ss->id;
+	have_release_callback |= (bool)ss->release << ss->id;
 	have_canfork_callback |= (bool)ss->can_fork << ss->id;
 
 	/* At system boot, before all subsystems have been
@@ -5752,16 +5752,19 @@ void cgroup_exit(struct task_struct *tsk)
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
index 2639a30a8aa5..2166c2d92ddc 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -219,6 +219,7 @@ repeat:
 	}
 
 	write_unlock_irq(&tasklist_lock);
+	cgroup_release(p);
 	release_thread(p);
 	call_rcu(&p->rcu, delayed_put_task_struct);
 
-- 
2.19.1



