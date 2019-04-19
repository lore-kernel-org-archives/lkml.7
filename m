Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D21C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 23:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3912171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 23:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rMPM8cWY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfDSXgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 19:36:39 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35079 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfDSXgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 19:36:38 -0400
Received: by mail-ua1-f68.google.com with SMTP id a46so2157545uae.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 16:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=++Hp+hQI2A1lbNdiR3ijME7viUSjt5MJqK0zoL6hpGs=;
        b=rMPM8cWY1AXSzGuo4F8G3XIUsErUC/EfMes/xzkWnNqw/pAJ9YoifQRn5q3yVOED52
         /4fReHjdsTJQA7W6wfujd757niPnZj7a9F1okbD/up1AioZcDDq16uULa/VMIkzhtRNN
         tUVzVef5Gg+SHDx7fXhYyFgGy1f6IRZDyYnDvrfJhMhNuif0VmdKybINXZU6VHZzHHcp
         3McBJoiFFnrahQX3YH3mwb5i0LbY7O7ZKcrdURxSWfoVp9V0Kpp5mAP6ZWqns8dwhmkx
         yD4+EBDUaVQhhediuKvv9tqYNzvFdh1eLIoFO3MAu9uIize0pmTf2xjm+8Bc038P/cko
         gJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++Hp+hQI2A1lbNdiR3ijME7viUSjt5MJqK0zoL6hpGs=;
        b=P20G+YwqDJD6tPHuAL1prhJ0p/Pgko+TEZuq7jqHZO6NOin1gZAoPxz/fk6DI9BhzR
         Prdgq7Kf4c0Scqcr3MSWvHXQg2rTTyfdbqFuMgIYkQt1gYqdO8AtbaMBhiuUu1AjXg7P
         WvCp/YGCXmkvc16hT/9bQgW97l59RJY/qS1nKaLq6I8GWCcrY01905c6gBBkEMHE7k2n
         ylaVu1UfKNBKrMGVRHCL5/kvtizzi37gXkMlm5Ekhpv2p+D5eBh0J9BZlPVnfyjik06p
         g02polcAdq2hhr9F/X4wRbJHghY1aJqA4H+cR0GXo3UYHITOQvPvUlzCGFHybCZCsA39
         l0AQ==
X-Gm-Message-State: APjAAAVPhOqF7oEskGWLzvYQFdrfbYpcXPrVFVrtiNq1s4Tzhr58womz
        XminH6rxNcfF1qWT9mcrQq2De7dFax2StUCs9Ekm8A==
X-Google-Smtp-Source: APXvYqzLC4ZjSeDdJMdXEbR8m38Zmo8UgbhwnJKRh0h4dE8Xr+s9ErQGpjRcPxstuCYsckX8Ha6E4Zi25USLfkxiG18=
X-Received: by 2002:ab0:72c2:: with SMTP id g2mr3472560uap.112.1555716996563;
 Fri, 19 Apr 2019 16:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190416120430.GA15437@redhat.com> <20190416192051.GA184889@google.com>
 <20190417130940.GC32622@redhat.com> <CAG48ez2Q0t2-rZz8wmGeih=NigYL-CT3+E6NgiPT0AkOQAUPMQ@mail.gmail.com>
 <CEB62F51-E8BF-4EFB-B438-8AF76633FF00@brauner.io> <20190419190247.GB251571@google.com>
 <20190419191858.iwcvqm6fihbkaata@brauner.io> <20190419194902.GE251571@google.com>
 <CAKOZueu3PzD_QgROXFRs8FvD=HTKJLsHDK9GrUdbFoMzx_7HEA@mail.gmail.com>
 <CAHrFyr4REuKFuARAXnhBC67TGzyDGmMONc7XjfUGvf+Qfm7EuQ@mail.gmail.com>
 <20190419212002.GB44851@google.com> <CAHk-=wiiYUuk7LrkNaggvzZqB63Efu5sChV5hAOdn1ZfunUw6Q@mail.gmail.com>
 <CAHrFyr6rA7w6H_N5bV_9EY26Jxza1TLp6=rLL7=grK6_tp6cHw@mail.gmail.com> <CAHk-=wh8DmfsOFY4OrqRjLYCYi+2Ej7uLbidmiPg+BhBOGZVcA@mail.gmail.com>
In-Reply-To: <CAHk-=wh8DmfsOFY4OrqRjLYCYi+2Ej7uLbidmiPg+BhBOGZVcA@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Fri, 19 Apr 2019 16:36:24 -0700
Message-ID: <CAKOZuesaWK1Y7c85jNv71LNx7sKoGgn_eLzQVPnoi6e4eUx4aQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <christian@brauner.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Michal Hocko <mhocko@suse.com>,
        Nadav Amit <namit@vmware.com>, Serge Hallyn <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Taehee Yoo <ap420073@gmail.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-team <kernel-team@android.com>,
        Tycho Andersen <tycho@tycho.ws>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 4:33 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Apr 19, 2019 at 4:20 PM Christian Brauner <christian@brauner.io> wrote:
> >
> > On Sat, Apr 20, 2019 at 1:11 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > It's also worth noting that POLLERR/POLLHUP/POLLNVAL cannot be masked
> > > for "poll()". Even if you only ask for POLLIN/POLLOUT, you will always
> > > get POLLERR/POLLHUP notification. That is again historical behavior,
> > > and it's kind of a "you can't poll a hung up fd". But it once again
> > > means that you should consider POLLHUP to be something *exceptional*
> > > and final, where no further or other state changes can happen or are
> > > relevant.
> >
> > Which kind of makes sense for process exit. So the historical behavior
> > here is in our favor and having POLLIN | POLLHUP rather fitting.
> > It just seems right that POLLHUP indicates "there can be
> > no more state transitions".
>
> Note that that is *not* true of process exit.
>
> The final state transition isn't "exit", it is actually "process has
> been reaped".  That's the point where data no longer exists.

FWIW, I think the exit status should be available via pidfd even after
process reaping. A non-parent holder of a pidfd has no ability to
control when the parent reaps the child, or even if reaping is
necessary at all --- the parent could make SIGCHLD SIG_IGN. Someone
trying to read exit status via a pidfd shouldn't fail to get that exit
status just because he lost the race with a concurrent waitpid().
