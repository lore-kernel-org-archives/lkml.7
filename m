Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7429C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10D02184D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="exjzghzO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731696AbfG3RpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:45:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43398 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfG3RpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:45:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id p13so66692450wru.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 10:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=55SXhObGMSQ3B0w5iMjyyzalfBJzrVOBbclW7iiKCkQ=;
        b=exjzghzO7EhbkTlYRFfZpr6tmrtVXcAc1TUpBd+Kl4u2JUg38zLUxXExvK1XJMeAHr
         SlyxbTxUP2z+uLswK5N+R5aD9XurFsnLC7er31ADmEw6e+cthpO8vgTny/Txh/AaxhZy
         UyP5/EwXK5UjoggTiOow6IAF0r7VTqfO69BIgtbWgyUNP0ncKxhxcQKicE91n2/lV9GL
         ULiImcXpHVtfhBQVZL6kj0KY15jtIpMDwL5j/EdSck5lUOzB7BhcXdADbWAn7+0ox4AY
         clZVy+4OW2s2Mz0wdzzmFCii/R+659YbFBpBorz3TPYwfRJ6Uo8crDJGkNoDfjYysPcj
         PCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=55SXhObGMSQ3B0w5iMjyyzalfBJzrVOBbclW7iiKCkQ=;
        b=finrWbkXXRC3P99OUfc6GDYVLBCHAtjI3bFmDmKqGYd3aNGHqeyh3geJPYtiFwbRD7
         Eymr7s/30W+HUX+pROP+6eh44GWxKSWnmrErLugljrmJGJIyN7wTk/s5NsdBkcsX77Bo
         QhTpPia9FJK1IjY/rKrCPLa+/Vsc2284ImB8UnzEOoXY4+0d0DyQv03cYsdEfUYVUkVG
         xtTKnp5mvTYKOq/D//Vn41b9wR92BEdg2TAY+yLQn/Px1iCH1EiMjeTKQAhUnuL2EXyu
         A2lHSE6Jn7BN4PtAliqMdrwqxugrkdr0PhUrmVwANPuVEbDLG5xZDX+Fh50MZuWfIVRg
         AbmA==
X-Gm-Message-State: APjAAAXCpF02uob373uevx/+04nHC0bwMKp4HxVoGxvAAGb2Cg6D/9uC
        JJFlokv8WX9jO8kqurVpQxuKUCEauZYfTgs50aSvOQ==
X-Google-Smtp-Source: APXvYqw7bdW2U1qAn58HfHRrUeJI5mayWPJXnuvI4caiQBk+twxM3cUV7/aucx0o+qhr7HnlZGa3XX7YY+oTszTwMDI=
X-Received: by 2002:adf:e50c:: with SMTP id j12mr45502820wrm.117.1564508702443;
 Tue, 30 Jul 2019 10:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190730013310.162367-1-surenb@google.com> <20190730081122.GH31381@hirez.programming.kicks-ass.net>
In-Reply-To: <20190730081122.GH31381@hirez.programming.kicks-ass.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 30 Jul 2019 10:44:51 -0700
Message-ID: <CAJuCfpH7NpuYKv-B9-27SpQSKhkzraw0LZzpik7_cyNMYcqB2Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] psi: do not require setsched permission from the
 trigger creator
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, lizefan@huawei.com,
        Johannes Weiner <hannes@cmpxchg.org>, axboe@kernel.dk,
        Dennis Zhou <dennis@kernel.org>,
        Dennis Zhou <dennisszhou@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Nick Kralevich <nnk@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 1:11 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jul 29, 2019 at 06:33:10PM -0700, Suren Baghdasaryan wrote:
> > When a process creates a new trigger by writing into /proc/pressure/*
> > files, permissions to write such a file should be used to determine whether
> > the process is allowed to do so or not. Current implementation would also
> > require such a process to have setsched capability. Setting of psi trigger
> > thread's scheduling policy is an implementation detail and should not be
> > exposed to the user level. Remove the permission check by using _nocheck
> > version of the function.
> >
> > Suggested-by: Nick Kralevich <nnk@google.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  kernel/sched/psi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > index 7acc632c3b82..ed9a1d573cb1 100644
> > --- a/kernel/sched/psi.c
> > +++ b/kernel/sched/psi.c
> > @@ -1061,7 +1061,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
> >                       mutex_unlock(&group->trigger_lock);
> >                       return ERR_CAST(kworker);
> >               }
> > -             sched_setscheduler(kworker->task, SCHED_FIFO, &param);
> > +             sched_setscheduler_nocheck(kworker->task, SCHED_FIFO, &param);
>
> ARGGH, wtf is there a FIFO-99!! thread here at all !?

We need psi poll_kworker to be an rt-priority thread so that psi
notifications are delivered to the userspace without delay even when
the CPUs are very congested. Otherwise it's easy to delay psi
notifications by running a simple CPU hogger executing "chrt -f 50 dd
if=/dev/zero of=/dev/null". Because these notifications are
time-critical for reacting to memory shortages we can't allow for such
delays.
Notice that this kworker is created only if userspace creates a psi
trigger. So unless you are using psi triggers you will never see this
kthread created.

> >               kthread_init_delayed_work(&group->poll_work,
> >                               psi_poll_work);
> >               rcu_assign_pointer(group->poll_kworker, kworker);
> > --
> > 2.22.0.709.g102302147b-goog
> >
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
