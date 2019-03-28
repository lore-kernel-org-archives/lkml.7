Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB34C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482F22173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 09:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="LioPs6i1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfC1JV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 05:21:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44231 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfC1JV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 05:21:26 -0400
Received: by mail-ed1-f68.google.com with SMTP id x10so16475069edh.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 02:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dthA24exXBdVdwNPMINaQPNMYrI6kaqq3CGd2cJRnVM=;
        b=LioPs6i1LkKjlEldVmTEnUDNCqqudksyP5enmwrVZv5dEEhOVcqqiLjxqN34Z1lL/U
         w1NFjG7SFxvVYXg981mFGBHLBlXC/UI0fXXolD4RtZ0OYQlPdsQmzU6B8zxivCivf2iu
         xfXBezSPCktU/Eb8GutYtR6vFcVklAV4qq1cSW5yXxXADpf1BFGfwc1/P374eSZnsdkA
         SYIkgHy1kOBF+M2L7wGioAWxLdtluC1yXXLdw4U2dHZUgvjVoPXd2WUWPsE8mYknbySJ
         twFEoFkOfU5zyKvau3DC2b59AzgMId5F6yAEhqsAkIrav2BLf8VJB+cRXBQ75yXDs8KO
         7xiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dthA24exXBdVdwNPMINaQPNMYrI6kaqq3CGd2cJRnVM=;
        b=bcNCzBL5Zh4CBM87DbbcC5VBBPDLGQnwVcEDw/JQvhKUBvlSPsj5W02xtLTeRlemh+
         MXtbvPgS6/BJ7wrydz0C+iD1ehtl8GOeKolv2xdRxaFpizd4kMWUg+BD1pGAb8m1UAIQ
         83L9pD02pU6DnjZFconwJQY3pqbjgHQxxz1ZUWyeu3ftKnbHBQHDzKNk3kIPXRzPMGwQ
         tP25MnWfbFiemIp2lKkoSCEGx2+ewXHmZvbtWCo50uaHjYneeq6ehqiibrTk0/yAaWGi
         +AhGcIHu5aJd4AU5/OrBycl3BQq0X5m3NufIIi/uSDZ0n+oTmyDmRU5g48DvxDG4h09Y
         EVZQ==
X-Gm-Message-State: APjAAAVQ0ToQJ1vn0PIvCobE1xXq86d+xTOqBU1Qo1xjdsjYqcIvlgZ6
        2Km3ODwGbZhcdxBo0ZLxmDQIrA==
X-Google-Smtp-Source: APXvYqyigINdqSkbxjNAzSJxg98BtMSdT++AXcyNNoZGfp71kIMq/vTBQ0pc0WEJoqIRlEhTJWA2JA==
X-Received: by 2002:a50:a5e5:: with SMTP id b34mr15502306edc.260.1553764883571;
        Thu, 28 Mar 2019 02:21:23 -0700 (PDT)
Received: from brauner.io ([193.96.224.243])
        by smtp.gmail.com with ESMTPSA id a25sm2048698edc.55.2019.03.28.02.21.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 28 Mar 2019 02:21:22 -0700 (PDT)
Date:   Thu, 28 Mar 2019 10:21:21 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Daniel Colascione <dancol@google.com>,
        Jann Horn <jannh@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
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
Subject: Re: pidfd design
Message-ID: <20190328092119.bzyjp4a6mk7yfoep@brauner.io>
References: <20190320191412.5ykyast3rgotz3nu@brauner.io>
 <CAKOZuesRwQ4=Svu1KgHWY=HZSS8mF8uFmuzuVOSH0QpJoy7a5w@mail.gmail.com>
 <CALCETrUFrFKC2YTLH7ViM_7XPYk3LNmNiaz6s8wtWo1pmJQXzg@mail.gmail.com>
 <CAG48ez3VMjLJBC_F3BxC2sc2s-28NdsrUduR=jX66XH0w2O-Qg@mail.gmail.com>
 <CAKOZueuNGn31QYpRa5G-OP_S=G3f9TBQ-w27giABn7UVgPQ8Ng@mail.gmail.com>
 <CALCETrV-52TXKbAim06Fr7vvFeOvk0SczneeV_Rtqr6-LN7-GQ@mail.gmail.com>
 <20190325234547.wo6lyimrp52qie5p@brauner.io>
 <CALCETrXfNV5marXSEDGm6F03DNC2a_M+NE94=GxEbH9oJyWkYA@mail.gmail.com>
 <20190326001231.3tnhhlvzg26mof33@brauner.io>
 <CALCETrUSaj+iTEOgEvy30eiCi2+FoN8+bq2BjJmamCjJ4yeBjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrUSaj+iTEOgEvy30eiCi2+FoN8+bq2BjJmamCjJ4yeBjA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 05:24:49PM -0700, Andy Lutomirski wrote:
> On Mon, Mar 25, 2019 at 5:12 PM Christian Brauner <christian@brauner.io> wrote:
> >
> > On Mon, Mar 25, 2019 at 05:00:17PM -0700, Andy Lutomirski wrote:
> > > On Mon, Mar 25, 2019 at 4:45 PM Christian Brauner <christian@brauner.io> wrote:
> > > >
> > > > On Mon, Mar 25, 2019 at 04:42:14PM -0700, Andy Lutomirski wrote:
> > > > > On Mon, Mar 25, 2019 at 1:23 PM Daniel Colascione <dancol@google.com> wrote:
> > > > > >
> > > > > > On Mon, Mar 25, 2019 at 1:14 PM Jann Horn <jannh@google.com> wrote:
> > > > > > >
> > > > > > > On Mon, Mar 25, 2019 at 8:44 PM Andy Lutomirski <luto@kernel.org> wrote:
> > > > >
> > > > > > > One ioctl on procfs roots to translate pidfds into that procfs,
> > > > > > > subject to both the normal lookup permission checks and only working
> > > > > > > if the pidfd has a translation into the procfs:
> > > > > > >
> > > > > > > int proc_root_fd = open("/proc", O_RDONLY);
> > > > > > > int proc_dir_fd = ioctl(proc_root_fd, PROC_PIDFD_TO_PROCFSFD, pidfd);
> > > > > > >
> > > > > > > And one ioctl on procfs directories to translate from PGIDs and PIDs to pidfds:
> > > > > > >
> > > > > > > int proc_pgid_fd = open("/proc/self", O_RDONLY);
> > > > > > > int self_pg_pidfd = ioctl(proc_pgid_fd, PROC_PROCFSFD_TO_PIDFD, 0);
> > > > > > > int proc_pid_fd = open("/proc/thread-self", O_RDONLY);
> > > > > > > int self_p_pidfd = ioctl(proc_pid_fd, PROC_PROCFSFD_TO_PIDFD, 0);
> > > > > > >
> > > > >
> > > > > This sounds okay to me.  Or we could make it so that a procfs
> > > > > directory fd also works as a pidfd, but that seems more likely to be
> > > > > problematic than just allowing two-way translation like this
> > > > >
> > > > > > >
> > > > > > > And then, as you proposed, the new sys_clone() can just return a
> > > > > > > pidfd, and you can convert it into a procfs fd yourself if you want.
> > > > > >
> > > > > > I think that's the consensus we reached on the other thread. The
> > > > > > O_DIRECTORY open on /proc/self/fd/mypidfd seems like it'd work well
> > > > > > enough.
> > > > >
> > > > > I must have missed this particular email.
> > > > >
> > > > > IMO, if /proc/self/fd/mypidfd allows O_DIRECTORY open to work, then it
> > > > > really ought to do function just like /proc/self/fd/mypidfd/. and
> > > > > /proc/self/fd/mypidfd/status should work.  And these latter two
> > > > > options seem nutty.
> > > > >
> > > > > Also, this O_DIRECTORY thing is missing the entire point of the ioctl
> > > > > interface -- it doesn't require procfs access.
> > > >
> > > > The other option was to encode the pid in the callers pid namespace into
> > > > the pidfd's fdinfo so that you can parse it out and open /proc/<pid>.
> > > > You'd just need an event on the pidfd to tell you when the process has
> > > > died. Jonathan and I just discussed this.
> > >
> > > From an application developer's POV, the ioctl interface sounds much,
> > > much nicer.
> >
> > Some people are strongly against ioctl()s some don't. I'm not against
> > them so both options are fine with me if people can agree.
> >
> 
> There are certainly non-ioctl equivalents that are functionally
> equivalent.  For example, there could be a syscall
> procfs_open_pidfd(procfs_fd, pid_fd).  I personally don't really mind
> ioctl() when it's really an operation on an fd.

I totally missed that mail somehow.
Yes, I agree that an ioctl() makes sense for that.
