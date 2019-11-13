Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5804C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D11222D0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfKMMfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 07:35:40 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60068 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfKMMfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 07:35:40 -0500
Received: from [79.140.120.64] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iUrri-0006yI-5s; Wed, 13 Nov 2019 12:35:18 +0000
Date:   Wed, 13 Nov 2019 13:35:17 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v8 2/2] selftests: add tests for clone3()
Message-ID: <20191113123513.znwjj23to5pruevp@wittgenstein>
References: <20191113080301.1197762-1-areber@redhat.com>
 <20191113080301.1197762-2-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191113080301.1197762-2-areber@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 09:03:01AM +0100, Adrian Reber wrote:
> This tests clone3() with *set_tid to see if all desired PIDs are working
> as expected. The tests are trying multiple invalid input parameters as
> well as creating processes while specifying a certain PID in multiple
> PID namespaces at the same time.
> 
> Signed-off-by: Adrian Reber <areber@redhat.com>
> ---
>  tools/testing/selftests/clone3/.gitignore     |   1 +
>  tools/testing/selftests/clone3/Makefile       |   2 +-
>  .../testing/selftests/clone3/clone3_set_tid.c | 345 ++++++++++++++++++
>  3 files changed, 347 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/clone3/clone3_set_tid.c
> 
> diff --git a/tools/testing/selftests/clone3/.gitignore b/tools/testing/selftests/clone3/.gitignore
> index 85d9d3ba2524..d56c3c49d869 100644
> --- a/tools/testing/selftests/clone3/.gitignore
> +++ b/tools/testing/selftests/clone3/.gitignore
> @@ -1 +1,2 @@
>  clone3
> +clone3_set_tid
> diff --git a/tools/testing/selftests/clone3/Makefile b/tools/testing/selftests/clone3/Makefile
> index ea922c014ae4..2d292545ca8e 100644
> --- a/tools/testing/selftests/clone3/Makefile
> +++ b/tools/testing/selftests/clone3/Makefile
> @@ -2,6 +2,6 @@
>  
>  CFLAGS += -I../../../../usr/include/
>  
> -TEST_GEN_PROGS := clone3
> +TEST_GEN_PROGS := clone3 clone3_set_tid

Another example, where --base would help me out. :) (Since I can already
see that this is missing the clone3_clear_sighand test that's scheduled
for 5.5. :))

>  
>  include ../lib.mk
> diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
> new file mode 100644
> index 000000000000..9a234fd2031e
> --- /dev/null
> +++ b/tools/testing/selftests/clone3/clone3_set_tid.c
> @@ -0,0 +1,345 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Based on Christian Brauner's clone3() example.
> + * These tests are assuming to be running in the host's
> + * PID namespace.
> + */
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <linux/types.h>
> +#include <linux/sched.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/syscall.h>
> +#include <sys/types.h>
> +#include <sys/un.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +#include <sched.h>
> +
> +#include "../kselftest.h"
> +
> +#ifndef MAX_PID_NS_LEVEL
> +#define MAX_PID_NS_LEVEL 32
> +#endif
> +
> +static int pipe_1[2];
> +static int pipe_2[2];
> +
> +static pid_t raw_clone(struct clone_args *args)
> +{
> +	return syscall(__NR_clone3, args, sizeof(struct clone_args));
> +}

So that function is now present in the clone3.c test you've added and
also in the clone3_clear_sighand.c under sys_clone3().
If you take [1] as your base tree you could add patches that consolidate
this definition into a header so we avoid the pointless code
duplication.
(Again, if you pass --base when doing --format-patch this will be
transparent to others.)


[1]: https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=pidfd

> +
> +static int call_clone3_set_tid(pid_t *set_tid,
> +			       size_t set_tid_size,
> +			       int flags,
> +			       int expected_pid,
> +			       int wait_for_it)

Nit: Why is that an int and not a bool? :)

> +{
> +	int status;
> +	int ret = 0;
> +	pid_t pid = -1;
> +	struct clone_args args = {0};
> +
> +	args.flags = flags;
> +	args.exit_signal = SIGCHLD;
> +	args.set_tid = (__u64)set_tid;
> +	args.set_tid_size = set_tid_size;

Nit: You can save the {0} by just doing:

struct clone_args args = {
	.flags = flags,
	.exit_signal = SIGCHLD,
	.set_tid = (__u64)set_tid,
	.set_tid_size = set_tid_size,
};

Also, I'd prefer if the cast would be done "properly" via

#define ptr_to_u64(ptr) ((__u64)((uintptr_t)(ptr)))

struct clone_args args = {
	.flags = flags,
	.exit_signal = SIGCHLD,
	.set_tid = ptr_to_u64(set_tid),
	.set_tid_size = set_tid_size,
};

> +
> +	pid = raw_clone(&args);
> +	if (pid < 0) {
> +		ksft_print_msg("%s - Failed to create new process\n",
> +			       strerror(errno));
> +		return -errno;
> +	}
> +
> +	if (pid == 0) {
> +		char tmp = 0;
> +		ksft_print_msg("I am the child, my PID is %d (expected %d)\n",
> +			       getpid(), set_tid[0]);
> +		if (wait_for_it) {
> +			ksft_print_msg("[%d] Child is ready and waiting\n", getpid());
> +			/* Signal the parent that the child is ready */
> +			close(pipe_1[0]);
> +			write(pipe_1[1], &tmp, 1);
> +			close(pipe_1[1]);
> +			close(pipe_2[1]);
> +			read(pipe_2[0], &tmp, 1);
> +			close(pipe_2[0]);
> +		}
> +
> +		if (set_tid[0] != getpid())
> +			_exit(EXIT_FAILURE);
> +		_exit(EXIT_SUCCESS);
> +	}
> +
> +	if (expected_pid == 0 || expected_pid == pid)
> +		ksft_print_msg("I am the parent (%d). My child's pid is %d\n",
> +			       getpid(), pid);
> +	else {

If one branch needs {} all branches should have {} according to kernel
coding style.

> +		ksft_print_msg(
> +			"Expected child pid %d does not match actual pid %d\n",
> +			expected_pid, pid);
> +		ret = -1;
> +	}
> +
> +	if (wait(&status) < 0) {
> +		ksft_print_msg("Child returned %s\n", strerror(errno));
> +		return -errno;
> +	}
> +	if (WEXITSTATUS(status))
> +		return WEXITSTATUS(status);

You should probably rather check:
	if (!WIFEXITED(status))
		return -1;
	
	return WEXITSTATUS(status));

Since you can also get killed by a signal.

> +
> +	return ret;
> +}
> +
> +static void test_clone3_set_tid(pid_t *set_tid,
> +				size_t set_tid_size,
> +				int flags,
> +				int expected,
> +				int expected_pid,
> +				int wait_for_it)
> +{
> +	int ret;
> +
> +	ksft_print_msg(
> +		"[%d] Trying clone3() with CLONE_SET_TID to %d and 0x%x\n",
> +		getpid(), set_tid[0], flags);
> +	ret = call_clone3_set_tid(set_tid, set_tid_size, flags, expected_pid,
> +				  wait_for_it);
> +	ksft_print_msg(
> +		"[%d] clone3() with CLONE_SET_TID %d says :%d - expected %d\n",
> +		getpid(), set_tid[0], ret, expected);
> +	if (ret != expected)
> +		ksft_test_result_fail(
> +			"[%d] Result (%d) is different than expected (%d)\n",
> +			getpid(), ret, expected);
> +	else
> +		ksft_test_result_pass("[%d] Result (%d) matches expectation (%d)\n",
> +			getpid(), ret, expected);
> +}
> +int main(int argc, char *argv[])
> +{
> +	FILE *f;
> +	char buf;
> +	pid_t pid;
> +	pid_t ns1;
> +	pid_t ns2;
> +	pid_t ns3;

Nit:
pid_t pid, ns1, ns2, ns3, ns_pid;

> +	int status;
> +	char *proc;
> +	int ret = -1;
> +	pid_t ns_pid;
> +	int pid_max = 0;
> +	uid_t uid = getuid();
> +	char line[1024] = {0};
> +	pid_t set_tid[MAX_PID_NS_LEVEL * 2];
> +	pid_t set_tid_small[1];
> +
> +	if (pipe(pipe_1) == -1 || pipe(pipe_2))
> +		 ksft_exit_fail_msg("pipe() failed\n");

Nit: The error checking here is inconsistent. Either do:

if (pipe(pipe_1) || pipe(pipe_2))
	 ksft_exit_fail_msg("pipe() failed\n");

or

if (pipe(pipe_1) < 0 || pipe(pipe_2) < 0)
	 ksft_exit_fail_msg("pipe() failed\n");

or == -1 but not mixed, please. :)

> +
> +	ksft_print_header();
> +	ksft_set_plan(27);

Now that's ambitious testing. I like it. :)

> +
> +	f = fopen("/proc/sys/kernel/pid_max", "r");
> +	if (f == NULL)
> +		ksft_exit_fail_msg(
> +			"%s - Could not open /proc/sys/kernel/pid_max\n",
> +			strerror(errno));
> +	fscanf(f, "%d", &pid_max);
> +	fclose(f);
> +	ksft_print_msg("/proc/sys/kernel/pid_max %d\n", pid_max);
> +
> +	/* Try invalid settings */
> +	memset(&set_tid, 0, sizeof(set_tid));
> +	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL + 1, 0, -E2BIG, 0, 0);
> +	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 2, 0, -E2BIG, 0, 0);
> +	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 2 + 1, 0, -E2BIG, 0, 0);
> +	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 42, 0, -E2BIG, 0, 0);
> +
> +	/* small set_tid array, but maximum set_tid_size */
> +	/* Find the current active PID */
> +	pid = fork();
> +	if (pid == 0) {
> +		ksft_print_msg("Child has PID %d\n", getpid());
> +		_exit(EXIT_SUCCESS);
> +	}
> +	(void)wait(NULL);
> +	/* After the child has finished, its PID should be free. */
> +	set_tid_small[0] = pid;
> +	/*
> +	 * There is a chance that this can return -EFAULT as the actual
> +	 * set_tid array has only one entry, but we are telling the kernel
> +	 * that it has the size MAX_PID_NS_LEVEL. This could lead to a
> +	 * situation where copy_from_user() fails. So far it always
> +	 * succeeds and copies random data (whatever is after set_tid_small).
> +	 */
> +	test_clone3_set_tid(set_tid_small, MAX_PID_NS_LEVEL, 0, -EINVAL, 0, 0);

Hm, I'm not sure that test makes a lot of sense.

> +
> +	/*
> +	 * This can actually work if this test running in a MAX_PID_NS_LEVEL - 1
> +	 * nested PID namespace.
> +	 */
> +	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL - 1, 0, -EINVAL, 0, 0);
> +
> +	memset(&set_tid, 0xff, sizeof(set_tid));
> +	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL + 1, 0, -E2BIG, 0, 0);
> +	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 2, 0, -E2BIG, 0, 0);
> +	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 2 + 1, 0, -E2BIG, 0, 0);
> +	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 42, 0, -E2BIG, 0, 0);
> +	/*
> +	 * This can actually work if this test running in a MAX_PID_NS_LEVEL - 1
> +	 * nested PID namespace.
> +	 */
> +	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL - 1, 0, -EINVAL, 0, 0);
> +
> +	memset(&set_tid, 0, sizeof(set_tid));
> +	/* Try with an invalid PID */
> +	set_tid[0] = 0;
> +	test_clone3_set_tid(set_tid, 1, 0, -EINVAL, 0, 0);
> +	set_tid[0] = -1;
> +	test_clone3_set_tid(set_tid, 1, 0, -EINVAL, 0, 0);
> +	/* Claim that the set_tid array actually contains 2 elements. */
> +	test_clone3_set_tid(set_tid, 2, 0, -EINVAL, 0, 0);
> +	/* Try it in a new PID namespace */
> +	if (uid == 0)
> +		test_clone3_set_tid(set_tid, 1, CLONE_NEWPID, -EINVAL, 0, 0);
> +	else
> +		test_clone3_set_tid(set_tid, 1, CLONE_NEWPID, -EPERM, 0, 0);

[1]:
I mean, you could really just do 
if (uid == 0)
	test_clone3_set_tid(set_tid, 1, CLONE_NEWPID, -EINVAL, 0, 0);
the else branch doesn't really test anything meaningful other than you
can't create new pid namespaces as an unprivileged user without also
creating a new user namespace.

> +
> +	/*
> +	 * Try with a valid PID (1) but as non-root. This should fail
> +	 * with -EPERM if running in the initial user namespace.
> +	 * As root it should tell us -EEXIST.
> +	 */
> +	set_tid[0] = 1;
> +	if (uid == 0)
> +		test_clone3_set_tid(set_tid, 1, 0, -EEXIST, 0, 0);
> +	else
> +		test_clone3_set_tid(set_tid, 1, 0, -EPERM, 0, 0);

See [1].

> +
> +	/* Try it in a new PID namespace */
> +	if (uid == 0)
> +		test_clone3_set_tid(set_tid, 1, CLONE_NEWPID, 0, 0, 0);
> +	else
> +		test_clone3_set_tid(set_tid, 1, CLONE_NEWPID, -EPERM, 0, 0);

See [1].

> +
> +	/* pid_max should fail everywhere */
> +	set_tid[0] = pid_max;
> +	test_clone3_set_tid(set_tid, 1, 0, -EINVAL, 0, 0);
> +	if (uid == 0)
> +		test_clone3_set_tid(set_tid, 1, CLONE_NEWPID, -EINVAL, 0, 0);
> +	else
> +		test_clone3_set_tid(set_tid, 1, CLONE_NEWPID, -EPERM, 0, 0);

See [1].
> +

> +	if (uid != 0) {
> +		/*
> +		 * All remaining tests require root. Tell the framework
> +		 * that all those tests are skipped as non-root.
> +		 */
> +		ksft_cnt.ksft_xskip += ksft_plan - ksft_test_num();
> +		goto out;
> +	}
> +
> +	/* Find the current active PID */
> +	pid = fork();
> +	if (pid == 0) {
> +		ksft_print_msg("Child has PID %d\n", getpid());
> +		usleep(500);

Why the usleep(500)?

> +		_exit(EXIT_SUCCESS);
> +	}
> +	(void)wait(NULL);

\n

> +	/* After the child has finished, its PID should be free. */
> +	set_tid[0] = pid;
> +	test_clone3_set_tid(set_tid, 1, 0, 0, 0, 0);

\n

> +	/* This should fail as there is no PID 1 in that namespace */
> +	test_clone3_set_tid(set_tid, 1, CLONE_NEWPID, -EINVAL, 0, 0);

Nit: please add \n between a two tests everywhere, especially if they
have comments on top of it. This is a little hard to read. :)

> +	set_tid[0] = 1;
> +	set_tid[1] = pid;
> +	test_clone3_set_tid(set_tid, 2, CLONE_NEWPID, 0, pid, 0);

This is missing a comment.

> +
> +	ksft_print_msg("unshare PID namespace\n");
> +	unshare(CLONE_NEWPID);

Why no error checking here when the next line assumes that there is no
PID 1 in that namespace?

> +	set_tid[0] = pid;
> +	/* This should fail as there is no PID 1 in that namespace */
> +	test_clone3_set_tid(set_tid, 1, 0, -EINVAL, 0, 0);
> +
> +	/* Let's create a PID 1 */
> +	ns_pid = fork();
> +	if (ns_pid == 0) {
> +		ksft_print_msg("Child in PID namespace has PID %d\n", getpid());
> +		set_tid[0] = 2;
> +		test_clone3_set_tid(set_tid, 1, 0, 0, 2, 0);
> +		set_tid[0] = 1;
> +		set_tid[1] = 42;
> +		set_tid[2] = pid;
> +		/*
> +		 * This should fail as there are not enough active PID
> +		 * namespaces. Again assuming this is running in the host's
> +		 * PID namespace. Not yet nested.
> +		 */
> +		test_clone3_set_tid(set_tid, 4, CLONE_NEWPID, -EINVAL, 0, 0);
> +		/*
> +		 * This should work and from the parent we should see
> +		 * something like 'NSpid:	pid	42	1'.

[2]:
You could verify this...
In tools/testing/selftests/pidfd/pidfd_fdinfo_test.c in my pidfd tree
is code that does this. You could just copy it. Look for
verify_fdinfo(). Though, I'll it for you to judge whether this is too
much hazzle.

> +		 */
> +		test_clone3_set_tid(set_tid, 3, CLONE_NEWPID, 0, 42, 1);
> +		_exit(ksft_cnt.ksft_pass);

Again, the missing \n makes the different tests hard to follow.

> +	}
> +
> +	close(pipe_1[1]);
> +	close(pipe_2[0]);
> +	while (read(pipe_1[0], &buf, 1) > 0) {
> +		ksft_print_msg("[%d] Child is ready and waiting\n", getpid());
> +		break;
> +	}
> +
> +	asprintf(&proc, "/proc/%d/status", pid);

char proc_path[100];
snprintf(proc_path, sizeof(proc_path), "/proc/%d/status", pid);

should do just fine and doesn't require you to free memory.

> +	f = fopen(proc, "r");
> +	if (f == NULL)
> +		ksft_exit_fail_msg(
> +			"%s - Could not open %s\n",
> +			strerror(errno), proc);
> +	while (fgets(line, 1024, f)) {

Ugh, fgets... :) I'd feel much happier with getline().

> +		if (strstr(line, "NSpid")) {
> +			/* Verify that all generated PIDs are as expected. */
> +			sscanf(line, "NSpid:\t%d\t%d\t%d", &ns3, &ns2, &ns1);
> +			break;

Oh this is the verification code for fdinfo, I mentioned in [2]. Again,
maybe you want to copy verify_fdinfo() and move this into a helper.

> +		}
> +	}
> +	fclose(f);
> +	free(proc);
> +	close(pipe_2[0]);

\n

> +	/* Tell the clone3()'d child to finish. */
> +	write(pipe_2[1], &buf, 1);
> +	close(pipe_2[1]);
> +
> +	if (wait(&status) < 0) {
> +		ksft_print_msg("Child returned %s\n", strerror(errno));
> +		ret = -errno;
> +		goto out;
> +	}
> +	if (WEXITSTATUS(status))

Nit: This should probably also verify if (WIFEXITED(status)).
