Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC19C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02A32075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 21:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="YYb7ELx/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfC0VCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 17:02:40 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33806 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbfC0VCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 17:02:40 -0400
Received: by mail-ed1-f67.google.com with SMTP id x14so12685628eds.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 14:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LlIEBLkG/ptrBRITODZ2BGZimwHWFV6sCRCJ6XJ1NOY=;
        b=YYb7ELx/b45ech/Zsx3KjBt8HMpg12fQVJohywpSOX477Wf2DgZfKJWayTSkoJxTn0
         RIqRA5vfo9/sVoH1POf65NcuH9NcQa+R0fFxZvvPtePo9LSsteqPRNJxDYvpVHSv5wW+
         +x4aDJQIwmHVKIt4m6fT/oWWwEbKXs2VPRPRUhNwWPRstM1miPg9DeTU0qH56WBV8FF0
         uz3MKldOk/kptZR4OhI1Hx8vvs1Hane3yvcnVlvhDp7+BPmt748f6XIXw7ndpiqk5VAC
         zdYivONYW8p4dSTwczWU6hMv8L55Sb9fIoKLJmkhzy0kPuWlmS1waKM0A2aLslBKsDhZ
         GIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LlIEBLkG/ptrBRITODZ2BGZimwHWFV6sCRCJ6XJ1NOY=;
        b=kzpjg8BbZ/Dyqb0K77XbtupAtHgDpd0NOUNMowgUfHcIEG6XNpX8eB6FDVdPL2QRUo
         JP/y2oqV7ndONgT4B61NtmERh8D84Bvgucgdxwtn7Tm/S9HULDvov9pUSZVXtLEDoceH
         B3DgDYdW5mgi43NiQ6UtiZ/hhRULvEu7lEVP1T2Hn0JffTOluuIPW0w0+vrWdKS+Aic8
         0jkdzRhAO0f+J4jNtYfuEuDNSz6eWlVF6widBtxYSLYZq/afjQ0D0oFTAJ/NeSFqA+Js
         f607rvQRH1tS+Vv8RIjVPOUqvsrySM4Hoq6giwkqyxhsi1+Bj0IqziGmMQmLw7qtr9MS
         Tm1g==
X-Gm-Message-State: APjAAAX6QAlHeMfjnBwc34uh7rE8Wa9X7idML1JejIttbf/pyrZvDzOf
        L4GGYtQVy0Wu2vnZfImEyiM1Xg==
X-Google-Smtp-Source: APXvYqxhfNEUaG9Wy1XEl6H6xGlHLsrvVfMyIGUUghjyiWk9xCiXEvPSlpFarTcBOCW1aiYhwbzZzA==
X-Received: by 2002:a17:906:4bc3:: with SMTP id x3mr19989451ejv.150.1553720557662;
        Wed, 27 Mar 2019 14:02:37 -0700 (PDT)
Received: from brauner.io ([2a02:8109:b6bf:d24a:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id e2sm4872787ejc.53.2019.03.27.14.02.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 27 Mar 2019 14:02:37 -0700 (PDT)
Date:   Wed, 27 Mar 2019 22:02:35 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Jann Horn <jannh@google.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Subject: Re: [PATCH 2/4] pid: add pidfd_open()
Message-ID: <20190327210234.po2t3m3575tqdcac@brauner.io>
References: <20190327162147.23198-1-christian@brauner.io>
 <20190327162147.23198-3-christian@brauner.io>
 <CAG48ez2QgRQKYeNDpacLGCOuNKVM1g=1PK3KzzO2Uoyn2cKXaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez2QgRQKYeNDpacLGCOuNKVM1g=1PK3KzzO2Uoyn2cKXaQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 06:07:54PM +0100, Jann Horn wrote:
> On Wed, Mar 27, 2019 at 5:22 PM Christian Brauner <christian@brauner.io> wrote:
> > pidfd_open() allows to retrieve pidfds for processes and removes the
> > dependency of pidfd on procfs. Multiple people have expressed a desire to
> > do this even when pidfd_send_signal() was merged. It is even recorded in
> [...]
> > IF PROCFD_TO_PIDFD is passed as a flag together with a file descriptor to a
> > /proc mount in a given pid namespace and a pidfd pidfd_open() will return a
> > file descriptor to the corresponding /proc/<pid> directory in procfs
> > mounts' pid namespace. pidfd_open() is very careful to verify that the pid
> 
> nit: s/mounts'/mount's/

Thanks.

> 
> > hasn't been recycled in between.
> > IF PIDFD_TO_PROCFD is passed as a flag together with a file descriptor
> > referencing a /proc/<pid> directory a pidfd referencing the struct pid
> > stashed in /proc/<pid> of the process will be returned.
> 
> nit: s/of the process //?

Yes.

> 
> > The pidfd_open() syscalls in that manner resembles openat() as it uses a
> 
> nit: s/syscalls/syscall/

Thanks.

> 
> [...]
> > diff --git a/kernel/pid.c b/kernel/pid.c
> > index 20881598bdfa..c9e24e726aba 100644
> > --- a/kernel/pid.c
> > +++ b/kernel/pid.c
> [...]
> > +static struct file *pidfd_open_proc_pid(const struct file *procf, pid_t pid,
> > +                                       const struct pid *pidfd_pid)
> > +{
> > +       char name[11]; /* int to strlen + \0 */
> 
> nit: The comment is a bit off; an unconstrained int needs 1+10+1
> bytes, I think? minus sign, 10 digits, nullbyte? But of course that
> can't actually happen here.

Yes, the comment is misleading.

> 
> > +       struct file *file;
> > +       struct pid *proc_pid;
> > +
> > +       snprintf(name, sizeof(name), "%d", pid);
> > +       file = file_open_root(procf->f_path.dentry, procf->f_path.mnt, name,
> > +                             O_DIRECTORY | O_NOFOLLOW, 0);
> 
> Maybe explicitly write the implied O_RDONLY (which is 0) here for clarity?

Yes.

> 
> [...]
> > +static int pidfd_to_procfd(pid_t pid, int procfd, int pidfd)
> > +{
> > +       long fd;
> > +       pid_t ns_pid;
> > +       struct fd fdproc, fdpid;
> > +       struct file *file = NULL;
> > +       struct pid *pidfd_pid = NULL;
> > +       struct pid_namespace *proc_pid_ns = NULL;
> > +
> > +       fdproc = fdget(procfd);
> > +       if (!fdproc.file)
> > +               return -EBADF;
> > +
> > +       fdpid = fdget(pidfd);
> > +       if (!fdpid.file) {
> > +               fdput(fdpid);
> 
> Typo: s/fdput(fdpid)/fdput(fdproc)/

Good catch!

> 
> [...]
> > +SYSCALL_DEFINE4(pidfd_open, pid_t, pid, int, procfd, int, pidfd, unsigned int,
> > +               flags)
> [...]
> > +       if (!flags) {
> [...]
> > +               rcu_read_lock();
> > +               pidfd_pid = get_pid(find_pid_ns(pid, task_active_pid_ns(current)));
> > +               rcu_read_unlock();
> 
> The previous three lines are equivalent to `pidfd_pid = find_get_pid(pid)`.

Perfect, will replace.

> 
> > +               fd = pidfd_create_fd(pidfd_pid, O_CLOEXEC);
> 
> Nit: You could hardcode O_CLOEXEC in pidfd_create_fd() and get rid of
> the second function argument if you want to.

Hm, let me rename this to pidfd_create_cloexec(pidfd_pid) then.

> 
> > +               put_pid(pidfd_pid);
> > +       } else if (flags & PIDFD_TO_PROCFD) {
> [...]
> > +               fd = pidfd_to_procfd(pid, procfd, pidfd);
> 
> The `pid` argument of pidfd_to_procfd() looks unused, maybe it makes
> sense to get rid of that?

Yes.
