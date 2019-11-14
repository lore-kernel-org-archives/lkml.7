Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E8EC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A03A2070E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfKNIjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 03:39:06 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60952 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfKNIjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 03:39:06 -0500
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iVAeX-0008KG-4z; Thu, 14 Nov 2019 08:38:57 +0000
Date:   Thu, 14 Nov 2019 09:38:56 +0100
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
Subject: Re: [PATCH v9 2/2] selftests: add tests for clone3() with *set_tid
Message-ID: <20191114083854.lyryiqbxecmxbrb7@wittgenstein>
References: <20191114070709.1504202-1-areber@redhat.com>
 <20191114070709.1504202-2-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191114070709.1504202-2-areber@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 08:07:09AM +0100, Adrian Reber wrote:
> +++ b/tools/testing/selftests/clone3/clone3_selftests.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _CLONE3_SELFTESTS_H
> +#define _CLONE3_SELFTESTS_H
> +
> +#include <stdint.h>
> +
> +#define ptr_to_u64(ptr) ((__u64)((uintptr_t)(ptr)))
> +
> +#ifndef __NR_clone3
> +#define __NR_clone3 -1
> +struct clone_args {
> +	__aligned_u64 flags;

Hugh, doesn't that complain about missing definition of __aligned_u64?
I thought that was declared in linux/types.h

> +	__aligned_u64 pidfd;
> +	__aligned_u64 child_tid;
> +	__aligned_u64 parent_tid;
> +	__aligned_u64 exit_signal;
> +	__aligned_u64 stack;
> +	__aligned_u64 stack_size;
> +	__aligned_u64 tls;
> +};
> +#endif
> +
> +static pid_t sys_clone3(struct clone_args *args, size_t size)
> +{
> +	return syscall(__NR_clone3, args, size);

And doesn't that one complain about missing syscall() defined in
sys/syscall.h?

I would rather make the header sm like:

#define _GNU_SOURCE
#include <sched.h>
#include <stdint.h>
#include <syscall.h>
#include <linux/types.h>

so that the order of inclusion doesn't matter. You're getting away with
this because you include syscall.h, etc. before clone3_selftests.h in
clone3_set_tid.c below. I'd rather not rely on such ordering.

/* stuff */

> +}
> +
> +#endif /* _CLONE3_SELFTESTS_H */
> diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
> +	if (expected_pid == 0 || expected_pid == pid) {
> +		ksft_print_msg("I am the parent (%d). My child's pid is %d\n",
> +			       getpid(), pid);
> +	} else {
> +		ksft_print_msg(
> +			"Expected child pid %d does not match actual pid %d\n",
> +			expected_pid, pid);
> +		ret = -1;

What's that for?
I think that whole ret variable can go, no?

> +	}
> +
> +	if (wait(&status) < 0) {
> +		ksft_print_msg("Child returned %s\n", strerror(errno));
> +		return -errno;
> +	}
> +
> +	if (!WIFEXITED(status))
> +		return -1;
> +
> +	return WEXITSTATUS(status);
> +}
> +
> +static void test_clone3_set_tid(pid_t *set_tid,
> +				size_t set_tid_size,
> +				int flags,
> +				int expected,
> +				int expected_pid,
> +				bool wait_for_it)
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
> +		ksft_test_result_pass(
> +			"[%d] Result (%d) matches expectation (%d)\n",
> +			getpid(), ret, expected);
> +}
> +int main(int argc, char *argv[])
> +{
> +	FILE *f;
> +	char buf;
> +	char *line;
> +	int status;
> +	int ret = -1;
> +	size_t len = 0;
> +	int pid_max = 0;
> +	uid_t uid = getuid();
> +	char proc_path[100] = {0};
> +	pid_t pid, ns1, ns2, ns3, ns_pid;
> +	pid_t set_tid[MAX_PID_NS_LEVEL * 2];

reverse-reverse Christmas tree ordering I see :)

> +
> +	if (pipe(pipe_1) < 0 || pipe(pipe_2) < 0)
> +		ksft_exit_fail_msg("pipe() failed\n");
> +
> +	ksft_print_header();
> +	ksft_set_plan(26);
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
> +	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL + 1, 0, -EINVAL, 0, 0);
> +
> +	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 2, 0, -EINVAL, 0, 0);
> +
> +	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 2 + 1, 0,
> +			-EINVAL, 0, 0);

\n

> +	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 42, 0, -EINVAL, 0, 0);
> +
> +	/*
> +	 * This can actually work if this test running in a MAX_PID_NS_LEVEL - 1
> +	 * nested PID namespace.
> +	 */
> +	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL - 1, 0, -EINVAL, 0, 0);
> +
> +	memset(&set_tid, 0xff, sizeof(set_tid));
> +	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL + 1, 0, -EINVAL, 0, 0);
> +
> +	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 2, 0, -EINVAL, 0, 0);
> +
> +	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 2 + 1, 0,
> +			-EINVAL, 0, 0);

\n

> +	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 42, 0, -EINVAL, 0, 0);

\n

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

\n

> +	set_tid[0] = -1;
> +	test_clone3_set_tid(set_tid, 1, 0, -EINVAL, 0, 0);

\n

> +	/* Claim that the set_tid array actually contains 2 elements. */
> +	test_clone3_set_tid(set_tid, 2, 0, -EINVAL, 0, 0);

\n

> +	/* Try it in a new PID namespace */
> +	if (uid == 0)
> +		test_clone3_set_tid(set_tid, 1, CLONE_NEWPID, -EINVAL, 0, 0);
> +	else
> +		ksft_test_result_skip("Clone3() with set_tid requires root\n");
> +
> +	/*
> +	 * Try with a valid PID (1) but as non-root. This should fail

Where are you trying this as non-root? I think that comment is obsolete,
no? :)

> +	 * with -EPERM if running in the initial user namespace.
> +	 * As root it should tell us -EEXIST.
> +	 */
> +	set_tid[0] = 1;
> +	if (uid == 0)
> +		test_clone3_set_tid(set_tid, 1, 0, -EEXIST, 0, 0);
> +	else
> +		ksft_test_result_skip("Clone3() with set_tid requires root\n");
> +
> +	/* Try it in a new PID namespace */
> +	if (uid == 0)
> +		test_clone3_set_tid(set_tid, 1, CLONE_NEWPID, 0, 0, 0);
> +	else
> +		ksft_test_result_skip("Clone3() with set_tid requires root\n");
> +
> +	/* pid_max should fail everywhere */
> +	set_tid[0] = pid_max;
> +	test_clone3_set_tid(set_tid, 1, 0, -EINVAL, 0, 0);

\n

> +	if (uid == 0)
> +		test_clone3_set_tid(set_tid, 1, CLONE_NEWPID, -EINVAL, 0, 0);
> +	else
> +		ksft_test_result_skip("Clone3() with set_tid requires root\n");
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
> +		_exit(EXIT_SUCCESS);
> +	}
> +	(void)wait(NULL);
> +
> +	/* After the child has finished, its PID should be free. */
> +	set_tid[0] = pid;
> +	test_clone3_set_tid(set_tid, 1, 0, 0, 0, 0);
> +
> +	/* This should fail as there is no PID 1 in that namespace */
> +	test_clone3_set_tid(set_tid, 1, CLONE_NEWPID, -EINVAL, 0, 0);
> +
> +	/*
> +	 * Creating a process with PID 1 in the newly created most nested
> +	 * PID namespace and PID 'pid' in the parent PID namespace. This
> +	 * needs to work.
> +	 */
> +	set_tid[0] = 1;
> +	set_tid[1] = pid;
> +	test_clone3_set_tid(set_tid, 2, CLONE_NEWPID, 0, pid, 0);
> +
> +	ksft_print_msg("unshare PID namespace\n");
> +	if (unshare(CLONE_NEWPID) == -1)
> +		ksft_exit_fail_msg("unshare(CLONE_NEWPID) failed: %s\n",
> +				strerror(errno));
> +
> +	set_tid[0] = pid;
> +
> +	/* This should fail as there is no PID 1 in that namespace */
> +	test_clone3_set_tid(set_tid, 1, 0, -EINVAL, 0, 0);
> +
> +	/* Let's create a PID 1 */
> +	ns_pid = fork();
> +	if (ns_pid == 0) {
> +		ksft_print_msg("Child in PID namespace has PID %d\n", getpid());
> +		set_tid[0] = 2;
> +		test_clone3_set_tid(set_tid, 1, 0, 0, 2, 0);

\n

> +		set_tid[0] = 1;
> +		set_tid[1] = 42;
> +		set_tid[2] = pid;
> +		/*
> +		 * This should fail as there are not enough active PID
> +		 * namespaces. Again assuming this is running in the host's
> +		 * PID namespace. Not yet nested.
> +		 */
> +		test_clone3_set_tid(set_tid, 4, CLONE_NEWPID, -EINVAL, 0, 0);
> +
> +		/*
> +		 * This should work and from the parent we should see
> +		 * something like 'NSpid:	pid	42	1'.
> +		 */
> +		test_clone3_set_tid(set_tid, 3, CLONE_NEWPID, 0, 42, 1);

Nit: test_clone3_set_tid(set_tid, 3, CLONE_NEWPID, 0, 42, true);
                                                          ^^^ not 1 :)
