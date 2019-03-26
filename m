Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A424C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226C720854
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553558433;
	bh=oxT/NQkiXnzvMNM9hpfA4gFWBFUhLaf1LWzTnXR9rJw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=upW6sKaDvpfLYSQyBFaWIrfZDexQ1yq9LtIKLbhr9lGxaKGalCi/ujmLheem1FwF+
	 slaRwJHoIRwPAcWcFskkJplW9P4WLiXfq3xwnj0oMHvtM6SZdhIb6xgzNheMd4YGhE
	 BlIxjCsOFcVjRpHHsZ1pD8ILi15jM0hTvnPJshTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbfCZAAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:00:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbfCZAAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:00:31 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A174121473
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 00:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553558429;
        bh=oxT/NQkiXnzvMNM9hpfA4gFWBFUhLaf1LWzTnXR9rJw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tcCDzthCN33eOoGu+1aba3At76TFGH1g54qZCrD/RtSQO2fD49BdYmRls0LAHSlcF
         EEe74GcdJKBV8uwS3lR376uNbeuu/oOk9pz9yYRiTafoCO3JEz9/nYTBkUGPnw0xn8
         e91WWjbFVIAOD1F+6IOn0XFAzaLqNGrNk31/PW78=
Received: by mail-wr1-f50.google.com with SMTP id t5so12176472wri.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:00:29 -0700 (PDT)
X-Gm-Message-State: APjAAAWhvN5aGJK85VKiBaxHo6QjsgwedUkDABg3eCx0XDa8gZ6CeKvc
        gBvIN2wD9lnlRVI2/zDOnneggN7iMZ91YkDXh7HsaA==
X-Google-Smtp-Source: APXvYqy92KXbgfkNrlT+M2PQrrEztjGhDnl9MDRvFlShz/ofJN1sFpDSC9i2qlYBaGIimyvOe3Pq5bbN65/xXbnjxKI=
X-Received: by 2002:adf:f011:: with SMTP id j17mr15076684wro.330.1553558428240;
 Mon, 25 Mar 2019 17:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190320182649.spryp5uaeiaxijum@brauner.io> <CAKOZuevHbQtrq+Nb-jw1L7O72BmAzcXmbUnfnseeXZjX4PE4tg@mail.gmail.com>
 <20190320185156.7bq775vvtsxqlzfn@brauner.io> <CALCETrXO=V=+qEdLDVPf8eCgLZiB9bOTrUfe0V-U-tUZoeoRDA@mail.gmail.com>
 <20190320191412.5ykyast3rgotz3nu@brauner.io> <CAKOZuesRwQ4=Svu1KgHWY=HZSS8mF8uFmuzuVOSH0QpJoy7a5w@mail.gmail.com>
 <CALCETrUFrFKC2YTLH7ViM_7XPYk3LNmNiaz6s8wtWo1pmJQXzg@mail.gmail.com>
 <CAG48ez3VMjLJBC_F3BxC2sc2s-28NdsrUduR=jX66XH0w2O-Qg@mail.gmail.com>
 <CAKOZueuNGn31QYpRa5G-OP_S=G3f9TBQ-w27giABn7UVgPQ8Ng@mail.gmail.com>
 <CALCETrV-52TXKbAim06Fr7vvFeOvk0SczneeV_Rtqr6-LN7-GQ@mail.gmail.com> <20190325234547.wo6lyimrp52qie5p@brauner.io>
In-Reply-To: <20190325234547.wo6lyimrp52qie5p@brauner.io>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 25 Mar 2019 17:00:17 -0700
X-Gmail-Original-Message-ID: <CALCETrXfNV5marXSEDGm6F03DNC2a_M+NE94=GxEbH9oJyWkYA@mail.gmail.com>
Message-ID: <CALCETrXfNV5marXSEDGm6F03DNC2a_M+NE94=GxEbH9oJyWkYA@mail.gmail.com>
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

On Mon, Mar 25, 2019 at 4:45 PM Christian Brauner <christian@brauner.io> wrote:
>
> On Mon, Mar 25, 2019 at 04:42:14PM -0700, Andy Lutomirski wrote:
> > On Mon, Mar 25, 2019 at 1:23 PM Daniel Colascione <dancol@google.com> wrote:
> > >
> > > On Mon, Mar 25, 2019 at 1:14 PM Jann Horn <jannh@google.com> wrote:
> > > >
> > > > On Mon, Mar 25, 2019 at 8:44 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > > > One ioctl on procfs roots to translate pidfds into that procfs,
> > > > subject to both the normal lookup permission checks and only working
> > > > if the pidfd has a translation into the procfs:
> > > >
> > > > int proc_root_fd = open("/proc", O_RDONLY);
> > > > int proc_dir_fd = ioctl(proc_root_fd, PROC_PIDFD_TO_PROCFSFD, pidfd);
> > > >
> > > > And one ioctl on procfs directories to translate from PGIDs and PIDs to pidfds:
> > > >
> > > > int proc_pgid_fd = open("/proc/self", O_RDONLY);
> > > > int self_pg_pidfd = ioctl(proc_pgid_fd, PROC_PROCFSFD_TO_PIDFD, 0);
> > > > int proc_pid_fd = open("/proc/thread-self", O_RDONLY);
> > > > int self_p_pidfd = ioctl(proc_pid_fd, PROC_PROCFSFD_TO_PIDFD, 0);
> > > >
> >
> > This sounds okay to me.  Or we could make it so that a procfs
> > directory fd also works as a pidfd, but that seems more likely to be
> > problematic than just allowing two-way translation like this
> >
> > > >
> > > > And then, as you proposed, the new sys_clone() can just return a
> > > > pidfd, and you can convert it into a procfs fd yourself if you want.
> > >
> > > I think that's the consensus we reached on the other thread. The
> > > O_DIRECTORY open on /proc/self/fd/mypidfd seems like it'd work well
> > > enough.
> >
> > I must have missed this particular email.
> >
> > IMO, if /proc/self/fd/mypidfd allows O_DIRECTORY open to work, then it
> > really ought to do function just like /proc/self/fd/mypidfd/. and
> > /proc/self/fd/mypidfd/status should work.  And these latter two
> > options seem nutty.
> >
> > Also, this O_DIRECTORY thing is missing the entire point of the ioctl
> > interface -- it doesn't require procfs access.
>
> The other option was to encode the pid in the callers pid namespace into
> the pidfd's fdinfo so that you can parse it out and open /proc/<pid>.
> You'd just need an event on the pidfd to tell you when the process has
> died. Jonathan and I just discussed this.

From an application developer's POV, the ioctl interface sounds much,
much nicer.
