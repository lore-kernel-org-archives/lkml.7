Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72892C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285CD2071B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bD+0UsF3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfKNTFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 14:05:37 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37825 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfKNTFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 14:05:36 -0500
Received: by mail-pf1-f194.google.com with SMTP id p24so4924384pfn.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 11:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TdgKi0bP9o5ApNGR8Ki0Mmo8JAvys6r0URy9jydqEZI=;
        b=bD+0UsF3be2FA0sOMal6mWT+zXdzvpH87OaC1cgVXuiaxNbRSTwpDoCd5ZlhI9dAEC
         TvPzNg+JbWA+/ggnJwZGUGEM7yO/ofT0/hyf0s3HlHvNRgwmnj/20ZZaSBoDUnXiNHTf
         z6lD6nMPJTDO6fwiWsjy3sY3iUSW0nfvUYDzurU73IRy/b9IG/3lgSaVbcOlqUQOUPSV
         5NQXETcsTEuw6LxTn3Vc6yVJr8LWuETzDPYf9d2swVwE9hgZnG5/TREW52cHShqi3SWN
         ohjKDlL6PSCmicR/+aXquaF4G94C4DTBJwJagfGCzttw+2adYewq3L46DJfPgq6llqdw
         uJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TdgKi0bP9o5ApNGR8Ki0Mmo8JAvys6r0URy9jydqEZI=;
        b=LPvdpfFOXqjP6gzLCflMyH5ogbScSKehPgHHLTi+PJR6KEfo0AY8eV7E9KVKJ/T5+K
         HqUKDhfs0rkyLrZx79gQaygpa6ZWTxUQZiqMHtabSitrtz0fqwJ3PoiKCyjLzj1OAAxb
         1KI26uJK6zKLBp/I6tmo9cHPRDyTD+eDNlTCkmV5uSag0UYNKw9S1l/VHTLlyh0nBLrA
         CUd+P6tPO9HrFt7JKJO5krYV+ou3I5xf2pQrBl/Icgv3KTk7ECczSMXt+2WE4LUmtupJ
         ogtFeJjCiZgksIcF1PDhOt9Yd96BtcoBGQAXm84rFOn83UBs+X2GrknepK5KA6FQUYq7
         kkHw==
X-Gm-Message-State: APjAAAXXg7zYiuU/WKI/jK1eB9h3jhPUOdUV37RJdkRQrCrAto+3GtU1
        I/2ncqsrJ7L77cYsIFBbf54=
X-Google-Smtp-Source: APXvYqytg3hGNI5xS/+r37r2YjOdfOYIEc2D2QXJnRlHTgKC7i0zv1w9Lr6YkwEpH8yzpVakjGsD9Q==
X-Received: by 2002:aa7:8421:: with SMTP id q1mr13009617pfn.174.1573758333673;
        Thu, 14 Nov 2019 11:05:33 -0800 (PST)
Received: from gmail.com ([2620:0:1008:fd00:25a6:3140:768c:a64d])
        by smtp.gmail.com with ESMTPSA id f185sm8316510pfb.183.2019.11.14.11.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 11:05:32 -0800 (PST)
Date:   Thu, 14 Nov 2019 11:05:23 -0800
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
Subject: Re: [PATCH v10 2/2] selftests: add tests for clone3() with *set_tid
Message-ID: <20191114190523.GB171963@gmail.com>
References: <20191114142707.1608679-1-areber@redhat.com>
 <20191114142707.1608679-2-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191114142707.1608679-2-areber@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 03:27:07PM +0100, Adrian Reber wrote:
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
> ---
>  tools/testing/selftests/clone3/.gitignore     |   1 +
>  tools/testing/selftests/clone3/Makefile       |   2 +-
>  tools/testing/selftests/clone3/clone3.c       |   8 +-
>  .../selftests/clone3/clone3_clear_sighand.c   |  20 +-
>  .../selftests/clone3/clone3_selftests.h       |  33 ++
>  .../testing/selftests/clone3/clone3_set_tid.c | 357 ++++++++++++++++++
>  6 files changed, 395 insertions(+), 26 deletions(-)
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
> index 000000000000..988c194d850d
> --- /dev/null
> +++ b/tools/testing/selftests/clone3/clone3_selftests.h
> @@ -0,0 +1,33 @@
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

$ make
gcc -g -I../../../../usr/include/    clone3_set_tid.c  -o /mnt/tools/testing/selftests/clone3/clone3_set_tid
clone3_set_tid.c: In function ‘call_clone3_set_tid’:
clone3_set_tid.c:45:4: error: ‘struct clone_args’ has no member named ‘set_tid’; did you mean ‘parent_tid’?
   45 |   .set_tid = ptr_to_u64(set_tid),
      |    ^~~~~~~
      |    parent_tid
clone3_set_tid.c:46:4: error: ‘struct clone_args’ has no member named ‘set_tid_size’
   46 |   .set_tid_size = set_tid_size,
      |    ^~~~~~~~~~~~
make: *** [../lib.mk:138: /mnt/tools/testing/selftests/clone3/clone3_set_tid] Error 1


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
> index 000000000000..f2bf2e7a0ee6
> --- /dev/null
> +++ b/tools/testing/selftests/clone3/clone3_set_tid.c
> @@ -0,0 +1,357 @@
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
> +		char tmp = 0;
> +
> +		ksft_print_msg("I am the child, my PID is %d (expected %d)\n",
> +			       getpid(), set_tid[0]);
> +		if (wait_for_it) {
> +			ksft_print_msg("[%d] Child is ready and waiting\n",
> +				       getpid());
> +
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
> +	if (expected_pid == 0 || expected_pid == pid) {
> +		ksft_print_msg("I am the parent (%d). My child's pid is %d\n",
> +			       getpid(), pid);
> +	} else {
> +		ksft_print_msg(
> +			"Expected child pid %d does not match actual pid %d\n",
> +			expected_pid, pid);
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
> +			if (i != 3)
> +				ns1 = ns2 = ns3 = 0;
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
> +	if (wait(&status) < 0) {
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
