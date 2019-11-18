Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AECC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 01:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7760206D6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 01:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAWda5OB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfKRBqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 20:46:48 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33208 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfKRBqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 20:46:47 -0500
Received: by mail-pg1-f195.google.com with SMTP id h27so8826277pgn.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 17:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jP3ad7NYj5eP5DNOPOUCVEwxQvU1ZecJiisLTW8VvgM=;
        b=IAWda5OBIKUw7uZWNxS5A6e2XCalbHu7OfnVK4V4FKp0LWsGP/rDxLdCqL/OkWHGlo
         TA3QKiob4dwzwEMAEQEWKiFrOrpJ9lEA8OfvwpfZisAf2osb8S5QteA4uqYsAWkAfXxB
         sbulqez973+spklowG/HuYlztvup23vrE8S4rkBu7QRYuhycNgIRKNCvfssjTsD56/oe
         /R/riHUIIndM46uCY4KVQmYqi1kVPvc1aFSTJuF3mf7VOh0JipZVAe9A44Smy2/z2GvI
         MtiC8GKe+aWPtkGen/X1llXp3jioIlJTUMUpCqymPvc2dWcCysBg+27DysFVeIVOFyLd
         ZGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jP3ad7NYj5eP5DNOPOUCVEwxQvU1ZecJiisLTW8VvgM=;
        b=ItaHPFOgp67DQUYPUpTuLbVNEHPEQgnZ3ko/GgsTTrnZBWvPDK1mWAaW4hd8f6VSQs
         /0RLT4QvxAFLV0P/4XE4ib+0hs1RArZPPbs7jKCAQIloVyxnglhEdgz0ufVK26lU3nbY
         iihphFXYSHhKtFF7kuYs0PcUn6qljJFYBlK6kKuXhIJ4kjQneMt7ODO/qVO7Nl5QUTaP
         MCHkk3yzwRiU7I6aezaLpKAOpwe/yK1u7hdmRkinb9xanIGtvwqCgnVvm1U4vC53j1S4
         VQiEBOCSDtsWM4SMnpOBWF7EMiKF3gNzHAheDye27qcQNz5Iyb2saoxKPNeKOBaRmmfg
         /guw==
X-Gm-Message-State: APjAAAVB3hPrZGIBkyv6fHx9SUIroiJUxAcS+GWrC0wVg62+dN7WdvPp
        djrY+3xXPXYaMAhJQgbPvGw=
X-Google-Smtp-Source: APXvYqy4CWvtrVEKsHK5KbLsXkpXxKFX3zJY3COmMxj32w6c2+CRDwC0sy+e4wwNds1+oAKzLewgmQ==
X-Received: by 2002:a65:6081:: with SMTP id t1mr956871pgu.391.1574041606392;
        Sun, 17 Nov 2019 17:46:46 -0800 (PST)
Received: from gmail.com ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id y1sm20047052pfq.138.2019.11.17.17.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 17:46:45 -0800 (PST)
Date:   Sun, 17 Nov 2019 17:46:42 -0800
From:   Andrei Vagin <avagin@gmail.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v11 2/2] selftests: add tests for clone3() with *set_tid
Message-ID: <20191118014642.GC391304@gmail.com>
References: <20191115123621.142252-1-areber@redhat.com>
 <20191115123621.142252-2-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20191115123621.142252-2-areber@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 01:36:21PM +0100, Adrian Reber wrote:
> This tests clone3() with *set_tid to see if all desired PIDs are working
> as expected. The tests are trying multiple invalid input parameters as
> well as creating processes while specifying a certain PID in multiple
> PID namespaces at the same time.
> 
> Additionally this moves common clone3() test code into clone3_selftests.h.
> 
> Signed-off-by: Adrian Reber <areber@redhat.com>
> ---
> v9:
>  - applied all changes from Christian's review (except using the
>    NSpid: parsing code from selftests/pidfd/pidfd_fdinfo_test.c)
> 
> v10:
>  - added even more '\n' and include file fixes (Christian)
> 
> v11:
>  - added more return code checking at multiple places (Andrei)
>  - also add set_tid/set_tid_size to internal struct (Andrei)
> ---
>  tools/testing/selftests/clone3/.gitignore     |   1 +
>  tools/testing/selftests/clone3/Makefile       |   2 +-
>  tools/testing/selftests/clone3/clone3.c       |   8 +-
>  .../selftests/clone3/clone3_clear_sighand.c   |  20 +-
>  .../selftests/clone3/clone3_selftests.h       |  35 ++
>  .../testing/selftests/clone3/clone3_set_tid.c | 381 ++++++++++++++++++
>  6 files changed, 421 insertions(+), 26 deletions(-)
>  create mode 100644 tools/testing/selftests/clone3/clone3_selftests.h
>  create mode 100644 tools/testing/selftests/clone3/clone3_set_tid.c
> 
> diff --git a/tools/testing/selftests/clone3/.gitignore b/tools/testing/selftests/clone3/.gitignore
> index 2a30ae18b06e..0dc4f32c6cb8 100644
> --- a/tools/testing/selftests/clone3/.gitignore
> +++ b/tools/testing/selftests/clone3/.gitignore
> @@ -1,2 +1,3 @@
>  clone3
>  clone3_clear_sighand
> +clone3_set_tid
> diff --git a/tools/testing/selftests/clone3/Makefile b/tools/testing/selftests/clone3/Makefile
> index eb26eb793c80..cf976c732906 100644
> --- a/tools/testing/selftests/clone3/Makefile
> +++ b/tools/testing/selftests/clone3/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  CFLAGS += -g -I../../../../usr/include/
>  
> -TEST_GEN_PROGS := clone3 clone3_clear_sighand
> +TEST_GEN_PROGS := clone3 clone3_clear_sighand clone3_set_tid
>  
>  include ../lib.mk
> diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
> index 0f8a9ef40117..4669b3d418e7 100644
> --- a/tools/testing/selftests/clone3/clone3.c
> +++ b/tools/testing/selftests/clone3/clone3.c
> @@ -18,6 +18,7 @@
>  #include <sched.h>
>  
>  #include "../kselftest.h"
> +#include "clone3_selftests.h"
>  
>  /*
>   * Different sizes of struct clone_args
> @@ -35,11 +36,6 @@ enum test_mode {
>  	CLONE3_ARGS_INVAL_EXIT_SIGNAL_NSIG,
>  };
>  
> -static pid_t raw_clone(struct clone_args *args, size_t size)
> -{
> -	return syscall(__NR_clone3, args, size);
> -}
> -
>  static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mode)
>  {
>  	struct clone_args args = {
> @@ -83,7 +79,7 @@ static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mode)
>  
>  	memcpy(&args_ext.args, &args, sizeof(struct clone_args));
>  
> -	pid = raw_clone((struct clone_args *)&args_ext, size);
> +	pid = sys_clone3((struct clone_args *)&args_ext, size);
>  	if (pid < 0) {
>  		ksft_print_msg("%s - Failed to create new process\n",
>  				strerror(errno));
> diff --git a/tools/testing/selftests/clone3/clone3_clear_sighand.c b/tools/testing/selftests/clone3/clone3_clear_sighand.c
> index 0d957be1bdc5..456783ad19d6 100644
> --- a/tools/testing/selftests/clone3/clone3_clear_sighand.c
> +++ b/tools/testing/selftests/clone3/clone3_clear_sighand.c
> @@ -14,30 +14,12 @@
>  #include <sys/wait.h>
>  
>  #include "../kselftest.h"
> +#include "clone3_selftests.h"
>  
>  #ifndef CLONE_CLEAR_SIGHAND
>  #define CLONE_CLEAR_SIGHAND 0x100000000ULL
>  #endif
>  
> -#ifndef __NR_clone3
> -#define __NR_clone3 -1
> -struct clone_args {
> -	__aligned_u64 flags;
> -	__aligned_u64 pidfd;
> -	__aligned_u64 child_tid;
> -	__aligned_u64 parent_tid;
> -	__aligned_u64 exit_signal;
> -	__aligned_u64 stack;
> -	__aligned_u64 stack_size;
> -	__aligned_u64 tls;
> -};
> -#endif
> -
> -static pid_t sys_clone3(struct clone_args *args, size_t size)
> -{
> -	return syscall(__NR_clone3, args, size);
> -}
> -
>  static void test_clone3_supported(void)
>  {
>  	pid_t pid;
> diff --git a/tools/testing/selftests/clone3/clone3_selftests.h b/tools/testing/selftests/clone3/clone3_selftests.h
> new file mode 100644
> index 000000000000..1a270390766a
> --- /dev/null
> +++ b/tools/testing/selftests/clone3/clone3_selftests.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _CLONE3_SELFTESTS_H
> +#define _CLONE3_SELFTESTS_H
> +
> +#define _GNU_SOURCE
> +#include <sched.h>
> +#include <stdint.h>
> +#include <syscall.h>
> +#include <linux/types.h>
> +
> +#define ptr_to_u64(ptr) ((__u64)((uintptr_t)(ptr)))
> +
> +#ifndef __NR_clone3
> +#define __NR_clone3 -1
> +struct clone_args {
> +	__aligned_u64 flags;
> +	__aligned_u64 pidfd;
> +	__aligned_u64 child_tid;
> +	__aligned_u64 parent_tid;
> +	__aligned_u64 exit_signal;
> +	__aligned_u64 stack;
> +	__aligned_u64 stack_size;
> +	__aligned_u64 tls;
> +	__aligned_u64 set_tid;
> +	__aligned_u64 set_tid_size;
> +};
> +#endif
> +
> +static pid_t sys_clone3(struct clone_args *args, size_t size)
> +{
> +	return syscall(__NR_clone3, args, size);
> +}
> +
> +#endif /* _CLONE3_SELFTESTS_H */
> diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
> new file mode 100644
> index 000000000000..3480e1c46983
> --- /dev/null
> +++ b/tools/testing/selftests/clone3/clone3_set_tid.c
> @@ -0,0 +1,381 @@
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
> +#include <stdbool.h>
> +#include <sys/syscall.h>
> +#include <sys/types.h>
> +#include <sys/un.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +#include <sched.h>
> +
> +#include "../kselftest.h"
> +#include "clone3_selftests.h"
> +
> +#ifndef MAX_PID_NS_LEVEL
> +#define MAX_PID_NS_LEVEL 32
> +#endif
> +
> +static int pipe_1[2];
> +static int pipe_2[2];
> +
> +static int call_clone3_set_tid(pid_t *set_tid,
> +			       size_t set_tid_size,
> +			       int flags,
> +			       int expected_pid,
> +			       bool wait_for_it)
> +{
> +	int status;
> +	pid_t pid = -1;
> +
> +	struct clone_args args = {
> +		.flags = flags,
> +		.exit_signal = SIGCHLD,
> +		.set_tid = ptr_to_u64(set_tid),
> +		.set_tid_size = set_tid_size,
> +	};
> +
> +	pid = sys_clone3(&args, sizeof(struct clone_args));
> +	if (pid < 0) {
> +		ksft_print_msg("%s - Failed to create new process\n",
> +			       strerror(errno));
> +		return -errno;
> +	}
> +
> +	if (pid == 0) {
> +		int ret;
> +		char tmp = 0;
> +		int exit_code = EXIT_SUCCESS;
> +
> +		ksft_print_msg("I am the child, my PID is %d (expected %d)\n",
> +			       getpid(), set_tid[0]);
> +		if (wait_for_it) {
> +			ksft_print_msg("[%d] Child is ready and waiting\n",
> +				       getpid());
> +
> +			/* Signal the parent that the child is ready */
> +			close(pipe_1[0]);
> +			ret = write(pipe_1[1], &tmp, 1);
> +			if (ret != 1) {
> +				ksft_print_msg(
> +					"Writing to pipe returned %d", ret);
> +				exit_code = EXIT_FAILURE;
> +			}
> +			close(pipe_1[1]);
> +			close(pipe_2[1]);
> +			ret = read(pipe_2[0], &tmp, 1);
> +			if (ret != 1) {
> +				ksft_print_msg(
> +					"Reading from pipe returned %d", ret);
> +				exit_code = EXIT_FAILURE;
> +			}
> +			close(pipe_2[0]);
> +		}
> +
> +		if (set_tid[0] != getpid())
> +			_exit(EXIT_FAILURE);
> +		_exit(exit_code);
> +	}
> +
> +	if (expected_pid == 0 || expected_pid == pid) {
> +		ksft_print_msg("I am the parent (%d). My child's pid is %d\n",
> +			       getpid(), pid);
> +	} else {
> +		ksft_print_msg(
> +			"Expected child pid %d does not match actual pid %d\n",
> +			expected_pid, pid);
> +		return -1;
> +	}
> +
> +	if (waitpid(pid, &status, 0) < 0) {
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
> +
> +	if (pipe(pipe_1) < 0 || pipe(pipe_2) < 0)
> +		ksft_exit_fail_msg("pipe() failed\n");
> +
> +	ksft_print_header();
> +	ksft_set_plan(27);
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
> +
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
> +
> +	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 42, 0, -EINVAL, 0, 0);
> +
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
> +
> +	set_tid[0] = -1;
> +	test_clone3_set_tid(set_tid, 1, 0, -EINVAL, 0, 0);
> +
> +	/* Claim that the set_tid array actually contains 2 elements. */
> +	test_clone3_set_tid(set_tid, 2, 0, -EINVAL, 0, 0);
> +
> +	/* Try it in a new PID namespace */
> +	if (uid == 0)
> +		test_clone3_set_tid(set_tid, 1, CLONE_NEWPID, -EINVAL, 0, 0);
> +	else
> +		ksft_test_result_skip("Clone3() with set_tid requires root\n");
> +
> +	/* Try with a valid PID (1) this should return -EEXIST. */
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
> +
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
> +	if (waitpid(pid, &status, 0) < 0)
> +		ksft_exit_fail_msg("Waiting for child %d failed", pid);
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
> +
> +		set_tid[0] = 1;
> +		set_tid[1] = -1;
> +		set_tid[2] = pid;
> +		/* This should fail as there is invalid PID at level '1'. */
> +		test_clone3_set_tid(set_tid, 3, CLONE_NEWPID, -EINVAL, 0, 0);
> +
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
> +		test_clone3_set_tid(set_tid, 3, CLONE_NEWPID, 0, 42, true);
> +
> +		_exit(ksft_cnt.ksft_pass);
> +	}
> +
> +	close(pipe_1[1]);
> +	close(pipe_2[0]);
> +	while (read(pipe_1[0], &buf, 1) > 0) {
> +		ksft_print_msg("[%d] Child is ready and waiting\n", getpid());
> +		break;
> +	}
> +
> +	snprintf(proc_path, sizeof(proc_path), "/proc/%d/status", pid);
> +	f = fopen(proc_path, "r");
> +	if (f == NULL)
> +		ksft_exit_fail_msg(
> +			"%s - Could not open %s\n",
> +			strerror(errno), proc_path);
> +
> +	while (getline(&line, &len, f) != -1) {
> +		if (strstr(line, "NSpid")) {
> +			int i;
> +
> +			/* Verify that all generated PIDs are as expected. */
> +			i = sscanf(line, "NSpid:\t%d\t%d\t%d",
> +				   &ns3, &ns2, &ns1);
> +			if (i != 3) {
> +				ksft_print_msg(
> +					"Unexpected 'NSPid:' entry: %s",
> +					line);
> +				ns1 = ns2 = ns3 = 0;
> +			}
> +			break;
> +		}
> +	}
> +	fclose(f);
> +	free(line);
> +	close(pipe_2[0]);
> +
> +	/* Tell the clone3()'d child to finish. */
> +	write(pipe_2[1], &buf, 1);
> +	close(pipe_2[1]);
> +
> +	if (waitpid(ns_pid, &status, 0) < 0) {
> +		ksft_print_msg("Child returned %s\n", strerror(errno));
> +		ret = -errno;
> +		goto out;
> +	}
> +
> +	if (!WIFEXITED(status))
> +		ksft_test_result_fail("Child error\n");
> +
> +	if (WEXITSTATUS(status))
> +		/*
> +		 * Update the number of total tests with the tests from the
> +		 * child processes.
> +		 */
> +		ksft_cnt.ksft_pass = WEXITSTATUS(status);

I just found that accounting of failed test cases in this test doesn't
work properly. And if one of the test cases fails in a child process,
the whole test will have the pass status.


For example, if we add a fake fail:

diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
index 3480e1c46..82c99c42f 100644
--- a/tools/testing/selftests/clone3/clone3_set_tid.c
+++ b/tools/testing/selftests/clone3/clone3_set_tid.c
@@ -301,7 +301,7 @@ int main(int argc, char *argv[])
                 * namespaces. Again assuming this is running in the host's
                 * PID namespace. Not yet nested.
                 */
-               test_clone3_set_tid(set_tid, 4, CLONE_NEWPID, -EINVAL, 0, 0);
+               test_clone3_set_tid(set_tid, 4, CLONE_NEWPID, -EPERM, 0, 0);
 
                /*
                 * This should work and from the parent we should see

$ make run_tests 
....
# ok 21 [21104] Result (0) matches expectation (0)
# # unshare PID namespace
# # [21104] Trying clone3() with CLONE_SET_TID to 21106 and 0x0
# # Invalid argument - Failed to create new process
# # [21104] clone3() with CLONE_SET_TID 21106 says :-22 - expected -22
# ok 22 [21104] Result (-22) matches expectation (-22)
# # [21104] Child is ready and waiting
# ok 26 PIDs in all namespaces as expected (21106,42,1)
# # Planned tests != run tests (27 != 26)
# # Pass 26 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0
ok 3 selftests: clone3: clone3_set_tid


> +
> +	if (ns3 == pid && ns2 == 42 && ns1 == 1)
> +		ksft_test_result_pass(
> +			"PIDs in all namespaces as expected (%d,%d,%d)\n",
> +			ns3, ns2, ns1);
> +	else
> +		ksft_test_result_fail(
> +			"PIDs in all namespaces not as expected (%d,%d,%d)\n",
> +			ns3, ns2, ns1);
> +out:
> +	ret = 0;
> +
> +	return !ret ? ksft_exit_pass() : ksft_exit_fail();
> +}
> -- 
> 2.23.0
> 
