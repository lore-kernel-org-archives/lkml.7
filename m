Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2181C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E91206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 13:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="C0ZDr728"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfDZNrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 09:47:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44134 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZNrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 09:47:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id z16so1654659pgv.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 06:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s2DAuFsWw5aBuX0/1KyP86Ft3Z7evjqTlyxIMditW9I=;
        b=C0ZDr728d6502R19f7P0Tpvg2LYSRxndxVRp0hExV/BeiVJH1U+PrNCP6vjpPDD5D3
         gPVEVyu4UR3ZfqPsx3wPa22BcOhMMMhmOepSJ9dOHCP5hrBl2BMxj0zf2OQEpJphTxqG
         PqKEAHxnQShwQHf0q/Tj/A1afpSGfvok0Tzq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s2DAuFsWw5aBuX0/1KyP86Ft3Z7evjqTlyxIMditW9I=;
        b=INMDq+MeynZV+poOpotXZAXoeFXxFW35BQH+9JjQk/ppgjYDNBtOLGSM7l98EPCaTk
         vTbO9Q27hMUpmz8UxMq5JvKSYcLpw8f1K/fRdEqfpIx2ooRseF4h1RJZ8GCOIfWGgkE7
         MlqHGMXW23WFJnP/HdhwCN5t58tZrsGcBc18zJIAVNpEoglM7sEktopqflc8P6v+2rCG
         LzMt6mY0GNH647RMqkmi+QCbO2HKEf05l21rrESdOACgz60hOYyDh/F+ogrWpdFECdVl
         rMksg2Me3kYiLFh0YnvN3+YfXyAvGaDLXUk9zFo7eo0T1suu8OJar+0h1/l4YMgS9HAE
         yhWQ==
X-Gm-Message-State: APjAAAVDIlU7Bf9+ym/hdyh6GcRzDJD/uZlrdznHlTgJKrH5V6qbpVnu
        qC7pn5t/2Yb9Z8onfHfndRS08w==
X-Google-Smtp-Source: APXvYqz+ZtLpxoMuC8333yqzmmRYlsUXD0Ar9uE7X+ov0vHCZZr8Dhe5vxrs/2EjImy7+TKjjKIvaA==
X-Received: by 2002:a63:4548:: with SMTP id u8mr43406902pgk.435.1556286441266;
        Fri, 26 Apr 2019 06:47:21 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id x6sm59899087pfb.171.2019.04.26.06.47.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 06:47:20 -0700 (PDT)
Date:   Fri, 26 Apr 2019 09:47:19 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Tycho Andersen <tycho@tycho.ws>
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
Message-ID: <20190426134719.GB261279@google.com>
References: <20190425190010.46489-1-joel@joelfernandes.org>
 <20190425190010.46489-2-joel@joelfernandes.org>
 <20190425200035.GC30500@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425200035.GC30500@cisco>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 02:00:35PM -0600, Tycho Andersen wrote:
> On Thu, Apr 25, 2019 at 03:00:10PM -0400, Joel Fernandes (Google) wrote:
> >
> > +void *test_pidfd_poll_exec_thread(void *priv)
> 
> I think everything in this file can be static, there's this one and
> 3-4 below.
> 
> > +int test_pidfd_poll_exec(int use_waitpid)
> > +{
> > +	int pid, pidfd = 0;
> > +	int status, ret;
> > +	pthread_t t1;
> > +	time_t prog_start = time(NULL);
> > +	const char *test_name = "pidfd_poll check for premature notification on child thread exec";
> > +
> > +	ksft_print_msg("Parent: pid: %d\n", getpid());
> > +	pid = pidfd_clone(CLONE_PIDFD, &pidfd, child_poll_exec_test);
> 
> If pidfd_clone() fails here, I think things will go haywire below.
> 
> > +	ksft_print_msg("Parent: Waiting for Child (%d) to complete.\n", pid);
> > +
> > +	if (use_waitpid) {
> > +		ret = waitpid(pid, &status, 0);
> > +		if (ret == -1)
> > +			ksft_print_msg("Parent: error\n");
> > +
> > +		if (ret == pid)
> > +			ksft_print_msg("Parent: Child process waited for.\n");
> > +	} else {
> > +		poll_pidfd(test_name, pidfd);
> > +	}
> > +
> > +	time_t prog_time = time(NULL) - prog_start;
> > +
> > +	ksft_print_msg("Time waited for child: %lu\n", prog_time);
> > +
> > +	close(pidfd);
> > +
> > +	if (prog_time < CHILD_THREAD_MIN_WAIT || prog_time > CHILD_THREAD_MIN_WAIT + 2)
> > +		ksft_exit_fail_msg("%s test: Failed\n", test_name);
> > +	else
> > +		ksft_test_result_pass("%s test: Passed\n", test_name);
> > +}
> > +
> > +void *test_pidfd_poll_leader_exit_thread(void *priv)
> > +{
> > +	char waittime[256];
> > +
> > +	ksft_print_msg("Child Thread: starting. pid %d tid %d ; and sleeping\n",
> > +			getpid(), syscall(SYS_gettid));
> > +	sleep(CHILD_THREAD_MIN_WAIT);
> > +	ksft_print_msg("Child Thread: DONE. pid %d tid %d\n", getpid(), syscall(SYS_gettid));
> > +	return NULL;
> > +}
> > +
> > +static time_t *child_exit_secs;
> > +static int child_poll_leader_exit_test(void *args)
> > +{
> > +	pthread_t t1, t2;
> > +
> > +	ksft_print_msg("Child: starting. pid %d tid %d\n", getpid(), syscall(SYS_gettid));
> > +	pthread_create(&t1, NULL, test_pidfd_poll_leader_exit_thread, NULL);
> > +	pthread_create(&t2, NULL, test_pidfd_poll_leader_exit_thread, NULL);
> > +
> > +	/*
> > +	 * glibc exit calls exit_group syscall, so explicity call exit only
> > +	 * so that only the group leader exits, leaving the threads alone.
> > +	 */
> > +	*child_exit_secs = time(NULL);
> > +	syscall(SYS_exit, 0);
> > +}
> > +
> > +int test_pidfd_poll_leader_exit(int use_waitpid)
> > +{
> > +	int pid, pidfd = 0;
> > +	int status, ret;
> > +	time_t prog_start = time(NULL);
> > +	const char *test_name = "pidfd_poll check for premature notification on non-empty"
> > +				"group leader exit";
> > +
> > +	child_exit_secs = mmap(NULL, sizeof *child_exit_secs, PROT_READ | PROT_WRITE,
> > +			MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> > +
> > +	ksft_print_msg("Parent: pid: %d\n", getpid());
> > +	pid = pidfd_clone(CLONE_PIDFD, &pidfd, child_poll_leader_exit_test);
> 
> Same problem here, I think.


All comments address and fixed in the next revision, thanks!

 - Joel

