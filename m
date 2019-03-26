Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D8FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9605D20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 02:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbyMewBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbfCZCZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 22:25:12 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40870 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730804AbfCZCZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 22:25:12 -0400
Received: by mail-it1-f194.google.com with SMTP id y63so5799225itb.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 19:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+lpTzd61Ax5/mB2IyxlIUFZrkafBLmUOKIKk5Je97zg=;
        b=MbyMewBKqK1adISImbT1DMBVVqmNi5VBmdrx2ndflkS59kPKKVOPpeR2qzZ2J3jwOt
         A4rpLbqNZy/P0inIb6YdJV+y/9vpKukoJxLMYLmDne/lpEyTsUDDMt0V9O1nzP2wX3pV
         VMiSW2NChnIYaSaIjEFSS8ftMvk3HQcaRS2iJv54eEX8YVOwjrPdHfFskYNgsAVTAa+3
         eBmX3lKxX4mjMQk1tuEqWSLbYX/n97PN8DWbBPPxf02ZvtCgrtRPomFcN6qUiRnlFTQ4
         LHXwLtkVja3U7OB2szdvJJndt3lM98bCW8ZZ9iYjxLvVBFP0WJT+ZHhcGg/f1otSC9zD
         k/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+lpTzd61Ax5/mB2IyxlIUFZrkafBLmUOKIKk5Je97zg=;
        b=Kg8Hc+uM/GLeY8xMp7lIT5ktGpCTqQ2PDFEZ0wcx0iwdi9Rg3CGifkOGvJgq0ihx6x
         2NlxFCtIftwTq/hVcPAmrocFdPGvY5naBpc+nQUbnnrIivLm1w+zlE73kIzTI/Wv4V79
         jLuUW+bRPkI/rLprudkhcz1kKwKOv+HHtrls5YUpYCuKcD1foHi5lHw/Z0q1FGfFFLDx
         3Vs2pfC7c8yLY4xBHf8rjBiNiHhq2CHF89IM3b33/HL83UjLUZ4Tp8SKUm3HSw3fFzzo
         pw8wGlWZAfVoy0k9pLwKTiFg+lb0yodJO9PJzz37PgWFrBnd6/41Yg3UDU4nHOUokmWn
         mCdw==
X-Gm-Message-State: APjAAAUFgk5WymsvGCC2Zq1uSRjnUDjx6dDWXMrh0+4bbZCwRovEgKPv
        Al4w16wX57p4lW+fpa4fPvAM/7bwY6cIcjaS99Y=
X-Google-Smtp-Source: APXvYqx31xlaSTqmu85qyLljhHwUrbablpKSCxlv1XXinPqPMNoUf3FUU7D5Epx4gSaOqDLX0pzSjuhnuLrh74RZiGk=
X-Received: by 2002:a05:660c:606:: with SMTP id i6mr1580260itk.154.1553567111385;
 Mon, 25 Mar 2019 19:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <1553564407-1162-1-git-send-email-laoar.shao@gmail.com> <20190325221745.1009cbdf@oasis.local.home>
In-Reply-To: <20190325221745.1009cbdf@oasis.local.home>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 26 Mar 2019 10:24:35 +0800
Message-ID: <CALOAHbAUaRVCL_z2Kq45r-iwRqo5OwGMoEHrDJPj1fJsXbH6iA@mail.gmail.com>
Subject: Re: [PATCH 0/3] tracing: introduce TRACE_EVENT_NONE and use it
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

On Tue, Mar 26, 2019 at 10:17 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 26 Mar 2019 09:40:04 +0800
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > In this patchset, I introduce a new macro TRACE_EVENT_NONE(), which will
> > define a tracepoint as a do-nothing inline function.
> >       #define TRACE_EVENT_NONE(name, proto)                   \
> >               static inline void trace_##name(proto)          \
> >               { }                                             \
> >               static inline bool trace_##name##_enabled(void) \
> >               {                                               \
> >                       return false;                           \
> >               }
> >
>
> BTW, I prefer a name of TRACE_EVENT_DISABLED()
>
> Which shows that it is disabled, or TRACE_EVENT_UNDEF(), or
> TRACE_EVENT_NOP(). Something that states it is turned off. When I first
> saw NONE() I thought it was another attempt to introduce zero parameter
> trace events.
>

I prefer TRACE_EVENT_NOP.
I will change it.

Thanks
Yafang

>
> > Let's take some example for why this macro is needed.
> >
> > - sched
> > The tracepoints trace_sched_stat_{iowait, blocked, wait, sleep} should
> > be not exposed to user if CONFIG_SCHEDSTATS is not set.
> > We can place #ifdef in the kernel/sched/fair.c to fix it, but we
> > don't want to sprinkle #ifdef.
>
> But you still sprinkle #ifdef in the header, but the part I don't like
> is the need to duplicate the prototypes and the like.
>
>
> > So with TRACE_EVENT_NONE(), we can fix it in
> > include/trace/events/sched.h.
> >
> > - rcu
> > When CONFIG_RCU_TRACE is not set, some rcu tracepoints are define as
> > do-nothing macro without validating arguments, that is not proper.
> > We should validate the arguments.
> >
> > Yafang Shao (3):
> >   tracing: introduce TRACE_EVENT_NONE()
> >   sched/fair: do not expose some tracepoints to user if
> >     CONFIG_SCHEDSTATS is not set
> >   rcu: validate arguments for rcu tracepoints
> >
>
> See my reply in the next patch.
>
> -- Steve
