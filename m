Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F03C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E1621736
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="jVXxaRh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfDSTtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:49:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40873 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfDSTtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:49:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id d31so3062802pgl.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LpoyHi0HeGZF5U4MGNDxs/nnBmqgJD8DcpF6f/4GO14=;
        b=jVXxaRh3ynwVPNMwZpTgWyD+hmK4dveFAwXhkTehTmmH7wZa6Li3FeAKRclEYCVVgd
         5Y2A3bTAcnsOfMHQcq5qWbhiz3QSksB4mcz37epSYErjfhrU+xkwWbGfcKL5hTb+oQyf
         4KGA4QLUnCrspbM3sGo6Ge3z7VLkSI+CYMCkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LpoyHi0HeGZF5U4MGNDxs/nnBmqgJD8DcpF6f/4GO14=;
        b=hbB572CdS0btSULPLt/Nk/fJ7V7qe7R+btWW9aYKIggqm3X6sesAG2sIHRNnqIXEwb
         Kkqa367q6BU+g4607y9hZ2E7Sdyew93K8FQi+RQXdORzQNQsvi3way2dl9ZuXvENWIh7
         PJe+n+A/k2bo9QefjxK+an60PhxiP8K/qCkiaBi9DiOcb4JHiJlZVeqZQXk9zzISAB08
         xRMTAM70TA9ttgLe7Z3mMQROSzLGP9J6AYgu+jx6vtTzusDSGzQri8D3rNGI8Yf+xTqO
         +etP3Wh8GKHQKKjKTpXd85xbQHKHdRTzXLR6LSk2QUgdWYFCqZbVZnQYoKZnnFKQTe0P
         D94A==
X-Gm-Message-State: APjAAAXmv7Exv2mXXA+YcnSJkh6/XgOtTQLs+0gP5+ic9Ce86Yi4QKhb
        T28w9OhYBMEMxsBhE7Kru8XAMg==
X-Google-Smtp-Source: APXvYqxtySt/hPDC0keU0UMY3Pbx0q/itm+b5891W1vxk5u13rc6DIumWHDNc4jDpywhf5HRYufO2Q==
X-Received: by 2002:aa7:8384:: with SMTP id u4mr5741934pfm.214.1555703344461;
        Fri, 19 Apr 2019 12:49:04 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id p6sm6943696pfd.122.2019.04.19.12.49.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 12:49:03 -0700 (PDT)
Date:   Fri, 19 Apr 2019 15:49:02 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Colascione <dancol@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Nadav Amit <namit@vmware.com>, Serge Hallyn <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Taehee Yoo <ap420073@gmail.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-team <kernel-team@android.com>,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
Message-ID: <20190419194902.GE251571@google.com>
References: <20190411175043.31207-1-joel@joelfernandes.org>
 <20190416120430.GA15437@redhat.com>
 <20190416192051.GA184889@google.com>
 <20190417130940.GC32622@redhat.com>
 <CAG48ez2Q0t2-rZz8wmGeih=NigYL-CT3+E6NgiPT0AkOQAUPMQ@mail.gmail.com>
 <CEB62F51-E8BF-4EFB-B438-8AF76633FF00@brauner.io>
 <20190419190247.GB251571@google.com>
 <20190419191858.iwcvqm6fihbkaata@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419191858.iwcvqm6fihbkaata@brauner.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 09:18:59PM +0200, Christian Brauner wrote:
> On Fri, Apr 19, 2019 at 03:02:47PM -0400, Joel Fernandes wrote:
> > On Thu, Apr 18, 2019 at 07:26:44PM +0200, Christian Brauner wrote:
> > > On April 18, 2019 7:23:38 PM GMT+02:00, Jann Horn <jannh@google.com> wrote:
> > > >On Wed, Apr 17, 2019 at 3:09 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > > >> On 04/16, Joel Fernandes wrote:
> > > >> > On Tue, Apr 16, 2019 at 02:04:31PM +0200, Oleg Nesterov wrote:
> > > >> > >
> > > >> > > Could you explain when it should return POLLIN? When the whole
> > > >process exits?
> > > >> >
> > > >> > It returns POLLIN when the task is dead or doesn't exist anymore,
> > > >or when it
> > > >> > is in a zombie state and there's no other thread in the thread
> > > >group.
> > > >>
> > > >> IOW, when the whole thread group exits, so it can't be used to
> > > >monitor sub-threads.
> > > >>
> > > >> just in case... speaking of this patch it doesn't modify
> > > >proc_tid_base_operations,
> > > >> so you can't poll("/proc/sub-thread-tid") anyway, but iiuc you are
> > > >going to use
> > > >> the anonymous file returned by CLONE_PIDFD ?
> > > >
> > > >I don't think procfs works that way. /proc/sub-thread-tid has
> > > >proc_tgid_base_operations despite not being a thread group leader.
> > > >(Yes, that's kinda weird.) AFAICS the WARN_ON_ONCE() in this code can
> > > >be hit trivially, and then the code will misbehave.
> > > >
> > > >@Joel: I think you'll have to either rewrite this to explicitly bail
> > > >out if you're dealing with a thread group leader, or make the code
> > > >work for threads, too.
> > > 
> > > The latter case probably being preferred if this API is supposed to be
> > > useable for thread management in userspace.
> > 
> > At the moment, we are not planning to use this for sub-thread management. I
> > am reworking this patch to only work on clone(2) pidfds which makes the above
> 
> Indeed and agreed.
> 
> > discussion about /proc a bit unnecessary I think. Per the latest CLONE_PIDFD
> > patches, CLONE_THREAD with pidfd is not supported.
> 
> Yes. We have no one asking for it right now and we can easily add this
> later.
> 
> Admittedly I haven't gotten around to reviewing the patches here yet
> completely. But one thing about using POLLIN. FreeBSD is using POLLHUP
> on process exit which I think is nice as well. How about returning
> POLLIN | POLLHUP on process exit?
> We already do things like this. For example, when you proxy between
> ttys. If the process that you're reading data from has exited and closed
> it's end you still can't usually simply exit because it might have still
> buffered data that you want to read.  The way one can deal with this
> from  userspace is that you can observe a (POLLHUP | POLLIN) event and
> you keep on reading until you only observe a POLLHUP without a POLLIN
> event at which point you know you have read
> all data.
> I like the semantics for pidfds as well as it would indicate:
> - POLLHUP -> process has exited
> - POLLIN  -> information can be read

Actually I think a bit different about this, in my opinion the pidfd should
always be readable (we would store the exit status somewhere in the future
which would be readable, even after task_struct is dead). So I was thinking
we always return EPOLLIN.  If process has not exited, then it blocks.

However, we also are returning EPOLLERR in previous patch if the task_struct
has been reaped (task == NULL). I could change that to EPOLLHUP.

So the update patch looks like below. Thoughts?

---8<-----------------------

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 6a803a0b75df..eb279b5f4115 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3069,8 +3069,45 @@ static int proc_tgid_base_readdir(struct file *file, struct dir_context *ctx)
 				   tgid_base_stuff, ARRAY_SIZE(tgid_base_stuff));
 }
 
+static unsigned int proc_tgid_base_poll(struct file *file, struct poll_table_struct *pts)
+{
+	int poll_flags = 0;
+	struct task_struct *task;
+	struct pid *pid;
+
+	task = get_proc_task(file->f_path.dentry->d_inode);
+
+	WARN_ON_ONCE(task && !thread_group_leader(task));
+
+	/*
+	 * tasklist_lock must be held because to avoid racing with
+	 * changes in exit_state and wake up. Basically to avoid:
+	 *
+	 * P0: read exit_state = 0
+	 * P1: write exit_state = EXIT_DEAD
+	 * P1: Do a wake up - wq is empty, so do nothing
+	 * P0: Queue for polling - wait forever.
+	 */
+	read_lock(&tasklist_lock);
+	if (!task)
+		poll_flags = POLLIN | POLLRDNORM | POLLHUP;
+	else if (task->exit_state && thread_group_empty(task))
+		poll_flags = POLLIN | POLLRDNORM;
+
+	if (!poll_flags) {
+		pid = proc_pid(file->f_path.dentry->d_inode);
+		poll_wait(file, &pid->wait_pidfd, pts);
+	}
+	read_unlock(&tasklist_lock);
+
+	if (task)
+		put_task_struct(task);
+	return poll_flags;
+}
+
 static const struct file_operations proc_tgid_base_operations = {
 	.read		= generic_read_dir,
+	.poll		= proc_tgid_base_poll,
 	.iterate_shared	= proc_tgid_base_readdir,
 	.llseek		= generic_file_llseek,
 };
diff --git a/include/linux/pid.h b/include/linux/pid.h
index b6f4ba16065a..2e0dcbc6d14e 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -3,6 +3,7 @@
 #define _LINUX_PID_H
 
 #include <linux/rculist.h>
+#include <linux/wait.h>
 
 enum pid_type
 {
@@ -60,6 +61,8 @@ struct pid
 	unsigned int level;
 	/* lists of tasks that use this pid */
 	struct hlist_head tasks[PIDTYPE_MAX];
+	/* wait queue for pidfd pollers */
+	wait_queue_head_t wait_pidfd;
 	struct rcu_head rcu;
 	struct upid numbers[1];
 };
diff --git a/kernel/pid.c b/kernel/pid.c
index 20881598bdfa..5c90c239242f 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -214,6 +214,8 @@ struct pid *alloc_pid(struct pid_namespace *ns)
 	for (type = 0; type < PIDTYPE_MAX; ++type)
 		INIT_HLIST_HEAD(&pid->tasks[type]);
 
+	init_waitqueue_head(&pid->wait_pidfd);
+
 	upid = pid->numbers + ns->level;
 	spin_lock_irq(&pidmap_lock);
 	if (!(ns->pid_allocated & PIDNS_ADDING))
diff --git a/kernel/signal.c b/kernel/signal.c
index f98448cf2def..e3781703ef7e 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1800,6 +1800,17 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 	return ret;
 }
 
+static void do_wakeup_pidfd_pollers(struct task_struct *task)
+{
+	struct pid *pid;
+
+	lockdep_assert_held(&tasklist_lock);
+
+	pid = get_task_pid(task, PIDTYPE_PID);
+	wake_up_all(&pid->wait_pidfd);
+	put_pid(pid);
+}
+
 /*
  * Let a parent know about the death of a child.
  * For a stopped/continued status change, use do_notify_parent_cldstop instead.
@@ -1823,6 +1834,9 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 	BUG_ON(!tsk->ptrace &&
 	       (tsk->group_leader != tsk || !thread_group_empty(tsk)));
 
+	/* Wake up all pidfd waiters */
+	do_wakeup_pidfd_pollers(tsk);
+
 	if (sig != SIGCHLD) {
 		/*
 		 * This is only possible if parent == real_parent.
diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
index deaf8073bc06..4b31c14f273c 100644
--- a/tools/testing/selftests/pidfd/Makefile
+++ b/tools/testing/selftests/pidfd/Makefile
@@ -1,4 +1,4 @@
-CFLAGS += -g -I../../../../usr/include/
+CFLAGS += -g -I../../../../usr/include/ -lpthread
 
 TEST_GEN_PROGS := pidfd_test
 
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index d59378a93782..57ae217339e9 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -4,18 +4,26 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/types.h>
+#include <pthread.h>
 #include <sched.h>
 #include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <syscall.h>
+#include <sys/epoll.h>
+#include <sys/mman.h>
 #include <sys/mount.h>
 #include <sys/wait.h>
+#include <time.h>
 #include <unistd.h>
 
 #include "../kselftest.h"
 
+#define CHILD_THREAD_MIN_WAIT 3 /* seconds */
+#define MAX_EVENTS 5
+#define __NR_pidfd_send_signal 424
+
 static inline int sys_pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
 					unsigned int flags)
 {
@@ -30,6 +38,22 @@ static void set_signal_received_on_sigusr1(int sig)
 		signal_received = 1;
 }
 
+static int open_pidfd(const char *test_name, pid_t pid)
+{
+	char buf[256];
+	int pidfd;
+
+	snprintf(buf, sizeof(buf), "/proc/%d", pid);
+	pidfd = open(buf, O_DIRECTORY | O_CLOEXEC);
+
+	if (pidfd < 0)
+		ksft_exit_fail_msg(
+			"%s test: Failed to open process file descriptor\n",
+			test_name);
+
+	return pidfd;
+}
+
 /*
  * Straightforward test to see whether pidfd_send_signal() works is to send
  * a signal to ourself.
@@ -87,7 +111,6 @@ static int wait_for_pid(pid_t pid)
 static int test_pidfd_send_signal_exited_fail(void)
 {
 	int pidfd, ret, saved_errno;
-	char buf[256];
 	pid_t pid;
 	const char *test_name = "pidfd_send_signal signal exited process";
 
@@ -99,17 +122,10 @@ static int test_pidfd_send_signal_exited_fail(void)
 	if (pid == 0)
 		_exit(EXIT_SUCCESS);
 
-	snprintf(buf, sizeof(buf), "/proc/%d", pid);
-
-	pidfd = open(buf, O_DIRECTORY | O_CLOEXEC);
+	pidfd = open_pidfd(test_name, pid);
 
 	(void)wait_for_pid(pid);
 
-	if (pidfd < 0)
-		ksft_exit_fail_msg(
-			"%s test: Failed to open process file descriptor\n",
-			test_name);
-
 	ret = sys_pidfd_send_signal(pidfd, 0, NULL, 0);
 	saved_errno = errno;
 	close(pidfd);
@@ -368,10 +384,179 @@ static int test_pidfd_send_signal_syscall_support(void)
 	return 0;
 }
 
+void *test_pidfd_poll_exec_thread(void *priv)
+{
+	char waittime[256];
+
+	ksft_print_msg("Child Thread: starting. pid %d tid %d ; and sleeping\n",
+			getpid(), syscall(SYS_gettid));
+	ksft_print_msg("Child Thread: doing exec of sleep\n");
+
+	sprintf(waittime, "%d", CHILD_THREAD_MIN_WAIT);
+	execl("/bin/sleep", "sleep", waittime, (char *)NULL);
+
+	ksft_print_msg("Child Thread: DONE. pid %d tid %d\n",
+			getpid(), syscall(SYS_gettid));
+	return NULL;
+}
+
+static int poll_pidfd(const char *test_name, int pidfd)
+{
+	int c;
+	int epoll_fd = epoll_create1(0);
+	struct epoll_event event, events[MAX_EVENTS];
+
+	if (epoll_fd == -1)
+		ksft_exit_fail_msg("%s test: Failed to create epoll file descriptor\n",
+				   test_name);
+
+	event.events = EPOLLIN;
+	event.data.fd = pidfd;
+
+	if (epoll_ctl(epoll_fd, EPOLL_CTL_ADD, pidfd, &event)) {
+		ksft_print_msg("%s test: Failed to add epoll file descriptor: Skipping\n",
+			       test_name);
+		_exit(PIDFD_SKIP);
+	}
+
+	c = epoll_wait(epoll_fd, events, MAX_EVENTS, 5000);
+	if (c != 1 || !(events[0].events & EPOLLIN))
+		ksft_exit_fail_msg("%s test: Unexpected epoll_wait result (c=%d, events=%x)\n",
+				   test_name, c, events[0].events);
+
+	close(epoll_fd);
+	return events[0].events;
+
+}
+
+int test_pidfd_poll_exec(int use_waitpid)
+{
+	int pid, pidfd;
+	int status, ret;
+	pthread_t t1;
+	time_t prog_start = time(NULL);
+	const char *test_name = "pidfd_poll check for premature notification on child thread exec";
+
+	ksft_print_msg("Parent: pid: %d\n", getpid());
+	pid = fork();
+	if (pid == 0) {
+		ksft_print_msg("Child: starting. pid %d tid %d\n", getpid(),
+				syscall(SYS_gettid));
+		pthread_create(&t1, NULL, test_pidfd_poll_exec_thread, NULL);
+		/*
+		 * Exec in the non-leader thread will destroy the leader immediately.
+		 * If the wait in the parent returns too soon, the test fails.
+		 */
+		while (1)
+			;
+	}
+
+	ksft_print_msg("Parent: Waiting for Child (%d) to complete.\n", pid);
+
+	if (use_waitpid) {
+		ret = waitpid(pid, &status, 0);
+		if (ret == -1)
+			ksft_print_msg("Parent: error\n");
+
+		if (ret == pid)
+			ksft_print_msg("Parent: Child process waited for.\n");
+	} else {
+		pidfd = open_pidfd(test_name, pid);
+		poll_pidfd(test_name, pidfd);
+	}
+
+	time_t prog_time = time(NULL) - prog_start;
+
+	ksft_print_msg("Time waited for child: %lu\n", prog_time);
+
+	close(pidfd);
+
+	if (prog_time < CHILD_THREAD_MIN_WAIT || prog_time > CHILD_THREAD_MIN_WAIT + 2)
+		ksft_exit_fail_msg("%s test: Failed\n", test_name);
+	else
+		ksft_test_result_pass("%s test: Passed\n", test_name);
+}
+
+void *test_pidfd_poll_leader_exit_thread(void *priv)
+{
+	char waittime[256];
+
+	ksft_print_msg("Child Thread: starting. pid %d tid %d ; and sleeping\n",
+			getpid(), syscall(SYS_gettid));
+	sleep(CHILD_THREAD_MIN_WAIT);
+	ksft_print_msg("Child Thread: DONE. pid %d tid %d\n", getpid(), syscall(SYS_gettid));
+	return NULL;
+}
+
+static time_t *child_exit_secs;
+int test_pidfd_poll_leader_exit(int use_waitpid)
+{
+	int pid, pidfd;
+	int status, ret;
+	pthread_t t1, t2;
+	time_t prog_start = time(NULL);
+	const char *test_name = "pidfd_poll check for premature notification on non-empty"
+				"group leader exit";
+
+	child_exit_secs = mmap(NULL, sizeof *child_exit_secs, PROT_READ | PROT_WRITE,
+			MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+
+	ksft_print_msg("Parent: pid: %d\n", getpid());
+	pid = fork();
+	if (pid == 0) {
+		ksft_print_msg("Child: starting. pid %d tid %d\n", getpid(), syscall(SYS_gettid));
+		pthread_create(&t1, NULL, test_pidfd_poll_leader_exit_thread, NULL);
+		pthread_create(&t2, NULL, test_pidfd_poll_leader_exit_thread, NULL);
+
+		/*
+		 * glibc exit calls exit_group syscall, so explicity call exit only
+		 * so that only the group leader exits, leaving the threads alone.
+		 */
+		*child_exit_secs = time(NULL);
+		syscall(SYS_exit, 0);
+	}
+
+	ksft_print_msg("Parent: Waiting for Child (%d) to complete.\n", pid);
+
+	if (use_waitpid) {
+		ret = waitpid(pid, &status, 0);
+		if (ret == -1)
+			ksft_print_msg("Parent: error\n");
+	} else {
+		/*
+		 * This sleep tests for the case where if the child exits, and is in
+		 * EXIT_ZOMBIE, but the thread group leader is non-empty, then the poll
+		 * doesn't prematurely return even though there are active threads
+		 */
+		sleep(1);
+		pidfd = open_pidfd(test_name, pid);
+		poll_pidfd(test_name, pidfd);
+	}
+
+	if (ret == pid)
+		ksft_print_msg("Parent: Child process waited for.\n");
+
+	time_t since_child_exit = time(NULL) - *child_exit_secs;
+
+	ksft_print_msg("Time since child exit: %lu\n", since_child_exit);
+
+	close(pidfd);
+
+	if (since_child_exit < CHILD_THREAD_MIN_WAIT ||
+			since_child_exit > CHILD_THREAD_MIN_WAIT + 2)
+		ksft_exit_fail_msg("%s test: Failed\n", test_name);
+	else
+		ksft_test_result_pass("%s test: Passed\n", test_name);
+}
+
 int main(int argc, char **argv)
 {
 	ksft_print_header();
 
+	test_pidfd_poll_exec(0);
+	test_pidfd_poll_exec(1);
+	test_pidfd_poll_leader_exit(0);
+	test_pidfd_poll_leader_exit(1);
 	test_pidfd_send_signal_syscall_support();
 	test_pidfd_send_signal_simple_success();
 	test_pidfd_send_signal_exited_fail();
