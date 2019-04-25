Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6F6C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798A42077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 20:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="u60JpgEH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbfDYUAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:00:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34198 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730582AbfDYUAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 16:00:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id b3so459480pfd.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 13:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YlNSEGqvGsK2xSc3bT8VpIFfzPtgMJJdRkn6eq4st2Q=;
        b=u60JpgEHfhqN5XJ9fiY53IvgvzqGK7C3bKOFuFx2xO9SdYrnux6CjRmIH78frzWMyM
         lt5r5DFvPuB4gLI0mP1dKkeiWnJSeP05KKd9Q+2IhMaR1O/hEvolIeyvXey4bCxfHIA5
         teGLAkVDbV2MhlxaGtS6I59+Qbd13pfy+XhDZhDyJlY2nbyCB4Qawq5JmOCmYT7GHaMK
         4UGw7QjG+TCtLl2wicU7pIuqfyFa549hbYCgH3nn9JfMpHxBFrV3HOM/xzNMEGvoL3oD
         zYwVtRCUPOkIC7UhNW0EiXrFXLnvP8WgDyGFBaTjeLU6orSo1cd2JR5ChZ2qTOG/Sl9K
         bqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YlNSEGqvGsK2xSc3bT8VpIFfzPtgMJJdRkn6eq4st2Q=;
        b=X5m4+uhQ/LgSLuCE1y1OAqLWmq9XMwEJwO0bYPostluxv3Cnb5RJZEsKOkCEE6vcNc
         BSGme7D+L+9jM2JLgqdXtrjWpviWXqCpmX18Y9Bj49O0rsqSuHhcuS/F5rFhGY8e+4DP
         +BEbCC8ud3QaEjEDnpnI/av0QCq4JzEtflMtfn8mFNW8JjQO4RqZbdqTOj0DFk7kW0JX
         m5wo48CKpambHIeshbH/yV4/OU8Kn6z6dZqiZHmneclqZtEyi5nsSlaKyWmrIhaPqaKh
         QztLR5nuB7rWwATJQ3sk2yR5uANqYQlp9Fp1JFww3ipre6cf/YC6koZ+p+HA5zgKJirf
         UbCw==
X-Gm-Message-State: APjAAAVk1XPXGXZ3y/9Gcn5+SD+wDCDOq8rLHAqh4CjiqABncxeyEzhd
        1a/w5iXK/TDoeOYudwqOv6N+Jg==
X-Google-Smtp-Source: APXvYqxWswwn7KRPRV7bBtsrp8EeuDpEoPlLMJX/ZGRjWYG7uzLrS3mHWIlySKCrOakzCniT2/62YQ==
X-Received: by 2002:aa7:914d:: with SMTP id 13mr42487302pfi.149.1556222438720;
        Thu, 25 Apr 2019 13:00:38 -0700 (PDT)
Received: from cisco ([2601:282:901:dd7b:7136:cebf:c0d3:8091])
        by smtp.gmail.com with ESMTPSA id p6sm28628796pfd.122.2019.04.25.13.00.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 13:00:37 -0700 (PDT)
Date:   Thu, 25 Apr 2019 14:00:35 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>, dancol@google.com,
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
        torvalds@linux-foundation.org
Subject: Re: [PATCH v1 2/2] Add selftests for pidfd polling
Message-ID: <20190425200035.GC30500@cisco>
References: <20190425190010.46489-1-joel@joelfernandes.org>
 <20190425190010.46489-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425190010.46489-2-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 03:00:10PM -0400, Joel Fernandes (Google) wrote:
>
> +void *test_pidfd_poll_exec_thread(void *priv)

I think everything in this file can be static, there's this one and
3-4 below.

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

If pidfd_clone() fails here, I think things will go haywire below.

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
> +	}
> +
> +	time_t prog_time = time(NULL) - prog_start;
> +
> +	ksft_print_msg("Time waited for child: %lu\n", prog_time);
> +
> +	close(pidfd);
> +
> +	if (prog_time < CHILD_THREAD_MIN_WAIT || prog_time > CHILD_THREAD_MIN_WAIT + 2)
> +		ksft_exit_fail_msg("%s test: Failed\n", test_name);
> +	else
> +		ksft_test_result_pass("%s test: Passed\n", test_name);
> +}
> +
> +void *test_pidfd_poll_leader_exit_thread(void *priv)
> +{
> +	char waittime[256];
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
> +{
> +	int pid, pidfd = 0;
> +	int status, ret;
> +	time_t prog_start = time(NULL);
> +	const char *test_name = "pidfd_poll check for premature notification on non-empty"
> +				"group leader exit";
> +
> +	child_exit_secs = mmap(NULL, sizeof *child_exit_secs, PROT_READ | PROT_WRITE,
> +			MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +
> +	ksft_print_msg("Parent: pid: %d\n", getpid());
> +	pid = pidfd_clone(CLONE_PIDFD, &pidfd, child_poll_leader_exit_test);

Same problem here, I think.

Tycho
