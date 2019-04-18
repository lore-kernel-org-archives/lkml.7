Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864E0C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57716214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VyMHjTIv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389931AbfDRS6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:58:08 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45466 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfDRS6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:58:07 -0400
Received: by mail-oi1-f196.google.com with SMTP id y84so2394993oia.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 11:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JuO+mETd7p+nBl+ISNr5AXSeFCMtbtyi+NcvmZSSpJk=;
        b=VyMHjTIvvFhUx8ve5O2dXCvRG1QNBzaweZBGJUtggcGhLpctkb9MIHLEHMJitAhBGb
         x8t8PFPMfyQz0GuSlqGTIrYOSZGKhr2aVQOuV+1aI8qQYL5v8BctO0IS0cwrFjzKnibN
         9TNjohu52WQbqGMfDIOQPPD9EfTYQ8zXeI58XxLAmXRsb4PCO8aeU1VcGXRmEzCrA2Jv
         3E2LmxoeQLRrsTgLrWVfG1J+sNuZ+gvOWaMIBLnh7CFe2B7YT1Wm3bUdO9OLE/6Ic3QN
         u9D23v98bbEyPBiB0XBY6QfGJwDT+UCcJjIQPSs5Y7rCxyUVtg5C9fwnEMNKWNj0NFpU
         k8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JuO+mETd7p+nBl+ISNr5AXSeFCMtbtyi+NcvmZSSpJk=;
        b=LcM02xi70d8ARh3DiRzOpqm90hMbdMVD8xjjkHU2Y8gRsiDLKsd8i/FvXhjYAgXh63
         iuIcok5B/5CfH7fLg4Mm5vUa1joSsZdNKC9ZSO1UhnKvPdDSz/exiMhKbfDgyM0wsdR6
         1u/kv0PFzwhCE4q/smTCFVMsTN3QUhgb1LcpJVF+5znApvy/7Tz1dsby7V0HClgpd7Hp
         3a8QzgxPYS0VkOARhVbYpHYjezMKGBoQ6oRcfrZOrk4NNppsOi/9H1dCDC02jWcWF/mF
         iJWia/U1vmnwfqlNBQtEUpGq80FgwuqwRdTT5LVC5QC1KvoIzZOc0hPYzFtijCfntV4K
         BvXQ==
X-Gm-Message-State: APjAAAWSiNzw6zibB0mAjvsyNrXM+6fH6/7kvQe9dpZuUee/D4uMtwpu
        Nhz+w+oDSn9NobuC/SKirGKTXy0jrQvpNIYmjVNcrg==
X-Google-Smtp-Source: APXvYqy6cM/03mVmFhmJGDKhomZk2V5jsnvwCjMrNMfZGG1otnS6jWqg8a/TDAOFQyG6MZbnVgtB4Fg5GfwNrx2nQgI=
X-Received: by 2002:aca:510d:: with SMTP id f13mr3032154oib.174.1555613886573;
 Thu, 18 Apr 2019 11:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190411175043.31207-1-joel@joelfernandes.org>
 <20190416120430.GA15437@redhat.com> <20190416192051.GA184889@google.com> <CAGLj2rELsr0PUgu41uZX_TKCpT-Q00X+cvgBhJ-U7RU3EBo5tA@mail.gmail.com>
In-Reply-To: <CAGLj2rELsr0PUgu41uZX_TKCpT-Q00X+cvgBhJ-U7RU3EBo5tA@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Thu, 18 Apr 2019 11:57:54 -0700
Message-ID: <CAKOZueu=5aNf+oDFBM56TbqZwKpB6q1y81V1cbL+k4DTyV53+A@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
To:     Jonathan Kowalski <bl0pbl33p@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Michal Hocko <mhocko@suse.com>,
        Nadav Amit <namit@vmware.com>, Serge Hallyn <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Taehee Yoo <ap420073@gmail.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Android Kernel Team <kernel-team@android.com>,
        Tycho Andersen <tycho@tycho.ws>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 11:44 AM Jonathan Kowalski <bl0pbl33p@gmail.com> wrote:
>
> On Tue, Apr 16, 2019 at 8:21 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Tue, Apr 16, 2019 at 02:04:31PM +0200, Oleg Nesterov wrote:
> > > On 04/11, Joel Fernandes (Google) wrote:
> > > >
> > > > +static unsigned int proc_tgid_base_poll(struct file *file, struct poll_table_struct *pts)
> > > > +{
> > > > +   int poll_flags = 0;
> > > > +   struct task_struct *task;
> > > > +   struct pid *pid;
> > > > +
> > > > +   task = get_proc_task(file->f_path.dentry->d_inode);
> > > > +
> > > > +   WARN_ON_ONCE(task && !thread_group_leader(task));
> > > > +
> > > > +   /*
> > > > +    * tasklist_lock must be held because to avoid racing with
> > > > +    * changes in exit_state and wake up. Basically to avoid:
> > > > +    *
> > > > +    * P0: read exit_state = 0
> > > > +    * P1: write exit_state = EXIT_DEAD
> > > > +    * P1: Do a wake up - wq is empty, so do nothing
> > > > +    * P0: Queue for polling - wait forever.
> > > > +    */
> > > > +   read_lock(&tasklist_lock);
> > > > +   if (!task)
> > > > +           poll_flags = POLLIN | POLLRDNORM | POLLERR;
> > > > +   else if (task->exit_state == EXIT_DEAD)
> > > > +           poll_flags = POLLIN | POLLRDNORM;
> > > > +   else if (task->exit_state == EXIT_ZOMBIE && thread_group_empty(task))
> > > > +           poll_flags = POLLIN | POLLRDNORM;
> > > > +
> > > > +   if (!poll_flags) {
> > > > +           pid = proc_pid(file->f_path.dentry->d_inode);
> > > > +           poll_wait(file, &pid->wait_pidfd, pts);
> > > > +   }
> > >
> > > can't understand...
> > >
> > > Could you explain when it should return POLLIN? When the whole process exits?
> >
> > It returns POLLIN when the task is dead or doesn't exist anymore, or when it
> > is in a zombie state and there's no other thread in the thread group.
> >
>
> Would using something other than POLLIN be an option (maybe POLLPRI)?
> The convention is to use it to indicate readability on the descriptor,
> and also possibly POLLHUP instead of POLLERR (the latter is less of a
> problem, but FreeBSD also does the same, so it'd help with some
> consistency for libraries wanting to use this, which aren't interested
> in other sub states).

Existing event loop libraries generally support checking only for
readability and writability. Not setting POLLIN would make these FDs
more difficult to use with existing event loop libraries. What
advantage would compensate for this difficulty?
