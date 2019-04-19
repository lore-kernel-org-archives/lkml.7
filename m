Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C554C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0756420693
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="A+wEyI7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfDSTWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:22:39 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36760 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfDSTWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:22:38 -0400
Received: by mail-ed1-f68.google.com with SMTP id u57so5145305edm.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/t6dn8aJULtVinxXkYxOtoSdEtvEHC+4JhcvzHHHW84=;
        b=A+wEyI7Z2jFVTSG0iKbPBVT9ugEJfb+f19137Rx4qkuAcrlot94aqFwIDG6uEAw1pA
         YEeAuEd+95BixZTREfIiYw6xR6N3UNbP2KeMqABeJiPmiv4THOc/a/2pAkkS0Yz4Pzy9
         DH+GgldvvXKiGsXT3zy3qHkvqKt9zXZd8oYTel9v8dVkuMOsgxdZfAZVOY4it54NFc7/
         X54kvsylm6ik0M9GOsy7/f33N9zFhYBV6PitDbEcYAZ/JLOQftX0wXX1RaIG0+A0xTCu
         zaolzj5R7FWLOzdDXF1PyZBY2RSg7JtDfmcEutTsmpXqcGhGw5BHOaUn1J846ffQaiI0
         dfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/t6dn8aJULtVinxXkYxOtoSdEtvEHC+4JhcvzHHHW84=;
        b=MHCJui9XdCvb74YSlB/QKr+JkW7o4uy6qxWXbj+FjLEcXzYiJqqo3LIQ1oHDIgfyD3
         0VI482JeAntK4LFZ32BGZW3aposFFp4afh+qtad6UHslNNLGzZQy5SqhqGFlAc3bnkH7
         PQKgH34CLG5TlVunkXWu39ZcQFEvAPoMu5TtcgqDelAj4qOQANC1z7j0Yvu+bJ2cNNYT
         kKRxnj6zp8VI3NWZ9CORoU5aDUbr8OkOghSmV9kLjoSD9JRRgfthuGRNmxN4XsmmrFyd
         YeqP0PsLCqjwDbD9HIqMPSGyQ1F3M9Vd/scN0Uk+pnlZbseQvBpEO2fLmpCUWlPlCzGf
         UV9w==
X-Gm-Message-State: APjAAAUWQU11k3sUq8QJaTV8KW4rfWlpfFu/y+VBkZT41vJzkgOE16Uh
        ErEqXRanDJeZ+fEiXXpnYPhEcg==
X-Google-Smtp-Source: APXvYqx/LgQuC9KWedOBI4VsMoQOXAMffnos+cQVjlJSkdPWynqstDQZuD2VSaFsPD/EJDWtlo4f5w==
X-Received: by 2002:a50:884c:: with SMTP id c12mr3467514edc.269.1555701756088;
        Fri, 19 Apr 2019 12:22:36 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id s14sm1536939eda.26.2019.04.19.12.22.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Apr 2019 12:22:35 -0700 (PDT)
Date:   Fri, 19 Apr 2019 21:22:34 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Colascione <dancol@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Nadav Amit <namit@vmware.com>, Serge Hallyn <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Taehee Yoo <ap420073@gmail.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-team <kernel-team@android.com>,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
Message-ID: <20190419192233.d2n6al7hgoga6gts@brauner.io>
References: <20190411175043.31207-1-joel@joelfernandes.org>
 <20190416120430.GA15437@redhat.com>
 <20190416192051.GA184889@google.com>
 <20190417130940.GC32622@redhat.com>
 <CAG48ez2Q0t2-rZz8wmGeih=NigYL-CT3+E6NgiPT0AkOQAUPMQ@mail.gmail.com>
 <CEB62F51-E8BF-4EFB-B438-8AF76633FF00@brauner.io>
 <20190419190247.GB251571@google.com>
 <20190419191858.iwcvqm6fihbkaata@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190419191858.iwcvqm6fihbkaata@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 09:18:58PM +0200, Christian Brauner wrote:
> On Fri, Apr 19, 2019 at 03:02:47PM -0400, Joel Fernandes wrote:
> > On Thu, Apr 18, 2019 at 07:26:44PM +0200, Christian Brauner wrote:
> > > On April 18, 2019 7:23:38 PM GMT+02:00, Jann Horn <jannh@google.com> wrote:
> > > >On Wed, Apr 17, 2019 at 3:09 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > > >> On 04/16, Joel Fernandes wrote:
> > > >> > On Tue, Apr 16, 2019 at 02:04:31PM +0200, Oleg Nesterov wrote:
> > > >> > >
> > > >> > > Could you explain when it should return POLLIN? When the whole
> > > >process exits?
> > > >> >
> > > >> > It returns POLLIN when the task is dead or doesn't exist anymore,
> > > >or when it
> > > >> > is in a zombie state and there's no other thread in the thread
> > > >group.
> > > >>
> > > >> IOW, when the whole thread group exits, so it can't be used to
> > > >monitor sub-threads.
> > > >>
> > > >> just in case... speaking of this patch it doesn't modify
> > > >proc_tid_base_operations,
> > > >> so you can't poll("/proc/sub-thread-tid") anyway, but iiuc you are
> > > >going to use
> > > >> the anonymous file returned by CLONE_PIDFD ?
> > > >
> > > >I don't think procfs works that way. /proc/sub-thread-tid has
> > > >proc_tgid_base_operations despite not being a thread group leader.
> > > >(Yes, that's kinda weird.) AFAICS the WARN_ON_ONCE() in this code can
> > > >be hit trivially, and then the code will misbehave.
> > > >
> > > >@Joel: I think you'll have to either rewrite this to explicitly bail
> > > >out if you're dealing with a thread group leader, or make the code
> > > >work for threads, too.
> > > 
> > > The latter case probably being preferred if this API is supposed to be
> > > useable for thread management in userspace.
> > 
> > At the moment, we are not planning to use this for sub-thread management. I
> > am reworking this patch to only work on clone(2) pidfds which makes the above
> 
> Indeed and agreed.
> 
> > discussion about /proc a bit unnecessary I think. Per the latest CLONE_PIDFD
> > patches, CLONE_THREAD with pidfd is not supported.
> 
> Yes. We have no one asking for it right now and we can easily add this
> later.
> 
> Admittedly I haven't gotten around to reviewing the patches here yet
> completely. But one thing about using POLLIN. FreeBSD is using POLLHUP
> on process exit which I think is nice as well. How about returning
> POLLIN | POLLHUP on process exit?
> We already do things like this. For example, when you proxy between
> ttys. If the process that you're reading data from has exited and closed
> it's end you still can't usually simply exit because it might have still
> buffered data that you want to read.  The way one can deal with this
> from  userspace is that you can observe a (POLLHUP | POLLIN) event and
> you keep on reading until you only observe a POLLHUP without a POLLIN
> event at which point you know you have read
> all data.
> I like the semantics for pidfds as well as it would indicate:
> - POLLHUP -> process has exited

or POLLRDHUP. The check you'd usually perform would probably be
if ((revents & (POLLIN | POLLPRI)) > 0) && ((revents & (POLLHUP | POLLRDHUP)) > 0)
        /* keep on trying to read */

I guess you have that set of flags already suggested in another mail?

Christian

> - POLLIN  -> information can be read

> 
> Christian
