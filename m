Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E61C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328CF2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tuVY75I6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfDLPao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:30:44 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37238 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbfDLPan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:30:43 -0400
Received: by mail-vs1-f66.google.com with SMTP id w13so5778236vsc.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 08:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WCeVpCJn+/VBqGO7SUvicv745LSiVr8/+6GQ6wCM828=;
        b=tuVY75I6tPrTGvJwWKarA/iYaQuwlcLQphJVG6VFjczrbRvlWFKr5CGKYTgboJF5+w
         LonhQj++DgJzMYXl/hrWXwkUDYM8ZVK69w1B1kHkx1q495XiDKpPZapStMILRzz2iWkQ
         54R7AvDr8YJ1uRFdEzWYTFlsb6gfNrynNS2HdabUXQR2BQpccHxZ8wFHwY5p0+Lk3xCF
         pbNYktnRXpZbLNkEa+WAdTsvsWnq68E1Vn146Sn9zvgb6JlF7ESh8EPRcVnZxSZjPdO6
         cNYdVsOYAqKiELuT+QU2qHFODxmHPMKMnAj+0S2Tq13iCgTgOg5FcXfNkb7P38ZhBUd1
         ooXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WCeVpCJn+/VBqGO7SUvicv745LSiVr8/+6GQ6wCM828=;
        b=LBM7SG/MhqPs8iM+TwqwiX9/JL2bL/eHDqkLdT0/uirie/+6s8669M3F3lAm+e9kYY
         +ochl/f5x9Jnkf0mM0rlEn0WFc7X8X0/Wa+5RET76qvnJvo4ifGZ4eNp7zJc0tg6HwBp
         aP1hMWiRoKSEPbbJt+94Yer++2yahlKVv6bl1Pvn3kkBwlyO/RT0BtmR33S4jVSE+d5V
         1J2q+B5Ctggw13JpDuxaYUgag+CIUsq9q/sf7CD1usXiMBsMueFgBA2xDCw+FwCVFmFj
         cO9RcMXnwxRJjYs0kBdQR5V+yyF4WuB7kqg99nej09Nk7GC/Tg/1jh+40im/9Cg39EkG
         wF3A==
X-Gm-Message-State: APjAAAXMNZVAY9jME2bcTbJYhMAvlatOIAcpxEqYUwBb0rcNemx/Llay
        x2Ij6s+FoJu8/94mlkOC6Fj1yYVsvT44tPlFhAOFPA==
X-Google-Smtp-Source: APXvYqzVWARcHk7V3SZK97ROzJzUIBAYjoig4ImnN5OLcMFwyeglwtcavgVLfUT+PZoHPi50u3Vwn6FXhv07EAvwLNU=
X-Received: by 2002:a67:6847:: with SMTP id d68mr31850761vsc.90.1555083042000;
 Fri, 12 Apr 2019 08:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190411014353.113252-1-surenb@google.com> <20190411014353.113252-3-surenb@google.com>
 <20190411153313.GE22763@bombadil.infradead.org> <20190412065314.GC13373@dhcp22.suse.cz>
 <CAKOZuetQH1rVtPdMNgw0sdnzWidd6v9eCWscRiOb7Y+3-JQ14Q@mail.gmail.com>
In-Reply-To: <CAKOZuetQH1rVtPdMNgw0sdnzWidd6v9eCWscRiOb7Y+3-JQ14Q@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Fri, 12 Apr 2019 08:30:30 -0700
Message-ID: <CAKOZueu-ZRzzER3Cb6bNBtbmmhBJRzqjGvwvt8KTyVrmP9wQ7g@mail.gmail.com>
Subject: Re: [RFC 2/2] signal: extend pidfd_send_signal() to allow expedited
 process killing
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        yuzhoujian@didichuxing.com,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Shakeel Butt <shakeelb@google.com>,
        Christian Brauner <christian@brauner.io>,
        Minchan Kim <minchan@kernel.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>, linux-mm <linux-mm@kvack.org>,
        lsf-pc@lists.linux-foundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 7:14 AM Daniel Colascione <dancol@google.com> wrote:
>
> On Thu, Apr 11, 2019 at 11:53 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Thu 11-04-19 08:33:13, Matthew Wilcox wrote:
> > > On Wed, Apr 10, 2019 at 06:43:53PM -0700, Suren Baghdasaryan wrote:
> > > > Add new SS_EXPEDITE flag to be used when sending SIGKILL via
> > > > pidfd_send_signal() syscall to allow expedited memory reclaim of the
> > > > victim process. The usage of this flag is currently limited to SIGKILL
> > > > signal and only to privileged users.
> > >
> > > What is the downside of doing expedited memory reclaim?  ie why not do it
> > > every time a process is going to die?
> >
> > Well, you are tearing down an address space which might be still in use
> > because the task not fully dead yeat. So there are two downsides AFAICS.
> > Core dumping which will not see the reaped memory so the resulting
>
> Test for SIGNAL_GROUP_COREDUMP before doing any of this then. If you
> try to start a core dump after reaping begins, too bad: you could have
> raced with process death anyway.
>
> > coredump might be incomplete. And unexpected #PF/gup on the reaped
> > memory will result in SIGBUS.
>
> It's a dying process. Why even bother returning from the fault
> handler? Just treat that situation as a thread exit. There's no need
> to make this observable to userspace at all.

Just for clarity, checking the code, I think we already do this.
zap_other_threads sets SIGKILL pending on every thread in the group,
and we'll handle SIGKILL in the process of taking any page fault or
doing any system call, so I don't think it's actually possible for a
thread in a dying process to observe the SIGBUS that reaping in theory
can generate.
