Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FD6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DE62075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E30MJRy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfC0RIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:08:22 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36689 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbfC0RIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 13:08:22 -0400
Received: by mail-oi1-f194.google.com with SMTP id t206so13455491oib.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 10:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KLsYT4Bwb6QApsu7GsfOlPR4CdP3tjqhomkZrjbHSJk=;
        b=E30MJRy1LCzO6GUqbMstWn/HHXurSJqiNNyZV+q9F6gTtkVsdhh6NPRw36U2Jyy4N5
         jk+pqJvCTUT1GGvRIiXD9rm8tUGS7xK+J+LlZe4QygkDFuCtTXLY6Hse9DtTaSp2Rs5F
         MOJOpHIMJKd94Py12csKRRu9kArYyJCDWcoN8vmJ9JbD+cKsZUEDbaKUA0vQ/l+xHU9d
         yOj0jIUhxBzn5R7JEk40C1MbQTuNO3mkKpQextXRzpoS1mrnifrWfChP6rqU2IxtSQs0
         gceP76KotfhWpKI5ZzzPiuLDdvn5Ku9y/Z5ccBOnCms/Jz0b1KITV10kTwcoJ7N9++8m
         nJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KLsYT4Bwb6QApsu7GsfOlPR4CdP3tjqhomkZrjbHSJk=;
        b=DvFB5TkNl661noFTIBs3It1egHirCPt/RSrce1a9TE/TMhOueYNegvyivk8UpnY/Dq
         wW2wfTEQJUI1Elx8H8S+VDFSjMq1Q2ui/2Fos+5MeQgLSR3Jz8bBXuYr0Eif0UYvtYgw
         k267FvYHvl1izEMl+OwiayxdlFY9vsdgKsNDtUFzGZncyMqxP/1WnlG8SaurQYTGRuZI
         aHtuFduj4GtMQX+oXDXLKULZ14cNYxsL4PTDeACsbLkchF2NyaEpDue9OMK8Zai+Ogq6
         o9nX4FEFriELcd9AqZ2pxR00zBqQGMgYMyRXKpWfn+weV0CSrJhD0opTWn2FXjKLmait
         k3fQ==
X-Gm-Message-State: APjAAAWg7Zm8ypHXGmfy8f/NQuFDENwzNU346/Ou0neZVPp+hRjv6JfZ
        Ud2k1AcpWQJ/vb+WB5N3Sc6fJDfZ1gsKg710tu0xYg==
X-Google-Smtp-Source: APXvYqx+YXk+xtAMDBkwSUHpdLqSxXIbQ1EXeTzkbEDKZ2nKmXft0FF2vbQFWU7YYgaZoMZjQ2O5a2Lt9Gra15nEWsU=
X-Received: by 2002:aca:4846:: with SMTP id v67mr20621645oia.39.1553706500926;
 Wed, 27 Mar 2019 10:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190327162147.23198-1-christian@brauner.io> <20190327162147.23198-3-christian@brauner.io>
In-Reply-To: <20190327162147.23198-3-christian@brauner.io>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 27 Mar 2019 18:07:54 +0100
Message-ID: <CAG48ez2QgRQKYeNDpacLGCOuNKVM1g=1PK3KzzO2Uoyn2cKXaQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] pid: add pidfd_open()
To:     Christian Brauner <christian@brauner.io>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 5:22 PM Christian Brauner <christian@brauner.io> wrote:
> pidfd_open() allows to retrieve pidfds for processes and removes the
> dependency of pidfd on procfs. Multiple people have expressed a desire to
> do this even when pidfd_send_signal() was merged. It is even recorded in
[...]
> IF PROCFD_TO_PIDFD is passed as a flag together with a file descriptor to a
> /proc mount in a given pid namespace and a pidfd pidfd_open() will return a
> file descriptor to the corresponding /proc/<pid> directory in procfs
> mounts' pid namespace. pidfd_open() is very careful to verify that the pid

nit: s/mounts'/mount's/

> hasn't been recycled in between.
> IF PIDFD_TO_PROCFD is passed as a flag together with a file descriptor
> referencing a /proc/<pid> directory a pidfd referencing the struct pid
> stashed in /proc/<pid> of the process will be returned.

nit: s/of the process //?

> The pidfd_open() syscalls in that manner resembles openat() as it uses a

nit: s/syscalls/syscall/

[...]
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 20881598bdfa..c9e24e726aba 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
[...]
> +static struct file *pidfd_open_proc_pid(const struct file *procf, pid_t pid,
> +                                       const struct pid *pidfd_pid)
> +{
> +       char name[11]; /* int to strlen + \0 */

nit: The comment is a bit off; an unconstrained int needs 1+10+1
bytes, I think? minus sign, 10 digits, nullbyte? But of course that
can't actually happen here.

> +       struct file *file;
> +       struct pid *proc_pid;
> +
> +       snprintf(name, sizeof(name), "%d", pid);
> +       file = file_open_root(procf->f_path.dentry, procf->f_path.mnt, name,
> +                             O_DIRECTORY | O_NOFOLLOW, 0);

Maybe explicitly write the implied O_RDONLY (which is 0) here for clarity?

[...]
> +static int pidfd_to_procfd(pid_t pid, int procfd, int pidfd)
> +{
> +       long fd;
> +       pid_t ns_pid;
> +       struct fd fdproc, fdpid;
> +       struct file *file = NULL;
> +       struct pid *pidfd_pid = NULL;
> +       struct pid_namespace *proc_pid_ns = NULL;
> +
> +       fdproc = fdget(procfd);
> +       if (!fdproc.file)
> +               return -EBADF;
> +
> +       fdpid = fdget(pidfd);
> +       if (!fdpid.file) {
> +               fdput(fdpid);

Typo: s/fdput(fdpid)/fdput(fdproc)/

[...]
> +SYSCALL_DEFINE4(pidfd_open, pid_t, pid, int, procfd, int, pidfd, unsigned int,
> +               flags)
[...]
> +       if (!flags) {
[...]
> +               rcu_read_lock();
> +               pidfd_pid = get_pid(find_pid_ns(pid, task_active_pid_ns(current)));
> +               rcu_read_unlock();

The previous three lines are equivalent to `pidfd_pid = find_get_pid(pid)`.

> +               fd = pidfd_create_fd(pidfd_pid, O_CLOEXEC);

Nit: You could hardcode O_CLOEXEC in pidfd_create_fd() and get rid of
the second function argument if you want to.

> +               put_pid(pidfd_pid);
> +       } else if (flags & PIDFD_TO_PROCFD) {
[...]
> +               fd = pidfd_to_procfd(pid, procfd, pidfd);

The `pid` argument of pidfd_to_procfd() looks unused, maybe it makes
sense to get rid of that?
