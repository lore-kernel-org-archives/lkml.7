Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D166BC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C7120693
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="vFtkEwj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbfDSTCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:02:52 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38349 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbfDSTCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:02:50 -0400
Received: by mail-pl1-f196.google.com with SMTP id f36so2976566plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p9ek9Lo1t5TDwh6GoEDfO3CWDi0O8EcB/kULAdUF/OU=;
        b=vFtkEwj0yv9OP3j0uE/8mvF2oBbaEbnga9y0/sXtRCBUScAMbt5NbTRw9cKstPvPtp
         FG33T7XnDBQnO2UeZGyqTGavpSTMU0mx83wbpIqF/UKm9SlMNGM3hc0ZLXsEMCRt3JoW
         s9Wmh0Xi1JY4d0EDv4nUp4wWSeeRaYl6u3s6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p9ek9Lo1t5TDwh6GoEDfO3CWDi0O8EcB/kULAdUF/OU=;
        b=rqgy5K+5vTR+aYwnbkb82if8TAyx86SpBg/bL2XQtHQIclQ74ICd3iLTo3qDwUKaqC
         SD8yuOdGmltQFUQqsnk7NG7zJ9xos3n3AAeNQdx7gNtPTCMj+FJLwDkKLgto9c/oHCYE
         ANcyMw2iWnS8Zi2GiMa4Lz79A+5ukSKr5sdcjNFw13i5+peDNsfc3J0oRUSrU0VILRii
         AlzY8r46m+Z2B9yW6WaKBoF2ETVbCo09AhOxf5+F5qS0S1nIRM9K2jryI6tnqH2rVDZO
         s6MghVrci+Tzz70Ro9U7QqK9foywg8Ub/hExBiFPNTpua2iHqoALW1Yb6JgCflfxtuXn
         8K+w==
X-Gm-Message-State: APjAAAW/92HypZM0vSDdIQWUoI6JtIhHap4TWmUuCsAUDi70iIztLbZl
        A/8DhyrdGSyP3DFSpbBHLBkQTg==
X-Google-Smtp-Source: APXvYqxsaWDdMXJAhn/z/WdbNMp1NyDUuHVxHZBUgyUycIQ+4HZPM1Nx2CEEyiMjCCtZoDlQM+bZCg==
X-Received: by 2002:a17:902:442:: with SMTP id 60mr5506960ple.107.1555700569184;
        Fri, 19 Apr 2019 12:02:49 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id o89sm9909856pfi.178.2019.04.19.12.02.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 12:02:48 -0700 (PDT)
Date:   Fri, 19 Apr 2019 15:02:47 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Christian Brauner <christian@brauner.io>
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
Message-ID: <20190419190247.GB251571@google.com>
References: <20190411175043.31207-1-joel@joelfernandes.org>
 <20190416120430.GA15437@redhat.com>
 <20190416192051.GA184889@google.com>
 <20190417130940.GC32622@redhat.com>
 <CAG48ez2Q0t2-rZz8wmGeih=NigYL-CT3+E6NgiPT0AkOQAUPMQ@mail.gmail.com>
 <CEB62F51-E8BF-4EFB-B438-8AF76633FF00@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CEB62F51-E8BF-4EFB-B438-8AF76633FF00@brauner.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 07:26:44PM +0200, Christian Brauner wrote:
> On April 18, 2019 7:23:38 PM GMT+02:00, Jann Horn <jannh@google.com> wrote:
> >On Wed, Apr 17, 2019 at 3:09 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >> On 04/16, Joel Fernandes wrote:
> >> > On Tue, Apr 16, 2019 at 02:04:31PM +0200, Oleg Nesterov wrote:
> >> > >
> >> > > Could you explain when it should return POLLIN? When the whole
> >process exits?
> >> >
> >> > It returns POLLIN when the task is dead or doesn't exist anymore,
> >or when it
> >> > is in a zombie state and there's no other thread in the thread
> >group.
> >>
> >> IOW, when the whole thread group exits, so it can't be used to
> >monitor sub-threads.
> >>
> >> just in case... speaking of this patch it doesn't modify
> >proc_tid_base_operations,
> >> so you can't poll("/proc/sub-thread-tid") anyway, but iiuc you are
> >going to use
> >> the anonymous file returned by CLONE_PIDFD ?
> >
> >I don't think procfs works that way. /proc/sub-thread-tid has
> >proc_tgid_base_operations despite not being a thread group leader.
> >(Yes, that's kinda weird.) AFAICS the WARN_ON_ONCE() in this code can
> >be hit trivially, and then the code will misbehave.
> >
> >@Joel: I think you'll have to either rewrite this to explicitly bail
> >out if you're dealing with a thread group leader, or make the code
> >work for threads, too.
> 
> The latter case probably being preferred if this API is supposed to be
> useable for thread management in userspace.

At the moment, we are not planning to use this for sub-thread management. I
am reworking this patch to only work on clone(2) pidfds which makes the above
discussion about /proc a bit unnecessary I think. Per the latest CLONE_PIDFD
patches, CLONE_THREAD with pidfd is not supported.

Also we wanted to make the polling of pidfd quite close to the wait(2) family
semantics which, as I understand correctly, is not something that works for
sub-threads. In the future, we could bail in poll(2) or return an error, if
clone(2) starts supporting thread pidfds, but at the moment I will like to
keep the WARN_ON just in case. Please let me know if I missed something.

thanks!

 - Joel

