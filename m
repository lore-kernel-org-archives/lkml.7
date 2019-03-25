Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEBDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396452083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="cVk1cYHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbfCYXpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 19:45:53 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39890 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfCYXpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 19:45:52 -0400
Received: by mail-ed1-f67.google.com with SMTP id p20so8675416eds.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 16:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OntNR28WwPqMJhtqPqgyFaqEwtslS1iyZrH+qWE3grA=;
        b=cVk1cYHTS0g7sBJckf00k2shHBsR7NFtfywGu/5GYvB1tsc/3Lbf10iQ+E9ejeeQWA
         wzhp3ajCZ0v7IBydAc2BJhEMC9RHlYAqsuCK/VQy5EXhts6+cEbORqG3uCT2jyuzyuem
         bHkPatnI7YmBTNESLmm2ihmeV1zdkeTzKbjyMV0X/JAk+9fz+F9urguId7XhHa5g00i/
         +EcDS8xkrmuyLnLI5tX6vL77ZTtg47mDhNbdXb6Cq1CI9Wzdo6dgWWeDiS5uMk96H+Zf
         1ndlgw77rlMYgr6DHQva2sSu0ZOyYZXMTnK26hGeZc/qPyGGNc3OHsVb1YzM+4I1Ryrv
         hozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OntNR28WwPqMJhtqPqgyFaqEwtslS1iyZrH+qWE3grA=;
        b=hXaVEmH+vFFyhz6TjdT0MJOEctn1n/Wz537aIXvPuYeSnUG/5/4x34yajIJvrd+3vp
         Tw6iwm2/DoVXtvr0GnmhHbBaLsc6XfvU9GxoDYYXPFdcexcnXq/W2XyinPOgC3V+pRwc
         /JZvAVdT5B1b/arP/Tl4pyOHEP1F6RaWW3Vc5EfYwJOHWJoc7YAn97wujpdD/rr0yUlF
         LcoisvvpS8UnyQmn+TYou2CeCyjnQnEyEx2qtJqodmQTqIyXiwL7Vq/G4puVYByrAdh1
         7zl7VdZoOmCBu5+mJNQd9Tz9l0yh5TwxbhX64ts6mhLud0YaH0zUi98J6HqYSyUn4odr
         PG3A==
X-Gm-Message-State: APjAAAV733Bvbg5Ke4usTtciSgaPajRDBCovlf4GDuBF8fLEkLiX+Ivt
        329hRtFQmi6R6EwUB0k/oRYc/w==
X-Google-Smtp-Source: APXvYqyE8W7S06VHzecNenRy2ZyY6i+oXBy3oB6NaHhYyP5nAMAwh++/hNX150czkas+L74GQEWRKg==
X-Received: by 2002:a50:ad58:: with SMTP id z24mr18121001edc.75.1553557550779;
        Mon, 25 Mar 2019 16:45:50 -0700 (PDT)
Received: from brauner.io ([2a02:8109:b6bf:d24a:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id e2sm3787185ejc.53.2019.03.25.16.45.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Mar 2019 16:45:50 -0700 (PDT)
Date:   Tue, 26 Mar 2019 00:45:48 +0100
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
Message-ID: <20190325234547.wo6lyimrp52qie5p@brauner.io>
References: <20190320182649.spryp5uaeiaxijum@brauner.io>
 <CAKOZuevHbQtrq+Nb-jw1L7O72BmAzcXmbUnfnseeXZjX4PE4tg@mail.gmail.com>
 <20190320185156.7bq775vvtsxqlzfn@brauner.io>
 <CALCETrXO=V=+qEdLDVPf8eCgLZiB9bOTrUfe0V-U-tUZoeoRDA@mail.gmail.com>
 <20190320191412.5ykyast3rgotz3nu@brauner.io>
 <CAKOZuesRwQ4=Svu1KgHWY=HZSS8mF8uFmuzuVOSH0QpJoy7a5w@mail.gmail.com>
 <CALCETrUFrFKC2YTLH7ViM_7XPYk3LNmNiaz6s8wtWo1pmJQXzg@mail.gmail.com>
 <CAG48ez3VMjLJBC_F3BxC2sc2s-28NdsrUduR=jX66XH0w2O-Qg@mail.gmail.com>
 <CAKOZueuNGn31QYpRa5G-OP_S=G3f9TBQ-w27giABn7UVgPQ8Ng@mail.gmail.com>
 <CALCETrV-52TXKbAim06Fr7vvFeOvk0SczneeV_Rtqr6-LN7-GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrV-52TXKbAim06Fr7vvFeOvk0SczneeV_Rtqr6-LN7-GQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 04:42:14PM -0700, Andy Lutomirski wrote:
> On Mon, Mar 25, 2019 at 1:23 PM Daniel Colascione <dancol@google.com> wrote:
> >
> > On Mon, Mar 25, 2019 at 1:14 PM Jann Horn <jannh@google.com> wrote:
> > >
> > > On Mon, Mar 25, 2019 at 8:44 PM Andy Lutomirski <luto@kernel.org> wrote:
> 
> > > One ioctl on procfs roots to translate pidfds into that procfs,
> > > subject to both the normal lookup permission checks and only working
> > > if the pidfd has a translation into the procfs:
> > >
> > > int proc_root_fd = open("/proc", O_RDONLY);
> > > int proc_dir_fd = ioctl(proc_root_fd, PROC_PIDFD_TO_PROCFSFD, pidfd);
> > >
> > > And one ioctl on procfs directories to translate from PGIDs and PIDs to pidfds:
> > >
> > > int proc_pgid_fd = open("/proc/self", O_RDONLY);
> > > int self_pg_pidfd = ioctl(proc_pgid_fd, PROC_PROCFSFD_TO_PIDFD, 0);
> > > int proc_pid_fd = open("/proc/thread-self", O_RDONLY);
> > > int self_p_pidfd = ioctl(proc_pid_fd, PROC_PROCFSFD_TO_PIDFD, 0);
> > >
> 
> This sounds okay to me.  Or we could make it so that a procfs
> directory fd also works as a pidfd, but that seems more likely to be
> problematic than just allowing two-way translation like this
> 
> > >
> > > And then, as you proposed, the new sys_clone() can just return a
> > > pidfd, and you can convert it into a procfs fd yourself if you want.
> >
> > I think that's the consensus we reached on the other thread. The
> > O_DIRECTORY open on /proc/self/fd/mypidfd seems like it'd work well
> > enough.
> 
> I must have missed this particular email.
> 
> IMO, if /proc/self/fd/mypidfd allows O_DIRECTORY open to work, then it
> really ought to do function just like /proc/self/fd/mypidfd/. and
> /proc/self/fd/mypidfd/status should work.  And these latter two
> options seem nutty.
> 
> Also, this O_DIRECTORY thing is missing the entire point of the ioctl
> interface -- it doesn't require procfs access.

The other option was to encode the pid in the callers pid namespace into
the pidfd's fdinfo so that you can parse it out and open /proc/<pid>.
You'd just need an event on the pidfd to tell you when the process has
died. Jonathan and I just discussed this.
