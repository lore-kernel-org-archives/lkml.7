Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970F4C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E60A20850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="U4qUTd4s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfDKUCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:02:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54710 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfDKUCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:02:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id c1so8274139wml.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 13:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=1BmaUiVc5tqO/JRNx08TNGC03SMqvGWlWsQ4IUnSQe4=;
        b=U4qUTd4s2iJHh9Qa7lPPUtdckEj4VLk+x/xMcsD1vendeUrYZFwzKnOpQWuY379qe2
         HGPOrjot2Yt3yI97mpxR5vo7NPygWbAUbXo7pY3gm62nkJQrKN6nlck7WqNVQ3wcUrsc
         /c+Xz7v+fLtFlHW+C+IyzEClA+/TRNVXAwvk6xB3dwsYWQDOB8yLDNfuhlttrTqvlgbB
         crGqpqljGG/VqciB00JQn7nraIagz0f2F05t/tdEKxgzBWHkVaUrd2S+3o2URVu7r8l+
         ExY3+9xQ6DiVKsqwiE6L3dbZ9RVf/+MiiK5wH/+0c6aOZ2mf2FzcL1G1CaTDOpTEDsKV
         Uqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=1BmaUiVc5tqO/JRNx08TNGC03SMqvGWlWsQ4IUnSQe4=;
        b=ftsf+6YFTEFhY7BzVu1IpYWKsVf9veU9CC5LdUjnxGPJIjJlUKw9rRH/6QCfgpkIYi
         qTMTFDaZpiSEUgLSAcpweMeu2WC4kh0o8zd76GExiJYgCAAfYSxGUghekw7CDWtxWU+M
         L0qCClI9JDh8cQ0JlEAbFN5odEXnmc/zbOb4F3ymFBmpsWWkO6u4Krkvk0I9NJ4YVMWJ
         3oE+ggoJCNnqUjtg3tIzWYHHcnix9bPxtgLGdN6WcA0hqg7qU5HBkkImsmnKCzLBPdlW
         1pczZNhl4+3Q3EEywku325xcoZtj49BiID9jShqQrE3P1dpMPkG++DrJhvdbvV2s25nZ
         YK1w==
X-Gm-Message-State: APjAAAWmElgEdSaMf2Ff8cob2uaSs/5bg4/JB1oJqeEiGYV3UnlcOHKd
        lEg6+SsIfaOwgnBgQe+o7mCEZw==
X-Google-Smtp-Source: APXvYqxG9tH6JuNDhWIhB5WxjpE8THlF0T6eE3Cv22x182Ke+vu00qmBM0w5nH1l7bH33DrWsBHocQ==
X-Received: by 2002:a1c:e0d6:: with SMTP id x205mr8250590wmg.28.1555012967067;
        Thu, 11 Apr 2019 13:02:47 -0700 (PDT)
Received: from [192.168.88.118] (x4db77fd8.dyn.telefonica.de. [77.183.127.216])
        by smtp.gmail.com with ESMTPSA id y133sm9483592wmd.2.2019.04.11.13.02.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 13:02:46 -0700 (PDT)
Date:   Thu, 11 Apr 2019 22:02:32 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20190411200059.GA75190@google.com>
References: <20190411175043.31207-1-joel@joelfernandes.org> <20190411200059.GA75190@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
To:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
CC:     luto@amacapital.net, rostedt@goodmis.org, dancol@google.com,
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
        Oleg Nesterov <oleg@redhat.com>,
        Serge Hallyn <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Taehee Yoo <ap420073@gmail.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        Tycho Andersen <tycho@tycho.ws>
From:   Christian Brauner <christian@brauner.io>
Message-ID: <DA36DE02-73C2-4C9E-9761-27B3EBC6FED2@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On April 11, 2019 10:00:59 PM GMT+02:00, Joel Fernandes <joel@joelfernandes=
=2Eorg> wrote:
>On Thu, Apr 11, 2019 at 01:50:42PM -0400, Joel Fernandes (Google)
>wrote:
>> pidfd are /proc/pid directory file descriptors referring to a task
>group
>> leader=2E Android low memory killer (LMK) needs pidfd polling support
>to
>> replace code that currently checks for existence of /proc/pid for
>> knowing a process that is signalled to be killed has died, which is
>both
>> racy and slow=2E The pidfd poll approach is race-free, and also allows
>the
>> LMK to do other things (such as by polling on other fds) while
>awaiting
>> the process being killed to die=2E
>
>It appears to me that the "pidfd" now will be an anon inode fd, and not
>based
>on /proc/, based on discussions with Linus=2E So I'll rework the patches
>accordingly=2E However that is relatively independent of this patch so
>this
>version can also be reviewed before I send out the reworked version=2E

Thank you very much, Joel=2E
I'm off this week and traveling but I'll try to give it a look asap=2E

Christian

>
>thanks,
>
> - Joel
>
>>=20
>> It prevents a situation where a PID is reused between when LMK sends
>a
>> kill signal and checks for existence of the PID, since the wrong PID
>is
>> now possibly checked for existence=2E
>>=20
>> In this patch, we follow the same mechanism used uhen the parent of
>the
>> task group is to be notified, that is when the tasks waiting on a
>poll
>> of pidfd are also awakened=2E
>>=20
>> We have decided to include the waitqueue in struct pid for the
>following
>> reasons:
>> 1=2E The wait queue has to survive for the lifetime of the poll=2E
>Including
>> it in task_struct would not be option in this case because the task
>can
>> be reaped and destroyed before the poll returns=2E
>>=20
>> 2=2E By including the struct pid for the waitqueue means that during
>> de_exec, the thread doing de_thread() automatically gets the new
>> waitqueue/pid even though its task_struct is different=2E
>>=20
>> Appropriate test cases are added in the second patch to provide
>coverage
>> of all the cases the patch is handling=2E
>>=20
>> Andy had a similar patch [1] in the past which was a good reference
>> however this patch tries to handle different situations properly
>related
>> to thread group existence, and how/where it notifies=2E And also solves
>> other bugs (existence of taks_struct)=2E  Daniel had a similar patch
>[2]
>> recently which this patch supercedes=2E
>>=20
>> [1] https://lore=2Ekernel=2Eorg/patchwork/patch/345098/
>> [2]
>https://lore=2Ekernel=2Eorg/lkml/20181029175322=2E189042-1-dancol@google=
=2Ecom/
>>=20
>> Cc: luto@amacapital=2Enet
>> Cc: rostedt@goodmis=2Eorg
>> Cc: dancol@google=2Ecom
>> Cc: christian@brauner=2Eio
>> Cc: jannh@google=2Ecom
>> Cc: surenb@google=2Ecom
>> Cc: torvalds@linux-foundation=2Eorg
>> Co-developed-by: Daniel Colascione <dancol@google=2Ecom>
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes=2Eorg>
>>=20
>> ---
>>  fs/proc/base=2Ec      | 39 +++++++++++++++++++++++++++++++++++++++
>>  include/linux/pid=2Eh |  3 +++
>>  kernel/exit=2Ec       |  1 -
>>  kernel/pid=2Ec        |  2 ++
>>  kernel/signal=2Ec     | 14 ++++++++++++++
>>  5 files changed, 58 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/fs/proc/base=2Ec b/fs/proc/base=2Ec
>> index 6a803a0b75df=2E=2E879900082647 100644
>> --- a/fs/proc/base=2Ec
>> +++ b/fs/proc/base=2Ec
>> @@ -3069,8 +3069,47 @@ static int proc_tgid_base_readdir(struct file
>*file, struct dir_context *ctx)
>>  				   tgid_base_stuff, ARRAY_SIZE(tgid_base_stuff));
>>  }
>> =20
>> +static unsigned int proc_tgid_base_poll(struct file *file, struct
>poll_table_struct *pts)
>> +{
>> +	int poll_flags =3D 0;
>> +	struct task_struct *task;
>> +	struct pid *pid;
>> +
>> +	task =3D get_proc_task(file->f_path=2Edentry->d_inode);
>> +
>> +	WARN_ON_ONCE(task && !thread_group_leader(task));
>> +
>> +	/*
>> +	 * tasklist_lock must be held because to avoid racing with
>> +	 * changes in exit_state and wake up=2E Basically to avoid:
>> +	 *
>> +	 * P0: read exit_state =3D 0
>> +	 * P1: write exit_state =3D EXIT_DEAD
>> +	 * P1: Do a wake up - wq is empty, so do nothing
>> +	 * P0: Queue for polling - wait forever=2E
>> +	 */
>> +	read_lock(&tasklist_lock);
>> +	if (!task)
>> +		poll_flags =3D POLLIN | POLLRDNORM | POLLERR;
>> +	else if (task->exit_state =3D=3D EXIT_DEAD)
>> +		poll_flags =3D POLLIN | POLLRDNORM;
>> +	else if (task->exit_state =3D=3D EXIT_ZOMBIE &&
>thread_group_empty(task))
>> +		poll_flags =3D POLLIN | POLLRDNORM;
>> +
>> +	if (!poll_flags) {
>> +		pid =3D proc_pid(file->f_path=2Edentry->d_inode);
>> +		poll_wait(file, &pid->wait_pidfd, pts);
>> +	}
>> +	read_unlock(&tasklist_lock);
>> +
>> +	if (task)
>> +		put_task_struct(task);
>> +	return poll_flags;
>> +}
>> +
>>  static const struct file_operations proc_tgid_base_operations =3D {
>>  	=2Eread		=3D generic_read_dir,
>> +	=2Epoll		=3D proc_tgid_base_poll,
>>  	=2Eiterate_shared	=3D proc_tgid_base_readdir,
>>  	=2Ellseek		=3D generic_file_llseek,
>>  };
>> diff --git a/include/linux/pid=2Eh b/include/linux/pid=2Eh
>> index b6f4ba16065a=2E=2E2e0dcbc6d14e 100644
>> --- a/include/linux/pid=2Eh
>> +++ b/include/linux/pid=2Eh
>> @@ -3,6 +3,7 @@
>>  #define _LINUX_PID_H
>> =20
>>  #include <linux/rculist=2Eh>
>> +#include <linux/wait=2Eh>
>> =20
>>  enum pid_type
>>  {
>> @@ -60,6 +61,8 @@ struct pid
>>  	unsigned int level;
>>  	/* lists of tasks that use this pid */
>>  	struct hlist_head tasks[PIDTYPE_MAX];
>> +	/* wait queue for pidfd pollers */
>> +	wait_queue_head_t wait_pidfd;
>>  	struct rcu_head rcu;
>>  	struct upid numbers[1];
>>  };
>> diff --git a/kernel/exit=2Ec b/kernel/exit=2Ec
>> index 2166c2d92ddc=2E=2Ec386ec52687d 100644
>> --- a/kernel/exit=2Ec
>> +++ b/kernel/exit=2Ec
>> @@ -181,7 +181,6 @@ static void delayed_put_task_struct(struct
>rcu_head *rhp)
>>  	put_task_struct(tsk);
>>  }
>> =20
>> -
>>  void release_task(struct task_struct *p)
>>  {
>>  	struct task_struct *leader;
>> diff --git a/kernel/pid=2Ec b/kernel/pid=2Ec
>> index 20881598bdfa=2E=2E5c90c239242f 100644
>> --- a/kernel/pid=2Ec
>> +++ b/kernel/pid=2Ec
>> @@ -214,6 +214,8 @@ struct pid *alloc_pid(struct pid_namespace *ns)
>>  	for (type =3D 0; type < PIDTYPE_MAX; ++type)
>>  		INIT_HLIST_HEAD(&pid->tasks[type]);
>> =20
>> +	init_waitqueue_head(&pid->wait_pidfd);
>> +
>>  	upid =3D pid->numbers + ns->level;
>>  	spin_lock_irq(&pidmap_lock);
>>  	if (!(ns->pid_allocated & PIDNS_ADDING))
>> diff --git a/kernel/signal=2Ec b/kernel/signal=2Ec
>> index f98448cf2def=2E=2Ee3781703ef7e 100644
>> --- a/kernel/signal=2Ec
>> +++ b/kernel/signal=2Ec
>> @@ -1800,6 +1800,17 @@ int send_sigqueue(struct sigqueue *q, struct
>pid *pid, enum pid_type type)
>>  	return ret;
>>  }
>> =20
>> +static void do_wakeup_pidfd_pollers(struct task_struct *task)
>> +{
>> +	struct pid *pid;
>> +
>> +	lockdep_assert_held(&tasklist_lock);
>> +
>> +	pid =3D get_task_pid(task, PIDTYPE_PID);
>> +	wake_up_all(&pid->wait_pidfd);
>> +	put_pid(pid);
>> +}
>> +
>>  /*
>>   * Let a parent know about the death of a child=2E
>>   * For a stopped/continued status change, use
>do_notify_parent_cldstop instead=2E
>> @@ -1823,6 +1834,9 @@ bool do_notify_parent(struct task_struct *tsk,
>int sig)
>>  	BUG_ON(!tsk->ptrace &&
>>  	       (tsk->group_leader !=3D tsk || !thread_group_empty(tsk)));
>> =20
>> +	/* Wake up all pidfd waiters */
>> +	do_wakeup_pidfd_pollers(tsk);
>> +
>>  	if (sig !=3D SIGCHLD) {
>>  		/*
>>  		 * This is only possible if parent =3D=3D real_parent=2E
>> --=20
>> 2=2E21=2E0=2E392=2Egf8f6787159e-goog
>>=20

