Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7FCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9666B2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553557351;
	bh=9HKKstgDeo0vs0rQiPhWD1UARtFAZEryCAqL281TzC8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0XDoLdejgMEQJjpXLyW9rjs4hNWFD2a1CGxdX8iicp1RP9yFkmndQ66ATp+SZ1Q/H
	 oywXWugvQSe8ujzLbljnvk+tpQ7uhydZFRV8xc6ms5cwYXZmq1IXIn7xmoPdwFd/F9
	 jQc+4IK2x7jGhpxWmaBhxbC0yTVin+9bGh9NW54k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfCYXma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 19:42:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbfCYXm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 19:42:28 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D3AE20854
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 23:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553557347;
        bh=9HKKstgDeo0vs0rQiPhWD1UARtFAZEryCAqL281TzC8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ep/KL1+deZDNfjqGXtXYY2NdhRdebRBYCVkEuBUYdm/oXouy1NtxYOcVOzWAQt4dt
         zCssZYorC9vIBLmbaA4sjJHg3cA3l3jDlLpzPNPfBQCKQIbAFXZb1KvlvSPJ5ayGnl
         iqDJ+CmHgaz9JQmvjSoazOPgJWtxNJDMqP6yQUMk=
Received: by mail-wm1-f47.google.com with SMTP id y197so10956617wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 16:42:27 -0700 (PDT)
X-Gm-Message-State: APjAAAUX3ML+Xz/Bp9aMDNTsLwn0kRlj3FP50IAwCYl7uSx8dXE4XRxi
        gZtsh0fufFiM5eyRpFcnFf2xgWfgVr8JFiYSduCZpw==
X-Google-Smtp-Source: APXvYqy7TwbBmkrbCD21UGhsWd3I+1cLabNvWbVw1JXomyD6gXIFMeYNYciXeA+MXQTdQH5VQE5zd3Brjbbfn57vN+s=
X-Received: by 2002:a7b:c257:: with SMTP id b23mr12729658wmj.83.1553557345804;
 Mon, 25 Mar 2019 16:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190319231020.tdcttojlbmx57gke@brauner.io> <20190320015249.GC129907@google.com>
 <CAKOZuetJzg_EiyuK7Pa13X3LKuBbreg7zJ5g4uQv_uV4wpmZjg@mail.gmail.com>
 <20190320035953.mnhax3vd47ya4zzm@brauner.io> <CAKOZuet3-VhmC3oHtEbPPvdiar_k_QXTf0TkgmH9LiwmW-_oNA@mail.gmail.com>
 <4A06C5BB-9171-4E70-BE31-9574B4083A9F@joelfernandes.org> <20190320182649.spryp5uaeiaxijum@brauner.io>
 <CAKOZuevHbQtrq+Nb-jw1L7O72BmAzcXmbUnfnseeXZjX4PE4tg@mail.gmail.com>
 <20190320185156.7bq775vvtsxqlzfn@brauner.io> <CALCETrXO=V=+qEdLDVPf8eCgLZiB9bOTrUfe0V-U-tUZoeoRDA@mail.gmail.com>
 <20190320191412.5ykyast3rgotz3nu@brauner.io> <CAKOZuesRwQ4=Svu1KgHWY=HZSS8mF8uFmuzuVOSH0QpJoy7a5w@mail.gmail.com>
 <CALCETrUFrFKC2YTLH7ViM_7XPYk3LNmNiaz6s8wtWo1pmJQXzg@mail.gmail.com>
 <CAG48ez3VMjLJBC_F3BxC2sc2s-28NdsrUduR=jX66XH0w2O-Qg@mail.gmail.com> <CAKOZueuNGn31QYpRa5G-OP_S=G3f9TBQ-w27giABn7UVgPQ8Ng@mail.gmail.com>
In-Reply-To: <CAKOZueuNGn31QYpRa5G-OP_S=G3f9TBQ-w27giABn7UVgPQ8Ng@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 25 Mar 2019 16:42:14 -0700
X-Gmail-Original-Message-ID: <CALCETrV-52TXKbAim06Fr7vvFeOvk0SczneeV_Rtqr6-LN7-GQ@mail.gmail.com>
Message-ID: <CALCETrV-52TXKbAim06Fr7vvFeOvk0SczneeV_Rtqr6-LN7-GQ@mail.gmail.com>
Subject: Re: pidfd design
To:     Daniel Colascione <dancol@google.com>
Cc:     Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
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

On Mon, Mar 25, 2019 at 1:23 PM Daniel Colascione <dancol@google.com> wrote:
>
> On Mon, Mar 25, 2019 at 1:14 PM Jann Horn <jannh@google.com> wrote:
> >
> > On Mon, Mar 25, 2019 at 8:44 PM Andy Lutomirski <luto@kernel.org> wrote:

> > One ioctl on procfs roots to translate pidfds into that procfs,
> > subject to both the normal lookup permission checks and only working
> > if the pidfd has a translation into the procfs:
> >
> > int proc_root_fd = open("/proc", O_RDONLY);
> > int proc_dir_fd = ioctl(proc_root_fd, PROC_PIDFD_TO_PROCFSFD, pidfd);
> >
> > And one ioctl on procfs directories to translate from PGIDs and PIDs to pidfds:
> >
> > int proc_pgid_fd = open("/proc/self", O_RDONLY);
> > int self_pg_pidfd = ioctl(proc_pgid_fd, PROC_PROCFSFD_TO_PIDFD, 0);
> > int proc_pid_fd = open("/proc/thread-self", O_RDONLY);
> > int self_p_pidfd = ioctl(proc_pid_fd, PROC_PROCFSFD_TO_PIDFD, 0);
> >

This sounds okay to me.  Or we could make it so that a procfs
directory fd also works as a pidfd, but that seems more likely to be
problematic than just allowing two-way translation like this

> >
> > And then, as you proposed, the new sys_clone() can just return a
> > pidfd, and you can convert it into a procfs fd yourself if you want.
>
> I think that's the consensus we reached on the other thread. The
> O_DIRECTORY open on /proc/self/fd/mypidfd seems like it'd work well
> enough.

I must have missed this particular email.

IMO, if /proc/self/fd/mypidfd allows O_DIRECTORY open to work, then it
really ought to do function just like /proc/self/fd/mypidfd/. and
/proc/self/fd/mypidfd/status should work.  And these latter two
options seem nutty.

Also, this O_DIRECTORY thing is missing the entire point of the ioctl
interface -- it doesn't require procfs access.

--Andy
