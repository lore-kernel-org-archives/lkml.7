Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F57C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB12420675
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="TSO6VFlf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbfDYV3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:29:23 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46816 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfDYV3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:29:23 -0400
Received: by mail-ed1-f65.google.com with SMTP id d1so1277564edd.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 14:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uWdRNvE8zIPF4zMOJg1Oc84hEmqCkyg/mKjJae2WQ0M=;
        b=TSO6VFlfLFHzPn6bUYl8U5PwU0zeggCftD36TTxmjfvZ2wFrnYDeHMVPix8vuyANwg
         64QJsqFSJdoQ1JPMHpyqtcRJJB37AtxtkM2Yy+AJqxoDQcn70QdNksG4ZcLQKIZNfxn1
         JmCJ182E4TdFvs4tOq6wCend+ot5q29Et38XaKG0zVZTzmpjlCOATUkKYCV0WuXoQUbT
         Fxs6hw1OWK9nNjzchXyN8sYRPz8OQhJfbzSPwLxGyp0bZFZTH/WzZUhqN0Xj2z7HUuXo
         Rngs2EsAaIrEZCR8qfDcc7R6IxQHiZA2drMWGFe+wmSWV+mAUJ3t5WtTJKTcIz80FpQy
         aWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uWdRNvE8zIPF4zMOJg1Oc84hEmqCkyg/mKjJae2WQ0M=;
        b=RPzf6g1aTcDSD42xSqNF5e3geGPps/vEsM/zsrTVrmm0J6WCfh5ApdHq2O2hPa3j61
         AH4hVZyLTYEYaW/aYkPHIKNSnxeGAxHFKZc3NFtLiz+zX+QB08V+PjL+ChaPTkyfTwig
         Dxf9GHlXd2Kvv/jXkzQNu4PXI+n5OiWfw5O85SkNee5CJw4ioIOM3KKO3Y+zxUUlnTtv
         cMUOpevt9MXMCqs05Qa6Zxjj5kyxle1I5e8CYEpJ739JmwGtEizwtEXrM7vh8iskMn3q
         vJA0kQO7evGTBA/IVxcTVVH1mLASBrouXwFQ+VmdiLVXggrwfFXS/08P7yjULE83eKE/
         BekA==
X-Gm-Message-State: APjAAAVcRtm9aE2dHFoI1nWovTY5CzlO4wcelqZNOLUyZgxMRXP2/dgk
        9kdAOsgfCIdOPMHEHDb3MMJQJQ==
X-Google-Smtp-Source: APXvYqxa46jgzGRxHuwmynngPfFDKUBcUsZWyECDsn/pMcQpRu9smENDIPRqM3rN+NELdKeUq3i4oA==
X-Received: by 2002:a50:a945:: with SMTP id m5mr18698454edc.207.1556227760651;
        Thu, 25 Apr 2019 14:29:20 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id l22sm4224693eja.67.2019.04.25.14.29.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 14:29:19 -0700 (PDT)
Date:   Thu, 25 Apr 2019 23:29:18 +0200
From:   Christian Brauner <christian@brauner.io>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, dancol@google.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, jannh@google.com,
        Jann Horn <jann@thejh.net>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        kernel-team@android.com, linux-kselftest@vger.kernel.org,
        luto@amacapital.net, Michal Hocko <mhocko@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        rostedt@goodmis.org, Serge Hallyn <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>, sspatil@google.com,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, timmurray@google.com,
        torvalds@linux-foundation.org, Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH v1 2/2] Add selftests for pidfd polling
Message-ID: <20190425212917.yotnir4uqgpnh764@brauner.io>
References: <20190425190010.46489-1-joel@joelfernandes.org>
 <20190425190010.46489-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190425190010.46489-2-joel@joelfernandes.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 03:00:10PM -0400, Joel Fernandes (Google) wrote:
> Other than verifying pidfd based polling, the tests make sure that
> wait semantics are preserved with the pidfd poll. Notably the 2 cases:
> 1. If a thread group leader exits while threads still there, then no
>    pidfd poll notifcation should happen.
> 2. If a non-thread group leader does an execve, then the thread group
>    leader is signaled to exit and is replaced with the execing thread
>    as the new leader, however the parent is not notified in this case.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  tools/testing/selftests/pidfd/Makefile     |   2 +-
>  tools/testing/selftests/pidfd/pidfd_test.c | 198 +++++++++++++++++++++
>  2 files changed, 199 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
> index deaf8073bc06..4b31c14f273c 100644
> --- a/tools/testing/selftests/pidfd/Makefile
> +++ b/tools/testing/selftests/pidfd/Makefile
> @@ -1,4 +1,4 @@
> -CFLAGS += -g -I../../../../usr/include/
> +CFLAGS += -g -I../../../../usr/include/ -lpthread
>  
>  TEST_GEN_PROGS := pidfd_test
>  
> diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
> index d59378a93782..e887f807645e 100644
> --- a/tools/testing/selftests/pidfd/pidfd_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_test.c
> @@ -4,18 +4,42 @@
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <linux/types.h>
> +#include <pthread.h>
>  #include <sched.h>
>  #include <signal.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <syscall.h>
> +#include <sys/epoll.h>
> +#include <sys/mman.h>
>  #include <sys/mount.h>
>  #include <sys/wait.h>
> +#include <time.h>
>  #include <unistd.h>
>  
>  #include "../kselftest.h"
>  
> +#define CHILD_THREAD_MIN_WAIT 3 /* seconds */
> +#define MAX_EVENTS 5
> +#define __NR_pidfd_send_signal 424

Should probably be ifndefed as well.

> +
> +#ifndef CLONE_PIDFD
> +#define CLONE_PIDFD 0x00001000
> +#endif
> +
> +static pid_t pidfd_clone(int flags, int *pidfd, int (*fn)(void *))
> +{
> +	size_t stack_size = 1024;
> +	char *stack[1024] = { 0 };
> +
> +#ifdef __ia64__
> +	return __clone2(fn, stack, stack_size, flags | SIGCHLD, NULL, pidfd);
> +#else
> +	return clone(fn, stack + stack_size, flags | SIGCHLD, NULL, pidfd);
> +#endif
> +}
> +
>  static inline int sys_pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
>  					unsigned int flags)
>  {
> @@ -368,10 +392,184 @@ static int test_pidfd_send_signal_syscall_support(void)
>  	return 0;
>  }
>  
> +void *test_pidfd_poll_exec_thread(void *priv)
> +{
> +	char waittime[256];
> +
> +	ksft_print_msg("Child Thread: starting. pid %d tid %d ; and sleeping\n",
> +			getpid(), syscall(SYS_gettid));
> +	ksft_print_msg("Child Thread: doing exec of sleep\n");
> +
> +	sprintf(waittime, "%d", CHILD_THREAD_MIN_WAIT);

> +#define CHILD_THREAD_MIN_SLEEP "3" /* seconds */

Could also be

#define str(s) _str(s)
#define _str(s) #s
#define CHILD_THREAD_MIN_SLEEP 3

execl("/bin/sleep", "sleep", str(CHILD_THREAD_MIN_SLEEP), (char *)NULL);

getting rid of waittime, and snprintf().

> +	execl("/bin/sleep", "sleep", waittime, (char *)NULL);
> +
> +	ksft_print_msg("Child Thread: DONE. pid %d tid %d\n",
> +			getpid(), syscall(SYS_gettid));
> +	return NULL;
> +}
> +
> +static int poll_pidfd(const char *test_name, int pidfd)
> +{
> +	int c;
> +	int epoll_fd = epoll_create1(0);

You probably don't need the epoll_fd after an exec, so:
int epoll_fd = epoll_create1(EPOLL_CLOEXEC);

> +	struct epoll_event event, events[MAX_EVENTS];
> +
> +	if (epoll_fd == -1)
> +		ksft_exit_fail_msg("%s test: Failed to create epoll file descriptor\n",
> +				   test_name);

I think logging the errno is helpful here. 

> +
> +	event.events = EPOLLIN;
> +	event.data.fd = pidfd;
> +
> +	if (epoll_ctl(epoll_fd, EPOLL_CTL_ADD, pidfd, &event)) {
> +		ksft_print_msg("%s test: Failed to add epoll file descriptor: Skipping\n",
> +			       test_name);

I think logging the errno is helpful here. 

> +		_exit(PIDFD_SKIP);

Why do you skip when you can't add the pidfd to the epoll loop? Why
shouldn't this be a test failure?

> +	}
> +
> +	c = epoll_wait(epoll_fd, events, MAX_EVENTS, 5000);

Uhm 5000 timeout? Either do a -1 or something that is noticeably
shorter, please. :)

> +	if (c != 1 || !(events[0].events & EPOLLIN))
> +		ksft_exit_fail_msg("%s test: Unexpected epoll_wait result (c=%d, events=%x)\n",
> +				   test_name, c, events[0].events);

I think logging the errno is helpful here. 

> +
> +	close(epoll_fd);
> +	return events[0].events;
> +
> +}
> +
> +static int child_poll_exec_test(void *args)
> +{
> +	pthread_t t1;
> +
> +	ksft_print_msg("Child (pidfd): starting. pid %d tid %d\n", getpid(),
> +			syscall(SYS_gettid));
> +	pthread_create(&t1, NULL, test_pidfd_poll_exec_thread, NULL);
> +	/*
> +	 * Exec in the non-leader thread will destroy the leader immediately.
> +	 * If the wait in the parent returns too soon, the test fails.
> +	 */
> +	while (1)
> +		;

Wouldn't sleep(<some-value>) be better here or at least a:

while (true)
        sleep(<some-sensible-value);

instead of a busy loop?

> +}
> +
> +int test_pidfd_poll_exec(int use_waitpid)
> +{
> +	int pid, pidfd = 0;
> +	int status, ret;
> +	pthread_t t1;
> +	time_t prog_start = time(NULL);
> +	const char *test_name = "pidfd_poll check for premature notification on child thread exec";
> +
> +	ksft_print_msg("Parent: pid: %d\n", getpid());
> +	pid = pidfd_clone(CLONE_PIDFD, &pidfd, child_poll_exec_test);

That needs to check for error aka
if (pid < 0)
I think Tycho mentioned this already.

> +
> +	ksft_print_msg("Parent: Waiting for Child (%d) to complete.\n", pid);
> +
> +	if (use_waitpid) {
> +		ret = waitpid(pid, &status, 0);
> +		if (ret == -1)
> +			ksft_print_msg("Parent: error\n");
> +
> +		if (ret == pid)
> +			ksft_print_msg("Parent: Child process waited for.\n");
> +	} else {
> +		poll_pidfd(test_name, pidfd);

Either make poll_pidfd() void or check the error value. One of the two.

> +	}
> +
> +	time_t prog_time = time(NULL) - prog_start;
> +
> +	ksft_print_msg("Time waited for child: %lu\n", prog_time);
> +
> +	close(pidfd);
> +
> +	if (prog_time < CHILD_THREAD_MIN_WAIT || prog_time > CHILD_THREAD_MIN_WAIT + 2)

This timing-based testing seems kinda odd to be honest. Can't we do
something better than this?

> +		ksft_exit_fail_msg("%s test: Failed\n", test_name);
> +	else
> +		ksft_test_result_pass("%s test: Passed\n", test_name);
> +}
> +
> +void *test_pidfd_poll_leader_exit_thread(void *priv)
> +{
> +	char waittime[256];

Unused variable

> +
> +	ksft_print_msg("Child Thread: starting. pid %d tid %d ; and sleeping\n",
> +			getpid(), syscall(SYS_gettid));
> +	sleep(CHILD_THREAD_MIN_WAIT);
> +	ksft_print_msg("Child Thread: DONE. pid %d tid %d\n", getpid(), syscall(SYS_gettid));
> +	return NULL;
> +}
> +
> +static time_t *child_exit_secs;
> +static int child_poll_leader_exit_test(void *args)
> +{
> +	pthread_t t1, t2;
> +
> +	ksft_print_msg("Child: starting. pid %d tid %d\n", getpid(), syscall(SYS_gettid));
> +	pthread_create(&t1, NULL, test_pidfd_poll_leader_exit_thread, NULL);
> +	pthread_create(&t2, NULL, test_pidfd_poll_leader_exit_thread, NULL);
> +
> +	/*
> +	 * glibc exit calls exit_group syscall, so explicity call exit only
> +	 * so that only the group leader exits, leaving the threads alone.
> +	 */
> +	*child_exit_secs = time(NULL);
> +	syscall(SYS_exit, 0);
> +}
> +
> +int test_pidfd_poll_leader_exit(int use_waitpid)

static

> +{
> +	int pid, pidfd = 0;
> +	int status, ret;
> +	time_t prog_start = time(NULL);
> +	const char *test_name = "pidfd_poll check for premature notification on non-empty"
> +				"group leader exit";
> +
> +	child_exit_secs = mmap(NULL, sizeof *child_exit_secs, PROT_READ | PROT_WRITE,
> +			MAP_SHARED | MAP_ANONYMOUS, -1, 0);

Error checking, please:

if (child_exit_secs == MAP_FAILED)

> +
> +	ksft_print_msg("Parent: pid: %d\n", getpid());
> +	pid = pidfd_clone(CLONE_PIDFD, &pidfd, child_poll_leader_exit_test);

Error checking, please:

if (pid < 0)

> +
> +	ksft_print_msg("Parent: Waiting for Child (%d) to complete.\n", pid);
> +
> +	if (use_waitpid) {
> +		ret = waitpid(pid, &status, 0);
> +		if (ret == -1)
> +			ksft_print_msg("Parent: error\n");
> +	} else {
> +		/*
> +		 * This sleep tests for the case where if the child exits, and is in
> +		 * EXIT_ZOMBIE, but the thread group leader is non-empty, then the poll
> +		 * doesn't prematurely return even though there are active threads
> +		 */
> +		sleep(1);
> +		poll_pidfd(test_name, pidfd);

Make poll_pidfd() void or check error, please.

> +	}
> +
> +	if (ret == pid)
> +		ksft_print_msg("Parent: Child process waited for.\n");
> +
> +	time_t since_child_exit = time(NULL) - *child_exit_secs;
> +
> +	ksft_print_msg("Time since child exit: %lu\n", since_child_exit);
> +
> +	close(pidfd);
> +
> +	if (since_child_exit < CHILD_THREAD_MIN_WAIT ||
> +			since_child_exit > CHILD_THREAD_MIN_WAIT + 2)

This looks very magical. Especially without a comment. Now you add
random +2. Please comment it or better, come up with a non-timing
based test.

> +		ksft_exit_fail_msg("%s test: Failed\n", test_name);
> +	else
> +		ksft_test_result_pass("%s test: Passed\n", test_name);
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	ksft_print_header();
>  
> +	test_pidfd_poll_exec(0);
> +	test_pidfd_poll_exec(1);
> +	test_pidfd_poll_leader_exit(0);
> +	test_pidfd_poll_leader_exit(1);
>  	test_pidfd_send_signal_syscall_support();
>  	test_pidfd_send_signal_simple_success();
>  	test_pidfd_send_signal_exited_fail();
> -- 
> 2.21.0.593.g511ec345e18-goog
> 
