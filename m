Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78062C28D18
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C5C72083E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbfFEP62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 11:58:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51476 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728386AbfFEP61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 11:58:27 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8C57F81F0D;
        Wed,  5 Jun 2019 15:58:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id B16BA80B9;
        Wed,  5 Jun 2019 15:58:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  5 Jun 2019 17:58:11 +0200 (CEST)
Date:   Wed, 5 Jun 2019 17:58:01 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, dbueso@suse.de,
        axboe@kernel.dk, dave@stgolabs.net, e@80x24.org, jbaron@akamai.com,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        omar.kilani@gmail.com, tglx@linutronix.de, stable@vger.kernel.org,
        Al Viro <viro@ZenIV.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH -mm 0/1] signal: simplify
 set_user_sigmask/restore_user_sigmask
Message-ID: <20190605155801.GA25165@redhat.com>
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
 <20190529161157.GA27659@redhat.com>
 <20190604134117.GA29963@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604134117.GA29963@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 05 Jun 2019 15:58:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On top of

	signal-remove-the-wrong-signal_pending-check-in-restore_user_sigmask.patch

Let me repeat, every file touched by this patch needs more cleanups,
fs/aio.c looks wrong with or without the recent changes. Lets discuss
this later.

To simplify the review, please see the code with this patch applied.
I am using epoll_pwait() as an example because it looks very simple.

Note that this patch moves WARN_ON(!TIF_SIGPENDING) from set_restore_sigmask()
to restore_unless().

	int set_user_sigmask(const sigset_t __user *umask, size_t sigsetsize)
	{
		sigset_t *kmask;

		if (!umask)
			return 0;
		if (sigsetsize != sizeof(sigset_t))
			return -EINVAL;
		if (copy_from_user(kmask, umask, sizeof(sigset_t)))
			return -EFAULT;

		set_restore_sigmask();
		current->saved_sigmask = current->blocked;
		set_current_blocked(kmask);

		return 0;
	}

	static inline void restore_saved_sigmask_unless(bool interrupted)
	{
		if (interrupted)
			WARN_ON(!test_thread_flag(TIF_SIGPENDING));
		else
			restore_saved_sigmask();
	}

	SYSCALL_DEFINE6(epoll_pwait, int, epfd, struct epoll_event __user *, events,
			int, maxevents, int, timeout, const sigset_t __user *, sigmask,
			size_t, sigsetsize)
	{
		int error;

		/*
		 * If the caller wants a certain signal mask to be set during the wait,
		 * we apply it here.
		 */
		error = set_user_sigmask(sigmask, sigsetsize);
		if (error)
			return error;

		error = do_epoll_wait(epfd, events, maxevents, timeout);
		restore_saved_sigmask_unless(error == -EINTR);

		return error;
	}

Oleg.

