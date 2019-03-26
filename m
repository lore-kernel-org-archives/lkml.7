Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B447C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E1D20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5S5Byyo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730982AbfCZCYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 22:24:03 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37376 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730625AbfCZCYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 22:24:03 -0400
Received: by mail-it1-f193.google.com with SMTP id u65so8052516itc.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 19:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nj8RlsG0Gym4DkZxs0NUiHZ6pTdih2yEZQMM2Wc1LQ0=;
        b=n5S5ByyotLz5AK9aSSibBTTwd7YWmgVATozn9AFvlpJxitMnLSNUb63r0K9qD2kUo2
         bkbi9LDWQdHEifiXMISKlrtNv0dEAGGrok9i9j6a0wTIeN+KHb12h0hIGlxt+9Ng41Rd
         m2inNbSlKuqtkkrhCwh3pZ4TSWig7895SGyG2bA69ajUJ4IARJL2MwL3J0ppgD/fR1QL
         HPOaNtWM+apOKtsXH8zuiERnii5Ms1nA0GzM/W+yPdfA6UX2wmF8pHmJ205vNakSB4WA
         3sn+2jvIdkns/RT78cZ+w4mOZhkshVAS15pRtTQZ7whOMHF6sDsn1t8OT1lbHkhkiWj+
         pjjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nj8RlsG0Gym4DkZxs0NUiHZ6pTdih2yEZQMM2Wc1LQ0=;
        b=Dm70gwcE3Ut+3giXyCaOKNoDLgb4lHyp5qvXw+TQIlxVpUEq7x5dZeNNwBSpK472Ql
         DIoP7e9T9BRZTWtdI1hnEpRVXaQjxYKezfaVbJD2gKUWcg7aHaNx8IYhhKLSfQC9RUty
         6chbleXBk2KFK2F0bZwD99vtXCCZM3DFUZwGlJKc9ffNVvimJZGFSCi5oiA27ItGkS3i
         bFsGBgsIjs59rqfF9cCxcd7mFQf5oGlyS/v2/mmXwKFPGs69D56CqEMtQGAkkXN4JE7J
         eJMrVmDR9xtk+K68EdSalp92k0LcFA2eAf+duCoul8+RzdQ0AvLrQSMjl2xH6IblEq6P
         +w2w==
X-Gm-Message-State: APjAAAWmd0Vfx1zXuFvCHdGP7wm2CECCOHjCComdDfKv2unb3/lulQV9
        ap669cMy4MxjuboxNjGNxrVtyCPYllZNBfe/54U=
X-Google-Smtp-Source: APXvYqwwytIy++eB5xhZQWFtmw0Ko79gXY/BNMlbI166p3B+FHjhFkuDaFghA6ACYfZ+PChSNyGbBG+/0ZyaCBTYwPo=
X-Received: by 2002:a05:660c:606:: with SMTP id i6mr1578070itk.154.1553567042873;
 Mon, 25 Mar 2019 19:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <1553564407-1162-1-git-send-email-laoar.shao@gmail.com>
 <1553564407-1162-3-git-send-email-laoar.shao@gmail.com> <20190325222105.637f7e23@oasis.local.home>
In-Reply-To: <20190325222105.637f7e23@oasis.local.home>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 26 Mar 2019 10:23:26 +0800
Message-ID: <CALOAHbDJgT6Uu8PWJKLxwz0wHJB9=YbkBN-KXqaniAEa=Pf=8Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] sched/fair: do not expose some tracepoints to user if
 CONFIG_SCHEDSTATS is not set
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        josh@joshtriplett.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        shaoyafang@didiglobal.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 10:21 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 26 Mar 2019 09:40:06 +0800
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > The tracepoints trace_sched_stat_{iowait, blocked, wait, sleep} should
> > be not exposed to user if CONFIG_SCHEDSTATS is not set.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  include/trace/events/sched.h | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> > index 9a4bdfa..4686c7f 100644
> > --- a/include/trace/events/sched.h
> > +++ b/include/trace/events/sched.h
> > @@ -336,6 +336,7 @@ static inline long __trace_sched_switch_state(bool preempt, struct task_struct *
> >                 __entry->pid, __entry->old_pid)
> >  );
> >
> > +#ifdef CONFIG_SCHEDSTATS
>
> Instead of doing this #ifdef here, perhaps we should have at the top of the file:
>
> #ifdef CONFIG_SCHEDSTATS
> # define TRACE_EVENT_SCHEDSTAT TRACE_EVENT
> #else
> # define TRACE_EVENT_SCHEDSTAT TRACE_EVENT_NOP
> #endif
>
> And then switch the sched stat tracepoints from TRACE_EVENT to
> use TRACE_EVENT_SCHEDSTAT.
>
> And if my magic macro hat is working while sitting on the shelf (don't
> have time to put it on), then the TRACE_EVENT_SCHEDSTAT will work like
> a TRACE_EVENT when enabled, and a TRACE_EVENT_NOP when not.
>
> Can you give that a try?
>
> If this works, you don't need to duplicate all the parameters again.
>

You proposal seems like a better solution.
I will have a try.
Thanks for your suggestion.

-Yafang

>
> >  /*
> >   * XXX the below sched_stat tracepoints only apply to
> > SCHED_OTHER/BATCH/IDLE
> >   *     adding sched_stat support to SCHED_FIFO/RR would be welcome.
> > @@ -395,6 +396,19 @@ static inline long
> > __trace_sched_switch_state(bool preempt, struct task_struct *
> > TP_PROTO(struct task_struct *tsk, u64 delay), TP_ARGS(tsk, delay));
> >
> > +#else /* CONFIG_SCHEDSTATS */
> > +
> > +TRACE_EVENT_NONE(sched_stat_wait,
> > +              TP_PROTO(struct task_struct *tsk, u64 delay));
> > +TRACE_EVENT_NONE(sched_stat_sleep,
> > +              TP_PROTO(struct task_struct *tsk, u64 delay));
> > +TRACE_EVENT_NONE(sched_stat_iowait,
> > +              TP_PROTO(struct task_struct *tsk, u64 delay));
> > +TRACE_EVENT_NONE(sched_stat_blocked,
> > +              TP_PROTO(struct task_struct *tsk, u64 delay));
> > +
> > +#endif /* CONFIG_SCHEDSTATS */
> > +
> >  /*
> >   * Tracepoint for accounting runtime (time the task is executing
> >   * on a CPU).
>
