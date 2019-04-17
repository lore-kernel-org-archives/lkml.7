Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7165C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8A32173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732221AbfDQNJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:09:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729898AbfDQNJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:09:47 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2573B88ABF;
        Wed, 17 Apr 2019 13:09:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id B9C2C19C58;
        Wed, 17 Apr 2019 13:09:41 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 17 Apr 2019 15:09:46 +0200 (CEST)
Date:   Wed, 17 Apr 2019 15:09:41 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, luto@amacapital.net,
        rostedt@goodmis.org, dancol@google.com, christian@brauner.io,
        jannh@google.com, surenb@google.com, torvalds@linux-foundation.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>, Nadav Amit <namit@vmware.com>,
        Serge Hallyn <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Taehee Yoo <ap420073@gmail.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
Message-ID: <20190417130940.GC32622@redhat.com>
References: <20190411175043.31207-1-joel@joelfernandes.org>
 <20190416120430.GA15437@redhat.com>
 <20190416192051.GA184889@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416192051.GA184889@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 17 Apr 2019 13:09:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/16, Joel Fernandes wrote:
>
> On Tue, Apr 16, 2019 at 02:04:31PM +0200, Oleg Nesterov wrote:
> >
> > Could you explain when it should return POLLIN? When the whole process exits?
>
> It returns POLLIN when the task is dead or doesn't exist anymore, or when it
> is in a zombie state and there's no other thread in the thread group.

IOW, when the whole thread group exits, so it can't be used to monitor sub-threads.

just in case... speaking of this patch it doesn't modify proc_tid_base_operations,
so you can't poll("/proc/sub-thread-tid") anyway, but iiuc you are going to use
the anonymous file returned by CLONE_PIDFD ?


> > Then all you need is
> >
> > 	!task || task->exit_state && thread_group_empty(task)
>
> Yes this works as well, all the tests pass with your suggestion so I'll
> change it to that. Although I will the be giving up returing EPOLLERR if the
> task_struct doesn't exit. We don't need that, but I thought it was cool to
> return it anyway.

OK, task == NULL means that it was already reaped by parent, pid_nr is free,
probably useful....

> > Please do not use EXIT_DEAD/EXIT_ZOMBIE. And ->wait_pidfd should probably
> > live in task->signal_struct.
>
> About wait_pidfd living in signal_struct, that wont work since the waitqueue
> has to survive for the duration of the poll system call.

That is why I said this will need the additional cleanup in free_signal_struct().
But I was wrong, somehow I forgot that free_poll_entry() needs wq_head->lock ;)
so this will need much more complications, lets forget it...

> Also the waitqueue living in struct pid solves the de_thread() issue I
> mentioned later in the following thread and in the commit message:
> https://lore.kernel.org/patchwork/comment/1257175/

Hmm...

	2. By including the struct pid for the waitqueue means that during
	de_exec, the thread doing de_thread() automatically gets the new
	waitqueue/pid even though its task_struct is different.

this one?

this is not true, or I do not understand...

it gets the _same_ (old, not new) PIDTYPE_TGID pid even if it changes task_struct.
But probably this is what you actually meant, because this is what your patch wants
or I am totally confused.

And note that exec/de_thread doesn't change ->signal_struct, so I do not understand
you anyway. Nevermind.

Oleg.

