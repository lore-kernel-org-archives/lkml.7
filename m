Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518E8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A83220830
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553559906;
	bh=moN+zykb8LJi23F5i1HmNugTTV3G0I4cScO6wV9ZQjU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kUNPlceCPkeoBVjLJipWrJTCXmlWhRXowpy30xXoQ+2w1i2IBeuyYGl2duYo6rct5
	 xfjJIrk/XkoVteA2y9OCSgkdxtrR4Yz6XaALou/hEOJyR9yw3yRsobxW7rWbc4lvtX
	 lNXXULAq0yRY/u2Dqfy1+JvcDLoiPFQ+wtDYmG+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfCZAZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:25:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbfCZAZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:25:04 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72B362087E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 00:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553559902;
        bh=moN+zykb8LJi23F5i1HmNugTTV3G0I4cScO6wV9ZQjU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yA1WlJZNlVpKQorSa6pyd9UUzYIbH6aegdAvtZrADM8j2r9YLoQf+DuTBLCjp/eII
         tZWpgTqVAmrwLNl7kMz/qQYOuIzxv6oZlkdBsOu1xvdBjcYDoCUgWogVoBz/H3H9/J
         +KSIqGaAYxqpRxW//TyE8mycWEuP8J0BxWuP8ixs=
Received: by mail-wr1-f47.google.com with SMTP id q1so12291001wrp.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:25:02 -0700 (PDT)
X-Gm-Message-State: APjAAAXGtgqOckuhRFCLvns91FWotR4uAbtS2CGy2VLhYqKYmuZpkjiw
        yeOBQhIjnqPmGXqXwWqOzwqejNoWONS7g4AsxmOOdw==
X-Google-Smtp-Source: APXvYqxfQ/3Qk3gx8fzj2tM9BDE6Q2rGHlxEgkFQJ8urhUWrAgbU1kKqij10TOSDQdGYVQW8SoHPgjwEDAUv/KzGAx4=
X-Received: by 2002:a5d:4710:: with SMTP id y16mr16771189wrq.176.1553559900918;
 Mon, 25 Mar 2019 17:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190320185156.7bq775vvtsxqlzfn@brauner.io> <CALCETrXO=V=+qEdLDVPf8eCgLZiB9bOTrUfe0V-U-tUZoeoRDA@mail.gmail.com>
 <20190320191412.5ykyast3rgotz3nu@brauner.io> <CAKOZuesRwQ4=Svu1KgHWY=HZSS8mF8uFmuzuVOSH0QpJoy7a5w@mail.gmail.com>
 <CALCETrUFrFKC2YTLH7ViM_7XPYk3LNmNiaz6s8wtWo1pmJQXzg@mail.gmail.com>
 <CAG48ez3VMjLJBC_F3BxC2sc2s-28NdsrUduR=jX66XH0w2O-Qg@mail.gmail.com>
 <CAKOZueuNGn31QYpRa5G-OP_S=G3f9TBQ-w27giABn7UVgPQ8Ng@mail.gmail.com>
 <CALCETrV-52TXKbAim06Fr7vvFeOvk0SczneeV_Rtqr6-LN7-GQ@mail.gmail.com>
 <20190325234547.wo6lyimrp52qie5p@brauner.io> <CALCETrXfNV5marXSEDGm6F03DNC2a_M+NE94=GxEbH9oJyWkYA@mail.gmail.com>
 <20190326001231.3tnhhlvzg26mof33@brauner.io>
In-Reply-To: <20190326001231.3tnhhlvzg26mof33@brauner.io>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 25 Mar 2019 17:24:49 -0700
X-Gmail-Original-Message-ID: <CALCETrUSaj+iTEOgEvy30eiCi2+FoN8+bq2BjJmamCjJ4yeBjA@mail.gmail.com>
Message-ID: <CALCETrUSaj+iTEOgEvy30eiCi2+FoN8+bq2BjJmamCjJ4yeBjA@mail.gmail.com>
Subject: Re: pidfd design
To:     Christian Brauner <christian@brauner.io>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Jann Horn <jannh@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        kernel-team <kernel-team@android.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 5:12 PM Christian Brauner <christian@brauner.io> wrote:
>
> On Mon, Mar 25, 2019 at 05:00:17PM -0700, Andy Lutomirski wrote:
> > On Mon, Mar 25, 2019 at 4:45 PM Christian Brauner <christian@brauner.io> wrote:
> > >
> > > On Mon, Mar 25, 2019 at 04:42:14PM -0700, Andy Lutomirski wrote:
> > > > On Mon, Mar 25, 2019 at 1:23 PM Daniel Colascione <dancol@google.com> wrote:
> > > > >
> > > > > On Mon, Mar 25, 2019 at 1:14 PM Jann Horn <jannh@google.com> wrote:
> > > > > >
> > > > > > On Mon, Mar 25, 2019 at 8:44 PM Andy Lutomirski <luto@kernel.org> wrote:
> > > >
> > > > > > One ioctl on procfs roots to translate pidfds into that procfs,
> > > > > > subject to both the normal lookup permission checks and only working
> > > > > > if the pidfd has a translation into the procfs:
> > > > > >
> > > > > > int proc_root_fd = open("/proc", O_RDONLY);
> > > > > > int proc_dir_fd = ioctl(proc_root_fd, PROC_PIDFD_TO_PROCFSFD, pidfd);
> > > > > >
> > > > > > And one ioctl on procfs directories to translate from PGIDs and PIDs to pidfds:
> > > > > >
> > > > > > int proc_pgid_fd = open("/proc/self", O_RDONLY);
> > > > > > int self_pg_pidfd = ioctl(proc_pgid_fd, PROC_PROCFSFD_TO_PIDFD, 0);
> > > > > > int proc_pid_fd = open("/proc/thread-self", O_RDONLY);
> > > > > > int self_p_pidfd = ioctl(proc_pid_fd, PROC_PROCFSFD_TO_PIDFD, 0);
> > > > > >
> > > >
> > > > This sounds okay to me.  Or we could make it so that a procfs
> > > > directory fd also works as a pidfd, but that seems more likely to be
> > > > problematic than just allowing two-way translation like this
> > > >
> > > > > >
> > > > > > And then, as you proposed, the new sys_clone() can just return a
> > > > > > pidfd, and you can convert it into a procfs fd yourself if you want.
> > > > >
> > > > > I think that's the consensus we reached on the other thread. The
> > > > > O_DIRECTORY open on /proc/self/fd/mypidfd seems like it'd work well
> > > > > enough.
> > > >
> > > > I must have missed this particular email.
> > > >
> > > > IMO, if /proc/self/fd/mypidfd allows O_DIRECTORY open to work, then it
> > > > really ought to do function just like /proc/self/fd/mypidfd/. and
> > > > /proc/self/fd/mypidfd/status should work.  And these latter two
> > > > options seem nutty.
> > > >
> > > > Also, this O_DIRECTORY thing is missing the entire point of the ioctl
> > > > interface -- it doesn't require procfs access.
> > >
> > > The other option was to encode the pid in the callers pid namespace into
> > > the pidfd's fdinfo so that you can parse it out and open /proc/<pid>.
> > > You'd just need an event on the pidfd to tell you when the process has
> > > died. Jonathan and I just discussed this.
> >
> > From an application developer's POV, the ioctl interface sounds much,
> > much nicer.
>
> Some people are strongly against ioctl()s some don't. I'm not against
> them so both options are fine with me if people can agree.
>

There are certainly non-ioctl equivalents that are functionally
equivalent.  For example, there could be a syscall
procfs_open_pidfd(procfs_fd, pid_fd).  I personally don't really mind
ioctl() when it's really an operation on an fd.
